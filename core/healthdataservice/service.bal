import ballerina/http;
import ballerina/log;
import ballerina/sql;
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
    string[]|error sqlStrings = getSqlStrings(DB_TYPE);
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

service /payer/data\-exchange on new http:Listener(9090) {

    resource function post initiate(@http:Payload PayerToPayerDataExchangeData data) returns json|error {
        json response = {"status": "processing"};
        PatientInfo patientInfo = data.patientInfo;
        string? dateOfBirth = patientInfo.dob;
        if dateOfBirth is string {

        }

        return response;
    }

    resource function get status() returns json|error {
        json response = {"status": "processing"};
        return response;
    }
}
