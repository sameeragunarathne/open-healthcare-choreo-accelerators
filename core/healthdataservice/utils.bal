import ballerinax/health.fhir.r4.uscore501;

isolated function mapPatientInfo(PatientInfo patientInfo) returns uscore501:USCorePatientProfile => {
    id: patientInfo.id,
    gender: patientInfo.gender ?: "unknown",
    name: [
        {
            text: patientInfo.name
        }
    ],
    birthDate: patientInfo.dob,
    address: from var addressItem in patientInfo.address ?: []
        select {
            text: addressItem
        },
    identifier: from var identifiersItem in patientInfo.identifiers ?: []
        select {
            system: identifiersItem.system,
            value: identifiersItem.value   
        }
};
