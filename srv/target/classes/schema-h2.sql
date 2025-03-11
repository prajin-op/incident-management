
DROP VIEW IF EXISTS localized_AdminService_Status;
DROP VIEW IF EXISTS localized_AdminService_Urgency;
DROP VIEW IF EXISTS localized_ProcessorService_Status;
DROP VIEW IF EXISTS localized_ProcessorService_Urgency;
DROP VIEW IF EXISTS ProcessorService_DraftAdministrativeData;
DROP VIEW IF EXISTS localized_sap_capire_incidents_Urgency;
DROP VIEW IF EXISTS localized_sap_capire_incidents_Status;
DROP VIEW IF EXISTS AdminService_Status_texts;
DROP VIEW IF EXISTS AdminService_Urgency_texts;
DROP VIEW IF EXISTS ProcessorService_Status_texts;
DROP VIEW IF EXISTS ProcessorService_Urgency_texts;
DROP VIEW IF EXISTS AdminService_Incidents_conversation;
DROP VIEW IF EXISTS AdminService_Status;
DROP VIEW IF EXISTS AdminService_Urgency;
DROP VIEW IF EXISTS AdminService_Addresses;
DROP VIEW IF EXISTS ProcessorService_Addresses;
DROP VIEW IF EXISTS ProcessorService_Incidents_conversation;
DROP VIEW IF EXISTS ProcessorService_Status;
DROP VIEW IF EXISTS ProcessorService_Urgency;
DROP VIEW IF EXISTS AdminService_Incidents;
DROP VIEW IF EXISTS AdminService_Customers;
DROP VIEW IF EXISTS ProcessorService_Customers;
DROP VIEW IF EXISTS ProcessorService_Incidents;
DROP TABLE IF EXISTS ProcessorService_Incidents_conversation_drafts;
DROP TABLE IF EXISTS ProcessorService_Incidents_drafts;
DROP TABLE IF EXISTS DRAFT_DraftAdministrativeData;
DROP TABLE IF EXISTS sap_capire_incidents_Urgency_texts;
DROP TABLE IF EXISTS sap_capire_incidents_Status_texts;
DROP TABLE IF EXISTS sap_capire_incidents_Incidents_conversation;
DROP TABLE IF EXISTS sap_capire_incidents_Urgency;
DROP TABLE IF EXISTS sap_capire_incidents_Status;
DROP TABLE IF EXISTS sap_capire_incidents_Addresses;
DROP TABLE IF EXISTS sap_capire_incidents_Customers;
DROP TABLE IF EXISTS sap_capire_incidents_Incidents;

CREATE TABLE sap_capire_incidents_Incidents (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  customer_ID NVARCHAR(255),
  title NVARCHAR(255),
  urgency_code NVARCHAR(255) DEFAULT 'M',
  status_code NVARCHAR(255) DEFAULT 'N',
  PRIMARY KEY(ID)
);


CREATE TABLE sap_capire_incidents_Customers (
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  ID NVARCHAR(255) NOT NULL,
  firstName NVARCHAR(255),
  lastName NVARCHAR(255),
  email NVARCHAR(255),
  phone NVARCHAR(255),
  creditCardNo NVARCHAR(16),
  PRIMARY KEY(ID)
);


CREATE TABLE sap_capire_incidents_Addresses (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  customer_ID NVARCHAR(255),
  city NVARCHAR(255),
  postCode NVARCHAR(255),
  streetAddress NVARCHAR(255),
  PRIMARY KEY(ID)
);


CREATE TABLE sap_capire_incidents_Status (
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(255) NOT NULL,
  criticality INTEGER,
  PRIMARY KEY(code)
);


CREATE TABLE sap_capire_incidents_Urgency (
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(255) NOT NULL,
  PRIMARY KEY(code)
);


CREATE TABLE sap_capire_incidents_Incidents_conversation (
  up__ID NVARCHAR(36) NOT NULL,
  ID NVARCHAR(36) NOT NULL,
  timestamp TIMESTAMP(7),
  author NVARCHAR(255),
  message NVARCHAR(255),
  PRIMARY KEY(up__ID, ID)
);


CREATE TABLE sap_capire_incidents_Status_texts (
  locale NVARCHAR(14) NOT NULL,
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(255) NOT NULL,
  PRIMARY KEY(locale, code)
);


CREATE TABLE sap_capire_incidents_Urgency_texts (
  locale NVARCHAR(14) NOT NULL,
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(255) NOT NULL,
  PRIMARY KEY(locale, code)
);


CREATE TABLE DRAFT_DraftAdministrativeData (
  DraftUUID NVARCHAR(36) NOT NULL,
  CreationDateTime TIMESTAMP(7),
  CreatedByUser NVARCHAR(256),
  DraftIsCreatedByMe BOOLEAN,
  LastChangeDateTime TIMESTAMP(7),
  LastChangedByUser NVARCHAR(256),
  InProcessByUser NVARCHAR(256),
  DraftIsProcessedByMe BOOLEAN,
  PRIMARY KEY(DraftUUID)
);


CREATE TABLE ProcessorService_Incidents_drafts (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP(7) NULL,
  createdBy NVARCHAR(255) NULL,
  modifiedAt TIMESTAMP(7) NULL,
  modifiedBy NVARCHAR(255) NULL,
  customer_ID NVARCHAR(255) NULL,
  title NVARCHAR(255) NULL,
  urgency_code NVARCHAR(255) NULL DEFAULT 'M',
  status_code NVARCHAR(255) NULL DEFAULT 'N',
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
);


CREATE TABLE ProcessorService_Incidents_conversation_drafts (
  up__ID NVARCHAR(36) NOT NULL,
  ID NVARCHAR(36) NOT NULL,
  timestamp TIMESTAMP(7) NULL,
  author NVARCHAR(255) NULL,
  message NVARCHAR(255) NULL,
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(up__ID, ID)
);


CREATE VIEW ProcessorService_Incidents AS SELECT
  Incidents_0.ID,
  Incidents_0.createdAt,
  Incidents_0.createdBy,
  Incidents_0.modifiedAt,
  Incidents_0.modifiedBy,
  Incidents_0.customer_ID,
  Incidents_0.title,
  Incidents_0.urgency_code,
  Incidents_0.status_code
FROM sap_capire_incidents_Incidents AS Incidents_0;


CREATE VIEW ProcessorService_Customers AS SELECT
  Customers_0.createdAt,
  Customers_0.createdBy,
  Customers_0.modifiedAt,
  Customers_0.modifiedBy,
  Customers_0.ID,
  Customers_0.firstName,
  Customers_0.lastName,
  Customers_0.firstName || ' ' || Customers_0.lastName AS name,
  Customers_0.email,
  Customers_0.phone,
  Customers_0.creditCardNo
FROM sap_capire_incidents_Customers AS Customers_0;


CREATE VIEW AdminService_Customers AS SELECT
  Customers_0.createdAt,
  Customers_0.createdBy,
  Customers_0.modifiedAt,
  Customers_0.modifiedBy,
  Customers_0.ID,
  Customers_0.firstName,
  Customers_0.lastName,
  Customers_0.firstName || ' ' || Customers_0.lastName AS name,
  Customers_0.email,
  Customers_0.phone,
  Customers_0.creditCardNo
FROM sap_capire_incidents_Customers AS Customers_0;


CREATE VIEW AdminService_Incidents AS SELECT
  Incidents_0.ID,
  Incidents_0.createdAt,
  Incidents_0.createdBy,
  Incidents_0.modifiedAt,
  Incidents_0.modifiedBy,
  Incidents_0.customer_ID,
  Incidents_0.title,
  Incidents_0.urgency_code,
  Incidents_0.status_code
FROM sap_capire_incidents_Incidents AS Incidents_0;


CREATE VIEW ProcessorService_Urgency AS SELECT
  Urgency_0.name,
  Urgency_0.descr,
  Urgency_0.code
FROM sap_capire_incidents_Urgency AS Urgency_0;


CREATE VIEW ProcessorService_Status AS SELECT
  Status_0.name,
  Status_0.descr,
  Status_0.code,
  Status_0.criticality
FROM sap_capire_incidents_Status AS Status_0;


CREATE VIEW ProcessorService_Incidents_conversation AS SELECT
  conversation_0.up__ID,
  conversation_0.ID,
  conversation_0.timestamp,
  conversation_0.author,
  conversation_0.message
FROM sap_capire_incidents_Incidents_conversation AS conversation_0;


CREATE VIEW ProcessorService_Addresses AS SELECT
  Addresses_0.ID,
  Addresses_0.createdAt,
  Addresses_0.createdBy,
  Addresses_0.modifiedAt,
  Addresses_0.modifiedBy,
  Addresses_0.customer_ID,
  Addresses_0.city,
  Addresses_0.postCode,
  Addresses_0.streetAddress
FROM sap_capire_incidents_Addresses AS Addresses_0;


CREATE VIEW AdminService_Addresses AS SELECT
  Addresses_0.ID,
  Addresses_0.createdAt,
  Addresses_0.createdBy,
  Addresses_0.modifiedAt,
  Addresses_0.modifiedBy,
  Addresses_0.customer_ID,
  Addresses_0.city,
  Addresses_0.postCode,
  Addresses_0.streetAddress
FROM sap_capire_incidents_Addresses AS Addresses_0;


CREATE VIEW AdminService_Urgency AS SELECT
  Urgency_0.name,
  Urgency_0.descr,
  Urgency_0.code
FROM sap_capire_incidents_Urgency AS Urgency_0;


CREATE VIEW AdminService_Status AS SELECT
  Status_0.name,
  Status_0.descr,
  Status_0.code,
  Status_0.criticality
FROM sap_capire_incidents_Status AS Status_0;


CREATE VIEW AdminService_Incidents_conversation AS SELECT
  conversation_0.up__ID,
  conversation_0.ID,
  conversation_0.timestamp,
  conversation_0.author,
  conversation_0.message
FROM sap_capire_incidents_Incidents_conversation AS conversation_0;


CREATE VIEW ProcessorService_Urgency_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.code
FROM sap_capire_incidents_Urgency_texts AS texts_0;


CREATE VIEW ProcessorService_Status_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.code
FROM sap_capire_incidents_Status_texts AS texts_0;


CREATE VIEW AdminService_Urgency_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.code
FROM sap_capire_incidents_Urgency_texts AS texts_0;


CREATE VIEW AdminService_Status_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.code
FROM sap_capire_incidents_Status_texts AS texts_0;


CREATE VIEW localized_sap_capire_incidents_Status AS SELECT
  coalesce(localized_1.name, L_0.name) AS name,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.code,
  L_0.criticality
FROM (sap_capire_incidents_Status AS L_0 LEFT JOIN sap_capire_incidents_Status_texts AS localized_1 ON localized_1.code = L_0.code AND localized_1.locale = @locale);


CREATE VIEW localized_sap_capire_incidents_Urgency AS SELECT
  coalesce(localized_1.name, L_0.name) AS name,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.code
FROM (sap_capire_incidents_Urgency AS L_0 LEFT JOIN sap_capire_incidents_Urgency_texts AS localized_1 ON localized_1.code = L_0.code AND localized_1.locale = @locale);


CREATE VIEW ProcessorService_DraftAdministrativeData AS SELECT
  DraftAdministrativeData.DraftUUID,
  DraftAdministrativeData.CreationDateTime,
  DraftAdministrativeData.CreatedByUser,
  DraftAdministrativeData.DraftIsCreatedByMe,
  DraftAdministrativeData.LastChangeDateTime,
  DraftAdministrativeData.LastChangedByUser,
  DraftAdministrativeData.InProcessByUser,
  DraftAdministrativeData.DraftIsProcessedByMe
FROM DRAFT_DraftAdministrativeData AS DraftAdministrativeData;


CREATE VIEW localized_ProcessorService_Urgency AS SELECT
  Urgency_0.name,
  Urgency_0.descr,
  Urgency_0.code
FROM localized_sap_capire_incidents_Urgency AS Urgency_0;


CREATE VIEW localized_ProcessorService_Status AS SELECT
  Status_0.name,
  Status_0.descr,
  Status_0.code,
  Status_0.criticality
FROM localized_sap_capire_incidents_Status AS Status_0;


CREATE VIEW localized_AdminService_Urgency AS SELECT
  Urgency_0.name,
  Urgency_0.descr,
  Urgency_0.code
FROM localized_sap_capire_incidents_Urgency AS Urgency_0;


CREATE VIEW localized_AdminService_Status AS SELECT
  Status_0.name,
  Status_0.descr,
  Status_0.code,
  Status_0.criticality
FROM localized_sap_capire_incidents_Status AS Status_0;

