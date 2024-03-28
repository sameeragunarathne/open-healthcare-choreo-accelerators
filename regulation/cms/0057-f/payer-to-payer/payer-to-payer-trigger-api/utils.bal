type Patient record {
    string id;
    string name;
    string[] addresses;
    string birthDate;
    Coverage[] coverages;
    Consent consent;
};

type Coverage record {
    string 'type;
    string details;
};

type PayerDiscoveryInfo record {
    string fhirUrl;
    string dcrEndpoint;
};

type Consent record {
    OptInOut optInOut;
    string policy;
};

enum OptInOut {
    optIn,
    optOut
};
