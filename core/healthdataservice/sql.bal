import ballerina/io;

public isolated function getSqlStrings(string dbType) returns string[]|error {  
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
