import ballerina/http;

service / on new http:Listener(9090) {

    isolated resource function get practitioner(http:Request req) returns json {

        return { "payload": "Practitioner data" };
    }
}

service / on new http:Listener(9091) {

    isolated resource function get patient(http:Request req) returns json {

        return { "payload": "Patient data" };
    }
}