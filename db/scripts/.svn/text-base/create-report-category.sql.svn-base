-- Table: report_category

-- DROP TABLE report_category;

CREATE TABLE report_category
(
  pkid integer NOT NULL,
  "name" character varying(64) NOT NULL,
  image character varying(64),
  ispositive boolean NOT NULL DEFAULT true,
  CONSTRAINT report_category_pkey PRIMARY KEY (pkid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE report_category OWNER TO fnctlint;
GRANT ALL ON TABLE report_category TO fnctlint;
GRANT ALL ON TABLE report_category TO fnctlint_ipiweb;
