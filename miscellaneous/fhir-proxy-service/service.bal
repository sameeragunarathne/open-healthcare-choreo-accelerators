import ballerina/http;

// Configurable authorization header and base URL for the FHIR server
configurable string authorizationHeader = ?;
configurable string fhirBaseUrl = "http://localhost:8090";

// HTTP client to interact with the FHIR server
final http:Client fhirClient = check new (fhirBaseUrl);

service / on new http:Listener(9090) {

    isolated resource function post practitioner(http:Caller caller, http:Request req) returns error? {

        // Send the request to the FHIR server's Practitioner endpoint
        http:Response fhirResponse = check fhirClient->get("/fhir/r4/Practitioner/4122622", headers = {"api-key": authorizationHeader});

        // Forward the response from the FHIR server to the client
        check caller->respond(fhirResponse);
    }
}