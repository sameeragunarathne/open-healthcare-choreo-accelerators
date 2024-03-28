import ballerinax/health.fhir.r4.uscore501;

function mapPatientInfo(PatientInfo patientInfo) returns uscore501:USCorePatientProfile => {
    identifier: [],
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
        }
};
