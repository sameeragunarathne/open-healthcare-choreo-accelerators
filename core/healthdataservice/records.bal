import ballerinax/health.fhir.r4.uscore501;
// enum to hold db types(mysql, mssql, etc)
public enum DbType {
    MYSQL = "MySQL", 
    MSSQL = "MSSQL", 
    ORACLE = "Oracle", 
    POSTGRESQL = "PostgreSQL"
};

public enum CoverageStatus {
    NEW = "new",
    OLD = "old",
    CONCURRENT = "concurrent"
}

public enum ConsentStatus {
    ACTIVE = "active",
    INACTIVE = "inactive"
}

public enum OptInOut {
    OPT_IN,
    OPT_OUT
}

public enum ConsentCategory {
    PAYER_TO_PAYER,
    PATIENT_ACCESS,
    PROVIDER_ACCESS,
    GENERAL
}

public type PayerToPayerDataExchangeData record {
    PatientInfo patientInfo;
    CoverageInfo newCoverage;
    CoverageInfo[] oldOrConcurrentCoverage;
    Consent consent;
};

public type PatientInfo record {
    string id;
    string name?;
    string dob?;
    uscore501:USCorePatientProfileGender gender?;
    string[] address?;
};

public type PayerInfo record {
    string id;
    string name;
    Identifier identifiers?;
};

public type CoverageInfo record {
    string id;
    CoverageStatus status;
    Identifier[] identifiers?;
    CoverageClass[] classes?;
    PayerInfo payer;
};

public type CoverageClass record {
    Code[] 'type?;
    string value;
};

public type Identifier record {
    string system;
    string value;
};

public type Code record {
    string code;
    string system;
    string display?;
};

public type Consent record {
    OptInOut optInOptOut;
    string consentPolicy?;
    string effectiveDate;
    string expirationDate;
    //url or document name to identify a reference to the consent
    string consentDocumentReference?;
    ConsentCategory category;
};