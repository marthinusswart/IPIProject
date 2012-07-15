-- View: _v_report

-- DROP VIEW _v_report;

CREATE OR REPLACE VIEW _v_report AS 
 SELECT a.pkid AS assmtid, a.fkuser AS usrid, a.fkq AS qreid, q.name AS qname, to_char(a.submittime, 'Dy, DD Mon. HH24:MI'::text) AS submittime, c.pkid AS custid, c.name AS custname, u.username, u.title, u.fname, u.initial, u.lname
   FROM _assignment a, users u, customer c, questionaire q
  WHERE a.fkuser = u.pkid AND a.fkq = q.pkid AND u.fkcustid = c.pkid AND a.fktststatus = 2
  ORDER BY c.name, u.username;

ALTER TABLE _v_report OWNER TO fnctlint;
GRANT ALL ON TABLE _v_report TO fnctlint;
GRANT ALL ON TABLE _v_report TO fnctlint_ipiweb;

-- Function: getreports()

-- DROP FUNCTION getreports();

CREATE OR REPLACE FUNCTION getreports()
  RETURNS SETOF _v_report AS
$BODY$ 
	SELECT * FROM _v_Report; 
$BODY$
  LANGUAGE 'sql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION getreports() OWNER TO fnctlint;

-- Function: getreportsbycustid(integer)

-- DROP FUNCTION getreportsbycustid(integer);

CREATE OR REPLACE FUNCTION getreportsbycustid(integer)
  RETURNS SETOF _v_report AS
$BODY$ 
	SELECT * FROM _v_Report WHERE custID = $1; 
$BODY$
  LANGUAGE 'sql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION getreportsbycustid(integer) OWNER TO fnctlint;

-- Function: getreportbyassmtid(integer)

-- DROP FUNCTION getreportbyassmtid(integer);

CREATE OR REPLACE FUNCTION getreportbyassmtid(integer)
  RETURNS SETOF _v_report AS
$BODY$ 
	SELECT * FROM _v_Report WHERE assmtID = $1; 
$BODY$
  LANGUAGE 'sql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION getreportbyassmtid(integer) OWNER TO fnctlint;

-- View: _v_assmts

-- DROP VIEW _v_assmts;

CREATE OR REPLACE VIEW _v_assmts AS 
 SELECT a.pkid AS assmt_num, q.pkid AS qre_num, q.name AS qre, u.username, t.descr AS status
   FROM _assignment a, questionaire q, users u, test_status t
  WHERE a.fkuser = u.pkid AND a.fkq = q.pkid AND t.pkid = a.fktststatus
  ORDER BY u.username;

ALTER TABLE _v_assmts OWNER TO fnctlint;
GRANT ALL ON TABLE _v_assmts TO fnctlint;
GRANT ALL ON TABLE _v_assmts TO fnctlint_ipiweb;

-- View: _v_qre

-- DROP VIEW _v_qre;

CREATE OR REPLACE VIEW _v_qre AS 
 SELECT questionaire.pkid AS qreid, questionaire.name AS name, questionaire.descr
   FROM questionaire;

ALTER TABLE _v_qre OWNER TO fnctlint;
GRANT ALL ON TABLE _v_qre TO fnctlint;
GRANT ALL ON TABLE _v_qre TO fnctlint_ipiweb;

-- View: answered_qres

-- DROP VIEW answered_qres;

CREATE OR REPLACE VIEW answered_qres AS 
 SELECT a.pkid AS assmt_num, q.name AS qre, u.username, count(*) AS num_answered
   FROM _assignment a, questionaire q, users u, _answer an
  WHERE an.fkassmt = a.pkid AND a.fkuser = u.pkid AND a.fkq = q.pkid
  GROUP BY a.pkid, q.name, u.username
  ORDER BY u.username;

ALTER TABLE answered_qres OWNER TO fnctlint;
GRANT ALL ON TABLE answered_qres TO fnctlint;

-- View: assmts

-- DROP VIEW assmts;

CREATE OR REPLACE VIEW assmts AS 
 SELECT a.pkid AS assmt_num, q.pkid AS qre_num, q.name AS qre, u.username, t.descr AS status
   FROM _assignment a, questionaire q, users u, test_status t
  WHERE a.fkuser = u.pkid AND a.fkq = q.pkid AND t.pkid = a.fktststatus
  ORDER BY u.username;

ALTER TABLE assmts OWNER TO fnctlint;
GRANT ALL ON TABLE assmts TO fnctlint;



