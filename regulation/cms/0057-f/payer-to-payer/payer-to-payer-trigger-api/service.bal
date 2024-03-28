import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service /payer\-to\-payer on new http:Listener(9090) {
    //new payer information(payer name, payer npi)
    //old coverage information(coverage id, coverage name, coverage type(s), coverage class(s), coverage status, coverage start date, coverage end date)
    //new coverage information(coverage id, coverage name, coverage type(s), coverage class(s), coverage start date, coverage end date)
    //old payer FHIR server url, dcr endpoint(optional)
    //member consent(opt-in/opt-out, consent policy)
    
}
