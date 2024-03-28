CREATE TABLE IF NOT EXISTS [Role] (
  [id] int NOT NULL PRIMARY KEY,
  [name] varchar(45) NULL
);

CREATE TABLE IF NOT EXISTS [User] (
  [id] int NOT NULL PRIMARY KEY,
  [role] int NULL,
  [name] varchar(45) NULL,
  FOREIGN KEY ([role]) REFERENCES [Role] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS [Patient] (
  [id] int NOT NULL PRIMARY KEY,
  [user] int NULL,
  [person_data] nvarchar(max) NULL,  -- Change data type to nvarchar(max) for JSON
  FOREIGN KEY ([user]) REFERENCES [User] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS [Payer] (
  [id] int NOT NULL PRIMARY KEY,
  [dcr_endpoint] varchar(45) NULL,
  [fhir_endpoint] varchar(45) NULL,
  [mtls_endpoint] varchar(45) NULL,
  [name] varchar(45) NULL
);

CREATE TABLE IF NOT EXISTS [Consent] (
  [id] int NOT NULL PRIMARY KEY,
  [consent_data] nvarchar(max) NULL,  -- Change data type to nvarchar(max) for JSON
  [status] varchar(45) NULL
);

CREATE TABLE IF NOT EXISTS [PayerToPayerRequest] (
  [id] int NOT NULL PRIMARY KEY,
  [old_payer] int NULL,
  [new_payer] int NULL,
  [patient] int NULL,
  [consent] int NULL,
  FOREIGN KEY ([old_payer]) REFERENCES [Payer] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY ([new_payer]) REFERENCES [Payer] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY ([patient]) REFERENCES [Patient] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY ([consent]) REFERENCES [Consent] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS [Coverage] (
  [id] int NOT NULL PRIMARY KEY,
  [coverage_data] nvarchar(max) NULL,  -- Change data type to nvarchar(max) for JSON
  [status] varchar(45) NULL
);

CREATE TABLE IF NOT EXISTS [PatientToPayerMapping] (
  [id] int NOT NULL PRIMARY KEY,
  [patient] int NULL,
  [payer] int NULL,
  [coverage] int NULL,
  [status] varchar(45) NULL,
  FOREIGN KEY ([payer]) REFERENCES [Payer] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY ([patient]) REFERENCES [Patient] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY ([coverage]) REFERENCES [Coverage] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS [PatientToConsentMapping] (
  [id] int NOT NULL PRIMARY KEY,
  [consent] int NULL,
  [patient] int NULL,
  FOREIGN KEY ([patient]) REFERENCES [Patient] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY ([consent]) REFERENCES [Consent] (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
