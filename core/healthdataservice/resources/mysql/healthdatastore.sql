CREATE TABLE IF NOT EXISTS `Role` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `User` (
  `id` INT NOT NULL,
  `role` INT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_USER_1_idx` (`role` ASC) VISIBLE,
  CONSTRAINT `FK_USER_1`
    FOREIGN KEY (`role`)
    REFERENCES `Role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Patient` (
  `id` INT NOT NULL,
  `user` INT NULL,
  `person_data` JSON NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_PATIENT_1_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `FK_PATIENT_1`
    FOREIGN KEY (`user`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Payer` (
  `id` INT NOT NULL,
  `dcr_endpoint` VARCHAR(45) NULL,
  `fhir_endpoint` VARCHAR(45) NULL,
  `mtls_endpoint` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Consent` (
  `id` INT NOT NULL,
  `consent_data` JSON NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `PayerToPayerRequest` (
  `id` INT NOT NULL,
  `old_payer` INT NULL,
  `new_payer` INT NULL,
  `patient` INT NULL,
  `consent` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `PayerToPayerRequest_FK_1_idx` (`old_payer` ASC) VISIBLE,
  INDEX `PayerToPayerRequest_FK_2_idx` (`new_payer` ASC) VISIBLE,
  INDEX `PayerToPayerRequest_FK_3_idx` (`patient` ASC) VISIBLE,
  INDEX `PayerToPayerRequest_FK_4_idx` (`consent` ASC) VISIBLE,
  CONSTRAINT `PayerToPayerRequest_FK_1`
    FOREIGN KEY (`old_payer`)
    REFERENCES `Payer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PayerToPayerRequest_FK_2`
    FOREIGN KEY (`new_payer`)
    REFERENCES `Payer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PayerToPayerRequest_FK_3`
    FOREIGN KEY (`patient`)
    REFERENCES `Patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PayerToPayerRequest_FK_4`
    FOREIGN KEY (`consent`)
    REFERENCES `Consent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Coverage` (
  `id` INT NOT NULL,
  `coverage_data` JSON NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `PatientToPayerMapping` (
  `id` INT NOT NULL,
  `patient` INT NULL,
  `payer` INT NULL,
  `coverage` INT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `Patient2PayerMapping_FK_1_idx` (`payer` ASC) VISIBLE,
  INDEX `Patient2PayerMapping_FK_2_idx` (`patient` ASC) VISIBLE,
  INDEX `Patient2PayerMapping_FK_3_idx` (`coverage` ASC) VISIBLE,
  CONSTRAINT `Patient2PayerMapping_FK_1`
    FOREIGN KEY (`payer`)
    REFERENCES `Payer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Patient2PayerMapping_FK_2`
    FOREIGN KEY (`patient`)
    REFERENCES `Patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Patient2PayerMapping_FK_3`
    FOREIGN KEY (`coverage`)
    REFERENCES `Coverage` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `PatientToConsentMapping` (
  `id` INT NOT NULL,
  `consent` INT NULL,
  `patient` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `PatientToConsentMapping_FK_1_idx` (`patient` ASC) VISIBLE,
  INDEX `PatientToConsentMapping_2_idx` (`consent` ASC) VISIBLE,
  CONSTRAINT `PatientToConsentMapping_FK_1`
    FOREIGN KEY (`patient`)
    REFERENCES `Patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PatientToConsentMapping_2`
    FOREIGN KEY (`consent`)
    REFERENCES `Consent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
