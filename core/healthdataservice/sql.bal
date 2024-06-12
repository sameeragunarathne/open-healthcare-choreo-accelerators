import ballerina/io;
import ballerina/sql;


public sql:ParameterizedQuery USER_CREATE = `INSERT INTO User (id, role) VALUES (?, ?)`;
public sql:ParameterizedQuery USER_EXISTS_CHECK = `SELECT EXISTS (
            SELECT 1 FROM User WHERE id = ?);`;

public final string USER_CREATE_MYSQL = string`INSERT INTO User (id, role) VALUES (`;
public final string ROLE_PATIENT_CHECK_MYSQL = string`SELECT id FROM Role WHERE name = 'patient'`;
public final string USER_EXISTS_MYSQL = string`SELECT EXISTS (
            SELECT 1 FROM User WHERE id `;
public final string PATIENT_CREATE_MYSQL = string`INSERT INTO Patient (id, user, person_data) VALUES (`;

public isolated function getDbSetupSqlStrings(string dbType) returns string[]|error {  
    string filePath = "";  
    if (dbType == MYSQL) {
        filePath = "resources/mysql/healthdatastore.sql";
    } else if (dbType == MSSQL) {
        filePath = "resources/mssql/healthdatastore.sql";
    } else {
        return error ("Unsupported database type");
    }
    // Read the SQL file content
    io:ReadableByteChannel fileChannel = check io:openReadableFile(filePath);
    readonly & byte[] fileContent = check fileChannel.readAll();
    _ = check fileChannel.close();

    string sqlContent = check string:fromBytes(fileContent);
    string:RegExp r = re `;`;
    string[] sqlStatements = r.split(sqlContent);
    string[] sqlStrings = [];

    // Process each SQL statement
    foreach string sqlStatement in sqlStatements {
        if (sqlStatement != "") {
            sqlStrings.push(sqlStatement.trim());
        }
    }
    return sqlStrings;
}
