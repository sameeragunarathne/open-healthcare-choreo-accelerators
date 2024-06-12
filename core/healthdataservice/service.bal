import ballerina/http;
import ballerina/log;
import ballerina/sql;
import ballerina/uuid;
import ballerinax/health.fhir.r4.uscore501;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

configurable string DB_TYPE = MYSQL;
configurable string USER = "root";
configurable string PASSWORD = "";
configurable string HOST = "localhost";
configurable int PORT = 3306;
configurable string DATABASE = "P2P";

final mysql:Client dbClient = check new (host = HOST, user = USER, password = PASSWORD, port = PORT, database = DATABASE);

function init() returns error? {
    string[]|error sqlStrings = getDbSetupSqlStrings(DB_TYPE);
    if sqlStrings is error {
        log:printError("Error occurred while getting the SQL strings.", sqlStrings);
    } else {
        foreach var sqlString in sqlStrings {
            if (sqlString != "") {
                sql:ParameterizedQuery dbSetupQry = ``;
                dbSetupQry.strings = [sqlString];
                sql:ExecutionResult|sql:Error executeResult = dbClient->execute(dbSetupQry);
                if executeResult is sql:Error {
                    log:printError(string `Error in executing the SQL: ${sqlString}`, executeResult);
                }
            }
        }
    }
}

service /payer\-data/exchange on new http:Listener(9090) {

    resource function post initiate(@http:Payload PayerToPayerDataExchangeData data) returns json|error {
        json response = {"status": "processing"};
        uscore501:USCorePatientProfile patient = mapPatientInfo(data.patientInfo);

        //handle below steps within a transaction
        string userId = uuid:createType4AsString();
        USER_EXISTS_CHECK.insertions[0] = userId;
        int|sql:Error userResult = dbClient->queryRow(USER_EXISTS_CHECK);
        if userResult is sql:Error {
            log:printError("Error occurred while checking user existance.", userResult);
            return {"status": "failed"};
        }
        if userResult > 0 {
            log:printError("User already exists.");
            return {"status": "failed"};
        }

        transaction {
            sql:ExecutionResult|sql:Error userQryResult = dbClient->execute(`INSERT INTO User (id, role) VALUES (${userId}, (SELECT id FROM Role WHERE name = 'patient'))`);
            sql:ExecutionResult|sql:Error patientQryResult = dbClient->execute(`INSERT INTO Patient (id, user, person_data) VALUES (${patient.id}, ${userId}, ${patient.toJsonString()})`);
            if userQryResult is sql:Error || patientQryResult is sql:Error {
                rollback;
                if patientQryResult is sql:Error {
                    response = {"status": "failed"};
                    log:printError("Error while creating patient.", patientQryResult);
                }
                if userQryResult is sql:Error {
                    response = {"status": "failed"};
                    log:printError("Error while creating user.", userQryResult);
                }
            } else {
                check commit;
            }
            log:printDebug("Patient data inserted successfully.");
        } on fail error e {
            log:printError("Error occurred while inserting patient data.", e);
        }
        return response;
    }

    resource function get status() returns json|error {
        json response = {"status": "processing"};
        return response;
    }
}
