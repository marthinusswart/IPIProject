-- Table: report_category_construct

-- DROP TABLE report_category_construct;

CREATE TABLE report_category_construct
(
  fkrc integer NOT NULL,
  fkc integer NOT NULL,
  "order" integer,
  CONSTRAINT report_category_construct_pkey PRIMARY KEY (fkrc, fkc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE report_category_construct OWNER TO fnctlint;
GRANT ALL ON TABLE report_category_construct TO fnctlint;
GRANT ALL ON TABLE report_category_construct TO fnctlint_ipiweb;
