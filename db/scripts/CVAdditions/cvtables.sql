-- Sequence: registrationcvdetail_pkid_seq

-- DROP SEQUENCE registrationcvdetail_pkid_seq;

CREATE SEQUENCE registrationcvdetail_pkid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 12
  CACHE 1;
ALTER TABLE registrationcvdetail_pkid_seq OWNER TO fnctlint;

-- Sequence: registrationcvreference_pkid_seq

-- DROP SEQUENCE registrationcvreference_pkid_seq;

CREATE SEQUENCE registrationcvreference_pkid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 4
  CACHE 1;
ALTER TABLE registrationcvreference_pkid_seq OWNER TO fnctlint;

-- Sequence: usercvdetail_pkid_seq

-- DROP SEQUENCE usercvdetail_pkid_seq;

CREATE SEQUENCE usercvdetail_pkid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE usercvdetail_pkid_seq OWNER TO fnctlint;

-- Sequence: usercvreference_pkid_seq

-- DROP SEQUENCE usercvreference_pkid_seq;

CREATE SEQUENCE usercvreference_pkid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE usercvreference_pkid_seq OWNER TO fnctlint;


CREATE TABLE registrationcvdetail
(
  pkid serial NOT NULL,
  tradequalifications character varying(1000) NOT NULL,
  marketsegment_fkid integer NOT NULL,
  career_fkid integer NOT NULL,
  employmentstatus_fkid integer NOT NULL,
  currentemploymentyears integer,
  currentemploymentmonths integer,
  comments character varying(2000),
  hobbies character varying(2000),
  CONSTRAINT registrationcvdetail_pkid PRIMARY KEY (pkid)
);
ALTER TABLE registrationcvdetail OWNER TO fnctlint;

-- Table: registrationcvreference

-- DROP TABLE registrationcvreference;

CREATE TABLE registrationcvreference
(
  pkid serial NOT NULL,
  referencenr integer NOT NULL,
  employer character varying(255) NOT NULL,
  employmentperiod character varying(255) NOT NULL,
  employerphone character varying(60),
  CONSTRAINT registrationcvreference_pkid PRIMARY KEY (pkid)
);
ALTER TABLE registrationcvreference OWNER TO fnctlint;

-- Table: registrationcvreferences

-- DROP TABLE registrationcvreferences;

CREATE TABLE registrationcvreferences
(
  cvdetail_fkid integer NOT NULL,
  cvreference_fkid integer NOT NULL,
  CONSTRAINT registrationcvreferences_pkid PRIMARY KEY (cvdetail_fkid, cvreference_fkid)
);
ALTER TABLE registrationcvreferences OWNER TO fnctlint;

-- Table: usercvdetail

-- DROP TABLE usercvdetail;

CREATE TABLE usercvdetail
(
  pkid serial NOT NULL,
  tradequalifications character varying(1000) NOT NULL,
  marketsegment_fkid integer NOT NULL,
  career_fkid integer NOT NULL,
  employmentstatus_fkid integer NOT NULL,
  currentemploymentyears integer,
  currentemploymentmonths integer,
  comments character varying(2000),
  hobbies character varying(2000),
  CONSTRAINT usercvdetail_pkid PRIMARY KEY (pkid)
);
ALTER TABLE usercvdetail OWNER TO fnctlint;

-- Table: usercvreference

-- DROP TABLE usercvreference;

CREATE TABLE usercvreference
(
  pkid serial NOT NULL,
  referencenr integer NOT NULL,
  employer character varying(255) NOT NULL,
  employmentperiod character varying(255) NOT NULL,
  employerphone character varying(60),
  CONSTRAINT usercvreference_pkid PRIMARY KEY (pkid)
);
ALTER TABLE usercvreference OWNER TO fnctlint;

-- Table: usercvreferences

-- DROP TABLE usercvreferences;

CREATE TABLE usercvreferences
(
  cvdetail_fkid integer NOT NULL,
  cvreference_fkid integer NOT NULL,
  CONSTRAINT usercvreferences_pkid PRIMARY KEY (cvdetail_fkid, cvreference_fkid)
);
ALTER TABLE usercvreferences OWNER TO fnctlint;

-- Table: career

-- DROP TABLE career;

CREATE TABLE career
(
  pkid integer NOT NULL,
  "name" character varying(100) NOT NULL,
  CONSTRAINT career_pkid PRIMARY KEY (pkid)
);
ALTER TABLE career OWNER TO fnctlint;
COMMENT ON TABLE career IS 'List of available careers.';

-- Table: employmentstatus

-- DROP TABLE employmentstatus;

CREATE TABLE employmentstatus
(
  "name" character varying(50) NOT NULL,
  pkid integer NOT NULL,
  CONSTRAINT employmentstatus_pkid PRIMARY KEY (pkid)
);
ALTER TABLE employmentstatus OWNER TO fnctlint;

-- Table: marketsegment

-- DROP TABLE marketsegment;

CREATE TABLE marketsegment
(
  pkid integer NOT NULL,
  "name" character varying(100) NOT NULL,
  CONSTRAINT marketsegment_pkid PRIMARY KEY (pkid)
);
ALTER TABLE marketsegment OWNER TO fnctlint;
COMMENT ON TABLE marketsegment IS 'The different market segments.';

