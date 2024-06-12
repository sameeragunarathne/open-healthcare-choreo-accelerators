import ballerina/http;
// import ballerina/io;
// import ballerinax/health.hl7v2commons;

public type V2ToFhirCustomServiceConfig record {
    string baseUrl;
    map<FhirEndpointConfig> segmentToAPI;
};

public type FhirEndpointConfig record {
    string path;
    boolean useDefault = false;
};

configurable V2ToFhirCustomServiceConfig serviceConfig = {
    baseUrl: "",
    segmentToAPI: {}
};


configurable map<string> fhirEndpoints = {
};

service /v2tofhir on new http:Listener(9091) {

    resource function get test() returns string|error{
        return "This is test";
    }

//     resource function post segment/nk1(@http:Payload hl7v2commons:Nk1 nk1) returns json|error {
//         io:print("NK1 segment received: ", nk1);
//         json response = {
//             "resourceType": "Patient",
//             "id": "example",
//             "text": {
//                 "status": "generated",
//                 "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n\t\t\t<table>\n\t\t\t\t<tbody>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td>Name</td>\n\t\t\t\t\t\t<td>Peter James \n              <b>Chalmers</b> (&quot;Jim&quot;)\n            </td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td>Address</td>\n\t\t\t\t\t\t<td>534 Erewhon, Pleasantville, Vic, 3999</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td>Contacts</td>\n\t\t\t\t\t\t<td>Home: unknown. Work: (03) 5555 6473</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td>Id</td>\n\t\t\t\t\t\t<td>MRN: 12345 (Acme Healthcare)</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</tbody>\n\t\t\t</table>\n\t\t</div>"
//             },
//             "identifier": [
//                 {
//                     "use": "usual",
//                     "type": {
//                         "coding": [
//                             {
//                                 "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
//                                 "code": "MR"
//                             }
//                         ]
//                     },
//                     "system": "urn:oid:1.2.36.146.595.217.0.1",
//                     "value": "12345",
//                     "period": {
//                         "start": "2001-05-06"
//                     },
//                     "assigner": {
//                         "display": "Acme Healthcare"
//                     }
//                 }
//             ],
//             "active": true,
//             "name": [
//                 {
//                     "use": "official",
//                     "family": "Chalmers",
//                     "given": [
//                         "Peter",
//                         "James"
//                     ]
//                 },
//                 {
//                     "use": "usual",
//                     "given": [
//                         "Jim"
//                     ]
//                 },
//                 {
//                     "use": "maiden",
//                     "family": "Windsor",
//                     "given": [
//                         "Peter",
//                         "James"
//                     ],
//                     "period": {
//                         "end": "2002"
//                     }
//                 }
//             ],
//             "telecom": [
//                 {
//                     "use": "home"
//                 },
//                 {
//                     "system": "phone",
//                     "value": "(03) 5555 6473",
//                     "use": "work",
//                     "rank": 1
//                 },
//                 {
//                     "system": "phone",
//                     "value": "(03) 3410 5613",
//                     "use": "mobile",
//                     "rank": 2
//                 },
//                 {
//                     "system": "phone",
//                     "value": "(03) 5555 8834",
//                     "use": "old",
//                     "period": {
//                         "end": "2014"
//                     }
//                 }
//             ],
//             "gender": "male",
//             "birthDate": "1974-12-25",
//             "_birthDate": {
//                 "extension": [
//                     {
//                         "url": "http://hl7.org/fhir/StructureDefinition/patient-birthTime",
//                         "valueDateTime": "1974-12-25T14:35:45-05:00"
//                     }
//                 ]
//             },
//             "deceasedBoolean": false,
//             "address": [
//                 {
//                     "use": "home",
//                     "type": "both",
//                     "text": "534 Erewhon St PeasantVille, Rainbow, Vic  3999",
//                     "line": [
//                         "534 Erewhon St"
//                     ],
//                     "city": "PleasantVille",
//                     "district": "Rainbow",
//                     "state": "Vic",
//                     "postalCode": "3999",
//                     "period": {
//                         "start": "1974-12-25"
//                     }
//                 }
//             ],
//             "contact": [
//                 {
//                     "relationship": [
//                         {
//                             "coding": [
//                                 {
//                                     "system": "http://terminology.hl7.org/CodeSystem/v2-0131",
//                                     "code": "N"
//                                 }
//                             ]
//                         }
//                     ],
//                     "name": {
//                         "family": "du Marché",
//                         "_family": {
//                             "extension": [
//                                 {
//                                     "url": "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix",
//                                     "valueString": "VV"
//                                 }
//                             ]
//                         },
//                         "given": [
//                             "Bénédicte"
//                         ]
//                     },
//                     "telecom": [
//                         {
//                             "system": "phone",
//                             "value": "+33 (237) 998327"
//                         }
//                     ],
//                     "address": {
//                         "use": "home",
//                         "type": "both",
//                         "line": [
//                             "534 Erewhon St"
//                         ],
//                         "city": "PleasantVille",
//                         "district": "Rainbow",
//                         "state": "Vic",
//                         "postalCode": "3999",
//                         "period": {
//                             "start": "1974-12-25"
//                         }
//                     },
//                     "gender": "female",
//                     "period": {
//                         "start": "2012"
//                     }
//                 }
//             ],
//             "managingOrganization": {
//                 "reference": "Organization/1"
//             }
//         };
// //         json response = {
// //     "resourceType": "Bundle",
// //     "meta": {
// //         "profile": [
// //             "http://hl7.org/fhir/StructureDefinition/Bundle"
// //         ]
// //     },
// //     "type": "transaction",
// //     "entry": [
// //         {
// //             "resource": {
// //                 "resourceType": "MessageHeader",
// //                 "eventUri": "",
// //                 "destination": [
// //                     {
// //                         "endpoint": "",
// //                         "name": "SMS"
// //                     }
// //                 ],
// //                 "source": {
// //                     "endpoint": "",
// //                     "name": "EPIC"
// //                 },
// //                 "eventCoding": {
// //                     "system": "A01",
// //                     "code": "ADT"
// //                 }
// //             }
// //         },
// //         {
// //             "resource": {
// //                 "resourceType": "Provenance",
// //                 "agent": [],
// //                 "activity": {
// //                     "coding": [
// //                         {
// //                             "display": "EVN"
// //                         }
// //                     ]
// //                 },
// //                 "recorded": "202211030800",
// //                 "target": [],
// //                 "occurredDateTime": "202211030800"
// //             }
// //         },
// //         {
// //             "resource": {
// //                 "resourceType": "Patient",
// //                 "gender": "male",
// //                 "telecom": [
// //                     {
// //                         "system": "phone",
// //                         "use": "home"
// //                     },
// //                     {
// //                         "system": "phone",
// //                         "use": "home"
// //                     }
// //                 ],
// //                 "address": [
// //                     {
// //                         "line": [
// //                             "254 MYSTREET AVE"
// //                         ],
// //                         "city": "MYTOWN",
// //                         "state": "OH",
// //                         "postalCode": "44123",
// //                         "country": "USA"
// //                     }
// //                 ],
// //                 "birthDate": "19480203",
// //                 "name": [
// //                     {
// //                         "family": "DOE",
// //                         "given": [
// //                             "JOHN"
// //                         ]
// //                     }
// //                 ],
// //                 "maritalStatus": {
// //                     "coding": [
// //                         {
// //                             "code": "M"
// //                         }
// //                     ]
// //                 }
// //             }
// //         }
// //     ]
// // };
//         return response;
//     }

//     resource function post segment/pid(@http:Payload hl7v2commons:Pid pid) returns json|error {
//         return {};
//     }

//     resource function post segment/pd1(@http:Payload hl7v2commons:Pd1 pd1) returns json|error {
//         return {};
//     }

//     resource function post segment/pv1(@http:Payload hl7v2commons:Pv1 pv1) returns json|error {
//         return {};
//     }

//     resource function post segment/dg1(@http:Payload hl7v2commons:Dg1 dg1) returns json|error {
//         return {};
//     }

//     resource function post segment/al1(@http:Payload hl7v2commons:Al1 al1) returns json|error {
//         return {};
//     }

//     resource function post segment/evn(@http:Payload hl7v2commons:Evn evn) returns json|error {
//         return {};
//     }

//     resource function post segment/msh(@http:Payload hl7v2commons:Msh msh) returns json|error {
//         return {};
//     }

//     resource function post segment/pv2(@http:Payload hl7v2commons:Pv2 pv2) returns json|error {
//         return {};
//     }

//     resource function post segment/obx(@http:Payload hl7v2commons:Obx obx) returns json|error {
//         return {};
//     }

//     resource function post segment/orc(@http:Payload hl7v2commons:Orc orc) returns json|error {
//         return {};
//     }

//     resource function post segment/obr(@http:Payload hl7v2commons:Obr obr) returns json|error {
//         return {};
//     }

}

