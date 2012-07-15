--
-- PostgreSQL database dump
--

\connect - fnctlint

SET search_path = public, pg_catalog;

--
-- TOC entry 3 (OID 16981)
-- Name: customer; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE customer (
    pkid serial NOT NULL,
    name character varying(50) NOT NULL,
    credits integer DEFAULT 0,
    code character varying(3),
    fkrootcust integer DEFAULT -999,
    fkparentcust integer DEFAULT -999
);


--
-- TOC entry 4 (OID 16981)
-- Name: customer; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE customer FROM PUBLIC;
GRANT ALL ON TABLE customer TO fnctlint_ipiweb;


--
-- TOC entry 75 (OID 16981)
-- Name: customer_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE customer_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE customer_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 5 (OID 16989)
-- Name: userlevel; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE userlevel (
    pkid serial NOT NULL,
    lvlname character varying(15)
);


--
-- TOC entry 6 (OID 16989)
-- Name: userlevel; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE userlevel FROM PUBLIC;
GRANT ALL ON TABLE userlevel TO fnctlint_ipiweb;


--
-- TOC entry 77 (OID 16989)
-- Name: userlevel_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE userlevel_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE userlevel_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 7 (OID 16994)
-- Name: users; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE users (
    pkid serial NOT NULL,
    fkcustid integer NOT NULL,
    fklevel integer NOT NULL,
    username character varying(20) NOT NULL,
    "password" character varying(40) NOT NULL,
    initial character(1),
    fname character varying(20),
    lname character varying(20),
    title character varying(5),
    idnum character varying(16),
    compref character varying(20),
    telh character varying(15),
    telw character varying(15),
    fax character varying(15),
    cell character varying(15),
    email character varying(35),
    website character varying(50)
);


--
-- TOC entry 8 (OID 16994)
-- Name: users; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE users FROM PUBLIC;
GRANT ALL ON TABLE users TO fnctlint_ipiweb;


--
-- TOC entry 79 (OID 16994)
-- Name: users_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE users_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE users_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 9 (OID 16999)
-- Name: addresstype; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE addresstype (
    pkid serial NOT NULL,
    typedescr character varying(10) NOT NULL
);


--
-- TOC entry 10 (OID 16999)
-- Name: addresstype; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE addresstype FROM PUBLIC;
GRANT ALL ON TABLE addresstype TO fnctlint_ipiweb;


--
-- TOC entry 81 (OID 16999)
-- Name: addresstype_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE addresstype_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE addresstype_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 11 (OID 17002)
-- Name: address; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE address (
    fkuserid integer NOT NULL,
    fkaddrtype integer NOT NULL,
    descr character varying(45),
    line1 character varying(45),
    line2 character varying(45),
    line3 character varying(45),
    areacode character varying(4)
);


--
-- TOC entry 12 (OID 17002)
-- Name: address; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE address FROM PUBLIC;
GRANT ALL ON TABLE address TO fnctlint_ipiweb;


--
-- TOC entry 13 (OID 17006)
-- Name: questionaire; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE questionaire (
    pkid serial NOT NULL,
    name character varying(30) NOT NULL,
    descr character varying(250),
    qwording integer DEFAULT 0,
    fktypeid integer DEFAULT -1
);


--
-- TOC entry 14 (OID 17006)
-- Name: questionaire; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE questionaire FROM PUBLIC;
GRANT ALL ON TABLE questionaire TO fnctlint_ipiweb;


--
-- TOC entry 83 (OID 17006)
-- Name: questionaire_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE questionaire_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE questionaire_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 15 (OID 17013)
-- Name: super_construct; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE super_construct (
    pkid serial NOT NULL,
    code character(1) NOT NULL,
    name character varying(30) NOT NULL,
    descr character varying(250)
);


--
-- TOC entry 16 (OID 17013)
-- Name: super_construct; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE super_construct FROM PUBLIC;
GRANT ALL ON TABLE super_construct TO fnctlint_ipiweb;


--
-- TOC entry 85 (OID 17013)
-- Name: super_construct_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE super_construct_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE super_construct_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 17 (OID 17016)
-- Name: _q_sc_entry; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE _q_sc_entry (
    fkq integer NOT NULL,
    fksc integer NOT NULL
);


--
-- TOC entry 18 (OID 17016)
-- Name: _q_sc_entry; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _q_sc_entry FROM PUBLIC;
GRANT ALL ON TABLE _q_sc_entry TO fnctlint_ipiweb;


--
-- TOC entry 19 (OID 17020)
-- Name: construct; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE construct (
    pkid serial NOT NULL,
    fksc integer NOT NULL,
    name character varying(40) NOT NULL,
    descr character varying(250),
    isoptional boolean DEFAULT false,
    ispositive boolean DEFAULT false,
    isneutral boolean DEFAULT false
);


--
-- TOC entry 20 (OID 17020)
-- Name: construct; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE construct FROM PUBLIC;
GRANT ALL ON TABLE construct TO fnctlint_ipiweb;


--
-- TOC entry 87 (OID 17020)
-- Name: construct_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE construct_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE construct_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 21 (OID 17026)
-- Name: _qsce_c_exclude; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE _qsce_c_exclude (
    fkq integer NOT NULL,
    fksc integer NOT NULL,
    fkc integer NOT NULL
);


--
-- TOC entry 22 (OID 17026)
-- Name: _qsce_c_exclude; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _qsce_c_exclude FROM PUBLIC;
GRANT ALL ON TABLE _qsce_c_exclude TO fnctlint_ipiweb;


--
-- TOC entry 23 (OID 17030)
-- Name: question; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE question (
    pkid serial NOT NULL,
    fkc integer NOT NULL,
    corder smallint NOT NULL,
    isinverted boolean DEFAULT false
);


--
-- TOC entry 24 (OID 17030)
-- Name: question; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE question FROM PUBLIC;
GRANT ALL ON TABLE question TO fnctlint_ipiweb;


--
-- TOC entry 89 (OID 17030)
-- Name: question_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE question_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE question_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 25 (OID 17034)
-- Name: wording; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE wording (
    fkqn integer NOT NULL,
    alt smallint DEFAULT 0 NOT NULL,
    wording character varying(150)
);


--
-- TOC entry 27 (OID 17034)
-- Name: wording; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE wording FROM PUBLIC;
GRANT ALL ON TABLE wording TO fnctlint_ipiweb;


--
-- TOC entry 28 (OID 17039)
-- Name: test_status; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE test_status (
    pkid serial NOT NULL,
    descr character varying(15)
);


--
-- TOC entry 29 (OID 17039)
-- Name: test_status; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE test_status FROM PUBLIC;
GRANT ALL ON TABLE test_status TO fnctlint_ipiweb;


--
-- TOC entry 91 (OID 17039)
-- Name: test_status_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE test_status_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE test_status_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 30 (OID 17044)
-- Name: _assignment; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE _assignment (
    pkid serial NOT NULL,
    fkuser integer NOT NULL,
    fkq integer NOT NULL,
    fktststatus integer DEFAULT 0 NOT NULL,
    submittime timestamp without time zone
);


--
-- TOC entry 31 (OID 17044)
-- Name: _assignment; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _assignment FROM PUBLIC;
GRANT ALL ON TABLE _assignment TO fnctlint_ipiweb;


--
-- TOC entry 93 (OID 17044)
-- Name: _assignment_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _assignment_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE _assignment_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 32 (OID 17048)
-- Name: _answer; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE _answer (
    fkqn integer NOT NULL,
    fkassmt integer NOT NULL,
    answer smallint NOT NULL,
    timetaken integer NOT NULL,
    ndoubted smallint NOT NULL,
    splitset smallint DEFAULT 1 NOT NULL
);


--
-- TOC entry 33 (OID 17048)
-- Name: _answer; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _answer FROM PUBLIC;
GRANT ALL ON TABLE _answer TO fnctlint_ipiweb;


--
-- TOC entry 34 (OID 17053)
-- Name: usrlist; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW usrlist AS
    SELECT u.username, u."password", u.fname AS first_name, u.lname AS last_name, u.email, l.lvlname AS user_level, c.name AS organization FROM users u, userlevel l, customer c WHERE (((u.fkcustid = c.pkid) AND (u.fklevel = l.pkid)) AND (u.pkid > 3)) ORDER BY u.lname, u.fname, l.pkid, c.name;


--
-- TOC entry 35 (OID 17053)
-- Name: usrlist; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE usrlist FROM PUBLIC;


--
-- TOC entry 36 (OID 17056)
-- Name: answered_qres; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW answered_qres AS
    SELECT a.pkid AS assmt_num, q.name AS qre, u.username, count(*) AS num_answered FROM _assignment a, questionaire q, users u, _answer an WHERE (((an.fkassmt = a.pkid) AND (a.fkuser = u.pkid)) AND (a.fkq = q.pkid)) GROUP BY a.pkid, q.name, u.username ORDER BY u.username;


--
-- TOC entry 37 (OID 17056)
-- Name: answered_qres; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE answered_qres FROM PUBLIC;


--
-- TOC entry 123 (OID 17057)
-- Name: getqreqnids (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION getqreqnids (integer) RETURNS SETOF integer
    AS '
        SELECT DISTINCT qn.pkid 
            FROM 
                    questionaire q, _q_sc_entry qe, super_construct sc, Construct c, question qn 
            WHERE 
                    (q.pkid= $1) AND (qe.fkQ=q.pkid) AND 
                    (qe.fkSC=sc.pkid) AND (c.fkSC=sc.pkid) AND (qn.fkC=c.pkid) 
            EXCEPT ALL 
            SELECT DISTINCT qn.pkid 
            FROM 
                    questionaire q, _q_sc_entry qe, super_construct sc, 
                    _qsce_c_exclude qx, Construct c, question qn 
            WHERE 
                    (q.pkid= $1) AND (qe.fkQ=q.pkid) AND 
                    (qe.fkSC=sc.pkid) AND (qx.fkQ=q.pkid) AND (qx.fkSC=sc.pkid) AND 
                    (qx.fkC=c.pkid) AND (c.fkSC=sc.pkid) AND (qn.fkC=c.pkid) 
'
    LANGUAGE sql;


--
-- TOC entry 38 (OID 17060)
-- Name: assmts; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW assmts AS
    SELECT a.pkid AS assmt_num, q.pkid AS qre_num, q.name AS qre, u.username, t.descr AS status FROM _assignment a, questionaire q, users u, test_status t WHERE (((a.fkuser = u.pkid) AND (a.fkq = q.pkid)) AND (t.pkid = a.fktststatus)) ORDER BY u.username;


--
-- TOC entry 39 (OID 17060)
-- Name: assmts; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE assmts FROM PUBLIC;


--
-- TOC entry 124 (OID 17061)
-- Name: resetassmt (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION resetassmt (integer) RETURNS integer
    AS '
	DELETE FROM _Answer WHERE fkAssmt = $1;
	UPDATE _Assignment 
	SET fkTstStatus = 0, submittime = NULL
	WHERE pkid = $1;
	SELECT 1;
'
    LANGUAGE sql;


--
-- TOC entry 125 (OID 17061)
-- Name: resetassmt (integer); Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON FUNCTION resetassmt (integer) FROM PUBLIC;


--
-- TOC entry 40 (OID 17064)
-- Name: _v_assmts; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_assmts AS
    SELECT a.pkid AS assmt_num, q.pkid AS qre_num, q.name AS qre, u.username, t.descr AS status FROM _assignment a, questionaire q, users u, test_status t WHERE (((a.fkuser = u.pkid) AND (a.fkq = q.pkid)) AND (t.pkid = a.fktststatus)) ORDER BY u.username;


--
-- TOC entry 41 (OID 17064)
-- Name: _v_assmts; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_assmts FROM PUBLIC;
GRANT ALL ON TABLE _v_assmts TO fnctlint_ipiweb;
GRANT SELECT ON TABLE _v_assmts TO fnctlint_export;


--
-- TOC entry 42 (OID 17067)
-- Name: _v_report; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_report AS
    SELECT a.pkid AS assmtid, a.fkuser AS usrid, a.fkq AS qreid, q.name AS qname, to_char(a.submittime, 'Dy, DD Mon. HH24:MI'::text) AS submittime, c.pkid AS custid, c.name AS custname, u.username, u.title, u.fname, u.initial, u.lname FROM _assignment a, users u, customer c, questionaire q WHERE ((((a.fkuser = u.pkid) AND (a.fkq = q.pkid)) AND (u.fkcustid = c.pkid)) AND (a.fktststatus = 2)) ORDER BY c.name, u.username;


--
-- TOC entry 43 (OID 17067)
-- Name: _v_report; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_report FROM PUBLIC;
GRANT ALL ON TABLE _v_report TO fnctlint_ipiweb;
GRANT SELECT ON TABLE _v_report TO fnctlint_export;


--
-- TOC entry 44 (OID 17070)
-- Name: _v_repanswerlist; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_repanswerlist AS
    SELECT ans.fkassmt AS assmtid, qn.fkc AS constid, ans.answer, ans.timetaken, ans.ndoubted, qn.isinverted FROM _answer ans, question qn WHERE (ans.fkqn = qn.pkid) ORDER BY ans.fkassmt, qn.fkc;


--
-- TOC entry 45 (OID 17070)
-- Name: _v_repanswerlist; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_repanswerlist FROM PUBLIC;
GRANT ALL ON TABLE _v_repanswerlist TO fnctlint_ipiweb;
GRANT SELECT ON TABLE _v_repanswerlist TO fnctlint_export;


--
-- TOC entry 126 (OID 17071)
-- Name: countreports (); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION countreports () RETURNS bigint
    AS ' 
	SELECT COUNT(*) FROM _v_Report; 
'
    LANGUAGE sql;


--
-- TOC entry 140 (OID 17072)
-- Name: countcustreports (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION countcustreports (integer) RETURNS bigint
    AS ' 
	SELECT COUNT(*) 
	FROM (SELECT * FROM _v_Report WHERE custID = $1) as foo; 
'
    LANGUAGE sql;


--
-- TOC entry 127 (OID 17073)
-- Name: countrepanswers (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION countrepanswers (integer) RETURNS bigint
    AS ' 
	SELECT COUNT(*) FROM _v_RepAnswerList WHERE assmtID = $1; 
'
    LANGUAGE sql;


--
-- TOC entry 128 (OID 17074)
-- Name: getreports (); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION getreports () RETURNS SETOF _v_report
    AS ' 
	SELECT * FROM _v_Report; 
'
    LANGUAGE sql;


--
-- TOC entry 129 (OID 17075)
-- Name: getreportsbycustid (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION getreportsbycustid (integer) RETURNS SETOF _v_report
    AS ' 
	SELECT * FROM _v_Report WHERE custID = $1; 
'
    LANGUAGE sql;


--
-- TOC entry 130 (OID 17076)
-- Name: getreportbyassmtid (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION getreportbyassmtid (integer) RETURNS SETOF _v_report
    AS ' 
	SELECT * FROM _v_Report WHERE assmtID = $1; 
'
    LANGUAGE sql;


--
-- TOC entry 131 (OID 17077)
-- Name: getrepanswersbyassmtid (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION getrepanswersbyassmtid (integer) RETURNS SETOF _v_repanswerlist
    AS ' 
	SELECT * FROM _v_RepAnswerList WHERE assmtID = $1; 
'
    LANGUAGE sql;


--
-- TOC entry 132 (OID 17078)
-- Name: unlockassmt (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION unlockassmt (integer) RETURNS integer
    AS '
	UPDATE _Assignment 
	SET fkTstStatus = 1
	WHERE pkid = $1;
	SELECT 1;
'
    LANGUAGE sql;


--
-- TOC entry 133 (OID 17078)
-- Name: unlockassmt (integer); Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON FUNCTION unlockassmt (integer) FROM PUBLIC;


--
-- TOC entry 46 (OID 17081)
-- Name: _v_custlist; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_custlist AS
    SELECT customer.pkid AS custid, customer.name FROM customer;


--
-- TOC entry 47 (OID 17081)
-- Name: _v_custlist; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_custlist FROM PUBLIC;
GRANT ALL ON TABLE _v_custlist TO fnctlint_ipiweb;
GRANT SELECT ON TABLE _v_custlist TO fnctlint_export;


--
-- TOC entry 48 (OID 17084)
-- Name: _v_userlist; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_userlist AS
    SELECT users.pkid AS usrid, users.fkcustid AS custid, users.username, users.initial, users.fname, users.lname, users.title, users.idnum, users.compref, users.telh, users.telw, users.fax, users.cell, users.email FROM users WHERE (users.fklevel = 3);


--
-- TOC entry 49 (OID 17084)
-- Name: _v_userlist; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_userlist FROM PUBLIC;
GRANT ALL ON TABLE _v_userlist TO fnctlint_ipiweb;
GRANT SELECT ON TABLE _v_userlist TO fnctlint_export;


--
-- TOC entry 50 (OID 17087)
-- Name: _v_const; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_const AS
    SELECT construct.pkid AS cid, construct.fksc AS scid, construct.name, construct.isoptional, construct.ispositive, construct.isneutral FROM construct;


--
-- TOC entry 51 (OID 17087)
-- Name: _v_const; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_const FROM PUBLIC;
GRANT ALL ON TABLE _v_const TO fnctlint_ipiweb;
GRANT SELECT ON TABLE _v_const TO fnctlint_export;


--
-- TOC entry 52 (OID 17090)
-- Name: _v_sconst; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_sconst AS
    SELECT super_construct.pkid AS scid, super_construct.code, super_construct.name FROM super_construct;


--
-- TOC entry 53 (OID 17090)
-- Name: _v_sconst; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_sconst FROM PUBLIC;
GRANT ALL ON TABLE _v_sconst TO fnctlint_ipiweb;
GRANT SELECT ON TABLE _v_sconst TO fnctlint_export;


--
-- TOC entry 54 (OID 17093)
-- Name: _v_qre; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_qre AS
    SELECT questionaire.pkid AS qreid, questionaire.name, questionaire.descr FROM questionaire;


--
-- TOC entry 55 (OID 17093)
-- Name: _v_qre; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_qre FROM PUBLIC;
GRANT ALL ON TABLE _v_qre TO fnctlint_ipiweb;
GRANT SELECT ON TABLE _v_qre TO fnctlint_export;


--
-- TOC entry 56 (OID 17096)
-- Name: registration; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE registration (
    pkid serial NOT NULL,
    username character varying(20) NOT NULL,
    "password" character varying(40) NOT NULL,
    initial character(1),
    fname character varying(20),
    lname character varying(20),
    title character varying(5),
    idnum character varying(16),
    compref character varying(20),
    telh character varying(15),
    telw character varying(15),
    fax character varying(15),
    cell character varying(15),
    email character varying(35),
    addrh1 character varying(45),
    addrh2 character varying(45),
    addrh3 character varying(45),
    addrh4 character varying(4),
    addrp1 character varying(45),
    addrp2 character varying(45),
    addrp3 character varying(45),
    addrp4 character varying(4),
    hq integer,
    emailok boolean DEFAULT false,
    submittime timestamp without time zone DEFAULT now()
);


--
-- TOC entry 57 (OID 17096)
-- Name: registration; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE registration FROM PUBLIC;
GRANT ALL ON TABLE registration TO fnctlint_ipiweb;


--
-- TOC entry 95 (OID 17096)
-- Name: registration_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE registration_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE registration_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 58 (OID 17103)
-- Name: qualification_code; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE qualification_code (
    pkid serial NOT NULL,
    name character varying(127)
);


--
-- TOC entry 59 (OID 17103)
-- Name: qualification_code; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE qualification_code FROM PUBLIC;
GRANT ALL ON TABLE qualification_code TO fnctlint_ipiweb;


--
-- TOC entry 97 (OID 17103)
-- Name: qualification_code_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE qualification_code_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE qualification_code_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 60 (OID 17106)
-- Name: qualification; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE qualification (
    fkusrid integer NOT NULL,
    fkqcode integer NOT NULL
);


--
-- TOC entry 61 (OID 17106)
-- Name: qualification; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE qualification FROM PUBLIC;
GRANT ALL ON TABLE qualification TO fnctlint_ipiweb;


--
-- TOC entry 62 (OID 17110)
-- Name: advert; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE advert (
    pkid serial NOT NULL,
    fkcustid integer NOT NULL,
    descr character varying(127),
    issuedate date
);


--
-- TOC entry 63 (OID 17110)
-- Name: advert; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE advert FROM PUBLIC;
GRANT ALL ON TABLE advert TO fnctlint_ipiweb;


--
-- TOC entry 99 (OID 17110)
-- Name: advert_pkid_seq; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE advert_pkid_seq FROM PUBLIC;
GRANT ALL ON TABLE advert_pkid_seq TO fnctlint_ipiweb;


--
-- TOC entry 134 (OID 17113)
-- Name: getcustadcount (character varying, integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION getcustadcount (character varying, integer) RETURNS bigint
    AS ' 
	SELECT COUNT(*) 
	FROM 
		advert a, 
		(SELECT username, upper(compref) as compref 
		FROM registration 
		UNION 
		SELECT username, upper(compref) as compref 
		FROM users) as foo 
	WHERE a.pkid=substr(compref, 4) AND compref like $1 || $2 
	GROUP by compref, a.pkid; 
'
    LANGUAGE sql;


--
-- TOC entry 135 (OID 17114)
-- Name: getorguser (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION getorguser (integer) RETURNS SETOF users
    AS ' 
	SELECT * FROM Users 
	WHERE fkCustID = $1 AND fkLevel=2
'
    LANGUAGE sql;


--
-- TOC entry 136 (OID 17115)
-- Name: deladdr (integer, integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION deladdr (integer, integer) RETURNS integer
    AS '  
	DELETE FROM Address 
	WHERE fkUserID = $1 AND fkAddrType = $2;
	SELECT 1;
'
    LANGUAGE sql;


--
-- TOC entry 64 (OID 17116)
-- Name: qre_type; Type: TABLE; Schema: public; Owner: fnctlint
--

CREATE TABLE qre_type (
    pkid integer NOT NULL,
    code character(2) NOT NULL,
    name character varying(50)
);


--
-- TOC entry 66 (OID 17116)
-- Name: qre_type; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE qre_type FROM PUBLIC;
GRANT ALL ON TABLE qre_type TO fnctlint_ipiweb;


--
-- TOC entry 137 (OID 17118)
-- Name: countparticipants (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION countparticipants (integer) RETURNS bigint
    AS ' 
	SELECT COUNT(*) FROM _Assignment a, Users u 
	WHERE fkQ = $1 AND fkUser=u.pkid AND u.fkLevel=3;
'
    LANGUAGE sql;


--
-- TOC entry 138 (OID 17119)
-- Name: countparticipantsbycustid (integer, integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION countparticipantsbycustid (integer, integer) RETURNS bigint
    AS ' 
	SELECT COUNT(*) FROM _Assignment a, Users u 
	WHERE fkQ = $1 AND u.fkCustID = $2 AND fkUser=u.pkid AND u.fkLevel=3;
'
    LANGUAGE sql;


--
-- TOC entry 139 (OID 17120)
-- Name: countuserassmts (integer); Type: FUNCTION; Schema: public; Owner: fnctlint
--

CREATE FUNCTION countuserassmts (integer) RETURNS bigint
    AS ' 
	SELECT COUNT(*) FROM _Assignment a 
	WHERE fkUser = $1;
'
    LANGUAGE sql;


--
-- TOC entry 67 (OID 17123)
-- Name: _v_assmts2_w_date; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_assmts2_w_date AS
    SELECT a.pkid AS assmt_num, q.pkid AS qre_num, q.name AS qre, u.username, t.descr AS status, a.submittime FROM _assignment a, questionaire q, users u, test_status t WHERE (((a.fkuser = u.pkid) AND (a.fkq = q.pkid)) AND (t.pkid = a.fktststatus)) ORDER BY u.username;


--
-- TOC entry 69 (OID 17123)
-- Name: _v_assmts2_w_date; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_assmts2_w_date FROM PUBLIC;
GRANT SELECT ON TABLE _v_assmts2_w_date TO fnctlint_export;


--
-- TOC entry 2 (OID 17128)
-- Name: pkids; Type: DOMAIN; Schema: public; Owner: fnctlint
--

CREATE DOMAIN pkids AS integer[];


--
-- TOC entry 70 (OID 17133)
-- Name: _v_custparent; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_custparent AS
    SELECT customer.pkid AS id, customer.fkparentcust AS parentid FROM customer;


--
-- TOC entry 71 (OID 17133)
-- Name: _v_custparent; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_custparent FROM PUBLIC;
GRANT SELECT ON TABLE _v_custparent TO fnctlint_export;


--
-- TOC entry 72 (OID 990324)
-- Name: _v_qna; Type: VIEW; Schema: public; Owner: fnctlint
--

CREATE VIEW _v_qna AS
    SELECT ans.fkassmt AS assignment_no, qn.fkc AS construct_no, ans.fkqn AS question_no, w.wording AS question, ans.answer FROM _answer ans, question qn, wording w WHERE (((ans.fkqn = qn.pkid) AND (w.fkqn = qn.pkid)) AND (w.alt = 0)) ORDER BY ans.fkassmt, ans.fkqn;


--
-- TOC entry 73 (OID 990324)
-- Name: _v_qna; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_qna FROM PUBLIC;
GRANT SELECT ON TABLE _v_qna TO fnctlint_export;


--
-- Data for TOC entry 142 (OID 16981)
-- Name: customer; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO customer VALUES (18, 'IPi SA', 3000, 'ZRB', 0, 0);
INSERT INTO customer VALUES (20, 'IPi NZ', 0, '+BU', 0, 0);
INSERT INTO customer VALUES (21, 'IPi Recruitment (test)', 0, '?ZP', 0, 18);
INSERT INTO customer VALUES (22, 'IPi Forensics', 0, '5JX', 0, 18);
INSERT INTO customer VALUES (24, 'Workaholics Corp', 0, 'P2D', 0, 21);
INSERT INTO customer VALUES (23, 'Jobseekers Inc.', 0, 'H%N', 0, 21);
INSERT INTO customer VALUES (26, 'CSI Miami', 0, 'T+D', 0, 22);
INSERT INTO customer VALUES (25, 'CSI', 0, '@5Y', 0, 22);
INSERT INTO customer VALUES (27, 'CSI NY', 0, 'MVV', 0, 22);
INSERT INTO customer VALUES (28, 'Ballistics', 0, 'EK6', 0, 25);
INSERT INTO customer VALUES (29, 'DNA Analysis', 0, 'M2B', 0, 25);
INSERT INTO customer VALUES (32, 'Scanning Electro-Microscopy', 0, '9JN', 0, 25);
INSERT INTO customer VALUES (33, 'Pathology', 0, '%VP', 0, 25);
INSERT INTO customer VALUES (34, 'IPi (USA) - Forensics', 0, 'LHQ', 0, 19);
INSERT INTO customer VALUES (35, 'Freebies', 0, 'PRM', 0, 19);
INSERT INTO customer VALUES (19, 'IPi USA', 5, 'VVX', 0, 0);
INSERT INTO customer VALUES (45, 'Amcotech 1', 0, 'MSU', 37, 37);
INSERT INTO customer VALUES (44, 'Amcotech', 0, '8&P', 37, 37);
INSERT INTO customer VALUES (47, 'Interpreters 01', 1, 'ENV', 37, 37);
INSERT INTO customer VALUES (58, 'HR', 0, 'S@D', 57, 57);
INSERT INTO customer VALUES (59, 'IT', 0, '3VZ', 57, 57);
INSERT INTO customer VALUES (60, 'Administration', 0, 'LT8', 57, 58);
INSERT INTO customer VALUES (61, 'Kingsway High School', 5, 'YBX', -999, -999);
INSERT INTO customer VALUES (0, 'FQGlobal Headoffice', 99, 'IPI', -999, -999);
INSERT INTO customer VALUES (66, 'FQGlobal America', 100, 'X$D', -999, -999);
INSERT INTO customer VALUES (64, 'Clear Channel', 6, 'SWZ', 62, 62);
INSERT INTO customer VALUES (65, 'Accounts', 13, 'U6&', 62, 64);
INSERT INTO customer VALUES (62, 'FQGlobal South Africa', 85, 'E&U', -999, -999);


--
-- Data for TOC entry 143 (OID 16989)
-- Name: userlevel; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO userlevel VALUES (1, 'administrator');
INSERT INTO userlevel VALUES (2, 'organization');
INSERT INTO userlevel VALUES (3, 'individual');


--
-- Data for TOC entry 144 (OID 16994)
-- Name: users; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO users VALUES (2, 0, 1, 'ipiAdmin', '1p1@dm1n', 'I', 'Neil', 'Whitehouse', 'Dr.', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'www.fqinstitute.com');
INSERT INTO users VALUES (4, 0, 3, 'NeilW', 'lrORPW', 'N', 'Neil', 'Whitehouse', 'Mr.', ' ', ' ', ' ', ' ', ' ', ' ', 'info@fqinstitute.com', ' ');
INSERT INTO users VALUES (5, 0, 3, 'neilipi', 'NI3F8u', 'N', 'Neil', 'Whitehouse', 'Dr.', '420228', 'ipi002', '0123357124', '0126531555', '0126531847', '0836809881', 'neil@fqinstitute.com', ' ');
INSERT INTO users VALUES (6, 0, 3, 'johannesl', 'oVdXJ5Y', ' ', 'Johannes', 'Lombaard', 'Mr.', ' ', ' ', ' ', ' ', ' ', '0832906383', 'johannesl@feathertechnologies.com', ' ');
INSERT INTO users VALUES (7, 0, 3, 'marthinus', 'ms2', 'M', 'Marthinus', 'Swart', 'Mr.', ' ', 'IPI30', ' ', ' ', ' ', ' ', 'marthinus.swart@gmail.com', ' ');
INSERT INTO users VALUES (9, 0, 3, 'assessmentb', 'assessmentb', 'B', 'AssessmentB', 'Test', 'Mr.', ' ', 'IPI30', ' ', ' ', ' ', ' ', 'assessmentb@gmail.com', ' ');
INSERT INTO users VALUES (10, 0, 3, 'assessmentc', 'assessmentc', 'C', 'AssessmentC', 'Test', 'Mr.', ' ', 'IPI30', ' ', ' ', ' ', ' ', 'assessmentc@gmail.com', ' ');
INSERT INTO users VALUES (11, 0, 3, 'assessmentd', 'assessmentd', 'D', 'AssessmentD', 'Test', 'Mr.', ' ', 'IPI30', ' ', ' ', ' ', ' ', 'assessmentd@gmail.com', ' ');
INSERT INTO users VALUES (12, 0, 3, 'assessmente', 'assessmente', 'E', 'AssessmentE', 'Test', 'Mr.', ' ', 'IPI30', ' ', ' ', ' ', ' ', 'assessmente@gmail.com', ' ');
INSERT INTO users VALUES (13, 0, 3, 'assessmentf', 'assessmentf', 'F', 'AssessmentF', 'Test', 'Mr.', ' ', 'IPI30', ' ', ' ', ' ', ' ', 'assessmentf@gmail.com', ' ');
INSERT INTO users VALUES (14, 0, 3, 'marthinus2', 'ms2', 'M', 'Marthinus2', 'Swart', 'Mr.', ' ', 'IPI30', ' ', ' ', ' ', ' ', 'marthinus.swart@gmail.com', ' ');
INSERT INTO users VALUES (646, 61, 2, 'lindaswart', 'KZuVav', NULL, 'Linda', 'Swart', 'Mrs.', '34567', '1001', NULL, '094270950', NULL, '0211403785', 'linda-c@kingsway.school.nz', NULL);
INSERT INTO users VALUES (647, 61, 3, 'neilwhitehouse', '+kyDeQ', NULL, 'Neil', 'Whitehouse', 'Dr.', '9876543', 'IPI0', NULL, NULL, NULL, '02102431963', 'neil@fqglobal.com', NULL);
INSERT INTO users VALUES (648, 62, 2, 'robg@fqglobal', '9?HXr9', NULL, 'Rob', 'Gillespie', 'Mr.', NULL, '1002', NULL, '0828805820', NULL, '0828805820', 'robg@fqglobal.co.za', 'www.fqglobal.co.za');
INSERT INTO users VALUES (3, 0, 2, 'ipiOrg', '1p10rg', 'I', 'Neil', 'Whitehouse', 'Dr.', '42089', 'IPI Group', NULL, '(649)4767061', NULL, '(64)2102431963', 'neil@fqglobal.com', 'www.fqglobal.com');
INSERT INTO users VALUES (649, 0, 3, 'Jeandre', 'oyFkQQ%', NULL, 'Jeandre', 'Row', NULL, '123456', 'IPI44', NULL, NULL, NULL, '02102431963', 'neil@fqglobal.com', NULL);
INSERT INTO users VALUES (655, 66, 2, 'mikevz', 'o6oPWo', NULL, 'Michael', 'Vanzutphen', 'Mr.', '234567', 'X$D', NULL, '4802922159', NULL, '4802922159', 'mvz@fqglobal.com', 'www.career-advice-jobs.com');
INSERT INTO users VALUES (660, 66, 3, 'vztennis1', 's2&mnxs', NULL, 'mike', 'vanzutphen', NULL, '123', 'X$D50', NULL, NULL, NULL, NULL, 'mvz@fqglobal.com', NULL);
INSERT INTO users VALUES (661, 62, 3, 'Johnpaul', 'AaB2M3', NULL, 'John', 'Paul', 'Mr.', '2345', 'SWZ55', NULL, NULL, NULL, NULL, 'johnp@udc.com', NULL);
INSERT INTO users VALUES (653, 64, 2, 'clearchannel', 'gvphew5', NULL, 'Clear', 'Channel', NULL, NULL, 'E&U', NULL, '1234567889', NULL, NULL, 'basil@clearchannel.com', 'www.clearchannel.com');
INSERT INTO users VALUES (654, 65, 2, 'accounts', 'eGCkfh', NULL, 'Jonny', 'Begood', 'Mr.', '2345', 'E&U', NULL, '094243978', NULL, NULL, 'accounts@clearchannel.com', NULL);
INSERT INTO users VALUES (662, 62, 3, 'Prettywoman', 'CVJ3t4', NULL, 'Pretty', 'Woman', 'Mrs.', NULL, 'U6&48', NULL, NULL, NULL, NULL, 'prettyw@who.co.za', NULL);


--
-- Data for TOC entry 145 (OID 16999)
-- Name: addresstype; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO addresstype VALUES (1, 'Home');
INSERT INTO addresstype VALUES (2, 'Work');
INSERT INTO addresstype VALUES (3, 'Post');
INSERT INTO addresstype VALUES (4, 'Premesis');


--
-- Data for TOC entry 146 (OID 17002)
-- Name: address; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO address VALUES (647, 1, NULL, '940 B East Coast Road', 'North Shore City', 'Auckland', '0630');
INSERT INTO address VALUES (648, 4, NULL, '10 Summerdown Close', 'Lone Hill', 'Johannesburg', NULL);
INSERT INTO address VALUES (649, 1, NULL, NULL, NULL, NULL, '0630');
INSERT INTO address VALUES (655, 4, NULL, '104 Fairoaks Circle', 'Gadsden', 'Alabama', '3590');
INSERT INTO address VALUES (660, 1, NULL, NULL, NULL, NULL, '3590');
INSERT INTO address VALUES (660, 3, NULL, NULL, NULL, NULL, '3590');
INSERT INTO address VALUES (661, 1, NULL, NULL, NULL, NULL, '2002');
INSERT INTO address VALUES (653, 4, NULL, NULL, NULL, NULL, 'q123');
INSERT INTO address VALUES (654, 4, NULL, NULL, NULL, NULL, '2002');
INSERT INTO address VALUES (662, 1, NULL, NULL, NULL, NULL, '2001');
INSERT INTO address VALUES (662, 3, NULL, NULL, NULL, NULL, '2001');


--
-- Data for TOC entry 147 (OID 17006)
-- Name: questionaire; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO questionaire VALUES (60, 'High School Profile', 'High School Assessment  (Full)', 0, 6);
INSERT INTO questionaire VALUES (61, 'Recruitment Value Profile', 'Recruitment Values (personal Values and Market segment', 1, 1);
INSERT INTO questionaire VALUES (64, 'High School Career Inventory', 'High School Career Inventory (Values Segments)', 0, 6);
INSERT INTO questionaire VALUES (58, 'Do Not Use Needs Deleting', 'Career Planning Assessment including High School Assessments', 0, 7);
INSERT INTO questionaire VALUES (68, 'Organization Screening Invento', 'OSI for Staff members with Supervisor', 0, 4);
INSERT INTO questionaire VALUES (69, 'Personal Profile', 'Personal Profile (without Supervisor)', 0, 5);


--
-- Data for TOC entry 148 (OID 17013)
-- Name: super_construct; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO super_construct VALUES (1, 'A', 'Positive Functioning', NULL);
INSERT INTO super_construct VALUES (2, 'B', 'Negative Functioning', NULL);
INSERT INTO super_construct VALUES (3, 'C', 'Self Perception', NULL);
INSERT INTO super_construct VALUES (4, 'D', 'Relationship', NULL);
INSERT INTO super_construct VALUES (5, 'E', 'Financial Management', NULL);
INSERT INTO super_construct VALUES (6, 'F', 'Corporate Functioning', NULL);
INSERT INTO super_construct VALUES (7, 'G', 'Emotional Functioning', NULL);
INSERT INTO super_construct VALUES (8, 'H', 'Personal Values', NULL);
INSERT INTO super_construct VALUES (9, 'I', 'Leadership Dynamics', NULL);
INSERT INTO super_construct VALUES (10, 'J', 'Task Orientated Qualities', NULL);
INSERT INTO super_construct VALUES (11, 'K', 'Self Orientated Qualities', NULL);
INSERT INTO super_construct VALUES (12, 'L', 'People Orientated Qualities', NULL);
INSERT INTO super_construct VALUES (13, 'M', 'High School Problems', NULL);
INSERT INTO super_construct VALUES (14, 'N', 'High School Relationships', NULL);
INSERT INTO super_construct VALUES (15, 'O', 'Fields Of Interest', NULL);


--
-- Data for TOC entry 149 (OID 17016)
-- Name: _q_sc_entry; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO _q_sc_entry VALUES (64, 8);
INSERT INTO _q_sc_entry VALUES (64, 15);
INSERT INTO _q_sc_entry VALUES (58, 8);
INSERT INTO _q_sc_entry VALUES (58, 9);
INSERT INTO _q_sc_entry VALUES (58, 10);
INSERT INTO _q_sc_entry VALUES (58, 11);
INSERT INTO _q_sc_entry VALUES (58, 12);
INSERT INTO _q_sc_entry VALUES (58, 13);
INSERT INTO _q_sc_entry VALUES (58, 15);
INSERT INTO _q_sc_entry VALUES (60, 13);
INSERT INTO _q_sc_entry VALUES (60, 14);
INSERT INTO _q_sc_entry VALUES (60, 8);
INSERT INTO _q_sc_entry VALUES (60, 15);
INSERT INTO _q_sc_entry VALUES (61, 8);
INSERT INTO _q_sc_entry VALUES (61, 15);
INSERT INTO _q_sc_entry VALUES (68, 1);
INSERT INTO _q_sc_entry VALUES (68, 2);
INSERT INTO _q_sc_entry VALUES (68, 3);
INSERT INTO _q_sc_entry VALUES (68, 4);
INSERT INTO _q_sc_entry VALUES (68, 5);
INSERT INTO _q_sc_entry VALUES (68, 6);
INSERT INTO _q_sc_entry VALUES (68, 7);
INSERT INTO _q_sc_entry VALUES (68, 8);
INSERT INTO _q_sc_entry VALUES (68, 9);
INSERT INTO _q_sc_entry VALUES (68, 10);
INSERT INTO _q_sc_entry VALUES (68, 11);
INSERT INTO _q_sc_entry VALUES (68, 12);
INSERT INTO _q_sc_entry VALUES (68, 15);
INSERT INTO _q_sc_entry VALUES (69, 1);
INSERT INTO _q_sc_entry VALUES (69, 2);
INSERT INTO _q_sc_entry VALUES (69, 3);
INSERT INTO _q_sc_entry VALUES (69, 4);
INSERT INTO _q_sc_entry VALUES (69, 5);
INSERT INTO _q_sc_entry VALUES (69, 7);
INSERT INTO _q_sc_entry VALUES (69, 8);
INSERT INTO _q_sc_entry VALUES (69, 9);
INSERT INTO _q_sc_entry VALUES (69, 10);
INSERT INTO _q_sc_entry VALUES (69, 11);
INSERT INTO _q_sc_entry VALUES (69, 12);
INSERT INTO _q_sc_entry VALUES (69, 15);


--
-- Data for TOC entry 150 (OID 17020)
-- Name: construct; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO construct VALUES (1, 1, 'Achievement IIS', NULL, true, true, false);
INSERT INTO construct VALUES (2, 1, 'Achievement GBS', NULL, true, true, false);
INSERT INTO construct VALUES (3, 1, 'Satisfaction IIS', NULL, true, true, false);
INSERT INTO construct VALUES (4, 1, 'Satisfaction GBS', NULL, true, true, false);
INSERT INTO construct VALUES (5, 1, 'Expectation IIS', NULL, true, true, false);
INSERT INTO construct VALUES (6, 1, 'Expectation GBS', NULL, true, true, false);
INSERT INTO construct VALUES (7, 2, 'Frustration IIS', NULL, true, false, false);
INSERT INTO construct VALUES (8, 2, 'Frustration GBS', NULL, true, false, false);
INSERT INTO construct VALUES (9, 2, 'Stress IIS', NULL, true, false, false);
INSERT INTO construct VALUES (10, 2, 'Stress GBS', NULL, true, false, false);
INSERT INTO construct VALUES (11, 2, 'Helplessness IIS', NULL, true, false, false);
INSERT INTO construct VALUES (12, 2, 'Helplessness GBS', NULL, true, false, false);
INSERT INTO construct VALUES (13, 3, 'Inner Insecurity', NULL, true, false, false);
INSERT INTO construct VALUES (14, 3, 'Guilt Feelings', NULL, true, false, false);
INSERT INTO construct VALUES (15, 3, 'Lack of Self worth', NULL, true, false, false);
INSERT INTO construct VALUES (16, 3, 'Stigma', NULL, true, false, false);
INSERT INTO construct VALUES (17, 3, 'Body Image', NULL, true, false, false);
INSERT INTO construct VALUES (18, 4, 'Relationship with Colleagues', NULL, true, true, false);
INSERT INTO construct VALUES (19, 4, 'Relationship with Partner', NULL, true, true, false);
INSERT INTO construct VALUES (20, 4, 'Relationships with Son', NULL, true, true, false);
INSERT INTO construct VALUES (21, 4, 'Relationships with Daughter', NULL, true, true, false);
INSERT INTO construct VALUES (22, 4, 'Relationships: General', NULL, true, true, false);
INSERT INTO construct VALUES (23, 4, 'Relationships: Stepson', NULL, true, true, false);
INSERT INTO construct VALUES (24, 4, 'Relationships: Stepdaughter', NULL, true, true, false);
INSERT INTO construct VALUES (25, 4, 'Relationships: Stepmother', NULL, true, true, false);
INSERT INTO construct VALUES (26, 4, 'Relationships: Stepfather', NULL, true, true, false);
INSERT INTO construct VALUES (27, 5, 'Financial Planning', NULL, true, true, false);
INSERT INTO construct VALUES (28, 5, 'Financial Control', NULL, true, true, false);
INSERT INTO construct VALUES (29, 5, 'Financial Discipline', NULL, true, true, false);
INSERT INTO construct VALUES (30, 6, 'Job Satisfaction', NULL, true, true, false);
INSERT INTO construct VALUES (31, 6, 'Job Security', NULL, true, true, false);
INSERT INTO construct VALUES (32, 6, 'Equality', NULL, true, true, false);
INSERT INTO construct VALUES (33, 6, 'Effectiveness of Supervisor', NULL, true, true, false);
INSERT INTO construct VALUES (34, 6, 'Supervisors Leadership Ability', NULL, true, true, false);
INSERT INTO construct VALUES (35, 6, 'Supervisors Communication Skills', NULL, true, true, false);
INSERT INTO construct VALUES (36, 6, 'Supervisors Listening Skills', NULL, true, true, false);
INSERT INTO construct VALUES (37, 6, 'Supervisors Competence', NULL, true, true, false);
INSERT INTO construct VALUES (38, 6, 'Supervisors Positive Attitude', NULL, true, true, false);
INSERT INTO construct VALUES (39, 6, 'Supervisors Problem Solving Ability', NULL, true, true, false);
INSERT INTO construct VALUES (40, 6, 'Supervisors Ability to Serve', NULL, true, true, false);
INSERT INTO construct VALUES (41, 6, 'Supervisors Reliability', NULL, true, true, false);
INSERT INTO construct VALUES (42, 7, 'Dependency', NULL, true, false, false);
INSERT INTO construct VALUES (43, 7, 'Disturbing Thoughts', NULL, true, false, false);
INSERT INTO construct VALUES (44, 7, 'Memory Loss', NULL, true, false, false);
INSERT INTO construct VALUES (45, 7, 'Paranoia', NULL, true, false, false);
INSERT INTO construct VALUES (46, 7, 'Anxiety', NULL, true, false, false);
INSERT INTO construct VALUES (47, 7, 'Suicidal Thoughts', NULL, true, false, false);
INSERT INTO construct VALUES (48, 7, 'Senselessness of Existence', NULL, true, false, false);
INSERT INTO construct VALUES (49, 8, 'Ability Utilization', NULL, true, false, true);
INSERT INTO construct VALUES (50, 8, 'Interest in People', NULL, true, false, true);
INSERT INTO construct VALUES (51, 8, 'Autonomy', NULL, true, false, true);
INSERT INTO construct VALUES (52, 8, 'Authority', NULL, true, false, true);
INSERT INTO construct VALUES (53, 8, 'Originality', NULL, true, false, true);
INSERT INTO construct VALUES (54, 8, 'Financial Compensation', NULL, true, false, true);
INSERT INTO construct VALUES (55, 8, 'Freedom Of Lifestyle', NULL, true, false, true);
INSERT INTO construct VALUES (56, 8, 'Status', NULL, true, false, true);
INSERT INTO construct VALUES (57, 8, 'Risk', NULL, true, false, true);
INSERT INTO construct VALUES (58, 8, 'Financial Guarantee', NULL, true, false, true);
INSERT INTO construct VALUES (59, 8, 'Personal Standards', NULL, true, false, true);
INSERT INTO construct VALUES (60, 8, 'Cultural Prejudice', NULL, true, false, true);
INSERT INTO construct VALUES (61, 8, 'Artistic Appreciation', NULL, true, false, true);
INSERT INTO construct VALUES (62, 8, 'Social Interaction', NULL, true, false, true);
INSERT INTO construct VALUES (63, 8, 'Physical Activities', NULL, true, false, true);
INSERT INTO construct VALUES (64, 8, 'Predictable Environment', NULL, true, false, true);
INSERT INTO construct VALUES (65, 8, 'Personal Development', NULL, true, false, true);
INSERT INTO construct VALUES (66, 8, 'Challenging Attributes', NULL, true, false, true);
INSERT INTO construct VALUES (67, 8, 'Multi Tasking', NULL, true, false, true);
INSERT INTO construct VALUES (68, 8, 'Servanthood', NULL, true, false, true);
INSERT INTO construct VALUES (69, 8, 'Result Orientation', NULL, true, false, true);
INSERT INTO construct VALUES (70, 8, 'Physical Challenges', NULL, true, false, true);
INSERT INTO construct VALUES (71, 9, 'Leadership Ability', NULL, true, false, true);
INSERT INTO construct VALUES (80, 9, 'Problem Solving Ability', NULL, true, false, true);
INSERT INTO construct VALUES (72, 10, 'Competence', NULL, true, false, true);
INSERT INTO construct VALUES (76, 10, 'Initiative', NULL, true, false, true);
INSERT INTO construct VALUES (81, 10, 'Responsibility', NULL, true, false, true);
INSERT INTO construct VALUES (83, 10, 'Reliability', NULL, true, false, true);
INSERT INTO construct VALUES (84, 10, 'Patience', NULL, true, false, true);
INSERT INTO construct VALUES (85, 10, 'Perseverance', NULL, true, false, true);
INSERT INTO construct VALUES (73, 11, 'Commitment', NULL, true, false, true);
INSERT INTO construct VALUES (75, 11, 'Focus', NULL, true, false, true);
INSERT INTO construct VALUES (78, 11, 'Passion', NULL, true, false, true);
INSERT INTO construct VALUES (79, 11, 'Positive Attitude', NULL, true, false, true);
INSERT INTO construct VALUES (82, 11, 'Self - Discipline', NULL, true, false, true);
INSERT INTO construct VALUES (74, 12, 'Communication Skills', NULL, true, false, true);
INSERT INTO construct VALUES (77, 12, 'Listening Skills', NULL, true, false, true);
INSERT INTO construct VALUES (86, 12, 'Interpersonal', NULL, true, false, true);
INSERT INTO construct VALUES (87, 13, 'Perseverance', NULL, true, false, false);
INSERT INTO construct VALUES (88, 13, 'Satisfaction', NULL, true, false, false);
INSERT INTO construct VALUES (89, 13, 'Future Perspectives', NULL, true, false, false);
INSERT INTO construct VALUES (90, 13, 'Anxiety', NULL, true, false, false);
INSERT INTO construct VALUES (91, 13, 'Guilt Feelings', NULL, true, false, false);
INSERT INTO construct VALUES (92, 13, 'Lack of Self Worth', NULL, true, false, false);
INSERT INTO construct VALUES (93, 13, 'Isolation', NULL, true, false, false);
INSERT INTO construct VALUES (94, 13, 'Responsible for Others', NULL, true, false, false);
INSERT INTO construct VALUES (95, 13, 'Lack of Assertiveness', NULL, true, false, false);
INSERT INTO construct VALUES (96, 13, 'Memory Loss', NULL, true, false, false);
INSERT INTO construct VALUES (97, 13, 'Frustration', NULL, true, false, false);
INSERT INTO construct VALUES (98, 13, 'Helplessness', NULL, true, false, false);
INSERT INTO construct VALUES (99, 13, 'Attitude towards Adults', NULL, true, false, false);
INSERT INTO construct VALUES (100, 13, 'Mistrust', NULL, true, false, false);
INSERT INTO construct VALUES (101, 13, 'Inferiority Complex', NULL, true, false, false);
INSERT INTO construct VALUES (102, 13, 'Body Image', NULL, true, false, false);
INSERT INTO construct VALUES (103, 13, 'Personal Boundaries', NULL, true, false, false);
INSERT INTO construct VALUES (104, 13, 'School Problems', NULL, true, false, false);
INSERT INTO construct VALUES (105, 14, 'Family (Where You Stay)', NULL, true, true, false);
INSERT INTO construct VALUES (106, 14, 'Relationship with Friends', NULL, true, true, false);
INSERT INTO construct VALUES (107, 14, 'Relationship with Mother', NULL, true, true, false);
INSERT INTO construct VALUES (108, 14, 'Relationship with Father', NULL, true, true, false);
INSERT INTO construct VALUES (109, 14, 'Relationship with Stepmother', NULL, true, true, false);
INSERT INTO construct VALUES (110, 14, 'Relationship with Stepfather', NULL, true, true, false);
INSERT INTO construct VALUES (111, 14, 'Relationships at School', NULL, true, true, false);
INSERT INTO construct VALUES (112, 14, 'Relationship with Teachers', NULL, true, true, false);
INSERT INTO construct VALUES (113, 14, 'Relationship with Brother', NULL, true, true, false);
INSERT INTO construct VALUES (114, 14, 'Relationship with Sister', NULL, true, true, false);
INSERT INTO construct VALUES (115, 15, 'Service', NULL, true, false, false);
INSERT INTO construct VALUES (116, 15, 'General Culture', NULL, true, false, false);
INSERT INTO construct VALUES (117, 15, 'Entrepreneur', NULL, true, false, false);
INSERT INTO construct VALUES (118, 15, 'Business Interaction', NULL, true, false, false);
INSERT INTO construct VALUES (119, 15, 'Technology', NULL, true, false, false);
INSERT INTO construct VALUES (120, 15, 'Science', NULL, true, false, false);
INSERT INTO construct VALUES (121, 15, 'Outdoors', NULL, true, false, false);
INSERT INTO construct VALUES (122, 15, 'Arts', NULL, true, false, false);
INSERT INTO construct VALUES (123, 15, 'Entertainment', NULL, true, false, false);
INSERT INTO construct VALUES (124, 15, 'Mechanical', NULL, true, false, false);
INSERT INTO construct VALUES (125, 15, 'Medical', NULL, true, false, false);
INSERT INTO construct VALUES (126, 15, 'Training', NULL, true, false, false);
INSERT INTO construct VALUES (127, 15, 'Administration', NULL, true, false, false);
INSERT INTO construct VALUES (128, 15, 'Human Resources', NULL, true, false, false);
INSERT INTO construct VALUES (129, 15, 'Aeronautics', NULL, true, false, false);
INSERT INTO construct VALUES (130, 15, 'Marketing', NULL, true, true, false);
INSERT INTO construct VALUES (131, 15, 'Research', NULL, true, false, false);
INSERT INTO construct VALUES (132, 15, 'Communications', NULL, true, false, false);


--
-- Data for TOC entry 151 (OID 17026)
-- Name: _qsce_c_exclude; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO _qsce_c_exclude VALUES (60, 8, 50);
INSERT INTO _qsce_c_exclude VALUES (60, 14, 109);
INSERT INTO _qsce_c_exclude VALUES (60, 14, 110);
INSERT INTO _qsce_c_exclude VALUES (68, 4, 23);
INSERT INTO _qsce_c_exclude VALUES (68, 4, 24);
INSERT INTO _qsce_c_exclude VALUES (68, 4, 25);
INSERT INTO _qsce_c_exclude VALUES (68, 4, 26);
INSERT INTO _qsce_c_exclude VALUES (69, 4, 23);
INSERT INTO _qsce_c_exclude VALUES (69, 4, 24);
INSERT INTO _qsce_c_exclude VALUES (69, 4, 25);
INSERT INTO _qsce_c_exclude VALUES (69, 4, 26);
INSERT INTO _qsce_c_exclude VALUES (69, 7, 47);


--
-- Data for TOC entry 152 (OID 17030)
-- Name: question; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO question VALUES (1, 1, 1, false);
INSERT INTO question VALUES (2, 1, 2, false);
INSERT INTO question VALUES (3, 1, 3, false);
INSERT INTO question VALUES (4, 1, 4, false);
INSERT INTO question VALUES (5, 1, 5, false);
INSERT INTO question VALUES (6, 1, 6, false);
INSERT INTO question VALUES (7, 1, 7, false);
INSERT INTO question VALUES (8, 1, 8, false);
INSERT INTO question VALUES (9, 1, 9, false);
INSERT INTO question VALUES (10, 1, 10, false);
INSERT INTO question VALUES (11, 1, 11, false);
INSERT INTO question VALUES (12, 1, 12, false);
INSERT INTO question VALUES (13, 2, 1, false);
INSERT INTO question VALUES (14, 2, 2, false);
INSERT INTO question VALUES (15, 2, 3, false);
INSERT INTO question VALUES (16, 2, 4, false);
INSERT INTO question VALUES (17, 2, 5, false);
INSERT INTO question VALUES (18, 2, 6, false);
INSERT INTO question VALUES (19, 2, 7, false);
INSERT INTO question VALUES (20, 2, 8, false);
INSERT INTO question VALUES (21, 2, 9, false);
INSERT INTO question VALUES (22, 2, 10, false);
INSERT INTO question VALUES (23, 3, 1, false);
INSERT INTO question VALUES (24, 3, 2, false);
INSERT INTO question VALUES (25, 3, 3, false);
INSERT INTO question VALUES (26, 3, 4, false);
INSERT INTO question VALUES (27, 3, 5, false);
INSERT INTO question VALUES (28, 3, 6, false);
INSERT INTO question VALUES (29, 3, 7, false);
INSERT INTO question VALUES (30, 3, 8, false);
INSERT INTO question VALUES (31, 3, 9, false);
INSERT INTO question VALUES (32, 3, 10, false);
INSERT INTO question VALUES (33, 3, 11, false);
INSERT INTO question VALUES (34, 3, 12, false);
INSERT INTO question VALUES (35, 4, 1, false);
INSERT INTO question VALUES (36, 4, 2, false);
INSERT INTO question VALUES (37, 4, 3, false);
INSERT INTO question VALUES (38, 4, 4, false);
INSERT INTO question VALUES (39, 4, 5, false);
INSERT INTO question VALUES (40, 4, 6, false);
INSERT INTO question VALUES (41, 4, 7, false);
INSERT INTO question VALUES (42, 4, 8, false);
INSERT INTO question VALUES (43, 4, 9, false);
INSERT INTO question VALUES (44, 5, 1, false);
INSERT INTO question VALUES (45, 5, 2, false);
INSERT INTO question VALUES (46, 5, 3, false);
INSERT INTO question VALUES (47, 5, 4, false);
INSERT INTO question VALUES (48, 5, 5, false);
INSERT INTO question VALUES (49, 5, 6, false);
INSERT INTO question VALUES (50, 5, 7, false);
INSERT INTO question VALUES (51, 5, 8, false);
INSERT INTO question VALUES (52, 5, 9, false);
INSERT INTO question VALUES (53, 5, 10, false);
INSERT INTO question VALUES (54, 5, 11, false);
INSERT INTO question VALUES (55, 6, 1, false);
INSERT INTO question VALUES (56, 6, 2, false);
INSERT INTO question VALUES (57, 6, 3, false);
INSERT INTO question VALUES (58, 6, 4, false);
INSERT INTO question VALUES (59, 6, 5, false);
INSERT INTO question VALUES (60, 6, 6, false);
INSERT INTO question VALUES (61, 6, 7, false);
INSERT INTO question VALUES (62, 6, 8, false);
INSERT INTO question VALUES (63, 6, 9, false);
INSERT INTO question VALUES (64, 6, 10, false);
INSERT INTO question VALUES (65, 6, 11, false);
INSERT INTO question VALUES (66, 7, 1, false);
INSERT INTO question VALUES (67, 7, 2, false);
INSERT INTO question VALUES (68, 7, 3, false);
INSERT INTO question VALUES (69, 7, 4, false);
INSERT INTO question VALUES (70, 7, 5, false);
INSERT INTO question VALUES (71, 7, 6, false);
INSERT INTO question VALUES (72, 7, 7, false);
INSERT INTO question VALUES (73, 7, 8, false);
INSERT INTO question VALUES (74, 7, 9, false);
INSERT INTO question VALUES (75, 7, 10, false);
INSERT INTO question VALUES (76, 8, 1, false);
INSERT INTO question VALUES (77, 8, 2, false);
INSERT INTO question VALUES (78, 8, 3, false);
INSERT INTO question VALUES (79, 8, 4, false);
INSERT INTO question VALUES (80, 8, 5, false);
INSERT INTO question VALUES (81, 8, 6, false);
INSERT INTO question VALUES (82, 8, 7, false);
INSERT INTO question VALUES (83, 8, 8, false);
INSERT INTO question VALUES (84, 8, 9, false);
INSERT INTO question VALUES (85, 8, 10, false);
INSERT INTO question VALUES (86, 8, 11, false);
INSERT INTO question VALUES (87, 9, 1, false);
INSERT INTO question VALUES (88, 9, 2, false);
INSERT INTO question VALUES (89, 9, 3, false);
INSERT INTO question VALUES (90, 9, 4, false);
INSERT INTO question VALUES (91, 9, 5, false);
INSERT INTO question VALUES (92, 9, 6, false);
INSERT INTO question VALUES (93, 9, 7, false);
INSERT INTO question VALUES (94, 9, 8, false);
INSERT INTO question VALUES (95, 9, 9, false);
INSERT INTO question VALUES (96, 9, 10, false);
INSERT INTO question VALUES (97, 9, 11, false);
INSERT INTO question VALUES (98, 10, 1, false);
INSERT INTO question VALUES (99, 10, 2, false);
INSERT INTO question VALUES (100, 10, 3, false);
INSERT INTO question VALUES (101, 10, 4, false);
INSERT INTO question VALUES (102, 10, 5, false);
INSERT INTO question VALUES (103, 10, 6, false);
INSERT INTO question VALUES (104, 10, 7, false);
INSERT INTO question VALUES (105, 10, 8, false);
INSERT INTO question VALUES (106, 10, 9, false);
INSERT INTO question VALUES (107, 10, 10, false);
INSERT INTO question VALUES (108, 10, 11, false);
INSERT INTO question VALUES (109, 10, 12, false);
INSERT INTO question VALUES (110, 11, 1, false);
INSERT INTO question VALUES (111, 11, 2, false);
INSERT INTO question VALUES (112, 11, 3, false);
INSERT INTO question VALUES (113, 11, 4, false);
INSERT INTO question VALUES (114, 11, 5, false);
INSERT INTO question VALUES (115, 11, 6, false);
INSERT INTO question VALUES (116, 11, 7, false);
INSERT INTO question VALUES (117, 11, 8, false);
INSERT INTO question VALUES (118, 11, 9, false);
INSERT INTO question VALUES (119, 11, 10, false);
INSERT INTO question VALUES (120, 11, 11, false);
INSERT INTO question VALUES (121, 11, 12, false);
INSERT INTO question VALUES (122, 12, 1, false);
INSERT INTO question VALUES (123, 12, 2, false);
INSERT INTO question VALUES (124, 12, 3, false);
INSERT INTO question VALUES (125, 12, 4, false);
INSERT INTO question VALUES (126, 12, 5, false);
INSERT INTO question VALUES (127, 12, 6, false);
INSERT INTO question VALUES (128, 12, 7, false);
INSERT INTO question VALUES (129, 12, 8, false);
INSERT INTO question VALUES (130, 12, 9, false);
INSERT INTO question VALUES (131, 12, 10, false);
INSERT INTO question VALUES (132, 12, 11, false);
INSERT INTO question VALUES (133, 12, 12, false);
INSERT INTO question VALUES (134, 13, 1, false);
INSERT INTO question VALUES (135, 13, 2, false);
INSERT INTO question VALUES (136, 13, 3, false);
INSERT INTO question VALUES (137, 13, 4, true);
INSERT INTO question VALUES (138, 13, 5, false);
INSERT INTO question VALUES (139, 13, 6, false);
INSERT INTO question VALUES (140, 13, 7, false);
INSERT INTO question VALUES (141, 13, 8, false);
INSERT INTO question VALUES (142, 14, 1, false);
INSERT INTO question VALUES (143, 14, 2, false);
INSERT INTO question VALUES (144, 14, 3, false);
INSERT INTO question VALUES (145, 14, 4, false);
INSERT INTO question VALUES (146, 14, 5, false);
INSERT INTO question VALUES (147, 14, 6, false);
INSERT INTO question VALUES (148, 14, 7, true);
INSERT INTO question VALUES (149, 14, 8, false);
INSERT INTO question VALUES (150, 15, 1, false);
INSERT INTO question VALUES (151, 15, 2, true);
INSERT INTO question VALUES (152, 15, 3, false);
INSERT INTO question VALUES (153, 15, 4, false);
INSERT INTO question VALUES (154, 15, 5, false);
INSERT INTO question VALUES (155, 15, 6, false);
INSERT INTO question VALUES (156, 15, 7, true);
INSERT INTO question VALUES (157, 15, 8, false);
INSERT INTO question VALUES (158, 15, 9, false);
INSERT INTO question VALUES (159, 16, 1, false);
INSERT INTO question VALUES (160, 16, 2, false);
INSERT INTO question VALUES (161, 16, 3, false);
INSERT INTO question VALUES (162, 16, 4, false);
INSERT INTO question VALUES (163, 16, 5, false);
INSERT INTO question VALUES (164, 16, 6, false);
INSERT INTO question VALUES (165, 16, 7, false);
INSERT INTO question VALUES (166, 16, 8, false);
INSERT INTO question VALUES (167, 16, 9, false);
INSERT INTO question VALUES (168, 17, 1, true);
INSERT INTO question VALUES (169, 17, 2, false);
INSERT INTO question VALUES (170, 17, 3, true);
INSERT INTO question VALUES (171, 17, 4, false);
INSERT INTO question VALUES (172, 17, 5, false);
INSERT INTO question VALUES (173, 17, 6, false);
INSERT INTO question VALUES (174, 17, 7, false);
INSERT INTO question VALUES (175, 17, 8, false);
INSERT INTO question VALUES (176, 17, 9, false);
INSERT INTO question VALUES (177, 18, 1, false);
INSERT INTO question VALUES (178, 18, 2, true);
INSERT INTO question VALUES (179, 18, 3, true);
INSERT INTO question VALUES (180, 18, 4, false);
INSERT INTO question VALUES (181, 18, 5, false);
INSERT INTO question VALUES (182, 18, 6, true);
INSERT INTO question VALUES (183, 18, 7, true);
INSERT INTO question VALUES (184, 18, 8, true);
INSERT INTO question VALUES (185, 18, 9, false);
INSERT INTO question VALUES (186, 19, 1, false);
INSERT INTO question VALUES (187, 19, 2, false);
INSERT INTO question VALUES (188, 19, 3, false);
INSERT INTO question VALUES (189, 19, 4, false);
INSERT INTO question VALUES (190, 19, 5, false);
INSERT INTO question VALUES (191, 19, 6, false);
INSERT INTO question VALUES (192, 19, 7, false);
INSERT INTO question VALUES (193, 20, 1, true);
INSERT INTO question VALUES (194, 20, 2, true);
INSERT INTO question VALUES (195, 20, 3, true);
INSERT INTO question VALUES (196, 20, 4, false);
INSERT INTO question VALUES (197, 20, 5, false);
INSERT INTO question VALUES (198, 20, 6, false);
INSERT INTO question VALUES (199, 20, 7, true);
INSERT INTO question VALUES (200, 21, 1, true);
INSERT INTO question VALUES (201, 21, 2, true);
INSERT INTO question VALUES (202, 21, 3, true);
INSERT INTO question VALUES (203, 21, 4, false);
INSERT INTO question VALUES (204, 21, 5, false);
INSERT INTO question VALUES (205, 21, 6, false);
INSERT INTO question VALUES (206, 21, 7, true);
INSERT INTO question VALUES (207, 22, 1, true);
INSERT INTO question VALUES (208, 22, 2, true);
INSERT INTO question VALUES (209, 22, 3, true);
INSERT INTO question VALUES (210, 22, 4, true);
INSERT INTO question VALUES (211, 22, 5, true);
INSERT INTO question VALUES (212, 22, 6, true);
INSERT INTO question VALUES (213, 22, 7, false);
INSERT INTO question VALUES (214, 22, 5, false);
INSERT INTO question VALUES (215, 22, 6, false);
INSERT INTO question VALUES (216, 22, 7, false);
INSERT INTO question VALUES (217, 23, 1, true);
INSERT INTO question VALUES (218, 23, 2, true);
INSERT INTO question VALUES (219, 23, 3, true);
INSERT INTO question VALUES (220, 23, 4, false);
INSERT INTO question VALUES (221, 23, 5, false);
INSERT INTO question VALUES (222, 23, 6, false);
INSERT INTO question VALUES (223, 23, 7, true);
INSERT INTO question VALUES (224, 24, 1, true);
INSERT INTO question VALUES (225, 24, 2, true);
INSERT INTO question VALUES (226, 24, 3, true);
INSERT INTO question VALUES (227, 24, 4, false);
INSERT INTO question VALUES (228, 24, 5, false);
INSERT INTO question VALUES (229, 24, 6, false);
INSERT INTO question VALUES (230, 24, 7, true);
INSERT INTO question VALUES (231, 25, 1, false);
INSERT INTO question VALUES (232, 25, 2, false);
INSERT INTO question VALUES (233, 25, 3, false);
INSERT INTO question VALUES (234, 25, 4, false);
INSERT INTO question VALUES (235, 25, 5, false);
INSERT INTO question VALUES (236, 25, 6, true);
INSERT INTO question VALUES (237, 25, 7, false);
INSERT INTO question VALUES (238, 25, 8, true);
INSERT INTO question VALUES (239, 26, 1, false);
INSERT INTO question VALUES (240, 26, 2, false);
INSERT INTO question VALUES (241, 26, 3, false);
INSERT INTO question VALUES (242, 26, 4, false);
INSERT INTO question VALUES (243, 26, 5, false);
INSERT INTO question VALUES (244, 26, 6, true);
INSERT INTO question VALUES (245, 26, 7, false);
INSERT INTO question VALUES (246, 26, 8, true);
INSERT INTO question VALUES (247, 27, 1, false);
INSERT INTO question VALUES (248, 27, 2, false);
INSERT INTO question VALUES (249, 27, 3, false);
INSERT INTO question VALUES (250, 27, 4, false);
INSERT INTO question VALUES (251, 27, 5, false);
INSERT INTO question VALUES (252, 27, 6, false);
INSERT INTO question VALUES (253, 27, 7, false);
INSERT INTO question VALUES (254, 27, 8, false);
INSERT INTO question VALUES (255, 27, 9, false);
INSERT INTO question VALUES (256, 27, 10, false);
INSERT INTO question VALUES (257, 27, 11, true);
INSERT INTO question VALUES (258, 27, 12, false);
INSERT INTO question VALUES (259, 27, 13, false);
INSERT INTO question VALUES (260, 27, 14, false);
INSERT INTO question VALUES (261, 28, 1, false);
INSERT INTO question VALUES (262, 28, 2, false);
INSERT INTO question VALUES (263, 28, 3, false);
INSERT INTO question VALUES (264, 28, 4, false);
INSERT INTO question VALUES (265, 28, 5, false);
INSERT INTO question VALUES (266, 28, 6, false);
INSERT INTO question VALUES (267, 28, 7, false);
INSERT INTO question VALUES (268, 28, 8, false);
INSERT INTO question VALUES (269, 28, 9, true);
INSERT INTO question VALUES (270, 28, 10, false);
INSERT INTO question VALUES (271, 28, 11, false);
INSERT INTO question VALUES (272, 28, 12, false);
INSERT INTO question VALUES (273, 29, 1, true);
INSERT INTO question VALUES (274, 29, 2, true);
INSERT INTO question VALUES (275, 29, 3, true);
INSERT INTO question VALUES (276, 29, 4, true);
INSERT INTO question VALUES (277, 29, 5, true);
INSERT INTO question VALUES (278, 29, 6, true);
INSERT INTO question VALUES (279, 29, 7, true);
INSERT INTO question VALUES (280, 29, 8, false);
INSERT INTO question VALUES (281, 29, 9, false);
INSERT INTO question VALUES (282, 29, 10, false);
INSERT INTO question VALUES (283, 29, 11, true);
INSERT INTO question VALUES (284, 29, 12, false);
INSERT INTO question VALUES (285, 29, 13, false);
INSERT INTO question VALUES (286, 29, 14, false);
INSERT INTO question VALUES (287, 30, 1, false);
INSERT INTO question VALUES (288, 30, 2, false);
INSERT INTO question VALUES (289, 30, 3, false);
INSERT INTO question VALUES (290, 30, 4, false);
INSERT INTO question VALUES (291, 30, 5, false);
INSERT INTO question VALUES (292, 30, 6, false);
INSERT INTO question VALUES (293, 30, 7, true);
INSERT INTO question VALUES (294, 30, 8, true);
INSERT INTO question VALUES (295, 31, 1, false);
INSERT INTO question VALUES (296, 31, 2, false);
INSERT INTO question VALUES (297, 31, 3, false);
INSERT INTO question VALUES (298, 31, 4, false);
INSERT INTO question VALUES (299, 31, 5, false);
INSERT INTO question VALUES (300, 31, 6, true);
INSERT INTO question VALUES (301, 31, 7, true);
INSERT INTO question VALUES (302, 31, 8, true);
INSERT INTO question VALUES (303, 32, 1, false);
INSERT INTO question VALUES (304, 32, 2, false);
INSERT INTO question VALUES (305, 32, 3, false);
INSERT INTO question VALUES (306, 32, 4, true);
INSERT INTO question VALUES (307, 32, 5, true);
INSERT INTO question VALUES (308, 32, 6, false);
INSERT INTO question VALUES (309, 33, 1, false);
INSERT INTO question VALUES (310, 33, 2, false);
INSERT INTO question VALUES (311, 33, 3, false);
INSERT INTO question VALUES (312, 33, 4, true);
INSERT INTO question VALUES (313, 33, 5, false);
INSERT INTO question VALUES (314, 33, 6, false);
INSERT INTO question VALUES (315, 33, 7, false);
INSERT INTO question VALUES (316, 34, 1, true);
INSERT INTO question VALUES (317, 34, 2, true);
INSERT INTO question VALUES (318, 34, 3, true);
INSERT INTO question VALUES (319, 34, 4, true);
INSERT INTO question VALUES (320, 34, 5, false);
INSERT INTO question VALUES (321, 34, 6, false);
INSERT INTO question VALUES (322, 34, 7, false);
INSERT INTO question VALUES (323, 34, 8, false);
INSERT INTO question VALUES (324, 34, 9, true);
INSERT INTO question VALUES (325, 34, 10, true);
INSERT INTO question VALUES (326, 35, 1, true);
INSERT INTO question VALUES (327, 35, 2, true);
INSERT INTO question VALUES (328, 35, 3, true);
INSERT INTO question VALUES (329, 35, 4, true);
INSERT INTO question VALUES (330, 35, 5, true);
INSERT INTO question VALUES (331, 35, 6, true);
INSERT INTO question VALUES (332, 35, 7, true);
INSERT INTO question VALUES (333, 35, 8, true);
INSERT INTO question VALUES (334, 35, 9, false);
INSERT INTO question VALUES (335, 35, 10, false);
INSERT INTO question VALUES (336, 36, 1, true);
INSERT INTO question VALUES (337, 36, 2, true);
INSERT INTO question VALUES (338, 36, 3, true);
INSERT INTO question VALUES (339, 36, 4, true);
INSERT INTO question VALUES (340, 36, 5, true);
INSERT INTO question VALUES (341, 36, 6, false);
INSERT INTO question VALUES (342, 36, 7, false);
INSERT INTO question VALUES (343, 36, 8, false);
INSERT INTO question VALUES (344, 36, 9, false);
INSERT INTO question VALUES (345, 36, 10, false);
INSERT INTO question VALUES (346, 37, 1, true);
INSERT INTO question VALUES (347, 37, 2, true);
INSERT INTO question VALUES (348, 37, 3, true);
INSERT INTO question VALUES (349, 37, 4, true);
INSERT INTO question VALUES (350, 37, 5, true);
INSERT INTO question VALUES (351, 37, 6, true);
INSERT INTO question VALUES (352, 37, 7, false);
INSERT INTO question VALUES (353, 37, 8, true);
INSERT INTO question VALUES (354, 37, 9, false);
INSERT INTO question VALUES (355, 37, 10, false);
INSERT INTO question VALUES (356, 38, 1, true);
INSERT INTO question VALUES (357, 38, 2, true);
INSERT INTO question VALUES (358, 38, 3, true);
INSERT INTO question VALUES (359, 38, 4, true);
INSERT INTO question VALUES (360, 38, 5, true);
INSERT INTO question VALUES (361, 38, 6, true);
INSERT INTO question VALUES (362, 38, 7, false);
INSERT INTO question VALUES (363, 38, 8, false);
INSERT INTO question VALUES (364, 38, 9, false);
INSERT INTO question VALUES (365, 38, 10, false);
INSERT INTO question VALUES (366, 39, 1, true);
INSERT INTO question VALUES (367, 39, 2, true);
INSERT INTO question VALUES (368, 39, 3, true);
INSERT INTO question VALUES (369, 39, 4, true);
INSERT INTO question VALUES (370, 39, 5, true);
INSERT INTO question VALUES (371, 39, 6, true);
INSERT INTO question VALUES (372, 39, 7, true);
INSERT INTO question VALUES (373, 39, 8, true);
INSERT INTO question VALUES (374, 39, 9, false);
INSERT INTO question VALUES (375, 39, 10, false);
INSERT INTO question VALUES (376, 40, 1, true);
INSERT INTO question VALUES (377, 40, 2, true);
INSERT INTO question VALUES (378, 40, 3, true);
INSERT INTO question VALUES (379, 40, 4, true);
INSERT INTO question VALUES (380, 40, 5, true);
INSERT INTO question VALUES (381, 40, 6, true);
INSERT INTO question VALUES (382, 40, 7, false);
INSERT INTO question VALUES (383, 40, 8, false);
INSERT INTO question VALUES (384, 40, 9, false);
INSERT INTO question VALUES (385, 40, 10, false);
INSERT INTO question VALUES (386, 41, 1, false);
INSERT INTO question VALUES (387, 41, 2, false);
INSERT INTO question VALUES (388, 41, 3, false);
INSERT INTO question VALUES (389, 41, 4, true);
INSERT INTO question VALUES (390, 41, 5, true);
INSERT INTO question VALUES (391, 41, 6, false);
INSERT INTO question VALUES (392, 41, 7, true);
INSERT INTO question VALUES (393, 42, 1, false);
INSERT INTO question VALUES (394, 42, 2, false);
INSERT INTO question VALUES (395, 42, 3, false);
INSERT INTO question VALUES (396, 42, 4, false);
INSERT INTO question VALUES (397, 42, 5, false);
INSERT INTO question VALUES (398, 42, 6, false);
INSERT INTO question VALUES (399, 42, 7, false);
INSERT INTO question VALUES (400, 42, 8, false);
INSERT INTO question VALUES (401, 43, 1, false);
INSERT INTO question VALUES (402, 43, 2, false);
INSERT INTO question VALUES (403, 43, 3, false);
INSERT INTO question VALUES (404, 43, 4, false);
INSERT INTO question VALUES (405, 43, 5, false);
INSERT INTO question VALUES (406, 43, 6, false);
INSERT INTO question VALUES (407, 43, 7, false);
INSERT INTO question VALUES (408, 43, 8, false);
INSERT INTO question VALUES (409, 43, 9, false);
INSERT INTO question VALUES (410, 44, 1, false);
INSERT INTO question VALUES (411, 44, 2, false);
INSERT INTO question VALUES (412, 44, 3, false);
INSERT INTO question VALUES (413, 44, 4, false);
INSERT INTO question VALUES (414, 44, 5, false);
INSERT INTO question VALUES (415, 44, 6, false);
INSERT INTO question VALUES (416, 44, 7, false);
INSERT INTO question VALUES (417, 45, 1, false);
INSERT INTO question VALUES (418, 45, 2, false);
INSERT INTO question VALUES (419, 45, 3, false);
INSERT INTO question VALUES (420, 45, 4, false);
INSERT INTO question VALUES (421, 45, 5, false);
INSERT INTO question VALUES (422, 45, 6, false);
INSERT INTO question VALUES (423, 45, 7, false);
INSERT INTO question VALUES (424, 45, 8, false);
INSERT INTO question VALUES (425, 45, 9, false);
INSERT INTO question VALUES (426, 45, 10, false);
INSERT INTO question VALUES (427, 46, 1, false);
INSERT INTO question VALUES (428, 46, 2, false);
INSERT INTO question VALUES (429, 46, 3, false);
INSERT INTO question VALUES (430, 46, 4, false);
INSERT INTO question VALUES (431, 46, 5, false);
INSERT INTO question VALUES (432, 46, 6, false);
INSERT INTO question VALUES (433, 46, 7, false);
INSERT INTO question VALUES (434, 47, 1, false);
INSERT INTO question VALUES (435, 47, 2, false);
INSERT INTO question VALUES (436, 47, 3, false);
INSERT INTO question VALUES (437, 47, 4, false);
INSERT INTO question VALUES (438, 47, 5, false);
INSERT INTO question VALUES (439, 47, 6, false);
INSERT INTO question VALUES (440, 47, 7, false);
INSERT INTO question VALUES (441, 47, 8, false);
INSERT INTO question VALUES (442, 47, 9, false);
INSERT INTO question VALUES (443, 47, 10, false);
INSERT INTO question VALUES (444, 48, 1, true);
INSERT INTO question VALUES (445, 48, 2, true);
INSERT INTO question VALUES (446, 48, 3, true);
INSERT INTO question VALUES (447, 48, 4, true);
INSERT INTO question VALUES (448, 48, 5, true);
INSERT INTO question VALUES (449, 48, 6, true);
INSERT INTO question VALUES (450, 48, 7, true);
INSERT INTO question VALUES (451, 48, 8, true);
INSERT INTO question VALUES (452, 49, 1, false);
INSERT INTO question VALUES (453, 49, 2, true);
INSERT INTO question VALUES (454, 49, 3, false);
INSERT INTO question VALUES (455, 49, 4, false);
INSERT INTO question VALUES (456, 49, 5, true);
INSERT INTO question VALUES (457, 49, 6, false);
INSERT INTO question VALUES (458, 49, 7, false);
INSERT INTO question VALUES (459, 50, 1, false);
INSERT INTO question VALUES (460, 50, 2, false);
INSERT INTO question VALUES (461, 50, 3, false);
INSERT INTO question VALUES (462, 50, 4, false);
INSERT INTO question VALUES (463, 50, 5, false);
INSERT INTO question VALUES (464, 50, 6, false);
INSERT INTO question VALUES (465, 50, 7, false);
INSERT INTO question VALUES (466, 51, 1, false);
INSERT INTO question VALUES (467, 51, 2, false);
INSERT INTO question VALUES (468, 51, 3, false);
INSERT INTO question VALUES (469, 51, 4, false);
INSERT INTO question VALUES (470, 51, 5, false);
INSERT INTO question VALUES (471, 51, 6, false);
INSERT INTO question VALUES (472, 51, 7, false);
INSERT INTO question VALUES (473, 52, 1, false);
INSERT INTO question VALUES (474, 52, 2, false);
INSERT INTO question VALUES (475, 52, 3, false);
INSERT INTO question VALUES (476, 52, 4, false);
INSERT INTO question VALUES (477, 52, 5, false);
INSERT INTO question VALUES (478, 52, 6, false);
INSERT INTO question VALUES (479, 52, 7, false);
INSERT INTO question VALUES (480, 53, 1, false);
INSERT INTO question VALUES (481, 53, 2, false);
INSERT INTO question VALUES (482, 53, 3, false);
INSERT INTO question VALUES (483, 53, 4, false);
INSERT INTO question VALUES (484, 53, 5, false);
INSERT INTO question VALUES (485, 53, 6, false);
INSERT INTO question VALUES (486, 53, 7, false);
INSERT INTO question VALUES (487, 54, 1, false);
INSERT INTO question VALUES (488, 54, 2, false);
INSERT INTO question VALUES (489, 54, 3, false);
INSERT INTO question VALUES (490, 54, 4, false);
INSERT INTO question VALUES (491, 54, 5, false);
INSERT INTO question VALUES (492, 54, 6, false);
INSERT INTO question VALUES (493, 54, 7, false);
INSERT INTO question VALUES (494, 55, 1, false);
INSERT INTO question VALUES (495, 55, 2, false);
INSERT INTO question VALUES (496, 55, 3, false);
INSERT INTO question VALUES (497, 55, 4, false);
INSERT INTO question VALUES (498, 55, 5, false);
INSERT INTO question VALUES (499, 55, 6, false);
INSERT INTO question VALUES (500, 55, 7, false);
INSERT INTO question VALUES (501, 56, 1, false);
INSERT INTO question VALUES (502, 56, 2, false);
INSERT INTO question VALUES (503, 56, 3, false);
INSERT INTO question VALUES (504, 56, 4, false);
INSERT INTO question VALUES (505, 56, 5, false);
INSERT INTO question VALUES (506, 56, 6, false);
INSERT INTO question VALUES (507, 56, 7, false);
INSERT INTO question VALUES (508, 57, 1, false);
INSERT INTO question VALUES (509, 57, 2, false);
INSERT INTO question VALUES (510, 57, 3, false);
INSERT INTO question VALUES (511, 57, 4, false);
INSERT INTO question VALUES (512, 57, 5, false);
INSERT INTO question VALUES (513, 57, 6, false);
INSERT INTO question VALUES (514, 57, 7, false);
INSERT INTO question VALUES (515, 58, 1, false);
INSERT INTO question VALUES (516, 58, 2, false);
INSERT INTO question VALUES (517, 58, 3, false);
INSERT INTO question VALUES (518, 58, 4, false);
INSERT INTO question VALUES (519, 58, 5, false);
INSERT INTO question VALUES (520, 58, 6, false);
INSERT INTO question VALUES (521, 58, 7, false);
INSERT INTO question VALUES (522, 59, 1, false);
INSERT INTO question VALUES (523, 59, 2, false);
INSERT INTO question VALUES (524, 59, 3, false);
INSERT INTO question VALUES (525, 59, 4, false);
INSERT INTO question VALUES (526, 59, 5, false);
INSERT INTO question VALUES (527, 59, 6, false);
INSERT INTO question VALUES (528, 59, 7, false);
INSERT INTO question VALUES (529, 59, 8, true);
INSERT INTO question VALUES (530, 59, 9, false);
INSERT INTO question VALUES (531, 59, 10, true);
INSERT INTO question VALUES (532, 60, 1, false);
INSERT INTO question VALUES (533, 60, 2, false);
INSERT INTO question VALUES (534, 60, 3, false);
INSERT INTO question VALUES (535, 60, 4, false);
INSERT INTO question VALUES (536, 60, 5, false);
INSERT INTO question VALUES (537, 60, 6, false);
INSERT INTO question VALUES (538, 61, 1, false);
INSERT INTO question VALUES (539, 61, 2, false);
INSERT INTO question VALUES (540, 61, 3, false);
INSERT INTO question VALUES (541, 61, 4, false);
INSERT INTO question VALUES (542, 61, 5, false);
INSERT INTO question VALUES (543, 61, 6, false);
INSERT INTO question VALUES (544, 61, 7, false);
INSERT INTO question VALUES (545, 62, 1, false);
INSERT INTO question VALUES (546, 62, 2, false);
INSERT INTO question VALUES (547, 62, 3, false);
INSERT INTO question VALUES (548, 62, 4, false);
INSERT INTO question VALUES (549, 62, 5, false);
INSERT INTO question VALUES (550, 62, 6, false);
INSERT INTO question VALUES (551, 62, 7, false);
INSERT INTO question VALUES (552, 63, 1, false);
INSERT INTO question VALUES (553, 63, 2, false);
INSERT INTO question VALUES (554, 63, 3, false);
INSERT INTO question VALUES (555, 63, 4, false);
INSERT INTO question VALUES (556, 63, 5, false);
INSERT INTO question VALUES (557, 63, 6, false);
INSERT INTO question VALUES (558, 63, 7, false);
INSERT INTO question VALUES (559, 64, 1, false);
INSERT INTO question VALUES (560, 64, 2, false);
INSERT INTO question VALUES (561, 64, 3, false);
INSERT INTO question VALUES (562, 64, 4, false);
INSERT INTO question VALUES (563, 64, 5, false);
INSERT INTO question VALUES (564, 64, 6, false);
INSERT INTO question VALUES (565, 64, 7, false);
INSERT INTO question VALUES (566, 65, 1, false);
INSERT INTO question VALUES (567, 65, 2, false);
INSERT INTO question VALUES (568, 65, 3, false);
INSERT INTO question VALUES (569, 65, 4, false);
INSERT INTO question VALUES (570, 65, 5, false);
INSERT INTO question VALUES (571, 65, 6, false);
INSERT INTO question VALUES (572, 65, 7, false);
INSERT INTO question VALUES (573, 66, 1, false);
INSERT INTO question VALUES (574, 66, 2, false);
INSERT INTO question VALUES (575, 66, 3, false);
INSERT INTO question VALUES (576, 66, 4, false);
INSERT INTO question VALUES (577, 66, 5, false);
INSERT INTO question VALUES (578, 66, 6, false);
INSERT INTO question VALUES (579, 66, 7, false);
INSERT INTO question VALUES (580, 67, 1, false);
INSERT INTO question VALUES (581, 67, 2, false);
INSERT INTO question VALUES (582, 67, 3, false);
INSERT INTO question VALUES (583, 67, 4, false);
INSERT INTO question VALUES (584, 67, 5, true);
INSERT INTO question VALUES (585, 67, 6, true);
INSERT INTO question VALUES (586, 67, 7, false);
INSERT INTO question VALUES (587, 68, 1, false);
INSERT INTO question VALUES (588, 68, 2, false);
INSERT INTO question VALUES (589, 68, 3, false);
INSERT INTO question VALUES (590, 68, 4, false);
INSERT INTO question VALUES (591, 68, 5, false);
INSERT INTO question VALUES (592, 68, 6, false);
INSERT INTO question VALUES (593, 68, 7, false);
INSERT INTO question VALUES (594, 68, 8, false);
INSERT INTO question VALUES (595, 68, 9, true);
INSERT INTO question VALUES (596, 69, 1, false);
INSERT INTO question VALUES (597, 69, 2, false);
INSERT INTO question VALUES (598, 69, 3, false);
INSERT INTO question VALUES (599, 69, 4, false);
INSERT INTO question VALUES (600, 69, 5, false);
INSERT INTO question VALUES (601, 69, 6, false);
INSERT INTO question VALUES (602, 69, 7, false);
INSERT INTO question VALUES (603, 69, 8, false);
INSERT INTO question VALUES (604, 70, 1, false);
INSERT INTO question VALUES (605, 70, 2, false);
INSERT INTO question VALUES (606, 70, 3, false);
INSERT INTO question VALUES (607, 70, 4, false);
INSERT INTO question VALUES (608, 70, 5, false);
INSERT INTO question VALUES (609, 70, 6, false);
INSERT INTO question VALUES (610, 71, 1, false);
INSERT INTO question VALUES (611, 71, 2, false);
INSERT INTO question VALUES (612, 71, 3, false);
INSERT INTO question VALUES (613, 71, 4, true);
INSERT INTO question VALUES (614, 71, 5, false);
INSERT INTO question VALUES (615, 71, 6, false);
INSERT INTO question VALUES (616, 71, 7, false);
INSERT INTO question VALUES (617, 71, 8, false);
INSERT INTO question VALUES (618, 71, 9, false);
INSERT INTO question VALUES (619, 71, 10, true);
INSERT INTO question VALUES (700, 80, 1, true);
INSERT INTO question VALUES (701, 80, 2, true);
INSERT INTO question VALUES (702, 80, 3, true);
INSERT INTO question VALUES (703, 80, 4, true);
INSERT INTO question VALUES (704, 80, 5, true);
INSERT INTO question VALUES (705, 80, 6, true);
INSERT INTO question VALUES (706, 80, 7, true);
INSERT INTO question VALUES (707, 80, 8, true);
INSERT INTO question VALUES (708, 80, 9, false);
INSERT INTO question VALUES (709, 80, 10, false);
INSERT INTO question VALUES (640, 72, 1, false);
INSERT INTO question VALUES (641, 72, 2, true);
INSERT INTO question VALUES (642, 72, 3, false);
INSERT INTO question VALUES (643, 72, 4, false);
INSERT INTO question VALUES (644, 72, 5, false);
INSERT INTO question VALUES (645, 72, 6, true);
INSERT INTO question VALUES (646, 72, 7, false);
INSERT INTO question VALUES (647, 72, 8, false);
INSERT INTO question VALUES (648, 72, 9, false);
INSERT INTO question VALUES (649, 72, 10, false);
INSERT INTO question VALUES (660, 76, 1, true);
INSERT INTO question VALUES (661, 76, 2, true);
INSERT INTO question VALUES (662, 76, 3, true);
INSERT INTO question VALUES (663, 76, 4, true);
INSERT INTO question VALUES (664, 76, 5, true);
INSERT INTO question VALUES (665, 76, 6, true);
INSERT INTO question VALUES (666, 76, 7, true);
INSERT INTO question VALUES (667, 76, 8, false);
INSERT INTO question VALUES (668, 76, 9, false);
INSERT INTO question VALUES (669, 76, 10, false);
INSERT INTO question VALUES (710, 81, 1, false);
INSERT INTO question VALUES (711, 81, 2, false);
INSERT INTO question VALUES (712, 81, 3, false);
INSERT INTO question VALUES (713, 81, 4, false);
INSERT INTO question VALUES (714, 81, 5, true);
INSERT INTO question VALUES (715, 81, 6, true);
INSERT INTO question VALUES (716, 81, 7, false);
INSERT INTO question VALUES (717, 81, 8, false);
INSERT INTO question VALUES (718, 81, 9, false);
INSERT INTO question VALUES (719, 81, 10, false);
INSERT INTO question VALUES (730, 83, 1, false);
INSERT INTO question VALUES (731, 83, 2, false);
INSERT INTO question VALUES (732, 83, 3, false);
INSERT INTO question VALUES (733, 83, 4, false);
INSERT INTO question VALUES (734, 83, 5, true);
INSERT INTO question VALUES (735, 83, 6, false);
INSERT INTO question VALUES (736, 83, 7, true);
INSERT INTO question VALUES (737, 84, 1, false);
INSERT INTO question VALUES (738, 84, 2, false);
INSERT INTO question VALUES (739, 84, 3, false);
INSERT INTO question VALUES (740, 84, 4, false);
INSERT INTO question VALUES (741, 84, 5, true);
INSERT INTO question VALUES (742, 84, 6, false);
INSERT INTO question VALUES (743, 84, 7, true);
INSERT INTO question VALUES (744, 84, 8, true);
INSERT INTO question VALUES (745, 84, 9, true);
INSERT INTO question VALUES (746, 84, 10, true);
INSERT INTO question VALUES (747, 85, 1, false);
INSERT INTO question VALUES (748, 85, 2, false);
INSERT INTO question VALUES (749, 85, 3, false);
INSERT INTO question VALUES (750, 85, 4, false);
INSERT INTO question VALUES (751, 85, 5, false);
INSERT INTO question VALUES (752, 85, 6, false);
INSERT INTO question VALUES (753, 85, 7, false);
INSERT INTO question VALUES (754, 85, 8, false);
INSERT INTO question VALUES (620, 73, 1, true);
INSERT INTO question VALUES (621, 73, 2, true);
INSERT INTO question VALUES (622, 73, 3, false);
INSERT INTO question VALUES (623, 73, 4, true);
INSERT INTO question VALUES (624, 73, 5, false);
INSERT INTO question VALUES (625, 73, 6, false);
INSERT INTO question VALUES (626, 73, 7, false);
INSERT INTO question VALUES (627, 73, 8, false);
INSERT INTO question VALUES (628, 73, 9, false);
INSERT INTO question VALUES (629, 73, 10, false);
INSERT INTO question VALUES (650, 75, 1, true);
INSERT INTO question VALUES (651, 75, 2, true);
INSERT INTO question VALUES (652, 75, 3, true);
INSERT INTO question VALUES (653, 75, 4, true);
INSERT INTO question VALUES (654, 75, 5, true);
INSERT INTO question VALUES (655, 75, 6, false);
INSERT INTO question VALUES (656, 75, 7, true);
INSERT INTO question VALUES (657, 75, 8, false);
INSERT INTO question VALUES (658, 75, 9, false);
INSERT INTO question VALUES (659, 75, 10, false);
INSERT INTO question VALUES (680, 78, 1, true);
INSERT INTO question VALUES (681, 78, 2, false);
INSERT INTO question VALUES (682, 78, 3, true);
INSERT INTO question VALUES (683, 78, 4, true);
INSERT INTO question VALUES (684, 78, 5, true);
INSERT INTO question VALUES (685, 78, 6, true);
INSERT INTO question VALUES (686, 78, 7, false);
INSERT INTO question VALUES (687, 78, 8, false);
INSERT INTO question VALUES (688, 78, 9, false);
INSERT INTO question VALUES (689, 78, 10, false);
INSERT INTO question VALUES (690, 79, 1, true);
INSERT INTO question VALUES (691, 79, 2, true);
INSERT INTO question VALUES (692, 79, 3, true);
INSERT INTO question VALUES (693, 79, 4, true);
INSERT INTO question VALUES (694, 79, 5, true);
INSERT INTO question VALUES (695, 79, 6, true);
INSERT INTO question VALUES (696, 79, 7, false);
INSERT INTO question VALUES (697, 79, 8, false);
INSERT INTO question VALUES (698, 79, 9, false);
INSERT INTO question VALUES (699, 79, 10, false);
INSERT INTO question VALUES (720, 82, 1, true);
INSERT INTO question VALUES (721, 82, 2, true);
INSERT INTO question VALUES (722, 82, 3, true);
INSERT INTO question VALUES (723, 82, 4, true);
INSERT INTO question VALUES (724, 82, 5, true);
INSERT INTO question VALUES (725, 82, 6, false);
INSERT INTO question VALUES (726, 82, 7, false);
INSERT INTO question VALUES (727, 82, 8, false);
INSERT INTO question VALUES (728, 82, 9, false);
INSERT INTO question VALUES (729, 82, 10, false);
INSERT INTO question VALUES (630, 74, 1, false);
INSERT INTO question VALUES (631, 74, 2, false);
INSERT INTO question VALUES (632, 74, 3, false);
INSERT INTO question VALUES (633, 74, 4, false);
INSERT INTO question VALUES (634, 74, 5, true);
INSERT INTO question VALUES (635, 74, 6, false);
INSERT INTO question VALUES (636, 74, 7, false);
INSERT INTO question VALUES (637, 74, 8, false);
INSERT INTO question VALUES (638, 74, 9, false);
INSERT INTO question VALUES (639, 74, 10, false);
INSERT INTO question VALUES (670, 77, 1, true);
INSERT INTO question VALUES (671, 77, 2, true);
INSERT INTO question VALUES (672, 77, 3, true);
INSERT INTO question VALUES (673, 77, 4, true);
INSERT INTO question VALUES (674, 77, 5, true);
INSERT INTO question VALUES (675, 77, 6, false);
INSERT INTO question VALUES (676, 77, 7, false);
INSERT INTO question VALUES (677, 77, 8, false);
INSERT INTO question VALUES (678, 77, 9, false);
INSERT INTO question VALUES (679, 77, 10, false);
INSERT INTO question VALUES (755, 86, 1, true);
INSERT INTO question VALUES (756, 86, 2, true);
INSERT INTO question VALUES (757, 86, 3, true);
INSERT INTO question VALUES (758, 86, 4, true);
INSERT INTO question VALUES (759, 86, 5, true);
INSERT INTO question VALUES (760, 86, 6, false);
INSERT INTO question VALUES (761, 86, 7, false);
INSERT INTO question VALUES (762, 86, 8, false);
INSERT INTO question VALUES (763, 86, 9, false);
INSERT INTO question VALUES (764, 86, 10, false);
INSERT INTO question VALUES (765, 87, 1, true);
INSERT INTO question VALUES (766, 87, 2, true);
INSERT INTO question VALUES (767, 87, 3, true);
INSERT INTO question VALUES (768, 87, 4, true);
INSERT INTO question VALUES (769, 87, 5, true);
INSERT INTO question VALUES (770, 87, 6, true);
INSERT INTO question VALUES (771, 87, 7, true);
INSERT INTO question VALUES (772, 87, 8, true);
INSERT INTO question VALUES (773, 88, 1, true);
INSERT INTO question VALUES (774, 88, 2, true);
INSERT INTO question VALUES (775, 88, 3, true);
INSERT INTO question VALUES (776, 88, 4, true);
INSERT INTO question VALUES (777, 88, 5, true);
INSERT INTO question VALUES (778, 88, 6, true);
INSERT INTO question VALUES (779, 88, 7, true);
INSERT INTO question VALUES (780, 88, 8, true);
INSERT INTO question VALUES (781, 88, 9, false);
INSERT INTO question VALUES (782, 89, 1, false);
INSERT INTO question VALUES (783, 89, 2, true);
INSERT INTO question VALUES (784, 89, 3, true);
INSERT INTO question VALUES (785, 89, 4, true);
INSERT INTO question VALUES (786, 89, 5, true);
INSERT INTO question VALUES (787, 89, 6, true);
INSERT INTO question VALUES (788, 89, 7, false);
INSERT INTO question VALUES (789, 89, 8, true);
INSERT INTO question VALUES (790, 90, 1, false);
INSERT INTO question VALUES (791, 90, 2, false);
INSERT INTO question VALUES (792, 90, 3, false);
INSERT INTO question VALUES (793, 90, 4, false);
INSERT INTO question VALUES (794, 90, 5, false);
INSERT INTO question VALUES (795, 90, 6, false);
INSERT INTO question VALUES (796, 90, 7, false);
INSERT INTO question VALUES (797, 90, 8, false);
INSERT INTO question VALUES (798, 91, 1, false);
INSERT INTO question VALUES (799, 91, 2, false);
INSERT INTO question VALUES (800, 91, 3, false);
INSERT INTO question VALUES (801, 91, 4, false);
INSERT INTO question VALUES (802, 91, 5, false);
INSERT INTO question VALUES (803, 91, 6, false);
INSERT INTO question VALUES (804, 91, 7, false);
INSERT INTO question VALUES (805, 91, 8, false);
INSERT INTO question VALUES (806, 91, 9, false);
INSERT INTO question VALUES (807, 92, 1, true);
INSERT INTO question VALUES (808, 92, 2, true);
INSERT INTO question VALUES (809, 92, 3, true);
INSERT INTO question VALUES (810, 92, 4, false);
INSERT INTO question VALUES (811, 92, 5, true);
INSERT INTO question VALUES (812, 92, 6, true);
INSERT INTO question VALUES (813, 92, 7, false);
INSERT INTO question VALUES (814, 92, 8, true);
INSERT INTO question VALUES (815, 93, 1, false);
INSERT INTO question VALUES (816, 93, 2, true);
INSERT INTO question VALUES (817, 93, 3, false);
INSERT INTO question VALUES (818, 93, 4, true);
INSERT INTO question VALUES (819, 93, 5, false);
INSERT INTO question VALUES (820, 93, 6, false);
INSERT INTO question VALUES (821, 93, 7, true);
INSERT INTO question VALUES (822, 93, 8, false);
INSERT INTO question VALUES (823, 94, 1, false);
INSERT INTO question VALUES (824, 94, 2, false);
INSERT INTO question VALUES (825, 94, 3, false);
INSERT INTO question VALUES (826, 94, 4, false);
INSERT INTO question VALUES (827, 94, 5, false);
INSERT INTO question VALUES (828, 94, 6, false);
INSERT INTO question VALUES (829, 94, 7, false);
INSERT INTO question VALUES (830, 94, 8, false);
INSERT INTO question VALUES (831, 95, 1, true);
INSERT INTO question VALUES (832, 95, 2, true);
INSERT INTO question VALUES (833, 95, 3, false);
INSERT INTO question VALUES (834, 95, 4, true);
INSERT INTO question VALUES (835, 95, 5, false);
INSERT INTO question VALUES (836, 95, 6, false);
INSERT INTO question VALUES (837, 95, 7, false);
INSERT INTO question VALUES (838, 95, 8, false);
INSERT INTO question VALUES (839, 96, 1, false);
INSERT INTO question VALUES (840, 96, 2, true);
INSERT INTO question VALUES (841, 96, 3, false);
INSERT INTO question VALUES (842, 96, 4, false);
INSERT INTO question VALUES (843, 96, 5, false);
INSERT INTO question VALUES (844, 96, 6, false);
INSERT INTO question VALUES (845, 96, 7, false);
INSERT INTO question VALUES (846, 96, 8, false);
INSERT INTO question VALUES (847, 97, 1, false);
INSERT INTO question VALUES (848, 97, 2, false);
INSERT INTO question VALUES (849, 97, 3, false);
INSERT INTO question VALUES (850, 97, 4, false);
INSERT INTO question VALUES (851, 97, 5, false);
INSERT INTO question VALUES (852, 97, 6, false);
INSERT INTO question VALUES (853, 97, 7, false);
INSERT INTO question VALUES (854, 98, 1, false);
INSERT INTO question VALUES (855, 98, 2, false);
INSERT INTO question VALUES (856, 98, 3, false);
INSERT INTO question VALUES (857, 98, 4, false);
INSERT INTO question VALUES (858, 98, 5, false);
INSERT INTO question VALUES (859, 98, 6, false);
INSERT INTO question VALUES (860, 98, 7, false);
INSERT INTO question VALUES (861, 98, 8, false);
INSERT INTO question VALUES (862, 99, 1, false);
INSERT INTO question VALUES (863, 99, 2, false);
INSERT INTO question VALUES (864, 99, 3, false);
INSERT INTO question VALUES (865, 99, 4, false);
INSERT INTO question VALUES (866, 99, 5, false);
INSERT INTO question VALUES (867, 99, 6, true);
INSERT INTO question VALUES (868, 99, 7, true);
INSERT INTO question VALUES (869, 99, 8, true);
INSERT INTO question VALUES (870, 99, 9, false);
INSERT INTO question VALUES (878, 100, 1, false);
INSERT INTO question VALUES (879, 100, 2, false);
INSERT INTO question VALUES (880, 100, 3, true);
INSERT INTO question VALUES (881, 100, 4, false);
INSERT INTO question VALUES (882, 100, 5, true);
INSERT INTO question VALUES (883, 100, 6, true);
INSERT INTO question VALUES (884, 100, 7, false);
INSERT INTO question VALUES (885, 100, 8, false);
INSERT INTO question VALUES (886, 100, 9, false);
INSERT INTO question VALUES (887, 101, 1, false);
INSERT INTO question VALUES (888, 101, 2, false);
INSERT INTO question VALUES (889, 101, 3, false);
INSERT INTO question VALUES (890, 101, 4, false);
INSERT INTO question VALUES (891, 101, 5, false);
INSERT INTO question VALUES (892, 101, 6, false);
INSERT INTO question VALUES (893, 101, 7, false);
INSERT INTO question VALUES (894, 101, 8, false);
INSERT INTO question VALUES (895, 101, 9, false);
INSERT INTO question VALUES (896, 102, 1, true);
INSERT INTO question VALUES (897, 102, 2, false);
INSERT INTO question VALUES (898, 102, 3, true);
INSERT INTO question VALUES (899, 102, 4, false);
INSERT INTO question VALUES (900, 102, 5, false);
INSERT INTO question VALUES (901, 102, 6, false);
INSERT INTO question VALUES (902, 102, 7, false);
INSERT INTO question VALUES (903, 102, 8, false);
INSERT INTO question VALUES (904, 102, 9, false);
INSERT INTO question VALUES (905, 103, 1, false);
INSERT INTO question VALUES (906, 103, 2, false);
INSERT INTO question VALUES (907, 103, 3, true);
INSERT INTO question VALUES (908, 103, 4, false);
INSERT INTO question VALUES (909, 103, 5, false);
INSERT INTO question VALUES (910, 103, 6, false);
INSERT INTO question VALUES (911, 103, 7, false);
INSERT INTO question VALUES (912, 104, 1, true);
INSERT INTO question VALUES (913, 104, 2, true);
INSERT INTO question VALUES (914, 104, 3, false);
INSERT INTO question VALUES (915, 104, 4, false);
INSERT INTO question VALUES (916, 104, 5, false);
INSERT INTO question VALUES (917, 104, 6, true);
INSERT INTO question VALUES (918, 104, 7, false);
INSERT INTO question VALUES (919, 104, 8, false);
INSERT INTO question VALUES (920, 105, 1, true);
INSERT INTO question VALUES (921, 105, 2, false);
INSERT INTO question VALUES (922, 105, 3, false);
INSERT INTO question VALUES (923, 105, 4, false);
INSERT INTO question VALUES (924, 105, 5, true);
INSERT INTO question VALUES (925, 105, 6, false);
INSERT INTO question VALUES (926, 105, 7, false);
INSERT INTO question VALUES (927, 105, 8, true);
INSERT INTO question VALUES (928, 105, 9, false);
INSERT INTO question VALUES (929, 105, 10, false);
INSERT INTO question VALUES (930, 105, 11, false);
INSERT INTO question VALUES (931, 105, 12, false);
INSERT INTO question VALUES (932, 106, 1, false);
INSERT INTO question VALUES (933, 106, 2, false);
INSERT INTO question VALUES (934, 106, 3, true);
INSERT INTO question VALUES (935, 106, 4, false);
INSERT INTO question VALUES (936, 106, 5, true);
INSERT INTO question VALUES (937, 106, 6, true);
INSERT INTO question VALUES (938, 106, 7, true);
INSERT INTO question VALUES (939, 106, 8, false);
INSERT INTO question VALUES (940, 107, 1, false);
INSERT INTO question VALUES (941, 107, 2, false);
INSERT INTO question VALUES (942, 107, 3, false);
INSERT INTO question VALUES (943, 107, 4, false);
INSERT INTO question VALUES (944, 107, 5, false);
INSERT INTO question VALUES (945, 107, 6, true);
INSERT INTO question VALUES (946, 107, 7, false);
INSERT INTO question VALUES (947, 107, 8, true);
INSERT INTO question VALUES (948, 108, 1, false);
INSERT INTO question VALUES (949, 108, 2, false);
INSERT INTO question VALUES (950, 108, 3, false);
INSERT INTO question VALUES (951, 108, 4, false);
INSERT INTO question VALUES (952, 108, 5, false);
INSERT INTO question VALUES (953, 108, 6, true);
INSERT INTO question VALUES (954, 108, 7, false);
INSERT INTO question VALUES (955, 108, 8, true);
INSERT INTO question VALUES (956, 109, 1, false);
INSERT INTO question VALUES (957, 109, 2, false);
INSERT INTO question VALUES (958, 109, 3, false);
INSERT INTO question VALUES (959, 109, 4, false);
INSERT INTO question VALUES (960, 109, 5, false);
INSERT INTO question VALUES (961, 109, 6, true);
INSERT INTO question VALUES (962, 109, 7, false);
INSERT INTO question VALUES (963, 109, 8, true);
INSERT INTO question VALUES (964, 110, 1, false);
INSERT INTO question VALUES (965, 110, 2, false);
INSERT INTO question VALUES (966, 110, 3, false);
INSERT INTO question VALUES (967, 110, 4, false);
INSERT INTO question VALUES (968, 110, 5, false);
INSERT INTO question VALUES (969, 110, 6, true);
INSERT INTO question VALUES (970, 110, 7, false);
INSERT INTO question VALUES (971, 110, 8, true);
INSERT INTO question VALUES (980, 110, 2, false);
INSERT INTO question VALUES (981, 110, 3, true);
INSERT INTO question VALUES (982, 110, 4, false);
INSERT INTO question VALUES (983, 110, 5, false);
INSERT INTO question VALUES (984, 110, 6, true);
INSERT INTO question VALUES (985, 110, 7, false);
INSERT INTO question VALUES (986, 110, 8, true);
INSERT INTO question VALUES (972, 111, 1, false);
INSERT INTO question VALUES (973, 111, 2, false);
INSERT INTO question VALUES (974, 111, 3, true);
INSERT INTO question VALUES (975, 111, 4, true);
INSERT INTO question VALUES (976, 111, 5, true);
INSERT INTO question VALUES (977, 111, 6, false);
INSERT INTO question VALUES (978, 111, 7, true);
INSERT INTO question VALUES (979, 112, 1, false);
INSERT INTO question VALUES (987, 113, 1, false);
INSERT INTO question VALUES (988, 113, 2, false);
INSERT INTO question VALUES (989, 113, 3, false);
INSERT INTO question VALUES (990, 113, 4, false);
INSERT INTO question VALUES (991, 113, 5, false);
INSERT INTO question VALUES (992, 113, 6, true);
INSERT INTO question VALUES (993, 113, 7, false);
INSERT INTO question VALUES (994, 113, 8, true);
INSERT INTO question VALUES (995, 114, 1, false);
INSERT INTO question VALUES (996, 114, 2, false);
INSERT INTO question VALUES (997, 114, 3, false);
INSERT INTO question VALUES (998, 114, 4, false);
INSERT INTO question VALUES (999, 114, 5, false);
INSERT INTO question VALUES (1000, 114, 6, true);
INSERT INTO question VALUES (1001, 114, 7, false);
INSERT INTO question VALUES (1002, 114, 8, true);
INSERT INTO question VALUES (1003, 115, 1, false);
INSERT INTO question VALUES (1004, 115, 2, false);
INSERT INTO question VALUES (1005, 115, 3, false);
INSERT INTO question VALUES (1006, 115, 4, false);
INSERT INTO question VALUES (1007, 115, 5, false);
INSERT INTO question VALUES (1008, 115, 6, false);
INSERT INTO question VALUES (1009, 115, 7, false);
INSERT INTO question VALUES (1010, 116, 1, false);
INSERT INTO question VALUES (1011, 116, 2, false);
INSERT INTO question VALUES (1012, 116, 3, false);
INSERT INTO question VALUES (1013, 116, 4, false);
INSERT INTO question VALUES (1014, 116, 5, false);
INSERT INTO question VALUES (1015, 116, 6, false);
INSERT INTO question VALUES (1016, 117, 1, false);
INSERT INTO question VALUES (1017, 117, 2, false);
INSERT INTO question VALUES (1018, 117, 3, false);
INSERT INTO question VALUES (1019, 117, 4, false);
INSERT INTO question VALUES (1020, 117, 5, false);
INSERT INTO question VALUES (1021, 117, 6, false);
INSERT INTO question VALUES (1022, 117, 7, false);
INSERT INTO question VALUES (1023, 117, 8, false);
INSERT INTO question VALUES (1024, 118, 1, false);
INSERT INTO question VALUES (1025, 118, 2, false);
INSERT INTO question VALUES (1026, 118, 3, false);
INSERT INTO question VALUES (1027, 118, 4, false);
INSERT INTO question VALUES (1028, 118, 5, false);
INSERT INTO question VALUES (1029, 118, 6, false);
INSERT INTO question VALUES (1030, 119, 1, false);
INSERT INTO question VALUES (1031, 119, 2, false);
INSERT INTO question VALUES (1032, 119, 3, false);
INSERT INTO question VALUES (1033, 119, 4, false);
INSERT INTO question VALUES (1034, 119, 5, false);
INSERT INTO question VALUES (1035, 119, 6, false);
INSERT INTO question VALUES (1036, 119, 7, false);
INSERT INTO question VALUES (1037, 119, 8, false);
INSERT INTO question VALUES (1038, 120, 1, false);
INSERT INTO question VALUES (1039, 120, 2, false);
INSERT INTO question VALUES (1040, 120, 3, false);
INSERT INTO question VALUES (1041, 120, 4, false);
INSERT INTO question VALUES (1042, 120, 5, false);
INSERT INTO question VALUES (1043, 120, 6, false);
INSERT INTO question VALUES (1044, 120, 7, false);
INSERT INTO question VALUES (1045, 120, 8, false);
INSERT INTO question VALUES (1046, 121, 1, false);
INSERT INTO question VALUES (1047, 121, 2, false);
INSERT INTO question VALUES (1048, 121, 3, false);
INSERT INTO question VALUES (1049, 121, 4, true);
INSERT INTO question VALUES (1050, 121, 5, false);
INSERT INTO question VALUES (1051, 121, 6, false);
INSERT INTO question VALUES (1052, 121, 7, true);
INSERT INTO question VALUES (1053, 121, 8, false);
INSERT INTO question VALUES (1054, 122, 1, false);
INSERT INTO question VALUES (1055, 122, 2, false);
INSERT INTO question VALUES (1056, 122, 3, false);
INSERT INTO question VALUES (1057, 122, 4, false);
INSERT INTO question VALUES (1058, 122, 5, false);
INSERT INTO question VALUES (1059, 122, 6, false);
INSERT INTO question VALUES (1060, 122, 7, false);
INSERT INTO question VALUES (1061, 123, 1, false);
INSERT INTO question VALUES (1062, 123, 2, false);
INSERT INTO question VALUES (1063, 123, 3, false);
INSERT INTO question VALUES (1064, 123, 4, false);
INSERT INTO question VALUES (1065, 123, 5, false);
INSERT INTO question VALUES (1066, 123, 6, false);
INSERT INTO question VALUES (1067, 123, 7, false);
INSERT INTO question VALUES (1068, 124, 1, false);
INSERT INTO question VALUES (1069, 124, 2, false);
INSERT INTO question VALUES (1070, 124, 3, true);
INSERT INTO question VALUES (1071, 124, 4, false);
INSERT INTO question VALUES (1072, 124, 5, true);
INSERT INTO question VALUES (1073, 124, 6, false);
INSERT INTO question VALUES (1074, 124, 7, false);
INSERT INTO question VALUES (1075, 125, 1, false);
INSERT INTO question VALUES (1076, 125, 2, false);
INSERT INTO question VALUES (1077, 125, 3, false);
INSERT INTO question VALUES (1078, 125, 4, false);
INSERT INTO question VALUES (1079, 125, 5, false);
INSERT INTO question VALUES (1080, 125, 6, false);
INSERT INTO question VALUES (1081, 125, 7, false);
INSERT INTO question VALUES (1082, 126, 1, false);
INSERT INTO question VALUES (1083, 126, 2, false);
INSERT INTO question VALUES (1084, 126, 3, false);
INSERT INTO question VALUES (1085, 126, 4, false);
INSERT INTO question VALUES (1086, 126, 5, false);
INSERT INTO question VALUES (1087, 126, 6, false);
INSERT INTO question VALUES (1088, 126, 7, false);
INSERT INTO question VALUES (1089, 126, 8, false);
INSERT INTO question VALUES (1090, 127, 1, false);
INSERT INTO question VALUES (1091, 127, 2, false);
INSERT INTO question VALUES (1092, 127, 3, false);
INSERT INTO question VALUES (1093, 127, 4, false);
INSERT INTO question VALUES (1094, 127, 5, false);
INSERT INTO question VALUES (1095, 127, 6, false);
INSERT INTO question VALUES (1096, 127, 7, false);
INSERT INTO question VALUES (1097, 128, 1, false);
INSERT INTO question VALUES (1098, 128, 2, false);
INSERT INTO question VALUES (1099, 128, 3, false);
INSERT INTO question VALUES (1100, 128, 4, false);
INSERT INTO question VALUES (1101, 128, 5, true);
INSERT INTO question VALUES (1102, 128, 6, true);
INSERT INTO question VALUES (1103, 128, 7, false);
INSERT INTO question VALUES (1104, 128, 8, false);
INSERT INTO question VALUES (1105, 129, 1, false);
INSERT INTO question VALUES (1106, 129, 2, false);
INSERT INTO question VALUES (1107, 129, 3, false);
INSERT INTO question VALUES (1108, 129, 4, false);
INSERT INTO question VALUES (1109, 129, 5, false);
INSERT INTO question VALUES (1110, 129, 6, false);
INSERT INTO question VALUES (1111, 129, 7, false);
INSERT INTO question VALUES (1112, 129, 8, false);
INSERT INTO question VALUES (1113, 130, 1, false);
INSERT INTO question VALUES (1114, 130, 2, false);
INSERT INTO question VALUES (1115, 130, 3, false);
INSERT INTO question VALUES (1116, 130, 4, false);
INSERT INTO question VALUES (1117, 130, 5, false);
INSERT INTO question VALUES (1118, 130, 6, false);
INSERT INTO question VALUES (1119, 130, 7, false);
INSERT INTO question VALUES (1120, 130, 8, false);
INSERT INTO question VALUES (1121, 131, 1, false);
INSERT INTO question VALUES (1122, 131, 2, false);
INSERT INTO question VALUES (1123, 131, 3, false);
INSERT INTO question VALUES (1124, 131, 4, false);
INSERT INTO question VALUES (1125, 131, 5, false);
INSERT INTO question VALUES (1126, 131, 6, false);
INSERT INTO question VALUES (1127, 131, 7, false);
INSERT INTO question VALUES (1128, 131, 8, false);
INSERT INTO question VALUES (1129, 132, 1, false);
INSERT INTO question VALUES (1130, 132, 2, false);
INSERT INTO question VALUES (1131, 132, 3, false);
INSERT INTO question VALUES (1132, 132, 4, true);
INSERT INTO question VALUES (1133, 132, 5, false);
INSERT INTO question VALUES (1134, 132, 6, true);
INSERT INTO question VALUES (1135, 132, 7, false);
INSERT INTO question VALUES (1136, 132, 8, false);


--
-- Data for TOC entry 153 (OID 17034)
-- Name: wording; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO wording VALUES (1, 0, 'I have will power.');
INSERT INTO wording VALUES (2, 0, 'I am goal oriented.');
INSERT INTO wording VALUES (3, 0, 'It is important to me to work hard.');
INSERT INTO wording VALUES (4, 0, 'I am successful.');
INSERT INTO wording VALUES (5, 0, 'I have a high energy level.');
INSERT INTO wording VALUES (6, 0, 'It is important to me to reach my planned objectives.');
INSERT INTO wording VALUES (7, 0, 'I am motivated.');
INSERT INTO wording VALUES (8, 0, 'I am effective in what I do.');
INSERT INTO wording VALUES (9, 0, 'It is important to me to improve on previous attempts.');
INSERT INTO wording VALUES (10, 0, 'I have perseverance');
INSERT INTO wording VALUES (11, 0, 'I want to be busy with something');
INSERT INTO wording VALUES (12, 0, 'I am enthusiastic about what I do.');
INSERT INTO wording VALUES (13, 0, 'I do my work with enthusiasm.');
INSERT INTO wording VALUES (14, 0, 'I take action to solve my problems.');
INSERT INTO wording VALUES (15, 0, 'I take control of my problems.');
INSERT INTO wording VALUES (16, 0, 'I complete that which I set out to do.');
INSERT INTO wording VALUES (17, 0, 'I take initiative when things need to be done.');
INSERT INTO wording VALUES (18, 0, 'I do things properly.');
INSERT INTO wording VALUES (19, 0, 'I improve on previous attempts.');
INSERT INTO wording VALUES (20, 0, 'I work hard.');
INSERT INTO wording VALUES (21, 0, 'I take control over my circumstances.');
INSERT INTO wording VALUES (22, 0, 'I keep on working until I am satisfied.');
INSERT INTO wording VALUES (23, 0, 'I accept my circumstances.');
INSERT INTO wording VALUES (24, 0, 'I feel satisfied with the standard of my life.');
INSERT INTO wording VALUES (25, 0, 'I feel good about the course my life is taking at present.');
INSERT INTO wording VALUES (26, 0, 'I feel cheerful.');
INSERT INTO wording VALUES (27, 0, 'I feel satisfied with my present accomplishments.');
INSERT INTO wording VALUES (28, 0, 'I enjoy my relationships.');
INSERT INTO wording VALUES (29, 0, 'I am satisfied with my relationships.');
INSERT INTO wording VALUES (30, 0, 'I experience peace of mind in my circumstances.');
INSERT INTO wording VALUES (31, 0, 'I feel happy.');
INSERT INTO wording VALUES (32, 0, 'I feel joyful.');
INSERT INTO wording VALUES (33, 0, 'I feel there is a sense of joy in my life.');
INSERT INTO wording VALUES (34, 0, 'I feel at ease in my relationship with others.');
INSERT INTO wording VALUES (35, 0, 'I do the things that I enjoy.');
INSERT INTO wording VALUES (36, 0, 'I socialize with others.');
INSERT INTO wording VALUES (37, 0, 'I spend time on hobbies.');
INSERT INTO wording VALUES (38, 0, 'I manage life with a smile.');
INSERT INTO wording VALUES (39, 0, 'I act in a friendly way.');
INSERT INTO wording VALUES (40, 0, 'I plan events in such a way that life is a joy to me.');
INSERT INTO wording VALUES (41, 0, 'I act cheerfully.');
INSERT INTO wording VALUES (42, 0, 'I take time to relax.');
INSERT INTO wording VALUES (43, 0, 'I act with ease in my relationship.');
INSERT INTO wording VALUES (44, 0, 'I believe that people have good intentions.');
INSERT INTO wording VALUES (45, 0, 'I maintain the belief that things will turn out fine.');
INSERT INTO wording VALUES (46, 0, 'I am hopeful about my future.');
INSERT INTO wording VALUES (47, 0, 'I keep calm by remaining positive.');
INSERT INTO wording VALUES (48, 0, 'I focus on the positive elements in others.');
INSERT INTO wording VALUES (49, 0, 'It is important to me to encourage others.');
INSERT INTO wording VALUES (50, 0, 'I am optimistic about my future.');
INSERT INTO wording VALUES (51, 0, 'I believe that things will turn out favourably.');
INSERT INTO wording VALUES (52, 0, 'I look forward to the future.');
INSERT INTO wording VALUES (53, 0, 'I adapt to bad things that happen to me in a positive way.');
INSERT INTO wording VALUES (54, 0, 'I focus on the positive elements in my circumstances.');
INSERT INTO wording VALUES (55, 0, 'I act calmly despite unpleasant events.');
INSERT INTO wording VALUES (56, 0, 'I support others.');
INSERT INTO wording VALUES (57, 0, 'I act in a protective way towards others.');
INSERT INTO wording VALUES (58, 0, 'I encourage others because things will turn out well.');
INSERT INTO wording VALUES (59, 0, 'My behaviour towards others shows that I have faith in them.');
INSERT INTO wording VALUES (60, 0, 'I help others to be successful.');
INSERT INTO wording VALUES (61, 0, 'I show others that I care for them.');
INSERT INTO wording VALUES (62, 0, 'I create solutions by acting positively in difficult circumstances.');
INSERT INTO wording VALUES (63, 0, 'I communicate positive feelings towards others.');
INSERT INTO wording VALUES (64, 0, 'I act calmly because all will be well.');
INSERT INTO wording VALUES (65, 0, 'I listen to others when they talk about their problems.');
INSERT INTO wording VALUES (66, 0, 'I feel frustrated.');
INSERT INTO wording VALUES (67, 0, 'I feel life is unfair.');
INSERT INTO wording VALUES (68, 0, 'I feel irritated.');
INSERT INTO wording VALUES (69, 0, 'I become embittered.');
INSERT INTO wording VALUES (70, 0, 'I feel angry.');
INSERT INTO wording VALUES (71, 0, 'I feel prevented from reaching my objectives.');
INSERT INTO wording VALUES (72, 0, 'I have a quick temper.');
INSERT INTO wording VALUES (73, 0, 'I feel impatient.');
INSERT INTO wording VALUES (74, 0, 'I feel people misunderstand me.');
INSERT INTO wording VALUES (75, 0, 'I feel everyone is against me.');
INSERT INTO wording VALUES (76, 0, 'I become entangled in arguments.');
INSERT INTO wording VALUES (77, 0, 'I tell others that they are to blame.');
INSERT INTO wording VALUES (78, 0, 'I create an unpleasant atmosphere when I feel frustrated.');
INSERT INTO wording VALUES (79, 0, 'I show my frustrations to others.');
INSERT INTO wording VALUES (80, 0, 'I get what I want by making others feel too threatened to oppose me.');
INSERT INTO wording VALUES (81, 0, 'I hurt others feelings before they can hurt me.');
INSERT INTO wording VALUES (82, 0, 'I communicate my dissatisfaction to others.');
INSERT INTO wording VALUES (83, 0, 'I act in an unfriendly way when I feel frustrated.');
INSERT INTO wording VALUES (84, 0, 'I criticize others.');
INSERT INTO wording VALUES (85, 0, 'I scare people through my actions.');
INSERT INTO wording VALUES (86, 0, 'I lose self-control when I become angry.');
INSERT INTO wording VALUES (87, 0, 'I feel tense when having to complete my objectives.');
INSERT INTO wording VALUES (88, 0, 'I feel people demand too much from me.');
INSERT INTO wording VALUES (89, 0, 'I feel panicky.');
INSERT INTO wording VALUES (90, 0, 'I find it difficult to keep up the pace.');
INSERT INTO wording VALUES (91, 0, 'I feel overstressed.');
INSERT INTO wording VALUES (92, 0, 'I become stressed when I have not completed my assignments.');
INSERT INTO wording VALUES (93, 0, 'I feel washed out.');
INSERT INTO wording VALUES (94, 0, 'I feel close to breaking point.');
INSERT INTO wording VALUES (95, 0, 'I feel overburdened.');
INSERT INTO wording VALUES (96, 0, 'I feel that there is too much pressure on me.');
INSERT INTO wording VALUES (97, 0, 'I feel nervous.');
INSERT INTO wording VALUES (98, 0, 'I get head and/or other aches as a result of tension.');
INSERT INTO wording VALUES (99, 0, 'I show my distress to others.');
INSERT INTO wording VALUES (100, 0, 'I act panicky when I experience stress.');
INSERT INTO wording VALUES (101, 0, 'I act disordered when I experience stress.');
INSERT INTO wording VALUES (102, 0, 'People can see from my actions that I am afraid.');
INSERT INTO wording VALUES (103, 0, 'I behave in a nervous manner.');
INSERT INTO wording VALUES (104, 0, 'Stress gives me muscular tension.');
INSERT INTO wording VALUES (105, 0, 'I act with uncertainty.');
INSERT INTO wording VALUES (106, 0, 'I work on too many things at the same time.');
INSERT INTO wording VALUES (107, 0, 'I behave in a disorganized manner.');
INSERT INTO wording VALUES (108, 0, 'I act moodily.');
INSERT INTO wording VALUES (109, 0, 'I act in a tense way.');
INSERT INTO wording VALUES (110, 0, 'I feel rejected.');
INSERT INTO wording VALUES (111, 0, 'I feel powerless to do anything about my circumstances.');
INSERT INTO wording VALUES (112, 0, 'I am downhearted.');
INSERT INTO wording VALUES (113, 0, 'I feel down-in-the-dumps.');
INSERT INTO wording VALUES (114, 0, 'I feel that I have been let down.');
INSERT INTO wording VALUES (115, 0, 'My life seems without purpose.');
INSERT INTO wording VALUES (116, 0, 'I feel depressed.');
INSERT INTO wording VALUES (117, 0, 'I experience life as meaningless.');
INSERT INTO wording VALUES (118, 0, 'I wish I could just run away from it all.');
INSERT INTO wording VALUES (119, 0, 'I feel like giving up.');
INSERT INTO wording VALUES (120, 0, 'I feel lonely.');
INSERT INTO wording VALUES (121, 0, 'My life seems to have limited expectations.');
INSERT INTO wording VALUES (122, 0, 'I create a depressing atmosphere around me.');
INSERT INTO wording VALUES (123, 0, 'I have stopped laughing.');
INSERT INTO wording VALUES (124, 0, 'I avoid people.');
INSERT INTO wording VALUES (125, 0, 'I find it difficult to get started.');
INSERT INTO wording VALUES (126, 0, 'I act in a listless way.');
INSERT INTO wording VALUES (127, 0, 'I act without any purpose.');
INSERT INTO wording VALUES (128, 0, 'I only do the minimum.');
INSERT INTO wording VALUES (129, 0, 'I achieve little.');
INSERT INTO wording VALUES (130, 0, 'I act unproductively.');
INSERT INTO wording VALUES (131, 0, 'I manage life from a negative point of view.');
INSERT INTO wording VALUES (132, 0, 'I act without enthusiasm.');
INSERT INTO wording VALUES (133, 0, 'I refrain from participating in activities.');
INSERT INTO wording VALUES (134, 0, 'My circumstances make me feel uncertain.');
INSERT INTO wording VALUES (135, 0, 'I am afraid people might reject me.');
INSERT INTO wording VALUES (136, 0, 'I am afraid that I will be hurt emotionally.');
INSERT INTO wording VALUES (137, 0, 'I feel secure within my circumstances.');
INSERT INTO wording VALUES (138, 0, 'I am afraid to fail.');
INSERT INTO wording VALUES (139, 0, 'I am afraid of the future.');
INSERT INTO wording VALUES (140, 0, 'I feel threatened by my current circumstances.');
INSERT INTO wording VALUES (141, 0, 'I become scared.');
INSERT INTO wording VALUES (142, 0, 'Feelings of guilt control my life.');
INSERT INTO wording VALUES (143, 0, 'I feel guilty.');
INSERT INTO wording VALUES (144, 0, 'I feel I deserve punishment.');
INSERT INTO wording VALUES (145, 0, 'Everything is my fault.');
INSERT INTO wording VALUES (146, 0, 'I blame myself.');
INSERT INTO wording VALUES (147, 0, 'I accept blame for things that go wrong.');
INSERT INTO wording VALUES (148, 0, 'I forgive myself for the mistakes I make.');
INSERT INTO wording VALUES (149, 0, 'I feel that I could do better.');
INSERT INTO wording VALUES (150, 0, 'I feel ashamed of myself.');
INSERT INTO wording VALUES (151, 0, 'I feel special.');
INSERT INTO wording VALUES (152, 0, 'I feel I am a hopeless person.');
INSERT INTO wording VALUES (153, 0, 'I feel like a failure.');
INSERT INTO wording VALUES (154, 0, 'I feel unimportant.');
INSERT INTO wording VALUES (155, 0, 'I find it difficult to accept myself.');
INSERT INTO wording VALUES (156, 0, 'I feel respected.');
INSERT INTO wording VALUES (157, 0, 'I feel worthless.');
INSERT INTO wording VALUES (158, 0, 'I feel like a person without a purpose.');
INSERT INTO wording VALUES (159, 0, 'Other people only want to hurt me.');
INSERT INTO wording VALUES (160, 0, 'I am different from other people.');
INSERT INTO wording VALUES (161, 0, 'I wish I was more like other people.');
INSERT INTO wording VALUES (162, 0, 'Other people have less problems than I do.');
INSERT INTO wording VALUES (163, 0, 'Bad things only happen to me.');
INSERT INTO wording VALUES (164, 0, 'Other people are getting on better than I am.');
INSERT INTO wording VALUES (165, 0, 'Other people are happier than I am.');
INSERT INTO wording VALUES (166, 0, 'My friends think I am different.');
INSERT INTO wording VALUES (167, 0, 'My friends say unkind things to me....');
INSERT INTO wording VALUES (168, 0, 'I like the way I look.');
INSERT INTO wording VALUES (169, 0, 'I wish I looked different.');
INSERT INTO wording VALUES (170, 0, 'I feel good about myself when I look in the mirror.');
INSERT INTO wording VALUES (171, 0, 'I feel like hiding my body.');
INSERT INTO wording VALUES (172, 0, 'I feel ashamed of my body.');
INSERT INTO wording VALUES (173, 0, 'My body feels dirty.');
INSERT INTO wording VALUES (174, 0, 'I think people laugh at my body.');
INSERT INTO wording VALUES (175, 0, 'I wish I could change my body.');
INSERT INTO wording VALUES (176, 0, 'My body gives me the horrors.');
INSERT INTO wording VALUES (177, 0, 'My colleagues treat me with respect.');
INSERT INTO wording VALUES (178, 0, 'I feel my colleagues criticize me.');
INSERT INTO wording VALUES (179, 0, 'My colleagues irritate me.');
INSERT INTO wording VALUES (180, 0, 'I get along with my colleagues.');
INSERT INTO wording VALUES (181, 0, 'My colleagues make me feel part of the team.');
INSERT INTO wording VALUES (182, 0, 'I think my colleagues talk behind my back.');
INSERT INTO wording VALUES (183, 0, 'My Colleagues frustrate me.');
INSERT INTO wording VALUES (184, 0, 'My colleagues let me down.');
INSERT INTO wording VALUES (185, 0, 'My colleagues support me.');
INSERT INTO wording VALUES (186, 0, 'I share my thoughts with my partner.');
INSERT INTO wording VALUES (187, 0, 'My partner and I do things together.');
INSERT INTO wording VALUES (188, 0, 'I spend time with my partner.');
INSERT INTO wording VALUES (189, 0, 'My partner and I enjoy our time together.');
INSERT INTO wording VALUES (190, 0, 'My partner and I have the same interest.');
INSERT INTO wording VALUES (191, 0, 'I share my secrets with my partner.');
INSERT INTO wording VALUES (192, 0, 'I can be honest with my partner.');
INSERT INTO wording VALUES (193, 0, 'My son frustrates me');
INSERT INTO wording VALUES (194, 0, 'I feel ashamed of my son');
INSERT INTO wording VALUES (195, 0, 'My son irritates me');
INSERT INTO wording VALUES (196, 0, 'My son and I spend time together');
INSERT INTO wording VALUES (197, 0, 'My son shows me respect');
INSERT INTO wording VALUES (198, 0, 'My son understands me');
INSERT INTO wording VALUES (199, 0, 'My son is too demanding');
INSERT INTO wording VALUES (200, 0, 'My daughter frustrates me');
INSERT INTO wording VALUES (201, 0, 'I feel ashamed of my daughter');
INSERT INTO wording VALUES (202, 0, 'My daughter irritates me');
INSERT INTO wording VALUES (203, 0, 'My daughter and I spend time together');
INSERT INTO wording VALUES (204, 0, 'My daughter shows me respect');
INSERT INTO wording VALUES (205, 0, 'My daughter understands me');
INSERT INTO wording VALUES (206, 0, 'My daughter is too demanding');
INSERT INTO wording VALUES (207, 0, 'I find it difficult to work with people.');
INSERT INTO wording VALUES (208, 0, 'I have poor interpersonal skills....');
INSERT INTO wording VALUES (209, 0, 'I focus on what I can get out of people...');
INSERT INTO wording VALUES (210, 0, 'I find it difficult to interact with all kinds of people.');
INSERT INTO wording VALUES (211, 0, 'I isolate myself from others.');
INSERT INTO wording VALUES (212, 0, 'I find it difficult to relate to people.');
INSERT INTO wording VALUES (213, 0, 'I focus on what I can put into people.');
INSERT INTO wording VALUES (214, 0, 'I am able to sustain my relationships');
INSERT INTO wording VALUES (215, 0, 'I have the ability to find the best in people');
INSERT INTO wording VALUES (216, 0, 'I develop good relationships with people');
INSERT INTO wording VALUES (217, 0, 'My stepson frustrates me');
INSERT INTO wording VALUES (218, 0, 'I feel ashamed of my stepson');
INSERT INTO wording VALUES (219, 0, 'My stepson irritates me.');
INSERT INTO wording VALUES (220, 0, 'My stepson and I spend quality time together');
INSERT INTO wording VALUES (221, 0, 'My stepson shows me respect');
INSERT INTO wording VALUES (222, 0, 'My stepson understands me');
INSERT INTO wording VALUES (223, 0, 'My stepson is too demanding');
INSERT INTO wording VALUES (224, 0, 'My stepdaughter frustrates me');
INSERT INTO wording VALUES (225, 0, 'I feel ashamed of my stepdaughter');
INSERT INTO wording VALUES (226, 0, 'My stepdaughter irritates me');
INSERT INTO wording VALUES (227, 0, 'My stepdaughter and I spend quality time together');
INSERT INTO wording VALUES (228, 0, 'My stepdaughter shows me respect');
INSERT INTO wording VALUES (229, 0, 'My stepdaughter understands me');
INSERT INTO wording VALUES (230, 0, 'My stepdaughter is too demanding');
INSERT INTO wording VALUES (231, 0, 'I like my stepmother.');
INSERT INTO wording VALUES (232, 0, 'I enjoy being with my stepmother');
INSERT INTO wording VALUES (233, 0, 'I love my stepmother');
INSERT INTO wording VALUES (234, 0, 'My stepmother loves me');
INSERT INTO wording VALUES (235, 0, 'My stepmother does a lot for me.');
INSERT INTO wording VALUES (236, 0, 'I feel angry when I think of my stepmother.');
INSERT INTO wording VALUES (237, 0, 'My stepmother understands me.');
INSERT INTO wording VALUES (238, 0, 'My stepmother is angry with me.');
INSERT INTO wording VALUES (239, 0, 'I like my stepfather');
INSERT INTO wording VALUES (240, 0, 'I enjoy being with my stepfather.');
INSERT INTO wording VALUES (241, 0, 'I love my stepfather');
INSERT INTO wording VALUES (242, 0, 'My stepfather loves me');
INSERT INTO wording VALUES (243, 0, 'My stepfather does a lot for me.');
INSERT INTO wording VALUES (244, 0, 'I feel angry when I think of my stepfather');
INSERT INTO wording VALUES (245, 0, 'My stepfather understands me.');
INSERT INTO wording VALUES (246, 0, 'My stepfather is angry with me.');
INSERT INTO wording VALUES (247, 0, 'I continuously plan how my finances will be used.');
INSERT INTO wording VALUES (248, 0, 'I read the small print of a financial transaction before making a commitment.');
INSERT INTO wording VALUES (249, 0, 'I plan my financial affairs on paper.');
INSERT INTO wording VALUES (250, 0, 'I decide how I will spend my money.');
INSERT INTO wording VALUES (251, 0, 'I make financial provision for the future.');
INSERT INTO wording VALUES (252, 0, '"I plan my finances in an orderly');
INSERT INTO wording VALUES (253, 0, 'I adjust my financial planning according to my circumstances.');
INSERT INTO wording VALUES (254, 0, 'It is a priority to pay my debts.');
INSERT INTO wording VALUES (255, 0, 'I make financial investments.');
INSERT INTO wording VALUES (256, 0, 'I am organised in my financial affairs.');
INSERT INTO wording VALUES (257, 0, 'Financial planning is a waste of time.');
INSERT INTO wording VALUES (258, 0, 'I pay my debt on time.');
INSERT INTO wording VALUES (259, 0, 'My financial planning is carried out.');
INSERT INTO wording VALUES (260, 0, 'It is important to me to plan my finances.');
INSERT INTO wording VALUES (261, 0, 'I verify my receipts.');
INSERT INTO wording VALUES (262, 0, 'I compare my budget with my expenses.');
INSERT INTO wording VALUES (263, 0, 'I check my financial statements carefully.');
INSERT INTO wording VALUES (264, 0, 'I can handle financial problems.');
INSERT INTO wording VALUES (265, 0, 'I keep track of my expenses.');
INSERT INTO wording VALUES (266, 0, 'I am in control of my finances.');
INSERT INTO wording VALUES (267, 0, 'I know what my expenses are.');
INSERT INTO wording VALUES (268, 0, 'I spend my money in a responsible way.');
INSERT INTO wording VALUES (269, 0, 'I am unaware of the amount of expenses I have.');
INSERT INTO wording VALUES (270, 0, 'I revise my budget.');
INSERT INTO wording VALUES (271, 0, 'I keep to my financial decisions.');
INSERT INTO wording VALUES (272, 0, 'My budget balances.');
INSERT INTO wording VALUES (273, 0, 'I impulsively spend money when I am angry.');
INSERT INTO wording VALUES (274, 0, 'I can foresee a financial crisis.');
INSERT INTO wording VALUES (275, 0, 'I impulsively go into debt.');
INSERT INTO wording VALUES (276, 0, 'I spend money without working to a budget.');
INSERT INTO wording VALUES (277, 0, 'I spend money without thinking of my financial goals');
INSERT INTO wording VALUES (278, 0, 'I buy things that I really do not need.');
INSERT INTO wording VALUES (279, 0, 'When I have money in my hand I seem to spend it.');
INSERT INTO wording VALUES (280, 0, 'I am careful with my money.');
INSERT INTO wording VALUES (281, 0, 'I work my finances out carefully.');
INSERT INTO wording VALUES (282, 0, 'I am financially disciplined.');
INSERT INTO wording VALUES (283, 0, 'I am extravagant (wasteful).');
INSERT INTO wording VALUES (284, 0, 'I can resist temptations to buy.');
INSERT INTO wording VALUES (285, 0, 'I only buy what I need.');
INSERT INTO wording VALUES (286, 0, 'I am diligent with my savings plan.');
INSERT INTO wording VALUES (287, 0, 'I look forward to coming to work.');
INSERT INTO wording VALUES (288, 0, 'My job gives me satisfaction.');
INSERT INTO wording VALUES (289, 0, 'I like my job.');
INSERT INTO wording VALUES (290, 0, 'I find my job interesting.');
INSERT INTO wording VALUES (291, 0, 'I am committed to my job.');
INSERT INTO wording VALUES (292, 0, 'My job stimulates me.');
INSERT INTO wording VALUES (293, 0, 'I do not enjoy the work I do.');
INSERT INTO wording VALUES (294, 0, 'I do not look forward to having to go to work.');
INSERT INTO wording VALUES (295, 0, 'I feel that I  have promotion possibilities in my job.');
INSERT INTO wording VALUES (296, 0, 'I know I will still have a job tomorrow.');
INSERT INTO wording VALUES (297, 0, 'I am certain I am going to keep my job.');
INSERT INTO wording VALUES (298, 0, 'There is a great future for me in my job.');
INSERT INTO wording VALUES (299, 0, 'I feel secure in my job.');
INSERT INTO wording VALUES (300, 0, 'I feel insecure in my job');
INSERT INTO wording VALUES (301, 0, 'I am not sure if I will have a job shortly.');
INSERT INTO wording VALUES (302, 0, 'There are no opportunities for promotion in my job.');
INSERT INTO wording VALUES (303, 0, 'The same standards are applicable to everyone in the workplace.');
INSERT INTO wording VALUES (304, 0, 'I am accepted in the same way as the people I work with.');
INSERT INTO wording VALUES (305, 0, 'At work I receive the same treatment as others.');
INSERT INTO wording VALUES (306, 0, 'Racism is alive in our organization.');
INSERT INTO wording VALUES (307, 0, 'Some co-workers receive special favours.');
INSERT INTO wording VALUES (308, 0, 'I am given equal opportunity to advance in my career.');
INSERT INTO wording VALUES (309, 0, 'My supervisor cares for me.');
INSERT INTO wording VALUES (310, 0, 'My supervisor does his job well.');
INSERT INTO wording VALUES (311, 0, 'My supervisor looks after my interests.');
INSERT INTO wording VALUES (312, 0, 'My supervisor only promotes the careers of certain workers.');
INSERT INTO wording VALUES (313, 0, 'My supervisor invites me to talk to him/her about my work problems.');
INSERT INTO wording VALUES (314, 0, 'I trust my supervisor.');
INSERT INTO wording VALUES (315, 0, 'My supervisor considers me when he / she makes decisions.');
INSERT INTO wording VALUES (316, 0, 'Other people seem to find it difficult to trust my supervisor.');
INSERT INTO wording VALUES (317, 0, 'My supervisor seems to have poor leadership abilities.');
INSERT INTO wording VALUES (318, 0, 'My supervisor seems to find it difficult to get out of difficult situations.');
INSERT INTO wording VALUES (319, 0, 'My supervisor tells lies to suit his/her needs.');
INSERT INTO wording VALUES (320, 0, 'My supervisor seems willing to face his/her flaws.');
INSERT INTO wording VALUES (321, 0, 'My supervisor seems to be able to manage people successfully.');
INSERT INTO wording VALUES (322, 0, 'My supervisor seems to have the ability to make people work together.');
INSERT INTO wording VALUES (323, 0, 'My supervisor seems to have the ability to lead others.');
INSERT INTO wording VALUES (324, 0, 'My supervisor seems to let people down.');
INSERT INTO wording VALUES (325, 0, 'People seem to find it difficult to rely on my supervisor.');
INSERT INTO wording VALUES (326, 0, 'My supervisor seems to find it difficult to connect with people.');
INSERT INTO wording VALUES (327, 0, 'Other people seem to be seldom attracted to my supervisor.');
INSERT INTO wording VALUES (328, 0, 'My supervisor seems to find it difficult to motivate others.');
INSERT INTO wording VALUES (329, 0, 'My supervisor seems to find it difficult to influence people to follow him/her.');
INSERT INTO wording VALUES (330, 0, 'My supervisor seems to find it difficult to move people in a new direction.');
INSERT INTO wording VALUES (331, 0, 'My supervisors communication skills seem to be ineffective.');
INSERT INTO wording VALUES (332, 0, 'My supervisor seems to find it difficult to make people want to follow him/her.');
INSERT INTO wording VALUES (333, 0, 'My supervisor seems to find it difficult to build relationships with people.');
INSERT INTO wording VALUES (334, 0, 'My supervisor communicates with enthusiasm.');
INSERT INTO wording VALUES (335, 0, 'My supervisor seems to have the ability to persuade others.');
INSERT INTO wording VALUES (336, 0, 'My supervisor seems to find it difficult to listen to others.');
INSERT INTO wording VALUES (337, 0, 'My supervisor seems to be caught up in his/her own ideas.');
INSERT INTO wording VALUES (338, 0, 'My supervisor seems to find it difficult to listen carefully to what others have to say.');
INSERT INTO wording VALUES (339, 0, 'My supervisor seems too busy to listen to what others have to say.');
INSERT INTO wording VALUES (340, 0, 'My supervisor seems to ignore the emotional content of what others have to say.');
INSERT INTO wording VALUES (341, 0, 'My supervisor seems to pay attention to what others have to say.');
INSERT INTO wording VALUES (342, 0, 'My supervisor genuinely seems to listen to what others have to say.');
INSERT INTO wording VALUES (343, 0, 'My supervisor seems to pay close attention to what is going on around him/her.');
INSERT INTO wording VALUES (344, 0, 'My supervisor pays attention to people.');
INSERT INTO wording VALUES (345, 0, 'My supervisor seems to observe other peoples body language when they talk.');
INSERT INTO wording VALUES (346, 0, 'People seem to find it difficult to have confidence in my supervisor''s knowledge.');
INSERT INTO wording VALUES (347, 0, 'People seem to have poor confidence in the way my supervisor plans things.');
INSERT INTO wording VALUES (348, 0, 'People seem to have poor confidence in the way my supervisor does things.');
INSERT INTO wording VALUES (349, 0, 'My supervisor completes tasks unsuccessfully.');
INSERT INTO wording VALUES (350, 0, 'My supervisor seems to expect nothing from him/her self.');
INSERT INTO wording VALUES (351, 0, 'My supervisor seems mentally detached from his/her work.');
INSERT INTO wording VALUES (352, 0, 'My supervisor seems emotionally attached from his/her work.');
INSERT INTO wording VALUES (353, 0, 'My supervisor seems to give divided attention to his/her duties.');
INSERT INTO wording VALUES (354, 0, 'My supervisor performs at a consistently high level.');
INSERT INTO wording VALUES (355, 0, 'My supervisor performs well in what he/she does.');
INSERT INTO wording VALUES (356, 0, 'My supervisor seems to see the worst in everything.');
INSERT INTO wording VALUES (357, 0, 'My supervisor seems to maintain a negative attitude.');
INSERT INTO wording VALUES (358, 0, 'My supervisor seems to be a pessimist.');
INSERT INTO wording VALUES (359, 0, 'My supervisor seems to have a negative outlook on life.');
INSERT INTO wording VALUES (360, 0, 'My supervisor seems to mistrust people.');
INSERT INTO wording VALUES (361, 0, 'My supervisor seems to be a negative person.');
INSERT INTO wording VALUES (362, 0, 'My supervisor seems to think positively.');
INSERT INTO wording VALUES (363, 0, 'My supervisor seems to expect the best of him/her self.');
INSERT INTO wording VALUES (364, 0, 'My supervisor seems to have a positive attitude.');
INSERT INTO wording VALUES (365, 0, 'My supervisor seems to expect the best from others.');
INSERT INTO wording VALUES (366, 0, 'My supervisor seems to try to solve all problems at once.');
INSERT INTO wording VALUES (367, 0, 'My supervisor seems to  ignore problems in the hope they will go away.');
INSERT INTO wording VALUES (368, 0, 'My supervisor seems to avoid problems.');
INSERT INTO wording VALUES (369, 0, 'My supervisor seems to allow others to put obstacles in his/her way.');
INSERT INTO wording VALUES (370, 0, 'My supervisor seems to feel powerless to solve his/her problems.');
INSERT INTO wording VALUES (371, 0, 'My supervisor seems to make major decisions when he/she is down.');
INSERT INTO wording VALUES (372, 0, 'My supervisor seems overwhelmed by the volume of problems.');
INSERT INTO wording VALUES (373, 0, 'My supervisor seems overwhelmed by the size of his/her problems.');
INSERT INTO wording VALUES (374, 0, 'My supervisor seems to think of multiple solutions to his/her problems.');
INSERT INTO wording VALUES (375, 0, 'My supervisor sees problems as an act to advance.');
INSERT INTO wording VALUES (376, 0, 'My supervisor seems to lack the desire to serve others.');
INSERT INTO wording VALUES (377, 0, 'My supervisor seems unwilling to help others.');
INSERT INTO wording VALUES (378, 0, 'My supervisor seems to be too important to serve others.');
INSERT INTO wording VALUES (379, 0, 'My supervisor seems to lack the desire to help others.');
INSERT INTO wording VALUES (380, 0, 'My supervisor seems to lack a sense of obligation to serve.');
INSERT INTO wording VALUES (381, 0, 'My supervisor''s focus seems to be on rank and position.');
INSERT INTO wording VALUES (382, 0, 'My supervisor seems to put others ahead of his/her personal desires.');
INSERT INTO wording VALUES (383, 0, 'My supervisor initiates service to others.');
INSERT INTO wording VALUES (384, 0, 'My supervisor seems to serve without expecting anything in return.');
INSERT INTO wording VALUES (385, 0, 'My supervisor performs acts of kindness to others.');
INSERT INTO wording VALUES (386, 0, 'My supervisor seems to make good decisions');
INSERT INTO wording VALUES (387, 0, 'My supervisor seems to be sure of his/her self');
INSERT INTO wording VALUES (388, 0, 'Failures seem to make my supervisor try harder.');
INSERT INTO wording VALUES (389, 0, 'My supervisor seems to prefer situations where he/she can depend on someone else''s acute ability.');
INSERT INTO wording VALUES (390, 0, 'My supervisor''s ability to handle difficult situations are poor.');
INSERT INTO wording VALUES (391, 0, 'My supervisor seems capable of dealing with problems that come up in life.');
INSERT INTO wording VALUES (392, 0, 'My supervisor seems to avoid trying to learn new things when they seem too hard for him/her.');
INSERT INTO wording VALUES (393, 0, '"I find it difficult to handle problems without the support of something. (drugs');
INSERT INTO wording VALUES (394, 0, 'I prefer something to support me when things go wrong.');
INSERT INTO wording VALUES (395, 0, '"I find it difficult to keep up the pace without the help from something else. (drugs');
INSERT INTO wording VALUES (396, 0, 'Life is difficult to handle on my own.');
INSERT INTO wording VALUES (397, 0, 'I like it when something helps me to handle pressure.');
INSERT INTO wording VALUES (398, 0, '"I find it hard to manage life without the support of something else');
INSERT INTO wording VALUES (399, 0, '"I am dependent on the support of something else');
INSERT INTO wording VALUES (400, 0, 'I need something to cope with life.');
INSERT INTO wording VALUES (401, 0, 'My thoughts are frightening to me.');
INSERT INTO wording VALUES (402, 0, 'I find it difficult to get rid of bad thoughts.');
INSERT INTO wording VALUES (403, 0, 'I have disturbing thoughts.');
INSERT INTO wording VALUES (404, 0, 'Horrible thoughts rush into my mind.');
INSERT INTO wording VALUES (405, 0, 'I have ideas and thoughts that disturb me greatly.');
INSERT INTO wording VALUES (406, 0, 'Disturbing ideas come to me.');
INSERT INTO wording VALUES (407, 0, 'I have strange thoughts.');
INSERT INTO wording VALUES (408, 0, 'I think about horrible things.');
INSERT INTO wording VALUES (409, 0, 'I worry about the horrible thoughts that I have.');
INSERT INTO wording VALUES (410, 0, 'I forget important phone numbers.');
INSERT INTO wording VALUES (411, 0, 'I have difficulty remembering basic things.');
INSERT INTO wording VALUES (412, 0, 'I forget where I put things that I use daily.');
INSERT INTO wording VALUES (413, 0, 'I forget personal information.');
INSERT INTO wording VALUES (414, 0, 'I forget important things about my work or school.');
INSERT INTO wording VALUES (415, 0, 'I find it difficult to remember more than one instruction.');
INSERT INTO wording VALUES (416, 0, 'My memory seems to fail me.');
INSERT INTO wording VALUES (417, 0, 'People stare at me.');
INSERT INTO wording VALUES (418, 0, 'People are trying to make me look foolish.');
INSERT INTO wording VALUES (419, 0, 'People who are supposed to be my friends are out to stab me in the back.');
INSERT INTO wording VALUES (420, 0, 'I can feel people watching me.');
INSERT INTO wording VALUES (421, 0, 'People spy on me.');
INSERT INTO wording VALUES (422, 0, 'People talk about me behind my back.');
INSERT INTO wording VALUES (423, 0, '"People are ""out to get me""."');
INSERT INTO wording VALUES (424, 0, 'People are trying to hurt me.');
INSERT INTO wording VALUES (425, 0, 'People talk about me.');
INSERT INTO wording VALUES (426, 0, 'People try to cause me trouble.');
INSERT INTO wording VALUES (427, 0, 'I wake up at night worrying about things I have to do.');
INSERT INTO wording VALUES (428, 0, 'I worry when I have not completed things I had to do.');
INSERT INTO wording VALUES (429, 0, 'I feel frightened when I have to face my job problems.');
INSERT INTO wording VALUES (430, 0, 'I feel panicky at work.');
INSERT INTO wording VALUES (431, 0, 'I experience fear when I am alone.');
INSERT INTO wording VALUES (432, 0, 'I experience a sense of fear.');
INSERT INTO wording VALUES (433, 0, 'Worry affects my sleeping habits.');
INSERT INTO wording VALUES (434, 0, 'I think about committing suicide.');
INSERT INTO wording VALUES (435, 0, 'The only way to end my shame is to end my life.');
INSERT INTO wording VALUES (436, 0, 'I think about ending my life.');
INSERT INTO wording VALUES (437, 0, 'I think I shall find peace when I take my own life.');
INSERT INTO wording VALUES (438, 0, 'It is useless for me to continue living.');
INSERT INTO wording VALUES (439, 0, 'I think about my final plans for ending my life.');
INSERT INTO wording VALUES (440, 0, 'Everyone would be better off if I was dead.');
INSERT INTO wording VALUES (441, 0, 'My life is over and I may as well end it.');
INSERT INTO wording VALUES (442, 0, 'I think about different ways that I could kill myself.');
INSERT INTO wording VALUES (443, 0, 'My agony is too great for me to continue living.');
INSERT INTO wording VALUES (444, 0, 'Life is worthwhile.');
INSERT INTO wording VALUES (445, 0, 'I help make the world a better place.');
INSERT INTO wording VALUES (446, 0, 'I have a dream for my life.');
INSERT INTO wording VALUES (447, 0, 'I overcome obstacles in my life.');
INSERT INTO wording VALUES (448, 0, 'I make a difference in life.');
INSERT INTO wording VALUES (449, 0, 'I have a purpose in life.');
INSERT INTO wording VALUES (450, 0, 'I know why I live.');
INSERT INTO wording VALUES (451, 0, 'I learn from my previous experiences.');
INSERT INTO wording VALUES (452, 0, 'I want to keep developing my skills.');
INSERT INTO wording VALUES (452, 1, 'The candidate should want to keep developing his/her skills.');
INSERT INTO wording VALUES (453, 0, 'It is unimportant to me to keep developing my skills.');
INSERT INTO wording VALUES (453, 1, 'The candidate should enjoy training that could improve his/her abilities.');
INSERT INTO wording VALUES (454, 0, 'I enjoy learning new skills consistantly.');
INSERT INTO wording VALUES (454, 1, 'The candidate should enjoy learning new skills consistently.');
INSERT INTO wording VALUES (455, 0, 'I enjoy feeling proud of my accomplishments.');
INSERT INTO wording VALUES (455, 1, 'The candidate should enjoy feeling proud of his/her accomplishments.');
INSERT INTO wording VALUES (456, 0, 'I find it intimidating to have to learn new skills.');
INSERT INTO wording VALUES (456, 1, 'The candidate should want to use his/her abilities to the fullest.');
INSERT INTO wording VALUES (457, 0, 'I like to utilize my full potential.');
INSERT INTO wording VALUES (457, 1, 'The candidate should like to utilize his/her inner potential.');
INSERT INTO wording VALUES (458, 0, 'I am unhappy when my abilities are not being used.');
INSERT INTO wording VALUES (458, 1, 'The candidate should enjoy using his/her talents to the full.');
INSERT INTO wording VALUES (459, 0, 'I have a desire to understand why people do things.');
INSERT INTO wording VALUES (459, 1, 'The candidate should have a desire to understand why people do things.');
INSERT INTO wording VALUES (460, 0, 'I enjoy observing human behaviour.');
INSERT INTO wording VALUES (460, 1, 'The candidate should enjoy observing human behaviour.');
INSERT INTO wording VALUES (461, 0, 'I enjoy understanding peoples coping ability.');
INSERT INTO wording VALUES (461, 1, 'The candidate should enjoy understanding peoples coping ability.');
INSERT INTO wording VALUES (462, 0, 'I spend time listning to other peoples problems.');
INSERT INTO wording VALUES (462, 1, 'The candidate should spend time listning to other peoples problems.');
INSERT INTO wording VALUES (463, 0, 'I am interested in human behaviour.');
INSERT INTO wording VALUES (463, 1, 'The candidate should have an interested in human behaviour.');
INSERT INTO wording VALUES (464, 0, 'My interests are people orientated.');
INSERT INTO wording VALUES (464, 1, 'The candidates'' interests should be people orientated.');
INSERT INTO wording VALUES (465, 0, 'People''s behaviour fascinates me.');
INSERT INTO wording VALUES (465, 1, 'The candidate should be upset when he/she sees someone in distress.');
INSERT INTO wording VALUES (466, 0, 'I like making my own decisions');
INSERT INTO wording VALUES (466, 1, 'The candidate should make his/her own decisions and rely on the decision that he/she has made.');
INSERT INTO wording VALUES (467, 0, 'I like to be able to choose the way I do things.');
INSERT INTO wording VALUES (467, 1, 'The candidate should like to be able to choose the way he/she does things.');
INSERT INTO wording VALUES (468, 0, 'I like to be dependent on myself in order for me to function optimally.');
INSERT INTO wording VALUES (468, 1, 'The candidate should like to be dependent on him/her self in order to function optimally.');
INSERT INTO wording VALUES (469, 0, 'I rely on myself in order to make things happen.');
INSERT INTO wording VALUES (469, 1, 'The candidate should rely on him/her self in order to make things happen.');
INSERT INTO wording VALUES (470, 0, 'I like to work independantly in order to have a job done the way I want it done.');
INSERT INTO wording VALUES (470, 1, 'The candidate should like to work independantly in order to have a job done the way he/she wants it done.');
INSERT INTO wording VALUES (471, 0, 'I trust in my own abilities in order to achieve my objectives.');
INSERT INTO wording VALUES (471, 1, 'The candidate should trust in his/her own abilities in order to achieve his/her objectives');
INSERT INTO wording VALUES (472, 0, 'I trust in my own opinion in order to get things done.');
INSERT INTO wording VALUES (472, 1, 'The candidate should trust in his/her own opinion in order to get things done.');
INSERT INTO wording VALUES (473, 0, 'I like to have the freedom to manage people.');
INSERT INTO wording VALUES (473, 1, 'The candidate should like the freedom to manage people.');
INSERT INTO wording VALUES (474, 0, 'I like to control my working environment.');
INSERT INTO wording VALUES (474, 1, 'The candidate should like to control his/her working environment.');
INSERT INTO wording VALUES (475, 0, 'I am competent at managing other people.');
INSERT INTO wording VALUES (475, 1, 'The candidate should be competent at managing other people.');
INSERT INTO wording VALUES (476, 0, 'I like to be able to make the decisions at work.');
INSERT INTO wording VALUES (476, 1, 'The candidate should like to be able to make the decisions at work.');
INSERT INTO wording VALUES (477, 0, 'I like to plan the daily tasks at work.');
INSERT INTO wording VALUES (477, 1, 'The candidate should like to plan his/her daily tasks at work.');
INSERT INTO wording VALUES (478, 0, 'I like following up on the instruction I have given to people.');
INSERT INTO wording VALUES (478, 1, 'The candidate should like following up on the instruction he/she has given to people.');
INSERT INTO wording VALUES (479, 0, 'I am able to handle authority over people in a constructive way.');
INSERT INTO wording VALUES (479, 1, 'The candidate should be able to handle authority over people in a constructive way.');
INSERT INTO wording VALUES (480, 0, 'I like trying out new ideas.');
INSERT INTO wording VALUES (480, 1, 'The candidate should like trying out new ideas.');
INSERT INTO wording VALUES (481, 0, 'I enjoy initiating new actions.');
INSERT INTO wording VALUES (481, 1, 'The candidate should enjoy initiating new actions.');
INSERT INTO wording VALUES (482, 0, 'I enjoy coming up with better ways of doing things.');
INSERT INTO wording VALUES (482, 1, 'The candidate should enjoy creating better ideas.');
INSERT INTO wording VALUES (483, 0, 'I make creative plans.');
INSERT INTO wording VALUES (483, 1, 'The candidates should be able to make creative plans.');
INSERT INTO wording VALUES (484, 0, 'I want to create unique solutions.');
INSERT INTO wording VALUES (484, 1, 'The candidate should want to create unique solutions.');
INSERT INTO wording VALUES (485, 0, 'I enjoy discovering better ways of doing things.');
INSERT INTO wording VALUES (485, 1, 'The candidate should enjoy discovering better ways of doing things.');
INSERT INTO wording VALUES (486, 0, 'I like to create new ideas.');
INSERT INTO wording VALUES (486, 1, 'The candidate should like to create new ideas.');
INSERT INTO wording VALUES (487, 0, 'I am willing to work hard for a lot of money.');
INSERT INTO wording VALUES (487, 1, 'The candidate should be willing to work hard for a lot of money.');
INSERT INTO wording VALUES (488, 0, 'I value financial freedom by going the extra mile.');
INSERT INTO wording VALUES (488, 1, 'The candidate should value financial freedom by going the extra mile.');
INSERT INTO wording VALUES (489, 0, 'I want to be paid for the effort I put in.');
INSERT INTO wording VALUES (489, 1, 'The candidate should want to be paid for the effort he/she puts in.');
INSERT INTO wording VALUES (490, 0, 'It is important to me to be financially rewarded for my efforts.');
INSERT INTO wording VALUES (490, 1, 'It should be important to the candidate to be financially rewarded for his/her efforts.');
INSERT INTO wording VALUES (491, 0, 'I work long hours in order to achieve financial success.');
INSERT INTO wording VALUES (491, 1, 'The candidate should work long hours in order to achieve financial success.');
INSERT INTO wording VALUES (492, 0, 'Being rewarded with money for my efforts is important to me.');
INSERT INTO wording VALUES (492, 1, 'Being rewarded with money for the candidates'' efforts should be important to him/her.');
INSERT INTO wording VALUES (493, 0, 'Financial rewards motivate me to work harder.');
INSERT INTO wording VALUES (493, 1, 'Financial rewards should motivate the candidate to work harder.');
INSERT INTO wording VALUES (494, 0, 'The work environment must allow me the freedom to attend to other important things.');
INSERT INTO wording VALUES (494, 1, 'The working environment should allow the candidate the freedom to attend to other important things.');
INSERT INTO wording VALUES (495, 0, 'I like an environment with little restrictions.');
INSERT INTO wording VALUES (495, 1, 'The candidate should like an environment with little restrictions.');
INSERT INTO wording VALUES (496, 0, 'I want to manage my own working hours.');
INSERT INTO wording VALUES (496, 1, 'The candidate should want to manage his/her own working hours.');
INSERT INTO wording VALUES (497, 0, 'I want to be rated by my delivered outcomes.');
INSERT INTO wording VALUES (497, 1, 'The candidate should want to be rated on his/her delivered outcomes.');
INSERT INTO wording VALUES (498, 0, 'I want the freedom to plan my own working environment.');
INSERT INTO wording VALUES (498, 1, 'The candidate should want the freedom to plan his/her own working environment.');
INSERT INTO wording VALUES (499, 0, 'The amount of time spent on the job is not the way to evaluate me.');
INSERT INTO wording VALUES (499, 1, 'The amount of time spent on the job is not the way for evaluating the candidate.');
INSERT INTO wording VALUES (500, 0, 'The work environment has to allow me to plan my own schedule.');
INSERT INTO wording VALUES (500, 1, 'The work environment has to allow the candidate to plan his/her own schedule.');
INSERT INTO wording VALUES (501, 0, 'I like to be respected by others for the work I do.');
INSERT INTO wording VALUES (501, 1, 'The candidate should like to be respected by others for the work he/she does.');
INSERT INTO wording VALUES (502, 0, 'I enjoy having influence in my community.');
INSERT INTO wording VALUES (502, 1, 'The candidate should enjoy having influence in his/her community.');
INSERT INTO wording VALUES (503, 0, 'I enjoy being looked up to.');
INSERT INTO wording VALUES (503, 1, 'The candidate should enjoy being looked up to.');
INSERT INTO wording VALUES (504, 0, 'I need to be respected by others.');
INSERT INTO wording VALUES (504, 1, 'The candidate should need to be respected by others.');
INSERT INTO wording VALUES (505, 0, 'I enjoy being the focus of attention.');
INSERT INTO wording VALUES (505, 1, 'The candidate should enjoy being the focus of attention.');
INSERT INTO wording VALUES (506, 0, 'I like to feel important in my community.');
INSERT INTO wording VALUES (506, 1, 'The candidate should like to feel important in his/her community.');
INSERT INTO wording VALUES (507, 0, 'I enjoy having status within my job.');
INSERT INTO wording VALUES (507, 1, 'The candidates should enjoy having status within his/her job.');
INSERT INTO wording VALUES (508, 0, 'Exciting challenges stimulate me to work better.');
INSERT INTO wording VALUES (508, 1, 'Exciting and risky environments should stimulate the candidate.');
INSERT INTO wording VALUES (509, 0, 'When I am challenged I will not hessitate to take a risk in my job.');
INSERT INTO wording VALUES (509, 1, 'The candidate should be challenged by risky job situations.');
INSERT INTO wording VALUES (510, 0, 'I enjoy taking risks if it is financially rewarding.');
INSERT INTO wording VALUES (510, 1, 'The candidate should  enjoy taking risks in his/her job environment.');
INSERT INTO wording VALUES (511, 0, 'I gain satisfaction from being exposed to risky situations.');
INSERT INTO wording VALUES (511, 1, 'The candidate should gain satisfaction from being exposed to risky situations.');
INSERT INTO wording VALUES (512, 0, 'I am not scared to take chances if it is beneficial to me.');
INSERT INTO wording VALUES (512, 1, 'The candidate should function well in dangerous or risky situations.');
INSERT INTO wording VALUES (513, 0, 'I need excitement in my job.');
INSERT INTO wording VALUES (513, 1, 'The candidate should feel happy when he/she is placed in dangerous environments.');
INSERT INTO wording VALUES (514, 0, 'Life without a challenge is boring.');
INSERT INTO wording VALUES (514, 1, 'The candidate should become motivated when placed in a dangerous or risky environment.');
INSERT INTO wording VALUES (515, 0, 'Financial security motivates me to work harder.');
INSERT INTO wording VALUES (515, 1, 'Financial security should motivate the candidate to work harder.');
INSERT INTO wording VALUES (516, 0, 'I will  be satisfied with the financial security provided by my job.');
INSERT INTO wording VALUES (516, 1, 'The candidate needs to be satisfied with his/her financial security provided by his/her job.');
INSERT INTO wording VALUES (517, 0, 'It is important to me to be sure of a monthly salary.');
INSERT INTO wording VALUES (517, 1, 'It should be important to the candidate to be sure of a monthly salary.');
INSERT INTO wording VALUES (518, 0, 'I function optimally when I am sure of a regular income.');
INSERT INTO wording VALUES (518, 1, 'The candidate should function optimally when he/she is sure of a regular income.');
INSERT INTO wording VALUES (519, 0, 'I am satisfied due to the fact that I receive a regular income.');
INSERT INTO wording VALUES (519, 1, 'The candidate should get enough reward from a regular income.');
INSERT INTO wording VALUES (520, 0, 'Being rewarded with money for my efforts is important to me.');
INSERT INTO wording VALUES (520, 1, 'Knowing the candidate is getting a fixed salary should stimulate him/her.');
INSERT INTO wording VALUES (521, 0, 'I am willing to work hard for financial security.');
INSERT INTO wording VALUES (521, 1, 'The candidate should be willing to work hard for financial security.');
INSERT INTO wording VALUES (522, 0, 'My personal standards  are very  important to me.');
INSERT INTO wording VALUES (522, 1, 'The candidates'' personal values should be important to him/her.');
INSERT INTO wording VALUES (523, 0, '"I am willing to take the risk of being fired');
INSERT INTO wording VALUES (523, 1, '"The candidate should be willing to take the risk of being fired');
INSERT INTO wording VALUES (524, 0, 'I refuse to do work that I believe is wrong and is against my personal standards.');
INSERT INTO wording VALUES (524, 1, 'The candidate should refuse to do work that he/she believes is wrong and is against his/her personal standards.');
INSERT INTO wording VALUES (525, 0, 'I refuse to do things that are in conflict with my moral standards.');
INSERT INTO wording VALUES (525, 1, 'The candidate should refuse to do things that are in conflict with his/her moral standards.');
INSERT INTO wording VALUES (526, 0, 'It is important to me to act according to my personal standards.');
INSERT INTO wording VALUES (526, 1, 'It should be important to the candidate to act according to his/her personal standards.');
INSERT INTO wording VALUES (527, 0, 'My decisions are strongly influenced by my moral standards.');
INSERT INTO wording VALUES (527, 1, 'The candidates'' decisions should be strongly influenced by his/her moral standards.');
INSERT INTO wording VALUES (528, 0, 'I become frustrated when people do things that are against my personal standards.');
INSERT INTO wording VALUES (528, 1, 'The candidate should become frustrated when people do things that are against his/her personal standards.');
INSERT INTO wording VALUES (529, 0, 'I am prepared to lower my personal  standards if necessary.');
INSERT INTO wording VALUES (529, 1, 'The candidate should be prepared to lower his/her moral standards if necessary.');
INSERT INTO wording VALUES (530, 0, 'I object to people who do not maintain a high personal standard.');
INSERT INTO wording VALUES (530, 1, 'The candidate should be prejudice against people who do not maintain a high moral standard.');
INSERT INTO wording VALUES (531, 0, 'I am prepared to do things that I know are against my personal standards.');
INSERT INTO wording VALUES (531, 1, 'The candidate should be prepared to do things that he/she knows are against his/her personal standards.');
INSERT INTO wording VALUES (532, 0, 'I work better with people who have the same beliefs as me.');
INSERT INTO wording VALUES (532, 1, 'The candidate should work better with people who have the same personal standards as him/her self.');
INSERT INTO wording VALUES (533, 0, 'I prefer working with people who see life the same way as I do.');
INSERT INTO wording VALUES (533, 1, 'The candidate should prefer working with people who see life the same way as he/she does.');
INSERT INTO wording VALUES (534, 0, 'Cultural identity plays an important role on how I get on with others.');
INSERT INTO wording VALUES (534, 1, 'Cultural identity should play an important role on how the candidate gets on with others.');
INSERT INTO wording VALUES (535, 0, 'I prefer working with people of the same cultural identity.');
INSERT INTO wording VALUES (535, 1, 'The candidate should prefer working with people of the same cultural identity.');
INSERT INTO wording VALUES (536, 0, 'I prefer working with someone who was brought up the same way as I was.');
INSERT INTO wording VALUES (536, 1, 'The candidate should prefer working with someone who was brought up the same as he/she was.');
INSERT INTO wording VALUES (537, 0, 'I find it hard to work with someone who has different values to me.');
INSERT INTO wording VALUES (537, 1, 'The candidate should find it hard to work with someone who has different values to him/her self.');
INSERT INTO wording VALUES (538, 0, 'I have the ability to create beautiful designs while performing my job.');
INSERT INTO wording VALUES (538, 1, 'The candidate should have the ability to create beautiful designs while performing his/her job.');
INSERT INTO wording VALUES (539, 0, '"I enjoy creating designs');
INSERT INTO wording VALUES (539, 1, 'The candidate should enjoy creating artistic and/or beautiful things as a job.');
INSERT INTO wording VALUES (540, 0, 'I really appreciate being able to do and/or create good art while doing my job.');
INSERT INTO wording VALUES (540, 1, '"The candidate should really appreciate being able to create good art');
INSERT INTO wording VALUES (541, 0, 'I have an artistic ability to be creative in my job.');
INSERT INTO wording VALUES (541, 1, 'The candidate should have an artistic ability to be creative in his/her job.');
INSERT INTO wording VALUES (542, 0, 'I love using artistic talents  to achieve my tasks at work.');
INSERT INTO wording VALUES (542, 1, 'The candidate should love using artistic means to achieve his/her tasks at work.');
INSERT INTO wording VALUES (543, 0, 'I value my artistic expertise in order to do my job efficiently.');
INSERT INTO wording VALUES (543, 1, 'The candidate should value artistic expertise within his/her job.');
INSERT INTO wording VALUES (544, 0, '"I love doing art by creating');
INSERT INTO wording VALUES (544, 1, 'The candidate should enjoy creating original artistic designs on his/her own.');
INSERT INTO wording VALUES (545, 0, 'Teamwork is important to me.');
INSERT INTO wording VALUES (545, 1, 'Teamwork should be important to the candidate.');
INSERT INTO wording VALUES (546, 0, 'I prefer making decisions as a team member.');
INSERT INTO wording VALUES (546, 1, 'The candidate should prefer making decisions as a team member.');
INSERT INTO wording VALUES (547, 0, 'I achieve more when working as a team player.');
INSERT INTO wording VALUES (547, 1, 'The candidate should achieve more when working with others.');
INSERT INTO wording VALUES (548, 0, 'I enjoy sharing new ideas with my team members.');
INSERT INTO wording VALUES (548, 1, 'The candidate should enjoy sharing new ideas with his/her team members.');
INSERT INTO wording VALUES (549, 0, 'I really enjoy working together as part of a team.');
INSERT INTO wording VALUES (549, 1, 'The candidate should really enjoy working together as a team member.');
INSERT INTO wording VALUES (550, 0, 'I enjoy achieving my daily tasks as a team member.');
INSERT INTO wording VALUES (550, 1, 'The candidate should enjoy working as a team member.');
INSERT INTO wording VALUES (551, 0, 'Making decisions as a team stimulates me.');
INSERT INTO wording VALUES (551, 1, 'The candidate should work best when he/she works as a team member.');
INSERT INTO wording VALUES (552, 0, 'I like my body to be kept active by my job.');
INSERT INTO wording VALUES (552, 1, 'The candidate should like his/her body to be kept active by his/her job.');
INSERT INTO wording VALUES (553, 0, 'I get a lot of satisfaction doing physical work.');
INSERT INTO wording VALUES (553, 1, 'The candidate should get a lot of satisfaction by doing physical work.');
INSERT INTO wording VALUES (554, 0, 'I enjoy work that keeps me physically active.');
INSERT INTO wording VALUES (554, 1, 'The candidate should enjoy work that keeps him physically active.');
INSERT INTO wording VALUES (555, 0, 'I enjoy being physically active in my job.');
INSERT INTO wording VALUES (555, 1, 'The candidate should enjoy being physically active in his/her job.');
INSERT INTO wording VALUES (556, 0, 'I need a job that  keeps me physically active.');
INSERT INTO wording VALUES (556, 1, 'The candidate should enjoy work that is physically demanding.');
INSERT INTO wording VALUES (557, 0, 'I need a job that makes me work physically hard.');
INSERT INTO wording VALUES (557, 1, 'The candidate should need to work physically hard.');
INSERT INTO wording VALUES (558, 0, 'I enjoy getting physical exercise while working.');
INSERT INTO wording VALUES (558, 1, 'The candidate should enjoy getting physical exercise while working.');
INSERT INTO wording VALUES (559, 0, 'I enjoy working in an environment where I know what is happening daily.');
INSERT INTO wording VALUES (559, 1, 'The candidate should enjoy doing repetitive work.');
INSERT INTO wording VALUES (560, 0, 'I function best when I know what will be happening next.');
INSERT INTO wording VALUES (560, 1, 'The candidate should function best when he/she knows what will be happening next.');
INSERT INTO wording VALUES (561, 0, 'I prefer a structured way of doing things.');
INSERT INTO wording VALUES (561, 1, 'The candidate should prefer a structured way of doing things.');
INSERT INTO wording VALUES (562, 0, 'It is stimulating not to always have to learn new things.');
INSERT INTO wording VALUES (562, 1, 'The candidate should find it stimulating not to always have to learn new things.');
INSERT INTO wording VALUES (563, 0, 'I get frustrated when my working tasks keep changing.');
INSERT INTO wording VALUES (563, 1, 'The candidate should get frustrated when his/her working tasks keep changing.');
INSERT INTO wording VALUES (564, 0, 'I hate to have to keep chopping and changing in my job.');
INSERT INTO wording VALUES (564, 1, 'The candidate should hate chopping and changing his/her job.');
INSERT INTO wording VALUES (565, 0, 'Once I am competent in my job I do not enjoy changing.');
INSERT INTO wording VALUES (565, 1, '"Once the candidate is competent in his/her job');
INSERT INTO wording VALUES (566, 0, 'My job needs to provide the opportunity for me to develop myself .');
INSERT INTO wording VALUES (566, 1, 'The candidate should need to develop him/her self as an individual person.');
INSERT INTO wording VALUES (567, 0, 'It is important for me to become better at my job.');
INSERT INTO wording VALUES (567, 1, 'It should be important to the candidate to become a better person.');
INSERT INTO wording VALUES (568, 0, 'I am enthusiastic when my job allows me to continuously improve myself.');
INSERT INTO wording VALUES (568, 1, 'The candidate should be enthusiastic about improving him/her self.');
INSERT INTO wording VALUES (569, 0, 'I need a job in which I can enhance my personal functioning.');
INSERT INTO wording VALUES (569, 1, 'The candidate should need a job to enhance his/her personal functioning.');
INSERT INTO wording VALUES (570, 0, 'I need to develop myself through my job.');
INSERT INTO wording VALUES (570, 1, 'The candidate should need to develop him/her self by his/her job.');
INSERT INTO wording VALUES (571, 0, 'My job must allow me to enable myself to become more efficient.');
INSERT INTO wording VALUES (571, 1, 'The candidates'' job should enable him/her to become a better person.');
INSERT INTO wording VALUES (572, 0, 'I will become more efficient by improving myself.');
INSERT INTO wording VALUES (572, 1, 'The candidate should become more efficient by improving him/her self.');
INSERT INTO wording VALUES (573, 0, 'I enjoy experiencing challenges while performing my daily tasks.');
INSERT INTO wording VALUES (573, 1, 'The candidate should enjoy experiencing life as a challenge.');
INSERT INTO wording VALUES (574, 0, 'I enjoy the experiences of challenges within my job.');
INSERT INTO wording VALUES (574, 1, 'The candidate should enjoy challenges to make him/her grow in the company.');
INSERT INTO wording VALUES (575, 0, 'I thrive on meeting the day to day deadlines at work.');
INSERT INTO wording VALUES (575, 1, 'The candidate should be goal orientated.');
INSERT INTO wording VALUES (576, 0, 'It is important to me to complete my tasks on time.');
INSERT INTO wording VALUES (576, 1, 'It should be important to the candidate to complete his/her tasks on time.');
INSERT INTO wording VALUES (577, 0, 'I make it a priority for me to motivate myself when challenged.');
INSERT INTO wording VALUES (577, 1, 'It should be important to the candidate to motivate him/her self when challenged.');
INSERT INTO wording VALUES (578, 0, 'I like to be faced with challenges at work.');
INSERT INTO wording VALUES (578, 1, 'The candidate should like to work independently to complete his/her working tasks.');
INSERT INTO wording VALUES (579, 0, 'I enjoy the challenges of  having to solve my problems on my own.');
INSERT INTO wording VALUES (579, 1, 'The candidate should enjoy the challenge of solving his/her problems on his/her own.');
INSERT INTO wording VALUES (580, 0, 'I enjoy doing different tasks daily.');
INSERT INTO wording VALUES (580, 1, 'The candidate should enjoy doing different jobs daily.');
INSERT INTO wording VALUES (581, 0, 'I like to complete various tasks daily.');
INSERT INTO wording VALUES (581, 1, 'The candidate should need to change his/her work activities from time to time.');
INSERT INTO wording VALUES (582, 0, 'I enjoy being responsible for different tasks daily.');
INSERT INTO wording VALUES (582, 1, 'The candidate should enjoy regular changes in his/her job.');
INSERT INTO wording VALUES (583, 0, 'I like doing a variety of different  jobs at work.');
INSERT INTO wording VALUES (583, 1, 'The candidate should like doing a variety of jobs at work.');
INSERT INTO wording VALUES (584, 0, 'I like to be given one task at a time.');
INSERT INTO wording VALUES (584, 1, 'Repetitive work should frustrate the candidate.');
INSERT INTO wording VALUES (585, 0, 'I get frustrated if I am given too many tasks at the same time.');
INSERT INTO wording VALUES (585, 1, 'The candidate should get frustrated if they have to do the same thing every day.');
INSERT INTO wording VALUES (586, 0, 'I am orientated towards a job where I am used for multi-tasking functions.');
INSERT INTO wording VALUES (586, 1, 'The candidate should be orientated to have a job where he/she is used for multi-tasking functions.');
INSERT INTO wording VALUES (587, 0, 'I have the desire to place others needs before my own.');
INSERT INTO wording VALUES (587, 1, 'The candidate should have the desire to initiate services for others.');
INSERT INTO wording VALUES (588, 0, 'Putting other peoples personal needs before my own is important to me.');
INSERT INTO wording VALUES (588, 1, 'The candidate should be willing to serve others at his/her own expense.');
INSERT INTO wording VALUES (589, 0, 'I am available to place others in front of my own personal desires.');
INSERT INTO wording VALUES (589, 1, 'The candidate should be available to place others in front of his/her personal desires.');
INSERT INTO wording VALUES (590, 0, 'I have a personal desire to attend to others needs without reward.');
INSERT INTO wording VALUES (590, 1, 'The candidate should have a desire to serve others.');
INSERT INTO wording VALUES (591, 0, '"I get a sense of satisfaction in my job');
INSERT INTO wording VALUES (591, 1, 'The candidate should have a sense of obligation to serve others less privileged.');
INSERT INTO wording VALUES (592, 0, 'I like to help others ahead of my  desires.');
INSERT INTO wording VALUES (592, 1, 'The candidate should put others ahead of his/her personal desires.');
INSERT INTO wording VALUES (593, 0, 'I like to initiate action in order to serve others in my job.');
INSERT INTO wording VALUES (593, 1, 'The candidate should initiate services to help others.');
INSERT INTO wording VALUES (594, 0, 'I like to meet the personal needs of others without expecting anything in return.');
INSERT INTO wording VALUES (594, 1, 'The candidate should serve others without expecting anything in return.');
INSERT INTO wording VALUES (595, 0, 'In my job I like to have all my needs taken care of.');
INSERT INTO wording VALUES (595, 1, 'The candidate should perform acts of kindness to others who are less fortunate than themselves.');
INSERT INTO wording VALUES (596, 0, 'It is important to know that I have been successful in my tasks.');
INSERT INTO wording VALUES (596, 1, 'The candidate needs to know that he/she has been successful in his/her tasks.');
INSERT INTO wording VALUES (597, 0, 'It is necessary to see tangible results for my efforts at work.');
INSERT INTO wording VALUES (597, 1, 'The candidate should want to achieve his/her objectives timeously.');
INSERT INTO wording VALUES (598, 0, 'I will continue working untill I have achieved my objectives.');
INSERT INTO wording VALUES (598, 1, 'The candidate needs to continue working untill he/she has achieved his/her objectives.');
INSERT INTO wording VALUES (599, 0, 'At the end of the day I like to feel I have accomplished my objectives.');
INSERT INTO wording VALUES (599, 1, 'At the end of the day the candidate should like to feel that he/she has accomplished his/her objectives.');
INSERT INTO wording VALUES (600, 0, 'Getting something finished on time motivates me to keep working.');
INSERT INTO wording VALUES (600, 1, 'Getting something finished should motivate the candidate to keep working.');
INSERT INTO wording VALUES (601, 0, 'I need to be sure of achieving all my objectives timeously.');
INSERT INTO wording VALUES (601, 1, 'The candidate needs to be sure of achieving all his/her objectives timeously.');
INSERT INTO wording VALUES (602, 0, 'I like having to set my goals and thereby achieve my objectives on time.');
INSERT INTO wording VALUES (602, 1, 'Tangible results should motivates the candidate to work harder.');
INSERT INTO wording VALUES (603, 0, 'I believe there is nothing better at work than to achieve my objectives on time.');
INSERT INTO wording VALUES (603, 1, 'The candidate should believe that there is nothing better than achieving his/her objectives timeously.');
INSERT INTO wording VALUES (604, 0, 'I enjoy the type of job  where I have to be physically fit.');
INSERT INTO wording VALUES (604, 1, 'The candidate should enjoy work where he/she has to be physically fit.');
INSERT INTO wording VALUES (605, 0, 'I feel good when working hard at work physically.');
INSERT INTO wording VALUES (605, 1, 'The candidate must feel good when working hard physically');
INSERT INTO wording VALUES (606, 0, 'I get satisfaction from the type of work which is physically demanding.');
INSERT INTO wording VALUES (606, 1, 'The candidate should get satisfaction from work which is physically demanding');
INSERT INTO wording VALUES (607, 0, 'I like training in order to be physically fit to do my job effectively.');
INSERT INTO wording VALUES (607, 1, 'The candidate must like training in order to be physically fit in his/her job');
INSERT INTO wording VALUES (608, 0, 'I work out physically for many hours each day in order to be competitive in my job.');
INSERT INTO wording VALUES (608, 1, 'The candidate should work out physically for many hours each day in order to be competitive in his/her job');
INSERT INTO wording VALUES (609, 0, 'Physical fitness and hard training is satisfying to me.');
INSERT INTO wording VALUES (609, 1, 'Physical fitness and hard training should be satisfying for the candidate.');
INSERT INTO wording VALUES (610, 0, 'Other people trust me.');
INSERT INTO wording VALUES (610, 1, 'Other people find it difficult to trust the candidate.');
INSERT INTO wording VALUES (611, 0, 'I have strong leadership abilities');
INSERT INTO wording VALUES (611, 1, 'The candidate should have good leadership abilities.');
INSERT INTO wording VALUES (612, 0, 'I find it easy to manage difficult situations.');
INSERT INTO wording VALUES (612, 1, 'The candidate should find it difficult to get out of difficult situations.');
INSERT INTO wording VALUES (613, 0, 'I tell lies to suit my needs.');
INSERT INTO wording VALUES (613, 1, 'The candidate tells lies to suit his/her needs.');
INSERT INTO wording VALUES (614, 0, 'I am willing to face my flaws.');
INSERT INTO wording VALUES (614, 1, 'The candidate should be willing to face his/her flaws.');
INSERT INTO wording VALUES (615, 0, 'I can manage people successfully.');
INSERT INTO wording VALUES (615, 1, 'The candidate should manage people successfully.');
INSERT INTO wording VALUES (616, 0, 'I have the ability to initiate that people work together in harmony.');
INSERT INTO wording VALUES (616, 1, 'The candidate should have the ability to let people work together.');
INSERT INTO wording VALUES (617, 0, 'I have the ability to encourage people.');
INSERT INTO wording VALUES (617, 1, 'The candidate should have the ability to lead others.');
INSERT INTO wording VALUES (618, 0, 'I do not let people down.');
INSERT INTO wording VALUES (618, 1, 'The candidate should not let people down.');
INSERT INTO wording VALUES (619, 0, 'People find it difficult to  rely on me.');
INSERT INTO wording VALUES (619, 1, 'People should be able to rely on the candidate.');
INSERT INTO wording VALUES (700, 0, 'I try to solve all problems at once.');
INSERT INTO wording VALUES (700, 1, 'The candidate should try to solve all problems at once.');
INSERT INTO wording VALUES (701, 0, 'I ignore problems in the hope they will go away.');
INSERT INTO wording VALUES (701, 1, 'The candidate should ignore problems in the hope they will go away.');
INSERT INTO wording VALUES (702, 0, 'I try to avoid the problems at work.');
INSERT INTO wording VALUES (702, 1, 'The candidate should avoid problems.');
INSERT INTO wording VALUES (703, 0, 'I allow others to put obstacles in my way.');
INSERT INTO wording VALUES (703, 1, 'The candidate should allow others to put obstacles in his/her way.');
INSERT INTO wording VALUES (704, 0, 'I feel powerless to take action in order to solve my problems.');
INSERT INTO wording VALUES (704, 1, 'The candidate should feel powerless to solve his/her problems.');
INSERT INTO wording VALUES (705, 0, 'I make major decisions when I am freeling  down.');
INSERT INTO wording VALUES (705, 1, 'The candidate should be able to make major decisions when he/she is down.');
INSERT INTO wording VALUES (706, 0, 'I am overwhelmed by the volume of the problems.');
INSERT INTO wording VALUES (706, 1, 'The candidate is overwhelmed by the volume of his/her problems.');
INSERT INTO wording VALUES (707, 0, 'The size of my problems overwhelms me at work.');
INSERT INTO wording VALUES (707, 1, 'The candidate is overwhelmed by the size of his/her problem.');
INSERT INTO wording VALUES (708, 0, 'I think of multiple solutions for my problems.');
INSERT INTO wording VALUES (708, 1, 'The candidate should think of multiple solutions for his/her problem.');
INSERT INTO wording VALUES (709, 0, 'I see problems as an act to advance my career.');
INSERT INTO wording VALUES (709, 1, 'The candidate should see problems as an act to advance.');
INSERT INTO wording VALUES (640, 0, 'I feel that people have confidence in me.');
INSERT INTO wording VALUES (640, 1, 'People find it difficult to have confidence in the candidates'' knowledge.');
INSERT INTO wording VALUES (641, 0, 'I feel that people have limited confidence in the way I plan things.');
INSERT INTO wording VALUES (641, 1, 'People have little confidence in the way the candidate plans things.');
INSERT INTO wording VALUES (642, 0, 'I feel that people like the way I do things');
INSERT INTO wording VALUES (642, 1, 'People have little confidence in the way the candidate does things.');
INSERT INTO wording VALUES (643, 0, 'I complete my tasks successfully at work.');
INSERT INTO wording VALUES (643, 1, 'The candidate completes tasks unsuccessfully.');
INSERT INTO wording VALUES (644, 0, 'I feel that there are great expectations for my future at work.');
INSERT INTO wording VALUES (644, 1, 'The candidate expects nothing from him/her self.');
INSERT INTO wording VALUES (645, 0, 'I feel that I am detached from my working environment.');
INSERT INTO wording VALUES (645, 1, 'The candidate is mentally detached from his/her work.');
INSERT INTO wording VALUES (646, 0, 'I am emotionally attached to my work.');
INSERT INTO wording VALUES (646, 1, 'The candidate should be emotionally attached to his/her work.');
INSERT INTO wording VALUES (647, 0, 'I give undivided attention to my duties.');
INSERT INTO wording VALUES (647, 1, 'The candidate should give undivided attention to his/her duties.');
INSERT INTO wording VALUES (648, 0, 'I perform at a consistently high level.');
INSERT INTO wording VALUES (648, 1, 'The candidate should perform at a consistently high level.');
INSERT INTO wording VALUES (649, 0, 'I am proficient  in what I do.');
INSERT INTO wording VALUES (649, 1, 'The candidate should perform well in what he/she does.');
INSERT INTO wording VALUES (660, 0, 'I need my colleagues to keep  motivating  me.');
INSERT INTO wording VALUES (660, 1, 'The candidate need other people to motivate them.');
INSERT INTO wording VALUES (661, 0, 'I need a jump-start to get me going at work.');
INSERT INTO wording VALUES (661, 1, 'The candidate needs a jump-start from others.');
INSERT INTO wording VALUES (662, 0, 'I hesitate to start taking action when things go wrong at work.');
INSERT INTO wording VALUES (662, 1, 'The candidate should hesitate to take action.');
INSERT INTO wording VALUES (663, 0, 'I hate taking the responsibility for things that go wrong at work.');
INSERT INTO wording VALUES (663, 1, 'The candidate should hate taking risks.');
INSERT INTO wording VALUES (664, 0, 'I wait for others to react when there is a problem.');
INSERT INTO wording VALUES (664, 1, 'The candidate should wait for others to react when there is a problem.');
INSERT INTO wording VALUES (665, 0, 'I wait for others to make things happen.');
INSERT INTO wording VALUES (665, 1, 'The candidate waits for others to make things happen.');
INSERT INTO wording VALUES (666, 0, 'I am discouraged by my past failures.');
INSERT INTO wording VALUES (666, 1, 'The candidate is discouraged by past failures.');
INSERT INTO wording VALUES (667, 0, 'I find a way to make things happen in my life.');
INSERT INTO wording VALUES (667, 1, 'The candidate should find a way to make things happen.');
INSERT INTO wording VALUES (668, 0, 'I push myself to act when things need to be done.');
INSERT INTO wording VALUES (668, 1, 'The candidate should push him/her self to act.');
INSERT INTO wording VALUES (669, 0, 'I am ready to react first when work has to be done.');
INSERT INTO wording VALUES (669, 1, 'The candidate should be ready to take action first.');
INSERT INTO wording VALUES (710, 0, 'I am capable of dealing with my problems.');
INSERT INTO wording VALUES (710, 1, 'The candidate should be capable of dealing with his/her lives.');
INSERT INTO wording VALUES (711, 0, 'I am able to make decisions on my own.');
INSERT INTO wording VALUES (711, 1, 'The candidateshould be able to make decisions on his/her own.');
INSERT INTO wording VALUES (712, 0, 'I am willing to go the extra mile at work.');
INSERT INTO wording VALUES (712, 1, 'The candidate should be willing to go the extra mile.');
INSERT INTO wording VALUES (713, 0, 'I am willing to do whatever it takes to complete a job on time.');
INSERT INTO wording VALUES (713, 1, 'The candidate should be willing to do whatever it takes to complete a job on time.');
INSERT INTO wording VALUES (714, 0, 'I prefer to depend on someone else''s ability.');
INSERT INTO wording VALUES (714, 1, 'The candidate should prefer to depend on someone else''s ability.');
INSERT INTO wording VALUES (715, 0, 'I find it hard to handle difficult situations.');
INSERT INTO wording VALUES (715, 1, 'The candidate should find it hard to handle difficult situations.');
INSERT INTO wording VALUES (716, 0, 'I have the ability to finish tasks on time.');
INSERT INTO wording VALUES (716, 1, 'The candidate should have the ability to finish tasks on time.');
INSERT INTO wording VALUES (717, 0, 'I am able to deliver the desired outcome at work.');
INSERT INTO wording VALUES (717, 1, 'The candidate should be able to deliver despite difficult circumstances.');
INSERT INTO wording VALUES (718, 0, 'I take control of my life.');
INSERT INTO wording VALUES (718, 1, 'The candidate should take control of his/her life.');
INSERT INTO wording VALUES (719, 0, 'I have a get it done attitude at work.');
INSERT INTO wording VALUES (719, 1, 'The candidate should have a get it done attitude.');
INSERT INTO wording VALUES (730, 0, 'I am accountable for my decisions.');
INSERT INTO wording VALUES (730, 1, 'The candidate should be accountable for his/her decisions.');
INSERT INTO wording VALUES (731, 0, 'I do what is expected of me within my time fram.');
INSERT INTO wording VALUES (731, 1, 'The candidate should do what is expected of him/her.');
INSERT INTO wording VALUES (732, 0, 'Keeping time is very important to me.');
INSERT INTO wording VALUES (732, 1, 'Time should be very important to the candidate.');
INSERT INTO wording VALUES (733, 0, 'I am able to do whatever I say I will do .');
INSERT INTO wording VALUES (733, 1, 'The candidate should be able to do whatever he/she says he/she will do.');
INSERT INTO wording VALUES (734, 0, 'I avoid people when I have not done what I promised.');
INSERT INTO wording VALUES (734, 1, 'The candidate should avoid people when he/she has not done what he/she promised.');
INSERT INTO wording VALUES (735, 0, 'I will contact the person if I am late.');
INSERT INTO wording VALUES (735, 1, 'The candidate should be capable of dealing with problems that come up in his/her life.');
INSERT INTO wording VALUES (736, 0, 'I avoid contacting people when I have not kept my undertakings.');
INSERT INTO wording VALUES (736, 1, 'The candidate should avoid contacting people when he/she has not kept his/her undertakings.');
INSERT INTO wording VALUES (737, 0, 'I am prepared to be patient in order to achieve my objectives.');
INSERT INTO wording VALUES (737, 1, 'The candidate must be prepared to be patient in order to achieve his/her objectives.');
INSERT INTO wording VALUES (738, 0, 'I can work on detail  for hours.');
INSERT INTO wording VALUES (738, 1, 'The candidate should be able to work on a small thing for hours.');
INSERT INTO wording VALUES (739, 0, 'I can stand in a line for long periods of time.');
INSERT INTO wording VALUES (739, 1, 'The candidate should be patient when having to stand in a queue.');
INSERT INTO wording VALUES (740, 0, 'I am very patient with people who learn slowly.');
INSERT INTO wording VALUES (740, 1, 'The candidate must be very patient with people who learn slowly.');
INSERT INTO wording VALUES (741, 0, 'People who battle to understand simple instructions irritate me.');
INSERT INTO wording VALUES (741, 1, 'People who battle to understand simple instructions should irritate the candidate.');
INSERT INTO wording VALUES (742, 0, 'I enjoy spending long periods of  time on detail.');
INSERT INTO wording VALUES (742, 1, 'The candidate must spend time on detail.');
INSERT INTO wording VALUES (743, 0, 'People who do not understand my point of view frustrate me.');
INSERT INTO wording VALUES (743, 1, 'People who do not understand the candidate''s point of view should frustrate him/her.');
INSERT INTO wording VALUES (744, 0, 'I need results immediately.');
INSERT INTO wording VALUES (744, 1, 'The candidate should need to have results immediately.');
INSERT INTO wording VALUES (745, 0, 'I get frustrated  when people do not complete their tasks on time.');
INSERT INTO wording VALUES (745, 1, 'The candidate should be patient when people do not complete their tasks on time.');
INSERT INTO wording VALUES (746, 0, 'I do mind waiting for people when I need to do things.');
INSERT INTO wording VALUES (746, 1, 'The candidate should not mind waiting for people when he/she needs to do things.');
INSERT INTO wording VALUES (747, 0, 'I keep on trying until I succeed.');
INSERT INTO wording VALUES (747, 1, 'The candidate should keep on trying until he/she succeeds.');
INSERT INTO wording VALUES (748, 0, 'I keep on working until my daily tasks are completed.');
INSERT INTO wording VALUES (748, 1, 'The candidate should keep on working until his/her daily tasks are completed.');
INSERT INTO wording VALUES (749, 0, 'It is important to me to keep on working untill I  understand my daily tasks.');
INSERT INTO wording VALUES (749, 1, 'It should be importantant to the candidate to understand his/her daily tasks.');
INSERT INTO wording VALUES (750, 0, 'I complete my daily tasks even though the tasks are difficult.');
INSERT INTO wording VALUES (750, 1, 'The candidate should complete his/her daily tasks even though the tasks are difficult.');
INSERT INTO wording VALUES (751, 0, 'It is important to me to do better and better.');
INSERT INTO wording VALUES (751, 1, 'It should be important to the candidate to do better and better.');
INSERT INTO wording VALUES (752, 1, 'The candidate should work very hard at his/her tasks.');
INSERT INTO wording VALUES (753, 0, 'It is important to me to complete my daily tasks correctly.');
INSERT INTO wording VALUES (753, 1, 'It should be important to the candidate to do his/her tasks correctly.');
INSERT INTO wording VALUES (754, 0, 'It is important to me to continue untill things are correct.');
INSERT INTO wording VALUES (754, 1, 'It should be important to the candidate to continue untill things are correct.');
INSERT INTO wording VALUES (620, 0, 'I am afraid to commit myself to deadlines in my job.');
INSERT INTO wording VALUES (620, 1, 'The candidate is afraid to commit to life.');
INSERT INTO wording VALUES (621, 0, 'I find it difficult to follow through on my promises.');
INSERT INTO wording VALUES (621, 1, 'The candidate finds it difficult to follow through on his/her promises.');
INSERT INTO wording VALUES (622, 0, 'I like to set my own goals at work.');
INSERT INTO wording VALUES (622, 1, 'The candidate finds it difficult to set goals.');
INSERT INTO wording VALUES (623, 0, 'I feel like quiting  under difficult circumstances.');
INSERT INTO wording VALUES (623, 1, 'The candidate quits under difficult circumstances.');
INSERT INTO wording VALUES (624, 0, 'I am willing to make sacrifices in order  to reach my goals.');
INSERT INTO wording VALUES (624, 1, 'The candidate should be willing to make sacrifices to reach his/her goals.');
INSERT INTO wording VALUES (625, 0, 'I spend extra time on the job in order to grow personally.');
INSERT INTO wording VALUES (625, 1, 'The candidate should spend time to grow personally.');
INSERT INTO wording VALUES (626, 0, 'I have the dedication to achieve my set objectives at work.');
INSERT INTO wording VALUES (626, 1, 'The candidate lacks the dedication to achieve his/her goals.');
INSERT INTO wording VALUES (627, 0, 'I feel the urge to do my work efficiently.');
INSERT INTO wording VALUES (627, 1, 'The candidate lacks the commitment to his/her work effectively.');
INSERT INTO wording VALUES (628, 0, 'I spend time on trying to develop my skills at work.');
INSERT INTO wording VALUES (628, 1, 'The candidate hardly spends time to develop his/her skills.');
INSERT INTO wording VALUES (629, 0, 'I keep on trying until I am successful.');
INSERT INTO wording VALUES (629, 1, 'The candidate should keep trying until he/she is successful.');
INSERT INTO wording VALUES (650, 0, 'I find it difficult to focus on one thing at a time.');
INSERT INTO wording VALUES (650, 1, 'The candidate should find it difficult to focus on one thing at a time.');
INSERT INTO wording VALUES (651, 0, 'I spend much time concentrating on my weaknesses.');
INSERT INTO wording VALUES (651, 1, 'The candidate should spend a lot of time concentrating on his/her weaknesses.');
INSERT INTO wording VALUES (652, 0, 'I have lost the ability to concentrate');
INSERT INTO wording VALUES (652, 1, 'The candidate should have lost his/her focus.');
INSERT INTO wording VALUES (653, 0, 'My concentration level is divided.');
INSERT INTO wording VALUES (653, 1, 'The candidates'' focus should be divided.');
INSERT INTO wording VALUES (654, 0, 'I have lost direction in my  life.');
INSERT INTO wording VALUES (654, 1, 'The candidate should have lost his/her focus in life.');
INSERT INTO wording VALUES (655, 0, 'I spend time concentrating  on my strengths.');
INSERT INTO wording VALUES (655, 1, 'The candidate should focus on his/her strengths.');
INSERT INTO wording VALUES (656, 0, 'I spend time concentrating on the  things that I do wrong.');
INSERT INTO wording VALUES (656, 1, 'The candidate should focus on what he/she does wrong.');
INSERT INTO wording VALUES (657, 0, 'I spend time concentrating on my objectives.');
INSERT INTO wording VALUES (657, 1, 'The candidate should focus on his/her goals.');
INSERT INTO wording VALUES (658, 0, 'My priorities are the centre of my attention.');
INSERT INTO wording VALUES (658, 1, 'The candidate should focus on his/her priorities.');
INSERT INTO wording VALUES (659, 0, 'I concentrate on what I do well at work.');
INSERT INTO wording VALUES (659, 1, 'The candidate should focus on what he/she does well.');
INSERT INTO wording VALUES (680, 0, 'I hate what I am doing at work.');
INSERT INTO wording VALUES (680, 1, 'The candidate should hate what he/she is doing.');
INSERT INTO wording VALUES (681, 0, 'I love going to work.');
INSERT INTO wording VALUES (681, 1, 'The candidate should hate his/her work.');
INSERT INTO wording VALUES (682, 0, 'I allow life to get me off track.');
INSERT INTO wording VALUES (682, 1, 'The candidate should allow life to get him/her off track.');
INSERT INTO wording VALUES (683, 0, 'I allow circumstances to stop me from reaching my objectives.');
INSERT INTO wording VALUES (683, 1, 'The candidate should allow circumstances to get him/her off track.');
INSERT INTO wording VALUES (684, 0, 'It is a waste of energy to get excited about work.');
INSERT INTO wording VALUES (684, 1, 'The candidate should feel that it is a waste of energy to get excited about work.');
INSERT INTO wording VALUES (685, 0, 'There is nothing in life to be excited about.');
INSERT INTO wording VALUES (685, 1, 'The candidate should have nothing in life to be excited about.');
INSERT INTO wording VALUES (686, 0, 'I will not allow circumstances to prevent me from reaching my goals in life.');
INSERT INTO wording VALUES (686, 1, 'The candidate should be passionate about his/her life.');
INSERT INTO wording VALUES (687, 0, 'I am committed to my work.');
INSERT INTO wording VALUES (687, 1, 'The candidate should be committed to his/her work.');
INSERT INTO wording VALUES (688, 0, 'I am dedicated to life.');
INSERT INTO wording VALUES (688, 1, 'The candidate should be dedicated to life.');
INSERT INTO wording VALUES (689, 0, 'I feel enthusiastic about my future at work.');
INSERT INTO wording VALUES (689, 1, 'The candidate should feel enthusiastic about life.');
INSERT INTO wording VALUES (690, 0, 'I see the worst in everything.');
INSERT INTO wording VALUES (690, 1, 'The candidate should see the worst in everything.');
INSERT INTO wording VALUES (691, 0, 'I maintain a negative attitude.');
INSERT INTO wording VALUES (691, 1, 'The candidate should maintain a negative attitude.');
INSERT INTO wording VALUES (692, 0, 'I am a pessimist.');
INSERT INTO wording VALUES (692, 1, 'The candidate should be a pessimists.');
INSERT INTO wording VALUES (693, 0, 'I have a negative outlook on life.');
INSERT INTO wording VALUES (693, 1, 'The candidate should have a negative outlook on life.');
INSERT INTO wording VALUES (694, 0, 'I choose to mistrust people.');
INSERT INTO wording VALUES (694, 1, 'The candidate should choose to mistrust people.');
INSERT INTO wording VALUES (695, 0, 'I am a negative  person.');
INSERT INTO wording VALUES (695, 1, 'The candidate should be a negative person.');
INSERT INTO wording VALUES (696, 0, 'I think positively.');
INSERT INTO wording VALUES (696, 1, 'The candidate should think positively.');
INSERT INTO wording VALUES (697, 0, 'I expect the best of myself.');
INSERT INTO wording VALUES (697, 1, 'The candidate should expect the best out of him/her self.');
INSERT INTO wording VALUES (698, 0, 'I have a positive attitude.');
INSERT INTO wording VALUES (698, 1, 'The candidate should have a positive attitude.');
INSERT INTO wording VALUES (699, 0, 'I expect the best from others.');
INSERT INTO wording VALUES (699, 1, 'The candidate should expect the best from others.');
INSERT INTO wording VALUES (720, 0, 'I do what I must only when it is convenient.');
INSERT INTO wording VALUES (720, 1, 'The candidate should do what they must only when it is convenient.');
INSERT INTO wording VALUES (721, 0, 'I do what I must only when I am in the mood.');
INSERT INTO wording VALUES (721, 1, 'The candidate should do what they must only when they are in the mood.');
INSERT INTO wording VALUES (722, 0, 'I am good at making excuses.');
INSERT INTO wording VALUES (722, 1, 'The candidate should be good at making excuses.');
INSERT INTO wording VALUES (723, 0, 'I have the tendency to make excuses.');
INSERT INTO wording VALUES (723, 1, 'The candidate should have the tendency to make excuses.');
INSERT INTO wording VALUES (724, 0, 'I lack the necessary self-discipline to be successful at work.');
INSERT INTO wording VALUES (724, 1, 'The candidate should lack self-discipline to be successful.');
INSERT INTO wording VALUES (725, 0, 'Self-discipline is a lifestyle to me.');
INSERT INTO wording VALUES (725, 1, 'Self-discipline should be a lifestyle to the candidate.');
INSERT INTO wording VALUES (726, 0, 'I do not like making excuses for incompleted tasks.');
INSERT INTO wording VALUES (726, 1, 'The candidate should get rid of excuses.');
INSERT INTO wording VALUES (727, 0, 'I insist on following  my priorities.');
INSERT INTO wording VALUES (727, 1, 'The candidate should follow his/her priorities.');
INSERT INTO wording VALUES (728, 0, 'I develop systems so I can be successful.');
INSERT INTO wording VALUES (728, 1, 'The candidate should develop systems so he/she can be successful.');
INSERT INTO wording VALUES (729, 0, 'I sort out my priorities at work.');
INSERT INTO wording VALUES (729, 1, 'The candidate should sort out his/her priorities.');
INSERT INTO wording VALUES (630, 0, 'I feel that I can express myself freely.');
INSERT INTO wording VALUES (630, 1, 'The candidate should find it difficult to connect with people.');
INSERT INTO wording VALUES (631, 0, 'Other people listen to me at work.');
INSERT INTO wording VALUES (631, 1, 'Other people are seldom attracted to the candidate.');
INSERT INTO wording VALUES (632, 0, 'I find it easy to express myself at work.');
INSERT INTO wording VALUES (632, 1, 'The candidate should find it difficult to motivate others.');
INSERT INTO wording VALUES (633, 0, 'I feel that I can easily  influence people.');
INSERT INTO wording VALUES (633, 1, 'The candidates should find it difficult to influence people to follow him/her.');
INSERT INTO wording VALUES (634, 0, 'I find it difficult to move people in a new direction.');
INSERT INTO wording VALUES (634, 1, 'The candidate should find it difficult to move people in a new direction.');
INSERT INTO wording VALUES (635, 0, 'I feel that  my communication skills are effective at work.');
INSERT INTO wording VALUES (635, 1, 'The candidate communication skills should be ineffective.');
INSERT INTO wording VALUES (636, 0, 'I find it easy to influence colleagues at work.');
INSERT INTO wording VALUES (636, 1, 'The candidate should find it difficult to make people want to follow him/her.');
INSERT INTO wording VALUES (637, 0, 'I enjoy building  relationships with people.');
INSERT INTO wording VALUES (637, 1, 'The candidate should find it difficult to build relationships with people.');
INSERT INTO wording VALUES (638, 0, 'I feel that I motivate colleagues through my enthusiasm at work.');
INSERT INTO wording VALUES (638, 1, 'The candidate should communicate with enthusiasm.');
INSERT INTO wording VALUES (639, 0, 'I have the ability to persuade others.');
INSERT INTO wording VALUES (639, 1, 'The candidate has the ability to persuade others.');
INSERT INTO wording VALUES (670, 0, 'I find it difficult to listen to others.');
INSERT INTO wording VALUES (670, 1, 'The candidate should find it difficult to listen to others.');
INSERT INTO wording VALUES (671, 0, 'I am caught up in things at work and I do not pay attention to others.');
INSERT INTO wording VALUES (671, 1, 'The candidate should be caught up in his/her own ideas.');
INSERT INTO wording VALUES (672, 0, 'I find it difficult to pay attention to what others have to say.');
INSERT INTO wording VALUES (672, 1, 'The candidate should find it difficult to listen carefully to what others have to say.');
INSERT INTO wording VALUES (673, 0, 'I am too busy to concentrate on  what others have to say.');
INSERT INTO wording VALUES (673, 1, 'The candidate should be too busy to listen to what others have to say.');
INSERT INTO wording VALUES (674, 0, 'I ignore the emotional content of what other have to say.');
INSERT INTO wording VALUES (674, 1, 'The candidate should ignore the emotional content of what others have to say.');
INSERT INTO wording VALUES (675, 0, 'I pay attention to what others have to say.');
INSERT INTO wording VALUES (675, 1, 'The candidate should pay attention to what others have to say.');
INSERT INTO wording VALUES (676, 0, 'I genuinely listen to what others have to say.');
INSERT INTO wording VALUES (676, 1, 'The candidate should genuinely listen to what others have to say.');
INSERT INTO wording VALUES (677, 0, 'I pay close attention to what is going on around me at work.');
INSERT INTO wording VALUES (677, 1, 'The candidate should pay close attention to what is going on around him/her.');
INSERT INTO wording VALUES (678, 0, 'I pay attention to people when they are talking to me.');
INSERT INTO wording VALUES (678, 1, 'The candidate should pay attention to people.');
INSERT INTO wording VALUES (679, 0, 'I observe other people''s body language when they talk to me');
INSERT INTO wording VALUES (679, 1, 'The candidate should observe people''s body language when they talk.');
INSERT INTO wording VALUES (755, 0, 'I find it difficult to work with people.');
INSERT INTO wording VALUES (755, 1, 'The candidate should find it difficult to work with people.');
INSERT INTO wording VALUES (756, 0, 'I have poor interpersonal skills.');
INSERT INTO wording VALUES (756, 1, 'The candidate should have poor interpersonal skills.');
INSERT INTO wording VALUES (757, 0, 'I focus on what I can get out of people.');
INSERT INTO wording VALUES (757, 1, 'The candidate should focus on what he/she can get out of people.');
INSERT INTO wording VALUES (758, 0, 'I find it difficult to interact with all kinds of people.');
INSERT INTO wording VALUES (758, 1, 'The candidate should find it difficult to interact with all kinds of people.');
INSERT INTO wording VALUES (759, 0, 'I isolate myself from others fellow collegues');
INSERT INTO wording VALUES (759, 1, 'The candidate should isolate him/her self from others.');
INSERT INTO wording VALUES (760, 0, 'I find it easy to relate to strange people.');
INSERT INTO wording VALUES (760, 1, 'The candidate should find it difficult to relate to people.');
INSERT INTO wording VALUES (761, 0, 'I focus on what I can put into people.');
INSERT INTO wording VALUES (761, 1, 'The candidate should focus on what he/she can put into people.');
INSERT INTO wording VALUES (762, 0, 'I am able to sustain good relationships.');
INSERT INTO wording VALUES (762, 1, 'The candidate should be able to sustain good relationships.');
INSERT INTO wording VALUES (763, 0, 'I have the ability to find the best in people.');
INSERT INTO wording VALUES (763, 1, 'The candidate should have the ability to find the best in people.');
INSERT INTO wording VALUES (764, 0, 'I develop good relationships with people.');
INSERT INTO wording VALUES (764, 1, 'The candidate should develop good relationships with people.');
INSERT INTO wording VALUES (765, 0, 'I keep on trying untill I succeed');
INSERT INTO wording VALUES (766, 0, 'I keep on doing my homework untill it is completed.');
INSERT INTO wording VALUES (767, 0, 'It is important to me to understand my school work.');
INSERT INTO wording VALUES (768, 0, 'I complete my schoolwork even if it is difficult.');
INSERT INTO wording VALUES (769, 0, 'It is important to me to do better and better.');
INSERT INTO wording VALUES (770, 0, 'I work untill my schoolwork is complete.');
INSERT INTO wording VALUES (771, 0, 'It is important to me to continue learning until I understand my schoolwork.');
INSERT INTO wording VALUES (772, 0, 'I will continue untill I have completed my schoolwork.');
INSERT INTO wording VALUES (773, 0, 'I feel satisfied when I work hard at school.');
INSERT INTO wording VALUES (774, 0, 'I am satisfied with what I have achieved.');
INSERT INTO wording VALUES (775, 0, 'I feel cheerful while I am at school.');
INSERT INTO wording VALUES (776, 0, 'I feel happy when I am at school.');
INSERT INTO wording VALUES (777, 0, 'I enjoy living.');
INSERT INTO wording VALUES (778, 0, 'I feel at ease in my relationships at school.');
INSERT INTO wording VALUES (779, 0, 'I experience peace of mind under my circumstances.');
INSERT INTO wording VALUES (780, 0, 'I feel good about the course my life is taking.');
INSERT INTO wording VALUES (781, 0, 'I feel like leaving school and doing something else.');
INSERT INTO wording VALUES (782, 0, 'I  do not want to be grown up.');
INSERT INTO wording VALUES (783, 0, 'I think of how nice it would be to  be grown up.');
INSERT INTO wording VALUES (784, 0, 'Things will go well for me when I am grown up.');
INSERT INTO wording VALUES (785, 0, 'I think it will be fun when I am grown up.');
INSERT INTO wording VALUES (786, 0, 'I wish I was grown up already.');
INSERT INTO wording VALUES (787, 0, 'I think my plans will work out when I am grown up.');
INSERT INTO wording VALUES (788, 0, 'I think things will be bad when I am grown up.');
INSERT INTO wording VALUES (789, 0, '"I  think it is better to be grown up');
INSERT INTO wording VALUES (790, 0, 'I am afraid to make mistakes.');
INSERT INTO wording VALUES (791, 0, 'I feel like running away from things that scare me.');
INSERT INTO wording VALUES (792, 0, 'Things that I don''t know scare me.');
INSERT INTO wording VALUES (793, 0, 'I get stomach pains from stress.');
INSERT INTO wording VALUES (794, 0, 'I am afraid things might go wrong.');
INSERT INTO wording VALUES (795, 0, 'There are places where I feel scared.');
INSERT INTO wording VALUES (796, 0, 'There are people that scare me.');
INSERT INTO wording VALUES (797, 0, 'I feel afraid.');
INSERT INTO wording VALUES (798, 0, 'I feel  I deserve being shouted at.');
INSERT INTO wording VALUES (799, 0, 'I am to blame when things go wrong.');
INSERT INTO wording VALUES (800, 0, '"When something is wrong');
INSERT INTO wording VALUES (801, 0, 'I feel I do too many things wrongly.');
INSERT INTO wording VALUES (802, 0, 'I cause problems at school.');
INSERT INTO wording VALUES (803, 0, 'I feel I should be punished.');
INSERT INTO wording VALUES (804, 0, 'I find it difficult to behave myself at school.');
INSERT INTO wording VALUES (805, 0, 'I easily get into trouble.');
INSERT INTO wording VALUES (806, 0, 'I am to blame for many things that go wrong.');
INSERT INTO wording VALUES (807, 0, 'People like me.');
INSERT INTO wording VALUES (808, 0, 'I am happy with myself.');
INSERT INTO wording VALUES (809, 0, 'I feel that I am important.');
INSERT INTO wording VALUES (810, 0, 'I feel shy when I have to do something.');
INSERT INTO wording VALUES (811, 0, 'People love me.');
INSERT INTO wording VALUES (812, 0, 'I feel good about myself.');
INSERT INTO wording VALUES (813, 0, 'People listen to me.');
INSERT INTO wording VALUES (814, 0, 'I feel life has no purpose.');
INSERT INTO wording VALUES (815, 0, 'When I am on my own I feel less afraid.');
INSERT INTO wording VALUES (816, 0, 'I enjoy having people around me.');
INSERT INTO wording VALUES (817, 0, 'I am scared to make new friends.');
INSERT INTO wording VALUES (818, 0, 'I like to do things on my own.');
INSERT INTO wording VALUES (819, 0, 'I am afraid of other children.');
INSERT INTO wording VALUES (820, 0, 'I like to be alone.');
INSERT INTO wording VALUES (821, 0, 'I easily tell other people how I feel.');
INSERT INTO wording VALUES (822, 0, 'I do things alone.');
INSERT INTO wording VALUES (823, 0, 'I must prevent others from becoming sad.');
INSERT INTO wording VALUES (824, 0, 'I must prevent bad things happening to other people.');
INSERT INTO wording VALUES (825, 0, 'I am worried about other people.');
INSERT INTO wording VALUES (826, 0, 'I must make sure other people are happy.');
INSERT INTO wording VALUES (827, 0, 'I must keep other people out of trouble.');
INSERT INTO wording VALUES (828, 0, 'Other peoples problems are more important than mine.');
INSERT INTO wording VALUES (829, 0, 'I may tell a lie to keep other people out of trouble.');
INSERT INTO wording VALUES (830, 0, 'I protect others by taking the blame when things go wrong.');
INSERT INTO wording VALUES (831, 0, 'I say no to things that are bad for me.');
INSERT INTO wording VALUES (832, 0, 'I show it when I dislike something.');
INSERT INTO wording VALUES (833, 0, 'I say yes when I actually mean to say no.');
INSERT INTO wording VALUES (834, 0, 'I will tell someone if I think he or she is wrong.');
INSERT INTO wording VALUES (835, 0, 'I am scared to say what I think.');
INSERT INTO wording VALUES (836, 0, 'I pretend to be satisfied.');
INSERT INTO wording VALUES (837, 0, 'I keep quiet even when I think others are wrong.');
INSERT INTO wording VALUES (838, 0, 'I do things that others want to do.');
INSERT INTO wording VALUES (839, 0, 'I forget where I put things.');
INSERT INTO wording VALUES (840, 0, '"When I have to give a message');
INSERT INTO wording VALUES (841, 0, 'I forget which day of the week  it is.');
INSERT INTO wording VALUES (842, 0, 'I find it hard to remember important things.');
INSERT INTO wording VALUES (843, 0, 'I forget to do my daily tasks.');
INSERT INTO wording VALUES (844, 0, 'I forget to give my parents letters from school.');
INSERT INTO wording VALUES (845, 0, 'I forget important things.');
INSERT INTO wording VALUES (846, 0, 'I forget what homework I have to do.');
INSERT INTO wording VALUES (847, 0, 'I easily feel angry.');
INSERT INTO wording VALUES (848, 0, 'I bully my friends when they make me angry.');
INSERT INTO wording VALUES (849, 0, 'I get what I want by scaring my friends.');
INSERT INTO wording VALUES (850, 0, 'I say nasty things to my friends when they make me angry.');
INSERT INTO wording VALUES (851, 0, 'I swear when my friends make me angry.');
INSERT INTO wording VALUES (852, 0, '"When I''m angry');
INSERT INTO wording VALUES (853, 0, 'I feel like shouting when I am angry.');
INSERT INTO wording VALUES (854, 0, 'I find it hard to do things right.');
INSERT INTO wording VALUES (855, 0, 'I do not feel like  laughing.');
INSERT INTO wording VALUES (856, 0, 'I feel powerless to do anything about my situation');
INSERT INTO wording VALUES (857, 0, 'I feel down in the dumps.');
INSERT INTO wording VALUES (858, 0, 'My life seems without purpose.');
INSERT INTO wording VALUES (859, 0, 'I feel that there are only a few things that I enjoy.');
INSERT INTO wording VALUES (860, 0, 'I feel like a failure.');
INSERT INTO wording VALUES (861, 0, 'I experience life as meaningless.');
INSERT INTO wording VALUES (862, 0, 'Grown-ups are stupid.');
INSERT INTO wording VALUES (863, 0, 'Grown-ups make me angry.');
INSERT INTO wording VALUES (864, 0, 'I do not like being in grown-ups company.');
INSERT INTO wording VALUES (865, 0, 'I am afraid of grown-ups.');
INSERT INTO wording VALUES (866, 0, 'Grown-ups must leave me alone.');
INSERT INTO wording VALUES (867, 0, 'I like spending time with grown-ups.');
INSERT INTO wording VALUES (868, 0, 'Grown-ups seem to like me');
INSERT INTO wording VALUES (869, 0, 'I enjoy being in  grown-ups company.');
INSERT INTO wording VALUES (870, 0, 'Grown-ups irritate me.');
INSERT INTO wording VALUES (878, 0, 'People lie to me.');
INSERT INTO wording VALUES (879, 0, 'I am afraid other people will hurt me.');
INSERT INTO wording VALUES (880, 0, 'I know other people will help me.');
INSERT INTO wording VALUES (881, 0, 'People pretend to like me.');
INSERT INTO wording VALUES (882, 0, 'I can put my trust in  other people.');
INSERT INTO wording VALUES (883, 0, 'People do  what they say they will do.');
INSERT INTO wording VALUES (884, 0, 'I am cautious about being alone with other people.');
INSERT INTO wording VALUES (885, 0, 'People seem to hide things from me.');
INSERT INTO wording VALUES (886, 0, 'I keep my secrets to myself.');
INSERT INTO wording VALUES (887, 0, 'Other people seem to want to hurt me.');
INSERT INTO wording VALUES (888, 0, 'I feel different to other people.');
INSERT INTO wording VALUES (889, 0, 'I wish I were more like other people.');
INSERT INTO wording VALUES (890, 0, 'It seems as if other people have far less problems than I have.');
INSERT INTO wording VALUES (891, 0, 'Bad things seem to only happen to me.');
INSERT INTO wording VALUES (892, 0, 'Other people seem to be dealing with life better than I am.');
INSERT INTO wording VALUES (893, 0, 'Other people seem to be happier than I am.');
INSERT INTO wording VALUES (894, 0, 'Collegues at school think they are better than me.');
INSERT INTO wording VALUES (895, 0, 'Other people say nasty things to me.');
INSERT INTO wording VALUES (896, 0, 'I like the way my body looks.');
INSERT INTO wording VALUES (897, 0, 'I wish my body  looked different.');
INSERT INTO wording VALUES (898, 0, 'I feel good about myself when I look in the mirror.');
INSERT INTO wording VALUES (899, 0, 'I feel like hiding my body.');
INSERT INTO wording VALUES (900, 0, 'I feel ashamed of my body.');
INSERT INTO wording VALUES (901, 0, 'People call me nasty names because of the way I look.');
INSERT INTO wording VALUES (902, 0, 'I feel that people are laughing at me because of my body.');
INSERT INTO wording VALUES (903, 0, 'I would like to be able to change my body.');
INSERT INTO wording VALUES (904, 0, 'My body seems to be a problem in my life.');
INSERT INTO wording VALUES (905, 0, 'I look to see what other children have in their bags.');
INSERT INTO wording VALUES (906, 0, 'I like to look into my teachers drawer.');
INSERT INTO wording VALUES (907, 0, 'I like to  knock before I enter a room.');
INSERT INTO wording VALUES (908, 0, 'I like standing close to people to smell their perfumes.');
INSERT INTO wording VALUES (909, 0, 'I like to search for things that I feel other people have hidden from me.');
INSERT INTO wording VALUES (910, 0, 'I like to peep into  other peoples belongings.');
INSERT INTO wording VALUES (911, 0, 'I take time to  snoop around other peoples belongings.');
INSERT INTO wording VALUES (912, 0, 'I like having to go to school.');
INSERT INTO wording VALUES (913, 0, 'I enjoy being at school.');
INSERT INTO wording VALUES (914, 0, 'I hate the time I have to spend at school.');
INSERT INTO wording VALUES (915, 0, 'I become bored at school.');
INSERT INTO wording VALUES (916, 0, 'School is unpleasant to me.');
INSERT INTO wording VALUES (917, 0, 'I feel that  my teacher cares about me.');
INSERT INTO wording VALUES (918, 0, 'It feels like I am always in trouble at school.');
INSERT INTO wording VALUES (919, 0, 'I feel my teacher does not like me.');
INSERT INTO wording VALUES (920, 0, 'I feel unwelcome when I come  home.');
INSERT INTO wording VALUES (921, 0, 'Home is a peaceful place to be in.');
INSERT INTO wording VALUES (922, 0, 'I enjoy going home and being with my family.');
INSERT INTO wording VALUES (923, 0, 'I family make me feel important at home.');
INSERT INTO wording VALUES (924, 0, 'I feel down  when I am I am in my families company.');
INSERT INTO wording VALUES (925, 0, 'My family allowes me  to decide for myself.');
INSERT INTO wording VALUES (926, 0, 'My family allows me to do what I like.');
INSERT INTO wording VALUES (927, 0, 'My family tries to control the way I live my life.');
INSERT INTO wording VALUES (928, 0, 'My family  like me to make my own decisions.');
INSERT INTO wording VALUES (929, 0, 'My family  respect my privacy.');
INSERT INTO wording VALUES (930, 0, 'My family gives me the freedom to do what I want.');
INSERT INTO wording VALUES (931, 0, 'I feel that my family  are over protective of me .');
INSERT INTO wording VALUES (932, 0, 'I spend a lot of time with my friends.');
INSERT INTO wording VALUES (933, 0, 'My friends and I have the same interest.');
INSERT INTO wording VALUES (934, 0, 'I wish I could find  other friends.');
INSERT INTO wording VALUES (935, 0, 'I feel secure when I am with my friends.');
INSERT INTO wording VALUES (936, 0, 'My friends get me into trouble.');
INSERT INTO wording VALUES (937, 0, 'My friends influence my decisions.');
INSERT INTO wording VALUES (938, 0, 'My family think that my friends are bad.');
INSERT INTO wording VALUES (939, 0, 'I know that I can rely on my friends when I am in trouble.');
INSERT INTO wording VALUES (940, 0, 'I like my mother.');
INSERT INTO wording VALUES (941, 0, 'I enjoy being with my mother.');
INSERT INTO wording VALUES (942, 0, 'I love my mother.');
INSERT INTO wording VALUES (943, 0, 'My mother loves me.');
INSERT INTO wording VALUES (944, 0, 'My mother does a lot for me.');
INSERT INTO wording VALUES (945, 0, 'I feel angry when I think of my mother.');
INSERT INTO wording VALUES (946, 0, 'My mother understands me.');
INSERT INTO wording VALUES (947, 0, 'My mother is angry with me.');
INSERT INTO wording VALUES (948, 0, 'I like my father.');
INSERT INTO wording VALUES (949, 0, 'I enjoy being with my father.');
INSERT INTO wording VALUES (950, 0, 'I love my father.');
INSERT INTO wording VALUES (951, 0, 'My father loves me.');
INSERT INTO wording VALUES (952, 0, 'My father does a lot for me.');
INSERT INTO wording VALUES (953, 0, 'I feel angry when I think of my father.');
INSERT INTO wording VALUES (954, 0, 'My father understands me.');
INSERT INTO wording VALUES (955, 0, 'My father is angry with me.');
INSERT INTO wording VALUES (956, 0, 'I like my stepmother.');
INSERT INTO wording VALUES (957, 0, 'I enjoy being with my stepmother.');
INSERT INTO wording VALUES (958, 0, 'I love my stepmother.');
INSERT INTO wording VALUES (959, 0, 'My stepmother loves me.');
INSERT INTO wording VALUES (960, 0, 'My stepmother does a lot for me.');
INSERT INTO wording VALUES (961, 0, 'I feel angry when I think of my stepmother.');
INSERT INTO wording VALUES (962, 0, 'My stepmother understands me.');
INSERT INTO wording VALUES (963, 0, 'My stepmother is angry with me.');
INSERT INTO wording VALUES (964, 0, 'I like my stepfather.');
INSERT INTO wording VALUES (965, 0, 'I enjoy being with my stepfather.');
INSERT INTO wording VALUES (966, 0, 'I love my stepfather.');
INSERT INTO wording VALUES (967, 0, 'My stepfather loves me.');
INSERT INTO wording VALUES (968, 0, 'My stepfather does a lot for me.');
INSERT INTO wording VALUES (969, 0, 'I feel angry when I think of my stepfather.');
INSERT INTO wording VALUES (970, 0, 'My stepfather understands me.');
INSERT INTO wording VALUES (971, 0, 'My stepfather is angry with me.');
INSERT INTO wording VALUES (980, 0, 'I enjoy being with my teachers');
INSERT INTO wording VALUES (981, 0, 'I hate my teachers.');
INSERT INTO wording VALUES (982, 0, 'My teachers love me.');
INSERT INTO wording VALUES (983, 0, 'My teachers do a lot for me.');
INSERT INTO wording VALUES (984, 0, 'I feel angry when I think of my teachers.');
INSERT INTO wording VALUES (985, 0, 'My teachers understand me.');
INSERT INTO wording VALUES (986, 0, 'My teachers get angry with me.');
INSERT INTO wording VALUES (972, 0, 'Being at school is a pleasure to me.');
INSERT INTO wording VALUES (973, 0, 'I look forward having to go to school.');
INSERT INTO wording VALUES (974, 0, 'Having to go to school spoils my day.');
INSERT INTO wording VALUES (975, 0, 'School is a boring institution.');
INSERT INTO wording VALUES (976, 0, 'I cannot wait for the day when I do not have to go to school.');
INSERT INTO wording VALUES (977, 0, 'I have good relationships with all my teachers.');
INSERT INTO wording VALUES (978, 0, 'My friends get me into trouble while I am at school.');
INSERT INTO wording VALUES (979, 0, 'I like my teachers');
INSERT INTO wording VALUES (987, 0, 'I like my brother.');
INSERT INTO wording VALUES (988, 0, 'I enjoy being with my brother.');
INSERT INTO wording VALUES (989, 0, 'I love my brother');
INSERT INTO wording VALUES (990, 0, 'My brother loves me.');
INSERT INTO wording VALUES (991, 0, 'My brother does a lot for me.');
INSERT INTO wording VALUES (992, 0, 'I feel angry when I think of my brother.');
INSERT INTO wording VALUES (993, 0, 'My brother  understands me.');
INSERT INTO wording VALUES (994, 0, 'My brother is angry with me.');
INSERT INTO wording VALUES (995, 0, 'I like my sister.');
INSERT INTO wording VALUES (996, 0, 'I enjoy being with my sister.');
INSERT INTO wording VALUES (997, 0, 'I love my sister.');
INSERT INTO wording VALUES (998, 0, 'My sister  loves me.');
INSERT INTO wording VALUES (999, 0, 'My sister does a lot for me.');
INSERT INTO wording VALUES (1000, 0, 'I feel angry when I think of my sister.');
INSERT INTO wording VALUES (1001, 0, 'My sister  understands me.');
INSERT INTO wording VALUES (1002, 0, 'My sister is angry with me.');
INSERT INTO wording VALUES (1003, 0, 'I enjoy offering people a good service.');
INSERT INTO wording VALUES (1004, 0, 'The service given to clients is important to me.');
INSERT INTO wording VALUES (1005, 0, 'I like delivering a service to the public.');
INSERT INTO wording VALUES (1006, 0, 'I like being on call in order to deliver an efficient service.');
INSERT INTO wording VALUES (1007, 0, 'I would become irritated if our clients receive bad service.');
INSERT INTO wording VALUES (1008, 0, 'I am prepared to sacrifice my own needs in order to deliver an efficient service.');
INSERT INTO wording VALUES (1009, 0, 'I am prepared to be at peoples beck and call in order to deliver an efficient service.');
INSERT INTO wording VALUES (1010, 0, 'I enjoy visiting museums.');
INSERT INTO wording VALUES (1011, 0, 'I enjoy finding out about the culture and history of people.');
INSERT INTO wording VALUES (1012, 0, 'I enjoy learning about different cultural languages.');
INSERT INTO wording VALUES (1013, 0, 'History facinates me.');
INSERT INTO wording VALUES (1014, 0, 'I enjoy cultural literature.');
INSERT INTO wording VALUES (1015, 0, 'I enjoy researching different cultures.');
INSERT INTO wording VALUES (1016, 0, 'I am prepared to work continuously untill my objectives are completed.');
INSERT INTO wording VALUES (1017, 0, 'I like to set my own targets and goals.');
INSERT INTO wording VALUES (1018, 0, 'I like taking authoriy within my working environment.');
INSERT INTO wording VALUES (1019, 0, 'It is important to me to be able to use my potential to the fullest.');
INSERT INTO wording VALUES (1020, 0, 'I like to be able to organize my own schedules according to my own priority.');
INSERT INTO wording VALUES (1021, 0, 'I am happy when I am able to do things when I like .');
INSERT INTO wording VALUES (1022, 0, 'I like to be held accountable or responsible for the actions of people who work under my authority.');
INSERT INTO wording VALUES (1023, 0, 'I am prepared to take risks in order to achieve my goals.');
INSERT INTO wording VALUES (1024, 0, 'I enjoy communicating and getting people to listen to me.');
INSERT INTO wording VALUES (1025, 0, '"I enjoy interacting with people');
INSERT INTO wording VALUES (1026, 0, 'I feel good when people take my advice.');
INSERT INTO wording VALUES (1027, 0, 'I enjoy an environment where I can use my business abilities to the fullest.');
INSERT INTO wording VALUES (1028, 0, 'I like to interact in such a manner that people find it easy to take my advice.');
INSERT INTO wording VALUES (1029, 0, 'I like to be interacting with people daily as a job.');
INSERT INTO wording VALUES (1030, 0, 'I enjoy working out how things work.');
INSERT INTO wording VALUES (1031, 0, 'I like to take something apart to discover how it works.');
INSERT INTO wording VALUES (1032, 0, 'I enjoy understanding the workings of electronic equipment.');
INSERT INTO wording VALUES (1033, 0, 'I enjoy designing new electronic devices or computer programs at work');
INSERT INTO wording VALUES (1034, 0, 'I enjoy seeing a tangible product of my efforts.');
INSERT INTO wording VALUES (1035, 0, 'I enjoy working out solutions to make things work.');
INSERT INTO wording VALUES (1036, 0, 'I enjoy working with computers or technical equipment.');
INSERT INTO wording VALUES (1037, 0, 'I enjoy working when I can use my ability to create electronic functionality.');
INSERT INTO wording VALUES (1038, 0, 'I enjoy finding out why things work the way they do.');
INSERT INTO wording VALUES (1039, 0, 'I like doing investigations into finding  new ways of doing things.');
INSERT INTO wording VALUES (1040, 0, 'I  like investigating new scientific discoveries.');
INSERT INTO wording VALUES (1041, 0, 'I enjoy testing and improving the methodolgy when solving problems.');
INSERT INTO wording VALUES (1042, 0, 'I enjoy making scientific inventions.');
INSERT INTO wording VALUES (1043, 0, 'It is interesting to discover how various things react.');
INSERT INTO wording VALUES (1044, 0, 'The field of science fascinates me.');
INSERT INTO wording VALUES (1045, 0, 'I enjoy making new discoveries while doing my job.');
INSERT INTO wording VALUES (1046, 0, 'I do not like working indoors.');
INSERT INTO wording VALUES (1047, 0, 'I like working outside.');
INSERT INTO wording VALUES (1048, 0, 'I enjoy working in the open air.');
INSERT INTO wording VALUES (1049, 0, 'Working outdoors irritates me.');
INSERT INTO wording VALUES (1050, 0, 'Working in nature is exiting.');
INSERT INTO wording VALUES (1051, 0, 'I would be very frustrated if I couldn''t work in nature.');
INSERT INTO wording VALUES (1052, 0, 'I enjoy working in an enclosed environment.');
INSERT INTO wording VALUES (1053, 0, 'I enjoy observing the wonders of nature.');
INSERT INTO wording VALUES (1054, 0, 'I like being creative at work.');
INSERT INTO wording VALUES (1055, 0, 'I need to be able to be original in my job.');
INSERT INTO wording VALUES (1056, 0, 'I get great satisfaction in my job by making something beautiful with my hands.');
INSERT INTO wording VALUES (1057, 0, 'I enjoy using my creative ability while working.');
INSERT INTO wording VALUES (1058, 0, 'People seem to get a sense of appreciation when they see my art work.');
INSERT INTO wording VALUES (1059, 0, 'Creative art is very important to me in my job.');
INSERT INTO wording VALUES (1060, 0, 'I appreciate working in an artistic environment.');
INSERT INTO wording VALUES (1061, 0, 'I like entertaining people when doing my job.');
INSERT INTO wording VALUES (1062, 0, 'I need to be continuously entertaining people as a job.');
INSERT INTO wording VALUES (1063, 0, 'I would  be satisfied  continuously entertaining people as a job.');
INSERT INTO wording VALUES (1064, 0, 'I feel a sense of satisfaction performing in front of large crowds of people.');
INSERT INTO wording VALUES (1065, 0, 'Large crowds in my work place  interest me.');
INSERT INTO wording VALUES (1066, 0, 'I like being the center of attraction when doing my job.');
INSERT INTO wording VALUES (1068, 0, 'I like working with my hands at work');
INSERT INTO wording VALUES (1069, 0, 'I like doing repairs while working in my job.');
INSERT INTO wording VALUES (1070, 0, 'I do not like physical work while doing my job.');
INSERT INTO wording VALUES (1071, 0, 'I feel a sense of satisfaction when repairing goods as a job.');
INSERT INTO wording VALUES (1072, 0, 'My talents at work are not in the ability of using my hands.');
INSERT INTO wording VALUES (1073, 0, 'I am able to work out the mechanical functioning of things very easily.');
INSERT INTO wording VALUES (1074, 0, 'I love to restore things as a job in order for them to function optimally.');
INSERT INTO wording VALUES (1075, 0, 'I like attending to people when they are sick as a job.');
INSERT INTO wording VALUES (1076, 0, 'Various diseases in people interest me as a job.');
INSERT INTO wording VALUES (1077, 0, 'I do like to study the science behind various diseases as a job.');
INSERT INTO wording VALUES (1078, 0, 'I feel a sense of satisfaction when people need my help.');
INSERT INTO wording VALUES (1079, 0, 'My talents are in my  ability  to deal with injured people.');
INSERT INTO wording VALUES (1080, 0, 'The sight of open wounds on injured people does not effect me.');
INSERT INTO wording VALUES (1081, 0, 'I am interested in studying how different chemicals react in different people.');
INSERT INTO wording VALUES (1082, 0, 'I like teaching people new things while doing my job');
INSERT INTO wording VALUES (1083, 0, 'I love to transfer knowledge to people as a job.');
INSERT INTO wording VALUES (1084, 0, 'I  like to constantly  interact with people while doing my job');
INSERT INTO wording VALUES (1085, 0, 'I can get the people motivated when they listen to me talk.');
INSERT INTO wording VALUES (1086, 0, 'My talents are  speaking in front of a lot of people.');
INSERT INTO wording VALUES (1087, 0, 'I am able to develop good relationships  when speaking to people at work.');
INSERT INTO wording VALUES (1088, 0, 'I like to influence people in the way I present different programs.');
INSERT INTO wording VALUES (1089, 0, 'I like uplifting people by teaching them new things');
INSERT INTO wording VALUES (1090, 0, 'Keeping accurate  records in my job  is important to me.');
INSERT INTO wording VALUES (1091, 0, 'I love to be in a job whene I know what is happening financially.');
INSERT INTO wording VALUES (1092, 0, 'Record administration as a job is important to me.');
INSERT INTO wording VALUES (1093, 0, 'I like managing company records and accounts.');
INSERT INTO wording VALUES (1094, 0, 'I like checking company policies and documents.');
INSERT INTO wording VALUES (1095, 0, 'I like keeping track of all the transactions within an organization.');
INSERT INTO wording VALUES (1096, 0, 'I am interested in assuring that the company''s administration is effective.');
INSERT INTO wording VALUES (1097, 0, 'I can manage people successfully.');
INSERT INTO wording VALUES (1098, 0, 'I have the abilty to initiate people to work in harmony.');
INSERT INTO wording VALUES (1099, 0, 'I enjoy helping people to find direction.');
INSERT INTO wording VALUES (1100, 0, 'I enjoy preventing conflict situations.');
INSERT INTO wording VALUES (1101, 0, 'I do not have the patience to listen to people''s petty problems.');
INSERT INTO wording VALUES (1102, 0, 'I am unable to act firmly.');
INSERT INTO wording VALUES (1103, 0, 'I am diplomatic when getting my message across to other people.');
INSERT INTO wording VALUES (1104, 0, 'I like working with people.');
INSERT INTO wording VALUES (1105, 0, 'I am facinated with aircrafts.');
INSERT INTO wording VALUES (1106, 0, 'I want to be involved in the aircraft industry.');
INSERT INTO wording VALUES (1107, 0, 'I have a passion for aircrafts.');
INSERT INTO wording VALUES (1108, 0, 'I am interested in aircraft dynamics.');
INSERT INTO wording VALUES (1109, 0, 'I like having to work irregular hours.');
INSERT INTO wording VALUES (1110, 0, 'Constant communication is inmportant to me.');
INSERT INTO wording VALUES (1111, 0, 'I am happy to follow repetative procedures.');
INSERT INTO wording VALUES (1112, 0, 'I would like to control the movement of aircraft.');
INSERT INTO wording VALUES (1113, 0, 'I like to create an awareness  of a product.');
INSERT INTO wording VALUES (1114, 0, 'I like to promote a product  to new clients.');
INSERT INTO wording VALUES (1115, 0, 'I am interested in knowing how advertising promotes products.');
INSERT INTO wording VALUES (1116, 0, 'I like to create a customer base for a living.');
INSERT INTO wording VALUES (1117, 0, 'I am able to walk into a company without fear of rejection.');
INSERT INTO wording VALUES (1118, 0, 'Creating market brands for a product facinates me.');
INSERT INTO wording VALUES (1119, 0, 'I like to be able to work out strategies in order to market effectively.');
INSERT INTO wording VALUES (1120, 0, 'I like to be able to attract peoples attention to the products on offer.');
INSERT INTO wording VALUES (1121, 0, 'I like searching for evidence.');
INSERT INTO wording VALUES (1122, 0, 'I like to find out about different markets daily.');
INSERT INTO wording VALUES (1123, 0, 'I like to investigate what has happened in different circumstances.');
INSERT INTO wording VALUES (1124, 0, 'Doing research motivates me.');
INSERT INTO wording VALUES (1125, 0, 'I like working long hours when I am investigating something.');
INSERT INTO wording VALUES (1126, 0, 'I have a lot of patience when it comes to research.');
INSERT INTO wording VALUES (1127, 0, 'Research stimulates me to keep on working.');
INSERT INTO wording VALUES (1128, 0, 'Working as a team player while doing an investigation stimulates me.');
INSERT INTO wording VALUES (1129, 0, 'I like talking on the radio/phone as a job.');
INSERT INTO wording VALUES (1130, 0, 'I like talking to customers via telephone.');
INSERT INTO wording VALUES (1131, 0, 'I like to answer incoming phone/radio calls');
INSERT INTO wording VALUES (1132, 0, 'The constant ringing of the telephone/radio irritates me');
INSERT INTO wording VALUES (1133, 0, 'I like the challenge when I have to handle numerous calls at the same time.');
INSERT INTO wording VALUES (1134, 0, 'The pressure of working on a busy phone/radio gets to me.');
INSERT INTO wording VALUES (1135, 0, 'I love being able to communicate with different clients on the telephone/radio as a job.');
INSERT INTO wording VALUES (1136, 0, 'I function my best when the telephone/radio keeps calling in to me.');
INSERT INTO wording VALUES (752, 0, 'I work very hard at my tasks in order to complete them on time.');
INSERT INTO wording VALUES (1067, 0, 'Large crowds watching me at work, is when I function best.');


--
-- Data for TOC entry 154 (OID 17039)
-- Name: test_status; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO test_status VALUES (0, 'not started');
INSERT INTO test_status VALUES (1, 'in progress');
INSERT INTO test_status VALUES (2, 'completed');
INSERT INTO test_status VALUES (3, 'canceled');


--
-- Data for TOC entry 155 (OID 17044)
-- Name: _assignment; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO _assignment VALUES (630, 647, 58, 2, '2010-02-05 04:18:09.838846');
INSERT INTO _assignment VALUES (631, 649, 60, 0, NULL);
INSERT INTO _assignment VALUES (638, 660, 61, 1, '2010-02-08 06:15:13.613178');
INSERT INTO _assignment VALUES (640, 648, 61, 0, NULL);
INSERT INTO _assignment VALUES (641, 648, 68, 0, NULL);
INSERT INTO _assignment VALUES (642, 648, 64, 0, NULL);
INSERT INTO _assignment VALUES (643, 648, 60, 0, NULL);
INSERT INTO _assignment VALUES (644, 653, 61, 0, NULL);
INSERT INTO _assignment VALUES (645, 653, 68, 0, NULL);
INSERT INTO _assignment VALUES (646, 653, 60, 0, NULL);
INSERT INTO _assignment VALUES (647, 661, 68, 0, NULL);
INSERT INTO _assignment VALUES (649, 654, 60, 0, NULL);
INSERT INTO _assignment VALUES (650, 661, 60, 0, NULL);
INSERT INTO _assignment VALUES (651, 662, 68, 0, NULL);
INSERT INTO _assignment VALUES (655, 5, 61, 0, NULL);
INSERT INTO _assignment VALUES (632, 4, 60, 1, '2010-02-15 02:21:00.685675');


--
-- Data for TOC entry 156 (OID 17048)
-- Name: _answer; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO _answer VALUES (689, 630, 5, 873, 0, 1);
INSERT INTO _answer VALUES (1005, 630, 3, 494, 0, 1);
INSERT INTO _answer VALUES (806, 630, 2, 695, 0, 1);
INSERT INTO _answer VALUES (692, 630, 2, 439, 0, 1);
INSERT INTO _answer VALUES (778, 630, 6, 635, 0, 1);
INSERT INTO _answer VALUES (633, 630, 6, 387, 0, 1);
INSERT INTO _answer VALUES (905, 630, 2, 546, 0, 1);
INSERT INTO _answer VALUES (637, 630, 6, 502, 0, 1);
INSERT INTO _answer VALUES (1035, 630, 6, 1158, 0, 1);
INSERT INTO _answer VALUES (790, 630, 2, 447, 0, 1);
INSERT INTO _answer VALUES (745, 630, 6, 540, 0, 1);
INSERT INTO _answer VALUES (784, 630, 5, 442, 0, 1);
INSERT INTO _answer VALUES (1062, 630, 3, 733, 1, 1);
INSERT INTO _answer VALUES (1021, 630, 6, 437, 0, 1);
INSERT INTO _answer VALUES (1040, 630, 6, 509, 0, 1);
INSERT INTO _answer VALUES (658, 630, 6, 1700, 0, 1);
INSERT INTO _answer VALUES (750, 630, 6, 511, 0, 1);
INSERT INTO _answer VALUES (887, 630, 2, 300, 0, 1);
INSERT INTO _answer VALUES (539, 630, 5, 867, 0, 1);
INSERT INTO _answer VALUES (644, 630, 5, 640, 0, 1);
INSERT INTO _answer VALUES (903, 630, 2, 386, 0, 1);
INSERT INTO _answer VALUES (651, 630, 2, 336, 0, 1);
INSERT INTO _answer VALUES (830, 630, 2, 591, 0, 1);
INSERT INTO _answer VALUES (912, 630, 3, 852, 0, 1);
INSERT INTO _answer VALUES (879, 630, 3, 916, 0, 1);
INSERT INTO _answer VALUES (839, 630, 3, 274, 0, 1);
INSERT INTO _answer VALUES (604, 630, 2, 556, 0, 1);
INSERT INTO _answer VALUES (906, 630, 1, 517, 0, 1);
INSERT INTO _answer VALUES (483, 630, 5, 711, 0, 1);
INSERT INTO _answer VALUES (821, 630, 4, 985, 0, 1);
INSERT INTO _answer VALUES (628, 630, 6, 572, 0, 1);
INSERT INTO _answer VALUES (780, 630, 6, 553, 0, 1);
INSERT INTO _answer VALUES (684, 630, 2, 532, 0, 1);
INSERT INTO _answer VALUES (569, 630, 6, 1028, 0, 1);
INSERT INTO _answer VALUES (714, 630, 1, 778, 0, 1);
INSERT INTO _answer VALUES (1102, 630, 6, 300, 0, 1);
INSERT INTO _answer VALUES (819, 630, 2, 466, 0, 1);
INSERT INTO _answer VALUES (1096, 630, 2, 478, 0, 1);
INSERT INTO _answer VALUES (462, 630, 2, 670, 0, 1);
INSERT INTO _answer VALUES (889, 630, 1, 388, 0, 1);
INSERT INTO _answer VALUES (1051, 630, 3, 807, 0, 1);
INSERT INTO _answer VALUES (878, 630, 3, 547, 0, 1);
INSERT INTO _answer VALUES (546, 630, 3, 651, 0, 1);
INSERT INTO _answer VALUES (640, 630, 5, 494, 0, 1);
INSERT INTO _answer VALUES (574, 630, 5, 648, 0, 1);
INSERT INTO _answer VALUES (700, 630, 4, 744, 0, 1);
INSERT INTO _answer VALUES (1099, 630, 6, 504, 0, 1);
INSERT INTO _answer VALUES (797, 630, 2, 189, 0, 1);
INSERT INTO _answer VALUES (453, 630, 6, 597, 0, 1);
INSERT INTO _answer VALUES (794, 630, 3, 1168, 0, 1);
INSERT INTO _answer VALUES (764, 630, 5, 2627, 0, 1);
INSERT INTO _answer VALUES (1052, 630, 4, 1188, 0, 1);
INSERT INTO _answer VALUES (1024, 630, 6, 860, 0, 1);
INSERT INTO _answer VALUES (524, 630, 7, 740, 0, 1);
INSERT INTO _answer VALUES (777, 630, 6, 281, 0, 1);
INSERT INTO _answer VALUES (1126, 630, 4, 1030, 0, 1);
INSERT INTO _answer VALUES (634, 630, 2, 351, 0, 1);
INSERT INTO _answer VALUES (505, 630, 5, 771, 0, 1);
INSERT INTO _answer VALUES (461, 630, 2, 404, 0, 1);
INSERT INTO _answer VALUES (470, 630, 6, 671, 0, 1);
INSERT INTO _answer VALUES (785, 630, 4, 753, 0, 1);
INSERT INTO _answer VALUES (475, 630, 6, 633, 0, 1);
INSERT INTO _answer VALUES (1063, 630, 3, 790, 0, 1);
INSERT INTO _answer VALUES (1045, 630, 6, 327, 0, 1);
INSERT INTO _answer VALUES (661, 630, 2, 648, 0, 1);
INSERT INTO _answer VALUES (758, 630, 3, 1673, 0, 1);
INSERT INTO _answer VALUES (753, 630, 6, 517, 0, 1);
INSERT INTO _answer VALUES (773, 630, 6, 519, 0, 1);
INSERT INTO _answer VALUES (1079, 630, 2, 421, 0, 1);
INSERT INTO _answer VALUES (748, 630, 6, 433, 0, 1);
INSERT INTO _answer VALUES (1055, 630, 6, 2994, 0, 1);
INSERT INTO _answer VALUES (1014, 630, 2, 291, 0, 1);
INSERT INTO _answer VALUES (740, 630, 2, 360, 0, 1);
INSERT INTO _answer VALUES (742, 630, 4, 1973, 0, 1);
INSERT INTO _answer VALUES (901, 630, 2, 434, 0, 1);
INSERT INTO _answer VALUES (809, 630, 6, 258, 0, 1);
INSERT INTO _answer VALUES (567, 630, 6, 330, 0, 1);
INSERT INTO _answer VALUES (910, 630, 1, 363, 0, 1);
INSERT INTO _answer VALUES (1103, 630, 5, 612, 0, 1);
INSERT INTO _answer VALUES (535, 630, 2, 589, 0, 1);
INSERT INTO _answer VALUES (767, 630, 5, 746, 0, 1);
INSERT INTO _answer VALUES (587, 630, 2, 450, 0, 1);
INSERT INTO _answer VALUES (664, 630, 2, 680, 0, 1);
INSERT INTO _answer VALUES (1087, 630, 5, 566, 0, 1);
INSERT INTO _answer VALUES (756, 630, 3, 755, 0, 1);
INSERT INTO _answer VALUES (907, 630, 6, 1264, 0, 1);
INSERT INTO _answer VALUES (1114, 630, 5, 812, 0, 1);
INSERT INTO _answer VALUES (1097, 630, 6, 468, 0, 1);
INSERT INTO _answer VALUES (720, 630, 2, 1915, 0, 1);
INSERT INTO _answer VALUES (514, 630, 2, 948, 0, 1);
INSERT INTO _answer VALUES (1020, 630, 5, 579, 0, 1);
INSERT INTO _answer VALUES (673, 630, 2, 835, 0, 1);
INSERT INTO _answer VALUES (838, 630, 4, 1191, 0, 1);
INSERT INTO _answer VALUES (526, 630, 6, 683, 1, 1);
INSERT INTO _answer VALUES (553, 630, 2, 319, 0, 1);
INSERT INTO _answer VALUES (775, 630, 5, 541, 1, 1);
INSERT INTO _answer VALUES (899, 630, 2, 1782, 0, 1);
INSERT INTO _answer VALUES (620, 630, 2, 1933, 1, 1);
INSERT INTO _answer VALUES (802, 630, 3, 585, 0, 1);
INSERT INTO _answer VALUES (487, 630, 5, 599, 0, 1);
INSERT INTO _answer VALUES (788, 630, 5, 1682, 0, 1);
INSERT INTO _answer VALUES (562, 630, 2, 1444, 0, 1);
INSERT INTO _answer VALUES (617, 630, 5, 490, 0, 1);
INSERT INTO _answer VALUES (818, 630, 6, 367, 0, 1);
INSERT INTO _answer VALUES (501, 630, 4, 758, 0, 1);
INSERT INTO _answer VALUES (575, 630, 6, 721, 0, 1);
INSERT INTO _answer VALUES (739, 630, 3, 477, 0, 1);
INSERT INTO _answer VALUES (455, 630, 6, 578, 0, 1);
INSERT INTO _answer VALUES (842, 630, 3, 1033, 0, 1);
INSERT INTO _answer VALUES (1013, 630, 2, 202, 0, 1);
INSERT INTO _answer VALUES (506, 630, 3, 438, 0, 1);
INSERT INTO _answer VALUES (1069, 630, 3, 991, 0, 1);
INSERT INTO _answer VALUES (566, 630, 6, 998, 0, 1);
INSERT INTO _answer VALUES (591, 630, 5, 385, 0, 1);
INSERT INTO _answer VALUES (1123, 630, 6, 1035, 0, 1);
INSERT INTO _answer VALUES (504, 630, 4, 680, 0, 1);
INSERT INTO _answer VALUES (898, 630, 5, 499, 0, 1);
INSERT INTO _answer VALUES (772, 630, 5, 871, 0, 1);
INSERT INTO _answer VALUES (647, 630, 6, 4748, 0, 1);
INSERT INTO _answer VALUES (531, 630, 2, 740, 0, 1);
INSERT INTO _answer VALUES (498, 630, 6, 348, 0, 1);
INSERT INTO _answer VALUES (1067, 630, 2, 4458, 0, 1);
INSERT INTO _answer VALUES (1043, 630, 5, 397, 0, 1);
INSERT INTO _answer VALUES (476, 630, 5, 616, 0, 1);
INSERT INTO _answer VALUES (670, 630, 2, 496, 0, 1);
INSERT INTO _answer VALUES (752, 630, 6, 6975, 0, 1);
INSERT INTO _answer VALUES (883, 630, 3, 622, 0, 1);
INSERT INTO _answer VALUES (1116, 630, 5, 1107, 0, 1);
INSERT INTO _answer VALUES (502, 630, 3, 374, 0, 1);
INSERT INTO _answer VALUES (646, 630, 5, 651, 0, 1);
INSERT INTO _answer VALUES (1131, 630, 2, 734, 0, 1);
INSERT INTO _answer VALUES (1134, 630, 5, 1165, 0, 1);
INSERT INTO _answer VALUES (672, 630, 4, 641, 0, 1);
INSERT INTO _answer VALUES (542, 630, 2, 361, 0, 1);
INSERT INTO _answer VALUES (1119, 630, 5, 565, 0, 1);
INSERT INTO _answer VALUES (702, 630, 2, 792, 0, 1);
INSERT INTO _answer VALUES (1009, 630, 3, 736, 0, 1);
INSERT INTO _answer VALUES (709, 630, 6, 620, 0, 1);
INSERT INTO _answer VALUES (480, 630, 6, 1249, 0, 1);
INSERT INTO _answer VALUES (533, 630, 3, 651, 0, 1);
INSERT INTO _answer VALUES (1015, 630, 1, 363, 0, 1);
INSERT INTO _answer VALUES (1047, 630, 4, 714, 0, 1);
INSERT INTO _answer VALUES (654, 630, 1, 487, 0, 1);
INSERT INTO _answer VALUES (660, 630, 2, 449, 0, 1);
INSERT INTO _answer VALUES (884, 630, 2, 393, 0, 1);
INSERT INTO _answer VALUES (1095, 630, 5, 1163, 0, 1);
INSERT INTO _answer VALUES (517, 630, 3, 353, 0, 1);
INSERT INTO _answer VALUES (1033, 630, 5, 646, 0, 1);
INSERT INTO _answer VALUES (558, 630, 2, 471, 0, 1);
INSERT INTO _answer VALUES (829, 630, 2, 437, 0, 1);
INSERT INTO _answer VALUES (1037, 630, 4, 1154, 0, 1);
INSERT INTO _answer VALUES (763, 630, 4, 794, 0, 1);
INSERT INTO _answer VALUES (1049, 630, 4, 1273, 0, 1);
INSERT INTO _answer VALUES (732, 630, 7, 493, 0, 1);
INSERT INTO _answer VALUES (599, 630, 6, 365, 0, 1);
INSERT INTO _answer VALUES (1071, 630, 5, 458, 0, 1);
INSERT INTO _answer VALUES (1120, 630, 5, 496, 0, 1);
INSERT INTO _answer VALUES (863, 630, 3, 682, 0, 1);
INSERT INTO _answer VALUES (798, 630, 2, 551, 0, 1);
INSERT INTO _answer VALUES (579, 630, 6, 760, 0, 1);
INSERT INTO _answer VALUES (1036, 630, 4, 449, 0, 1);
INSERT INTO _answer VALUES (1086, 630, 5, 1160, 0, 1);
INSERT INTO _answer VALUES (586, 630, 5, 997, 0, 1);
INSERT INTO _answer VALUES (1023, 630, 5, 390, 0, 1);
INSERT INTO _answer VALUES (1027, 630, 6, 867, 0, 1);
INSERT INTO _answer VALUES (1121, 630, 5, 661, 0, 1);
INSERT INTO _answer VALUES (704, 630, 1, 370, 0, 1);
INSERT INTO _answer VALUES (1100, 630, 6, 488, 0, 1);
INSERT INTO _answer VALUES (701, 630, 2, 590, 0, 1);
INSERT INTO _answer VALUES (908, 630, 2, 389, 0, 1);
INSERT INTO _answer VALUES (902, 630, 2, 361, 0, 1);
INSERT INTO _answer VALUES (1064, 630, 5, 468, 0, 1);
INSERT INTO _answer VALUES (851, 630, 3, 657, 0, 1);
INSERT INTO _answer VALUES (734, 630, 2, 473, 0, 1);
INSERT INTO _answer VALUES (585, 630, 3, 1467, 0, 1);
INSERT INTO _answer VALUES (532, 630, 2, 461, 0, 1);
INSERT INTO _answer VALUES (916, 630, 3, 340, 0, 1);
INSERT INTO _answer VALUES (557, 630, 1, 531, 0, 1);
INSERT INTO _answer VALUES (824, 630, 2, 298, 0, 1);
INSERT INTO _answer VALUES (897, 630, 2, 292, 0, 1);
INSERT INTO _answer VALUES (1112, 630, 2, 391, 0, 1);
INSERT INTO _answer VALUES (540, 630, 2, 911, 0, 1);
INSERT INTO _answer VALUES (683, 630, 2, 484, 0, 1);
INSERT INTO _answer VALUES (681, 630, 6, 1045, 0, 1);
INSERT INTO _answer VALUES (601, 630, 6, 599, 0, 1);
INSERT INTO _answer VALUES (603, 630, 6, 438, 0, 1);
INSERT INTO _answer VALUES (885, 630, 2, 443, 0, 1);
INSERT INTO _answer VALUES (915, 630, 5, 413, 0, 1);
INSERT INTO _answer VALUES (825, 630, 3, 651, 0, 1);
INSERT INTO _answer VALUES (913, 630, 4, 348, 0, 1);
INSERT INTO _answer VALUES (769, 630, 6, 418, 0, 1);
INSERT INTO _answer VALUES (735, 630, 7, 490, 0, 1);
INSERT INTO _answer VALUES (543, 630, 2, 1410, 0, 1);
INSERT INTO _answer VALUES (722, 630, 2, 334, 0, 1);
INSERT INTO _answer VALUES (613, 630, 2, 381, 0, 1);
INSERT INTO _answer VALUES (728, 630, 5, 393, 0, 1);
INSERT INTO _answer VALUES (814, 630, 1, 288, 0, 1);
INSERT INTO _answer VALUES (1028, 630, 6, 635, 0, 1);
INSERT INTO _answer VALUES (718, 630, 6, 277, 0, 1);
INSERT INTO _answer VALUES (792, 630, 3, 742, 0, 1);
INSERT INTO _answer VALUES (529, 630, 1, 338, 0, 1);
INSERT INTO _answer VALUES (1133, 630, 5, 957, 0, 1);
INSERT INTO _answer VALUES (1084, 630, 5, 775, 0, 1);
INSERT INTO _answer VALUES (696, 630, 6, 476, 1, 1);
INSERT INTO _answer VALUES (509, 630, 3, 718, 0, 1);
INSERT INTO _answer VALUES (619, 630, 2, 795, 0, 1);
INSERT INTO _answer VALUES (833, 630, 2, 386, 0, 1);
INSERT INTO _answer VALUES (1094, 630, 3, 632, 0, 1);
INSERT INTO _answer VALUES (458, 630, 6, 2120, 0, 1);
INSERT INTO _answer VALUES (454, 630, 5, 402, 0, 1);
INSERT INTO _answer VALUES (1016, 630, 6, 700, 0, 1);
INSERT INTO _answer VALUES (616, 630, 5, 489, 0, 1);
INSERT INTO _answer VALUES (1117, 630, 6, 561, 0, 1);
INSERT INTO _answer VALUES (759, 630, 2, 406, 0, 1);
INSERT INTO _answer VALUES (537, 630, 3, 878, 0, 1);
INSERT INTO _answer VALUES (708, 630, 5, 441, 0, 1);
INSERT INTO _answer VALUES (1107, 630, 4, 346, 0, 1);
INSERT INTO _answer VALUES (621, 630, 2, 308, 0, 1);
INSERT INTO _answer VALUES (1018, 630, 6, 726, 0, 1);
INSERT INTO _answer VALUES (626, 630, 6, 609, 0, 1);
INSERT INTO _answer VALUES (1054, 630, 2, 373, 0, 1);
INSERT INTO _answer VALUES (1104, 630, 5, 481, 0, 1);
INSERT INTO _answer VALUES (550, 630, 3, 640, 0, 1);
INSERT INTO _answer VALUES (805, 630, 3, 425, 0, 1);
INSERT INTO _answer VALUES (468, 630, 5, 751, 0, 1);
INSERT INTO _answer VALUES (1105, 630, 4, 240, 0, 1);
INSERT INTO _answer VALUES (869, 630, 4, 698, 0, 1);
INSERT INTO _answer VALUES (1059, 630, 2, 438, 0, 1);
INSERT INTO _answer VALUES (515, 630, 3, 457, 0, 1);
INSERT INTO _answer VALUES (791, 630, 2, 404, 0, 1);
INSERT INTO _answer VALUES (760, 630, 5, 331, 0, 1);
INSERT INTO _answer VALUES (789, 630, 3, 817, 0, 1);
INSERT INTO _answer VALUES (563, 630, 3, 1318, 1, 1);
INSERT INTO _answer VALUES (1085, 630, 5, 704, 0, 1);
INSERT INTO _answer VALUES (668, 630, 6, 734, 0, 1);
INSERT INTO _answer VALUES (831, 630, 6, 455, 0, 1);
INSERT INTO _answer VALUES (674, 630, 3, 686, 0, 1);
INSERT INTO _answer VALUES (836, 630, 3, 500, 0, 1);
INSERT INTO _answer VALUES (536, 630, 2, 464, 0, 1);
INSERT INTO _answer VALUES (489, 630, 6, 487, 0, 1);
INSERT INTO _answer VALUES (627, 630, 6, 1903, 0, 1);
INSERT INTO _answer VALUES (782, 630, 3, 819, 0, 1);
INSERT INTO _answer VALUES (589, 630, 2, 895, 0, 1);
INSERT INTO _answer VALUES (652, 630, 2, 512, 0, 1);
INSERT INTO _answer VALUES (564, 630, 3, 664, 0, 1);
INSERT INTO _answer VALUES (602, 630, 6, 802, 0, 1);
INSERT INTO _answer VALUES (880, 630, 5, 554, 0, 1);
INSERT INTO _answer VALUES (556, 630, 2, 318, 0, 1);
INSERT INTO _answer VALUES (1058, 630, 2, 497, 0, 1);
INSERT INTO _answer VALUES (799, 630, 3, 466, 0, 1);
INSERT INTO _answer VALUES (687, 630, 6, 210, 0, 1);
INSERT INTO _answer VALUES (695, 630, 2, 319, 0, 1);
INSERT INTO _answer VALUES (707, 630, 2, 346, 0, 1);
INSERT INTO _answer VALUES (779, 630, 5, 393, 0, 1);
INSERT INTO _answer VALUES (503, 630, 5, 267, 0, 1);
INSERT INTO _answer VALUES (552, 630, 2, 488, 0, 1);
INSERT INTO _answer VALUES (845, 630, 2, 436, 0, 1);
INSERT INTO _answer VALUES (482, 630, 6, 452, 0, 1);
INSERT INTO _answer VALUES (822, 630, 3, 689, 0, 1);
INSERT INTO _answer VALUES (1017, 630, 6, 301, 0, 1);
INSERT INTO _answer VALUES (1130, 630, 3, 367, 0, 1);
INSERT INTO _answer VALUES (786, 630, 4, 478, 0, 1);
INSERT INTO _answer VALUES (688, 630, 6, 190, 0, 1);
INSERT INTO _answer VALUES (595, 630, 3, 566, 0, 1);
INSERT INTO _answer VALUES (653, 630, 2, 505, 0, 1);
INSERT INTO _answer VALUES (890, 630, 3, 1353, 0, 1);
INSERT INTO _answer VALUES (573, 630, 5, 939, 0, 1);
INSERT INTO _answer VALUES (518, 630, 3, 615, 0, 1);
INSERT INTO _answer VALUES (815, 630, 3, 936, 0, 1);
INSERT INTO _answer VALUES (866, 630, 2, 246, 0, 1);
INSERT INTO _answer VALUES (629, 630, 6, 253, 0, 1);
INSERT INTO _answer VALUES (1026, 630, 6, 585, 0, 1);
INSERT INTO _answer VALUES (1060, 630, 2, 450, 0, 1);
INSERT INTO _answer VALUES (656, 630, 2, 367, 0, 1);
INSERT INTO _answer VALUES (841, 630, 2, 303, 0, 1);
INSERT INTO _answer VALUES (816, 630, 4, 607, 1, 1);
INSERT INTO _answer VALUES (1007, 630, 6, 697, 0, 1);
INSERT INTO _answer VALUES (554, 630, 2, 399, 0, 1);
INSERT INTO _answer VALUES (1113, 630, 4, 403, 0, 1);
INSERT INTO _answer VALUES (460, 630, 5, 348, 0, 1);
INSERT INTO _answer VALUES (768, 630, 5, 499, 0, 1);
INSERT INTO _answer VALUES (471, 630, 6, 890, 0, 1);
INSERT INTO _answer VALUES (1022, 630, 6, 495, 0, 1);
INSERT INTO _answer VALUES (667, 630, 6, 290, 0, 1);
INSERT INTO _answer VALUES (544, 630, 2, 372, 0, 1);
INSERT INTO _answer VALUES (659, 630, 6, 341, 0, 1);
INSERT INTO _answer VALUES (680, 630, 2, 612, 0, 1);
INSERT INTO _answer VALUES (1070, 630, 6, 728, 0, 1);
INSERT INTO _answer VALUES (622, 630, 6, 389, 0, 1);
INSERT INTO _answer VALUES (888, 630, 3, 829, 0, 1);
INSERT INTO _answer VALUES (808, 630, 6, 276, 0, 1);
INSERT INTO _answer VALUES (1004, 630, 6, 529, 0, 1);
INSERT INTO _answer VALUES (582, 630, 6, 773, 0, 1);
INSERT INTO _answer VALUES (892, 630, 3, 606, 0, 1);
INSERT INTO _answer VALUES (1006, 630, 4, 536, 0, 1);
INSERT INTO _answer VALUES (860, 630, 1, 197, 0, 1);
INSERT INTO _answer VALUES (817, 630, 2, 298, 0, 1);
INSERT INTO _answer VALUES (452, 630, 6, 275, 0, 1);
INSERT INTO _answer VALUES (904, 630, 2, 420, 0, 2);
INSERT INTO _answer VALUES (493, 630, 5, 846, 0, 2);
INSERT INTO _answer VALUES (495, 630, 5, 604, 0, 2);
INSERT INTO _answer VALUES (545, 630, 4, 666, 0, 2);
INSERT INTO _answer VALUES (577, 630, 6, 1330, 0, 2);
INSERT INTO _answer VALUES (796, 630, 2, 411, 0, 2);
INSERT INTO _answer VALUES (717, 630, 6, 540, 0, 2);
INSERT INTO _answer VALUES (826, 630, 4, 474, 0, 2);
INSERT INTO _answer VALUES (849, 630, 2, 365, 0, 2);
INSERT INTO _answer VALUES (859, 630, 2, 1111, 0, 2);
INSERT INTO _answer VALUES (810, 630, 2, 242, 0, 2);
INSERT INTO _answer VALUES (755, 630, 2, 347, 0, 2);
INSERT INTO _answer VALUES (525, 630, 6, 618, 0, 2);
INSERT INTO _answer VALUES (840, 630, 6, 34582, 0, 2);
INSERT INTO _answer VALUES (729, 630, 6, 1047, 0, 2);
INSERT INTO _answer VALUES (803, 630, 2, 338, 0, 2);
INSERT INTO _answer VALUES (894, 630, 3, 792, 0, 2);
INSERT INTO _answer VALUES (516, 630, 4, 958, 0, 2);
INSERT INTO _answer VALUES (918, 630, 3, 441, 0, 2);
INSERT INTO _answer VALUES (643, 630, 6, 653, 0, 2);
INSERT INTO _answer VALUES (665, 630, 2, 400, 0, 2);
INSERT INTO _answer VALUES (685, 630, 2, 339, 0, 2);
INSERT INTO _answer VALUES (581, 630, 5, 503, 0, 2);
INSERT INTO _answer VALUES (592, 630, 3, 335, 0, 2);
INSERT INTO _answer VALUES (580, 630, 6, 710, 0, 2);
INSERT INTO _answer VALUES (757, 630, 2, 306, 0, 2);
INSERT INTO _answer VALUES (691, 630, 2, 257, 0, 2);
INSERT INTO _answer VALUES (1127, 630, 5, 331, 0, 2);
INSERT INTO _answer VALUES (1128, 630, 4, 640, 0, 2);
INSERT INTO _answer VALUES (800, 630, 2, 1713, 0, 2);
INSERT INTO _answer VALUES (857, 630, 2, 202, 0, 2);
INSERT INTO _answer VALUES (1066, 630, 4, 686, 0, 2);
INSERT INTO _answer VALUES (541, 630, 2, 305, 0, 2);
INSERT INTO _answer VALUES (686, 630, 6, 604, 0, 2);
INSERT INTO _answer VALUES (699, 630, 6, 443, 0, 2);
INSERT INTO _answer VALUES (605, 630, 2, 289, 0, 2);
INSERT INTO _answer VALUES (882, 630, 3, 381, 0, 2);
INSERT INTO _answer VALUES (459, 630, 5, 480, 0, 2);
INSERT INTO _answer VALUES (484, 630, 5, 253, 0, 2);
INSERT INTO _answer VALUES (848, 630, 1, 395, 0, 2);
INSERT INTO _answer VALUES (1057, 630, 5, 701, 0, 2);
INSERT INTO _answer VALUES (1053, 630, 4, 377, 0, 2);
INSERT INTO _answer VALUES (741, 630, 3, 656, 0, 2);
INSERT INTO _answer VALUES (528, 630, 7, 580, 0, 2);
INSERT INTO _answer VALUES (588, 630, 2, 867, 0, 2);
INSERT INTO _answer VALUES (693, 630, 2, 287, 0, 2);
INSERT INTO _answer VALUES (731, 630, 6, 3982, 0, 2);
INSERT INTO _answer VALUES (711, 630, 6, 265, 0, 2);
INSERT INTO _answer VALUES (511, 630, 4, 604, 0, 2);
INSERT INTO _answer VALUES (886, 630, 3, 725, 1, 2);
INSERT INTO _answer VALUES (649, 630, 5, 452, 0, 2);
INSERT INTO _answer VALUES (746, 630, 6, 798, 0, 2);
INSERT INTO _answer VALUES (856, 630, 1, 279, 0, 2);
INSERT INTO _answer VALUES (669, 630, 6, 337, 0, 2);
INSERT INTO _answer VALUES (568, 630, 6, 387, 0, 2);
INSERT INTO _answer VALUES (607, 630, 1, 634, 0, 2);
INSERT INTO _answer VALUES (636, 630, 5, 345, 0, 2);
INSERT INTO _answer VALUES (865, 630, 3, 480, 0, 2);
INSERT INTO _answer VALUES (895, 630, 3, 455, 0, 2);
INSERT INTO _answer VALUES (847, 630, 2, 513, 0, 2);
INSERT INTO _answer VALUES (474, 630, 6, 404, 0, 2);
INSERT INTO _answer VALUES (594, 630, 3, 820, 0, 2);
INSERT INTO _answer VALUES (675, 630, 5, 686, 0, 2);
INSERT INTO _answer VALUES (583, 630, 5, 833, 0, 2);
INSERT INTO _answer VALUES (638, 630, 5, 638, 0, 2);
INSERT INTO _answer VALUES (909, 630, 5, 704, 0, 2);
INSERT INTO _answer VALUES (520, 630, 5, 398, 0, 2);
INSERT INTO _answer VALUES (1008, 630, 4, 485, 0, 2);
INSERT INTO _answer VALUES (1039, 630, 6, 588, 1, 2);
INSERT INTO _answer VALUES (823, 630, 3, 492, 0, 2);
INSERT INTO _answer VALUES (761, 630, 5, 813, 1, 2);
INSERT INTO _answer VALUES (766, 630, 5, 472, 0, 2);
INSERT INTO _answer VALUES (561, 630, 4, 558, 0, 2);
INSERT INTO _answer VALUES (710, 630, 6, 587, 0, 2);
INSERT INTO _answer VALUES (584, 630, 4, 525, 0, 2);
INSERT INTO _answer VALUES (618, 630, 6, 1178, 0, 2);
INSERT INTO _answer VALUES (1081, 630, 2, 613, 0, 2);
INSERT INTO _answer VALUES (706, 630, 2, 610, 0, 2);
INSERT INTO _answer VALUES (610, 630, 6, 623, 0, 2);
INSERT INTO _answer VALUES (738, 630, 5, 381, 0, 2);
INSERT INTO _answer VALUES (743, 630, 3, 790, 1, 2);
INSERT INTO _answer VALUES (608, 630, 2, 563, 0, 2);
INSERT INTO _answer VALUES (1068, 630, 3, 637, 0, 2);
INSERT INTO _answer VALUES (1042, 630, 5, 260, 0, 2);
INSERT INTO _answer VALUES (853, 630, 4, 825, 0, 2);
INSERT INTO _answer VALUES (596, 630, 6, 362, 0, 2);
INSERT INTO _answer VALUES (1041, 630, 5, 850, 1, 2);
INSERT INTO _answer VALUES (570, 630, 6, 733, 0, 2);
INSERT INTO _answer VALUES (771, 630, 6, 503, 0, 2);
INSERT INTO _answer VALUES (801, 630, 2, 390, 0, 2);
INSERT INTO _answer VALUES (787, 630, 6, 407, 0, 2);
INSERT INTO _answer VALUES (473, 630, 4, 712, 0, 2);
INSERT INTO _answer VALUES (1003, 630, 5, 617, 0, 2);
INSERT INTO _answer VALUES (712, 630, 6, 538, 0, 2);
INSERT INTO _answer VALUES (703, 630, 2, 321, 0, 2);
INSERT INTO _answer VALUES (1125, 630, 6, 285, 0, 2);
INSERT INTO _answer VALUES (590, 630, 2, 345, 0, 2);
INSERT INTO _answer VALUES (844, 630, 3, 1160, 0, 2);
INSERT INTO _answer VALUES (578, 630, 5, 479, 0, 2);
INSERT INTO _answer VALUES (793, 630, 2, 297, 0, 2);
INSERT INTO _answer VALUES (1089, 630, 4, 410, 0, 2);
INSERT INTO _answer VALUES (812, 630, 6, 304, 0, 2);
INSERT INTO _answer VALUES (597, 630, 6, 367, 0, 2);
INSERT INTO _answer VALUES (576, 630, 6, 374, 0, 2);
INSERT INTO _answer VALUES (500, 630, 5, 981, 0, 2);
INSERT INTO _answer VALUES (521, 630, 3, 387, 0, 2);
INSERT INTO _answer VALUES (1124, 630, 4, 372, 0, 2);
INSERT INTO _answer VALUES (457, 630, 6, 332, 0, 2);
INSERT INTO _answer VALUES (490, 630, 6, 431, 0, 2);
INSERT INTO _answer VALUES (642, 630, 5, 722, 1, 2);
INSERT INTO _answer VALUES (676, 630, 6, 532, 0, 2);
INSERT INTO _answer VALUES (1072, 630, 6, 1300, 0, 2);
INSERT INTO _answer VALUES (538, 630, 2, 770, 0, 2);
INSERT INTO _answer VALUES (893, 630, 3, 381, 0, 2);
INSERT INTO _answer VALUES (631, 630, 5, 417, 0, 2);
INSERT INTO _answer VALUES (837, 630, 3, 646, 0, 2);
INSERT INTO _answer VALUES (467, 630, 6, 348, 0, 2);
INSERT INTO _answer VALUES (1076, 630, 2, 268, 0, 2);
INSERT INTO _answer VALUES (919, 630, 4, 746, 0, 2);
INSERT INTO _answer VALUES (486, 630, 6, 233, 0, 2);
INSERT INTO _answer VALUES (560, 630, 3, 473, 0, 2);
INSERT INTO _answer VALUES (494, 630, 5, 1011, 0, 2);
INSERT INTO _answer VALUES (682, 630, 2, 1073, 0, 2);
INSERT INTO _answer VALUES (751, 630, 6, 314, 0, 2);
INSERT INTO _answer VALUES (1092, 630, 3, 531, 0, 2);
INSERT INTO _answer VALUES (861, 630, 2, 292, 0, 2);
INSERT INTO _answer VALUES (572, 630, 6, 289, 0, 2);
INSERT INTO _answer VALUES (463, 630, 4, 503, 0, 2);
INSERT INTO _answer VALUES (1031, 630, 6, 810, 0, 2);
INSERT INTO _answer VALUES (820, 630, 3, 234, 0, 2);
INSERT INTO _answer VALUES (496, 630, 6, 294, 0, 2);
INSERT INTO _answer VALUES (754, 630, 6, 1093, 0, 2);
INSERT INTO _answer VALUES (662, 630, 2, 742, 0, 2);
INSERT INTO _answer VALUES (911, 630, 1, 489, 0, 2);
INSERT INTO _answer VALUES (1122, 630, 5, 563, 0, 2);
INSERT INTO _answer VALUES (466, 630, 6, 282, 0, 2);
INSERT INTO _answer VALUES (530, 630, 7, 658, 0, 2);
INSERT INTO _answer VALUES (749, 630, 6, 592, 0, 2);
INSERT INTO _answer VALUES (641, 630, 2, 388, 0, 2);
INSERT INTO _answer VALUES (1078, 630, 4, 728, 0, 2);
INSERT INTO _answer VALUES (1065, 630, 2, 343, 0, 2);
INSERT INTO _answer VALUES (479, 630, 6, 322, 0, 2);
INSERT INTO _answer VALUES (671, 630, 4, 1131, 0, 2);
INSERT INTO _answer VALUES (551, 630, 3, 333, 0, 2);
INSERT INTO _answer VALUES (630, 630, 6, 715, 0, 2);
INSERT INTO _answer VALUES (1118, 630, 3, 496, 1, 2);
INSERT INTO _answer VALUES (914, 630, 4, 538, 0, 2);
INSERT INTO _answer VALUES (716, 630, 6, 450, 0, 2);
INSERT INTO _answer VALUES (1011, 630, 2, 341, 0, 2);
INSERT INTO _answer VALUES (1030, 630, 6, 342, 0, 2);
INSERT INTO _answer VALUES (1038, 630, 5, 493, 0, 2);
INSERT INTO _answer VALUES (744, 630, 6, 226, 0, 2);
INSERT INTO _answer VALUES (762, 630, 5, 431, 0, 2);
INSERT INTO _answer VALUES (1083, 630, 5, 975, 0, 2);
INSERT INTO _answer VALUES (499, 630, 5, 1078, 1, 2);
INSERT INTO _answer VALUES (736, 630, 2, 969, 0, 2);
INSERT INTO _answer VALUES (1073, 630, 6, 321, 0, 2);
INSERT INTO _answer VALUES (534, 630, 2, 274, 0, 2);
INSERT INTO _answer VALUES (1098, 630, 5, 534, 0, 2);
INSERT INTO _answer VALUES (1106, 630, 4, 496, 0, 2);
INSERT INTO _answer VALUES (1110, 630, 5, 639, 0, 2);
INSERT INTO _answer VALUES (472, 630, 6, 370, 0, 2);
INSERT INTO _answer VALUES (807, 630, 5, 237, 0, 2);
INSERT INTO _answer VALUES (549, 630, 3, 481, 0, 2);
INSERT INTO _answer VALUES (713, 630, 6, 525, 0, 2);
INSERT INTO _answer VALUES (804, 630, 4, 1406, 0, 2);
INSERT INTO _answer VALUES (559, 630, 3, 1370, 0, 2);
INSERT INTO _answer VALUES (492, 630, 5, 457, 1, 2);
INSERT INTO _answer VALUES (896, 630, 4, 701, 0, 2);
INSERT INTO _answer VALUES (1012, 630, 2, 259, 0, 2);
INSERT INTO _answer VALUES (854, 630, 2, 328, 0, 2);
INSERT INTO _answer VALUES (1044, 630, 5, 392, 0, 2);
INSERT INTO _answer VALUES (598, 630, 6, 259, 0, 2);
INSERT INTO _answer VALUES (724, 630, 2, 798, 0, 2);
INSERT INTO _answer VALUES (723, 630, 2, 327, 0, 2);
INSERT INTO _answer VALUES (727, 630, 6, 456, 0, 2);
INSERT INTO _answer VALUES (827, 630, 2, 451, 0, 2);
INSERT INTO _answer VALUES (465, 630, 5, 569, 0, 2);
INSERT INTO _answer VALUES (1108, 630, 4, 285, 0, 2);
INSERT INTO _answer VALUES (1010, 630, 2, 305, 0, 2);
INSERT INTO _answer VALUES (765, 630, 6, 269, 0, 2);
INSERT INTO _answer VALUES (1111, 630, 2, 395, 0, 2);
INSERT INTO _answer VALUES (781, 630, 3, 437, 0, 2);
INSERT INTO _answer VALUES (855, 630, 2, 1144, 0, 2);
INSERT INTO _answer VALUES (657, 630, 6, 679, 0, 2);
INSERT INTO _answer VALUES (1091, 630, 3, 1233, 0, 2);
INSERT INTO _answer VALUES (523, 630, 6, 10901, 0, 2);
INSERT INTO _answer VALUES (635, 630, 5, 335, 0, 2);
INSERT INTO _answer VALUES (737, 630, 5, 874, 0, 2);
INSERT INTO _answer VALUES (510, 630, 4, 905, 1, 2);
INSERT INTO _answer VALUES (1050, 630, 3, 527, 1, 2);
INSERT INTO _answer VALUES (1048, 630, 3, 478, 0, 2);
INSERT INTO _answer VALUES (870, 630, 3, 288, 0, 2);
INSERT INTO _answer VALUES (639, 630, 6, 301, 0, 2);
INSERT INTO _answer VALUES (834, 630, 5, 344, 0, 2);
INSERT INTO _answer VALUES (678, 630, 5, 359, 0, 2);
INSERT INTO _answer VALUES (1074, 630, 2, 356, 0, 2);
INSERT INTO _answer VALUES (512, 630, 4, 547, 0, 2);
INSERT INTO _answer VALUES (481, 630, 6, 44395, 0, 2);
INSERT INTO _answer VALUES (1109, 630, 4, 835, 2, 2);
INSERT INTO _answer VALUES (1132, 630, 5, 868, 0, 2);
INSERT INTO _answer VALUES (477, 630, 6, 477, 0, 2);
INSERT INTO _answer VALUES (698, 630, 5, 251, 0, 2);
INSERT INTO _answer VALUES (679, 630, 5, 603, 0, 2);
INSERT INTO _answer VALUES (611, 630, 6, 490, 0, 2);
INSERT INTO _answer VALUES (776, 630, 4, 449, 1, 2);
INSERT INTO _answer VALUES (1135, 630, 3, 763, 0, 2);
INSERT INTO _answer VALUES (868, 630, 5, 419, 0, 2);
INSERT INTO _answer VALUES (623, 630, 2, 520, 0, 2);
INSERT INTO _answer VALUES (719, 630, 6, 623, 0, 2);
INSERT INTO _answer VALUES (747, 630, 6, 929, 0, 2);
INSERT INTO _answer VALUES (609, 630, 2, 320, 0, 2);
INSERT INTO _answer VALUES (497, 630, 6, 299, 0, 2);
INSERT INTO _answer VALUES (1080, 630, 3, 3453, 0, 2);
INSERT INTO _answer VALUES (547, 630, 3, 306, 0, 2);
INSERT INTO _answer VALUES (615, 630, 5, 218, 0, 2);
INSERT INTO _answer VALUES (648, 630, 6, 671, 0, 2);
INSERT INTO _answer VALUES (464, 630, 4, 413, 0, 2);
INSERT INTO _answer VALUES (1034, 630, 5, 477, 0, 2);
INSERT INTO _answer VALUES (485, 630, 5, 322, 0, 2);
INSERT INTO _answer VALUES (1056, 630, 2, 524, 0, 2);
INSERT INTO _answer VALUES (508, 630, 5, 318, 0, 2);
INSERT INTO _answer VALUES (663, 630, 2, 532, 0, 2);
INSERT INTO _answer VALUES (1088, 630, 5, 777, 0, 2);
INSERT INTO _answer VALUES (1046, 630, 4, 848, 0, 2);
INSERT INTO _answer VALUES (705, 630, 3, 525, 0, 2);
INSERT INTO _answer VALUES (1115, 630, 4, 772, 0, 2);
INSERT INTO _answer VALUES (770, 630, 5, 296, 0, 2);
INSERT INTO _answer VALUES (645, 630, 2, 1030, 0, 2);
INSERT INTO _answer VALUES (858, 630, 2, 366, 0, 2);
INSERT INTO _answer VALUES (666, 630, 2, 305, 0, 2);
INSERT INTO _answer VALUES (677, 630, 5, 571, 0, 2);
INSERT INTO _answer VALUES (835, 630, 2, 382, 0, 2);
INSERT INTO _answer VALUES (606, 630, 2, 493, 0, 2);
INSERT INTO _answer VALUES (1090, 630, 4, 321, 0, 2);
INSERT INTO _answer VALUES (862, 630, 2, 349, 0, 2);
INSERT INTO _answer VALUES (828, 630, 2, 351, 0, 2);
INSERT INTO _answer VALUES (491, 630, 6, 320, 0, 2);
INSERT INTO _answer VALUES (1019, 630, 6, 423, 0, 2);
INSERT INTO _answer VALUES (1077, 630, 2, 415, 0, 2);
INSERT INTO _answer VALUES (1061, 630, 3, 596, 0, 2);
INSERT INTO _answer VALUES (593, 630, 3, 416, 0, 2);
INSERT INTO _answer VALUES (733, 630, 6, 446, 0, 2);
INSERT INTO _answer VALUES (548, 630, 4, 340, 0, 2);
INSERT INTO _answer VALUES (632, 630, 5, 331, 0, 2);
INSERT INTO _answer VALUES (612, 630, 5, 361, 0, 2);
INSERT INTO _answer VALUES (725, 630, 6, 476, 0, 2);
INSERT INTO _answer VALUES (1032, 630, 4, 451, 0, 2);
INSERT INTO _answer VALUES (469, 630, 6, 247, 0, 2);
INSERT INTO _answer VALUES (625, 630, 6, 384, 0, 2);
INSERT INTO _answer VALUES (900, 630, 2, 225, 0, 2);
INSERT INTO _answer VALUES (650, 630, 4, 1291, 0, 2);
INSERT INTO _answer VALUES (1025, 630, 4, 278, 0, 2);
INSERT INTO _answer VALUES (697, 630, 6, 210, 0, 2);
INSERT INTO _answer VALUES (690, 630, 2, 497, 0, 2);
INSERT INTO _answer VALUES (1101, 630, 4, 523, 0, 2);
INSERT INTO _answer VALUES (555, 630, 2, 250, 0, 2);
INSERT INTO _answer VALUES (774, 630, 5, 658, 0, 2);
INSERT INTO _answer VALUES (488, 630, 6, 401, 0, 2);
INSERT INTO _answer VALUES (846, 630, 4, 686, 0, 2);
INSERT INTO _answer VALUES (507, 630, 4, 401, 0, 2);
INSERT INTO _answer VALUES (694, 630, 3, 605, 0, 2);
INSERT INTO _answer VALUES (832, 630, 5, 597, 0, 2);
INSERT INTO _answer VALUES (891, 630, 2, 306, 0, 2);
INSERT INTO _answer VALUES (721, 630, 3, 559, 0, 2);
INSERT INTO _answer VALUES (1093, 630, 4, 303, 0, 2);
INSERT INTO _answer VALUES (1029, 630, 4, 541, 0, 2);
INSERT INTO _answer VALUES (867, 630, 3, 257, 0, 2);
INSERT INTO _answer VALUES (1075, 630, 2, 436, 0, 2);
INSERT INTO _answer VALUES (917, 630, 5, 360, 0, 2);
INSERT INTO _answer VALUES (783, 630, 3, 386, 0, 2);
INSERT INTO _answer VALUES (478, 630, 6, 482, 1, 2);
INSERT INTO _answer VALUES (813, 630, 5, 354, 0, 2);
INSERT INTO _answer VALUES (730, 630, 6, 799, 0, 2);
INSERT INTO _answer VALUES (881, 630, 3, 440, 0, 2);
INSERT INTO _answer VALUES (456, 630, 2, 437, 0, 2);
INSERT INTO _answer VALUES (795, 630, 2, 419, 0, 2);
INSERT INTO _answer VALUES (1136, 630, 3, 706, 1, 2);
INSERT INTO _answer VALUES (843, 630, 2, 460, 0, 2);
INSERT INTO _answer VALUES (1129, 630, 4, 440, 0, 2);
INSERT INTO _answer VALUES (655, 630, 6, 363, 0, 2);
INSERT INTO _answer VALUES (565, 630, 3, 601, 0, 2);
INSERT INTO _answer VALUES (1082, 630, 4, 378, 0, 2);
INSERT INTO _answer VALUES (614, 630, 5, 675, 0, 2);
INSERT INTO _answer VALUES (571, 630, 6, 677, 0, 2);
INSERT INTO _answer VALUES (726, 630, 5, 716, 0, 2);
INSERT INTO _answer VALUES (522, 630, 6, 324, 0, 2);
INSERT INTO _answer VALUES (600, 630, 6, 363, 0, 2);
INSERT INTO _answer VALUES (715, 630, 2, 346, 0, 2);
INSERT INTO _answer VALUES (513, 630, 4, 358, 0, 2);
INSERT INTO _answer VALUES (850, 630, 3, 744, 0, 2);
INSERT INTO _answer VALUES (519, 630, 4, 550, 0, 2);
INSERT INTO _answer VALUES (852, 630, 3, 654, 0, 2);
INSERT INTO _answer VALUES (864, 630, 3, 410, 0, 2);
INSERT INTO _answer VALUES (624, 630, 6, 713, 0, 2);
INSERT INTO _answer VALUES (811, 630, 5, 273, 0, 2);
INSERT INTO _answer VALUES (527, 630, 2, 540, 0, 2);
INSERT INTO _answer VALUES (529, 638, 6, 251, 0, 1);
INSERT INTO _answer VALUES (1023, 638, 3, 87, 0, 1);
INSERT INTO _answer VALUES (592, 638, 3, 268, 0, 1);
INSERT INTO _answer VALUES (549, 638, 6, 109, 0, 1);
INSERT INTO _answer VALUES (564, 638, 3, 548, 0, 1);
INSERT INTO _answer VALUES (601, 638, 6, 2364, 0, 1);
INSERT INTO _answer VALUES (533, 638, 6, 230, 0, 1);
INSERT INTO _answer VALUES (489, 638, 4, 150, 0, 1);
INSERT INTO _answer VALUES (1031, 638, 5, 211, 0, 1);
INSERT INTO _answer VALUES (485, 638, 6, 108, 0, 1);
INSERT INTO _answer VALUES (1086, 638, 7, 106, 0, 1);
INSERT INTO _answer VALUES (1087, 638, 7, 71, 0, 1);
INSERT INTO _answer VALUES (1043, 638, 7, 2159, 0, 1);
INSERT INTO _answer VALUES (1044, 638, 7, 63, 0, 1);
INSERT INTO _answer VALUES (583, 638, 7, 59, 0, 1);
INSERT INTO _answer VALUES (575, 638, 7, 157, 0, 1);
INSERT INTO _answer VALUES (1092, 638, 7, 50, 0, 1);
INSERT INTO _answer VALUES (1118, 638, 7, 97, 0, 1);
INSERT INTO _answer VALUES (536, 638, 7, 61, 0, 1);
INSERT INTO _answer VALUES (557, 638, 7, 72, 0, 1);
INSERT INTO _answer VALUES (1110, 632, 6, 291, 0, 1);
INSERT INTO _answer VALUES (1021, 632, 6, 557, 0, 1);
INSERT INTO _answer VALUES (1090, 632, 5, 628, 0, 1);
INSERT INTO _answer VALUES (891, 632, 2, 387, 0, 1);
INSERT INTO _answer VALUES (572, 632, 5, 909, 0, 1);
INSERT INTO _answer VALUES (1097, 632, 5, 520, 0, 1);
INSERT INTO _answer VALUES (828, 632, 2, 419, 0, 1);
INSERT INTO _answer VALUES (455, 632, 6, 517, 0, 1);
INSERT INTO _answer VALUES (482, 632, 6, 515, 0, 1);
INSERT INTO _answer VALUES (452, 632, 6, 247, 0, 1);
INSERT INTO _answer VALUES (562, 632, 3, 787, 0, 1);
INSERT INTO _answer VALUES (1062, 632, 2, 309, 0, 1);
INSERT INTO _answer VALUES (524, 632, 6, 987, 0, 1);
INSERT INTO _answer VALUES (818, 632, 6, 504, 0, 1);
INSERT INTO _answer VALUES (503, 632, 4, 278, 0, 1);
INSERT INTO _answer VALUES (467, 632, 5, 295, 0, 1);
INSERT INTO _answer VALUES (556, 632, 5, 307, 0, 1);
INSERT INTO _answer VALUES (1135, 632, 3, 459, 0, 1);
INSERT INTO _answer VALUES (1128, 632, 2, 745, 0, 1);
INSERT INTO _answer VALUES (897, 632, 2, 312, 0, 1);


--
-- Data for TOC entry 157 (OID 17096)
-- Name: registration; Type: TABLE DATA; Schema: public; Owner: fnctlint
--



--
-- Data for TOC entry 158 (OID 17103)
-- Name: qualification_code; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO qualification_code VALUES (0, 'None');
INSERT INTO qualification_code VALUES (1, 'High School - Grade 10');
INSERT INTO qualification_code VALUES (2, 'High School - Grade 12 (matric)');
INSERT INTO qualification_code VALUES (3, 'College Diploma');
INSERT INTO qualification_code VALUES (4, 'University Course');
INSERT INTO qualification_code VALUES (5, 'Bachelors Degree');
INSERT INTO qualification_code VALUES (6, 'Postgraduate Degree (Honours)');
INSERT INTO qualification_code VALUES (7, 'Postgraduate Degree (Masters)');
INSERT INTO qualification_code VALUES (8, 'Postgraduate Degree (Doctors)');


--
-- Data for TOC entry 159 (OID 17106)
-- Name: qualification; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO qualification VALUES (647, 8);
INSERT INTO qualification VALUES (660, 3);
INSERT INTO qualification VALUES (661, 4);
INSERT INTO qualification VALUES (662, 3);


--
-- Data for TOC entry 160 (OID 17110)
-- Name: advert; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO advert VALUES (38, 62, 'Recruitment Values', '2010-02-05');
INSERT INTO advert VALUES (39, 62, 'Organization Screening Inventory', '2010-02-05');
INSERT INTO advert VALUES (40, 0, 'Organization Screening Inventory', '2010-02-05');
INSERT INTO advert VALUES (41, 0, 'High School Career Inventory', '2010-02-05');
INSERT INTO advert VALUES (42, 0, 'Personal Profile', '2010-02-05');
INSERT INTO advert VALUES (43, 0, 'Recruitment Values', '2010-02-05');
INSERT INTO advert VALUES (44, 0, 'High School Functioning Assesment', '2010-02-05');
INSERT INTO advert VALUES (45, 61, 'High School Full Assessment', '2010-02-05');
INSERT INTO advert VALUES (46, 61, 'High School Career Planning Inventory', '2010-02-05');
INSERT INTO advert VALUES (47, 0, 'Career Personality Test', '2010-02-07');
INSERT INTO advert VALUES (48, 65, 'Accountant', '2010-02-08');
INSERT INTO advert VALUES (49, 66, 'High School Assessment', '2010-02-09');
INSERT INTO advert VALUES (50, 66, 'Personal Profile', '2010-02-09');
INSERT INTO advert VALUES (51, 66, 'career personality test', '2010-06-02');
INSERT INTO advert VALUES (53, 62, 'Personal Profile Inventory', '2010-02-09');
INSERT INTO advert VALUES (54, 64, 'Accounts Department', '2010-02-09');
INSERT INTO advert VALUES (55, 64, 'Branch Managers', '2010-02-09');


--
-- Data for TOC entry 161 (OID 17116)
-- Name: qre_type; Type: TABLE DATA; Schema: public; Owner: fnctlint
--

INSERT INTO qre_type VALUES (-1, '??', '??');
INSERT INTO qre_type VALUES (1, 'VA', 'Values Profile Assessment');
INSERT INTO qre_type VALUES (2, 'FA', 'Full Assessment');
INSERT INTO qre_type VALUES (3, 'JP', 'Job Definition Profile');
INSERT INTO qre_type VALUES (4, 'SI', 'Organization Screening Inventory');
INSERT INTO qre_type VALUES (5, 'PP', 'Personal Profile');
INSERT INTO qre_type VALUES (6, 'HA', 'Highschool Assessment');
INSERT INTO qre_type VALUES (7, 'CP', 'Career Planning Inventory');


--
-- TOC entry 100 (OID 195284)
-- Name: customer_code_key; Type: INDEX; Schema: public; Owner: fnctlint
--

CREATE UNIQUE INDEX customer_code_key ON customer USING btree (code);


--
-- TOC entry 102 (OID 195285)
-- Name: customer_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (pkid);


--
-- TOC entry 101 (OID 195287)
-- Name: customer_name_key; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_name_key UNIQUE (name);


--
-- TOC entry 103 (OID 195289)
-- Name: userlevel_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY userlevel
    ADD CONSTRAINT userlevel_pkey PRIMARY KEY (pkid);


--
-- TOC entry 104 (OID 195291)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (pkid);


--
-- TOC entry 105 (OID 195293)
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 162 (OID 195295)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY users
    ADD CONSTRAINT "$1" FOREIGN KEY (fkcustid) REFERENCES customer(pkid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 163 (OID 195299)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY users
    ADD CONSTRAINT "$2" FOREIGN KEY (fklevel) REFERENCES userlevel(pkid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 106 (OID 195303)
-- Name: addresstype_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY addresstype
    ADD CONSTRAINT addresstype_pkey PRIMARY KEY (pkid);


--
-- TOC entry 164 (OID 195305)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY address
    ADD CONSTRAINT "$1" FOREIGN KEY (fkuserid) REFERENCES users(pkid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 165 (OID 195309)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY address
    ADD CONSTRAINT "$2" FOREIGN KEY (fkaddrtype) REFERENCES addresstype(pkid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 108 (OID 195313)
-- Name: questionaire_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY questionaire
    ADD CONSTRAINT questionaire_pkey PRIMARY KEY (pkid);


--
-- TOC entry 107 (OID 195315)
-- Name: questionaire_name_key; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY questionaire
    ADD CONSTRAINT questionaire_name_key UNIQUE (name);


--
-- TOC entry 109 (OID 195317)
-- Name: super_construct_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY super_construct
    ADD CONSTRAINT super_construct_pkey PRIMARY KEY (pkid);


--
-- TOC entry 110 (OID 195319)
-- Name: _q_sc_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _q_sc_entry
    ADD CONSTRAINT _q_sc_entry_pkey PRIMARY KEY (fkq, fksc);


--
-- TOC entry 167 (OID 195321)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _q_sc_entry
    ADD CONSTRAINT "$1" FOREIGN KEY (fkq) REFERENCES questionaire(pkid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 168 (OID 195325)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _q_sc_entry
    ADD CONSTRAINT "$2" FOREIGN KEY (fksc) REFERENCES super_construct(pkid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 111 (OID 195329)
-- Name: construct_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY construct
    ADD CONSTRAINT construct_pkey PRIMARY KEY (pkid);


--
-- TOC entry 169 (OID 195331)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY construct
    ADD CONSTRAINT "$1" FOREIGN KEY (fksc) REFERENCES super_construct(pkid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 112 (OID 195335)
-- Name: _qsce_c_exclude_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _qsce_c_exclude
    ADD CONSTRAINT _qsce_c_exclude_pkey PRIMARY KEY (fkq, fksc, fkc);


--
-- TOC entry 170 (OID 195337)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _qsce_c_exclude
    ADD CONSTRAINT "$1" FOREIGN KEY (fkq, fksc) REFERENCES _q_sc_entry(fkq, fksc) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 171 (OID 195341)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _qsce_c_exclude
    ADD CONSTRAINT "$2" FOREIGN KEY (fkc) REFERENCES construct(pkid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 113 (OID 195345)
-- Name: question_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_pkey PRIMARY KEY (pkid);


--
-- TOC entry 172 (OID 195347)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY question
    ADD CONSTRAINT "$1" FOREIGN KEY (fkc) REFERENCES construct(pkid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 173 (OID 195351)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY wording
    ADD CONSTRAINT "$1" FOREIGN KEY (fkqn) REFERENCES question(pkid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 114 (OID 195355)
-- Name: test_status_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY test_status
    ADD CONSTRAINT test_status_pkey PRIMARY KEY (pkid);


--
-- TOC entry 116 (OID 195357)
-- Name: _assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _assignment
    ADD CONSTRAINT _assignment_pkey PRIMARY KEY (pkid);


--
-- TOC entry 115 (OID 195359)
-- Name: _assignment_fkuser_key; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _assignment
    ADD CONSTRAINT _assignment_fkuser_key UNIQUE (fkuser, fkq);


--
-- TOC entry 174 (OID 195361)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _assignment
    ADD CONSTRAINT "$1" FOREIGN KEY (fkuser) REFERENCES users(pkid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 175 (OID 195365)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _assignment
    ADD CONSTRAINT "$2" FOREIGN KEY (fkq) REFERENCES questionaire(pkid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 176 (OID 195369)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _assignment
    ADD CONSTRAINT "$3" FOREIGN KEY (fktststatus) REFERENCES test_status(pkid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 117 (OID 195373)
-- Name: _answer_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _answer
    ADD CONSTRAINT _answer_pkey PRIMARY KEY (fkqn, fkassmt);


--
-- TOC entry 177 (OID 195375)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _answer
    ADD CONSTRAINT "$1" FOREIGN KEY (fkqn) REFERENCES question(pkid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 178 (OID 195379)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY _answer
    ADD CONSTRAINT "$2" FOREIGN KEY (fkassmt) REFERENCES _assignment(pkid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 118 (OID 195383)
-- Name: registration_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY registration
    ADD CONSTRAINT registration_pkey PRIMARY KEY (pkid);


--
-- TOC entry 119 (OID 195385)
-- Name: registration_username_key; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY registration
    ADD CONSTRAINT registration_username_key UNIQUE (username);


--
-- TOC entry 120 (OID 195387)
-- Name: qualification_code_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY qualification_code
    ADD CONSTRAINT qualification_code_pkey PRIMARY KEY (pkid);


--
-- TOC entry 179 (OID 195389)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY qualification
    ADD CONSTRAINT "$1" FOREIGN KEY (fkusrid) REFERENCES users(pkid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 180 (OID 195393)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY qualification
    ADD CONSTRAINT "$2" FOREIGN KEY (fkqcode) REFERENCES qualification_code(pkid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 121 (OID 195397)
-- Name: advert_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY advert
    ADD CONSTRAINT advert_pkey PRIMARY KEY (pkid);


--
-- TOC entry 181 (OID 195399)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY advert
    ADD CONSTRAINT "$1" FOREIGN KEY (fkcustid) REFERENCES customer(pkid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 122 (OID 195403)
-- Name: qre_type_pkey; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY qre_type
    ADD CONSTRAINT qre_type_pkey PRIMARY KEY (pkid);


--
-- TOC entry 166 (OID 195405)
-- Name: fktypeid; Type: CONSTRAINT; Schema: public; Owner: fnctlint
--

ALTER TABLE ONLY questionaire
    ADD CONSTRAINT fktypeid FOREIGN KEY (fktypeid) REFERENCES qre_type(pkid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 74 (OID 16979)
-- Name: customer_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('customer_pkid_seq', 66, true);


--
-- TOC entry 76 (OID 16987)
-- Name: userlevel_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('userlevel_pkid_seq', 1, false);


--
-- TOC entry 78 (OID 16992)
-- Name: users_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('users_pkid_seq', 662, true);


--
-- TOC entry 80 (OID 16997)
-- Name: addresstype_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('addresstype_pkid_seq', 1, false);


--
-- TOC entry 82 (OID 17004)
-- Name: questionaire_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('questionaire_pkid_seq', 69, true);


--
-- TOC entry 84 (OID 17011)
-- Name: super_construct_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('super_construct_pkid_seq', 1, false);


--
-- TOC entry 86 (OID 17018)
-- Name: construct_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('construct_pkid_seq', 2, true);


--
-- TOC entry 88 (OID 17028)
-- Name: question_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('question_pkid_seq', 1, false);


--
-- TOC entry 90 (OID 17037)
-- Name: test_status_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('test_status_pkid_seq', 1, false);


--
-- TOC entry 92 (OID 17042)
-- Name: _assignment_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('_assignment_pkid_seq', 655, true);


--
-- TOC entry 94 (OID 17094)
-- Name: registration_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('registration_pkid_seq', 278, true);


--
-- TOC entry 96 (OID 17101)
-- Name: qualification_code_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('qualification_code_pkid_seq', 1, false);


--
-- TOC entry 98 (OID 17108)
-- Name: advert_pkid_seq; Type: SEQUENCE SET; Schema: public; Owner: fnctlint
--

SELECT pg_catalog.setval ('advert_pkid_seq', 55, true);


--
-- TOC entry 26 (OID 17034)
-- Name: COLUMN wording.wording; Type: COMMENT; Schema: public; Owner: fnctlint
--

COMMENT ON COLUMN wording.wording IS 'The wording of question';


--
-- TOC entry 141 (OID 17072)
-- Name: FUNCTION countcustreports (integer); Type: COMMENT; Schema: public; Owner: fnctlint
--

COMMENT ON FUNCTION countcustreports (integer) IS 'public';


--
-- TOC entry 65 (OID 17116)
-- Name: COLUMN qre_type.name; Type: COMMENT; Schema: public; Owner: fnctlint
--

COMMENT ON COLUMN qre_type.name IS 'The type name';


--
-- TOC entry 68 (OID 17121)
-- Name: VIEW _v_assmts2_w_date; Type: COMMENT; Schema: public; Owner: fnctlint
--

COMMENT ON VIEW _v_assmts2_w_date IS 'Same as _v_assmts, with the additional column ''submitdate''. Workaround for not being able to add cols on existing view.';


