--
--	Synopsis:	This script creates the IPI postgres database for the assessment web-application.
--

---------------------------- [DB] ------------------------------------------------------
--DROP DATABASE fnctlint_ipi;
--CREATE DATABASE fnctlint_ipi;

--DROP USER fnctlint_ipiweb;
--CREATE USER fnctlint_ipiweb WITH ENCRYPTED PASSWORD '1P1w3b';
--GRANT ALL PRIVILEGES ON DATABASE fnctlint_ipi TO fnctlint_ipiweb;


-------------------------- [TABLES] ----------------------------------------------------
SELECT '-------------------------+++ TABLES +++ --------------------------------' AS _;
SELECT '----------------------- CREATE [Customer] ------------------------------' AS _;
DROP TABLE Customer CASCADE;
CREATE TABLE Customer (
	pkid 				serial NOT NULL,
	
	name 				varchar(50) UNIQUE NOT NULL,		-- name of customer (e.g. "Dot-Ellipses IT Solutions cc")
	credits 			int DEFAULT 0,							-- number of payd credits (for assigning tests to users) assigned to this customer
	code 				varchar(3) UNIQUE DEFAULT NULL,	-- 3-letter advert / company ref# pefix
	fkRootCust 		int DEFAULT -999,						-- reference to the highest department of the organization (if this is the highest dept, -999)
	fkParentCust 	int DEFAULT -999,						-- reference to the department directly above the current (if this is the highest dept, -999)
   
	PRIMARY KEY(pkid),
	FOREIGN KEY(fkRootCust) REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(fkParentCust) REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE
);
GRANT ALL PRIVILEGES ON Customer TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON customer_pkid_seq TO fnctlint_ipiweb;
\d Customer;
	

SELECT '----------------------- CREATE [UserLevel] ------------------------------' AS _;
DROP TABLE UserLevel CASCADE;
CREATE TABLE UserLevel (
	pkid			serial NOT NULL,
	lvlname		varchar(15),
        
	PRIMARY KEY(pkid)
);
GRANT ALL PRIVILEGES ON UserLevel TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON userlevel_pkid_seq TO fnctlint_ipiweb;
\d UserLevel;


SELECT '----------------------- CREATE [Users] ------------------------------' AS _;
DROP TABLE Users CASCADE;
CREATE TABLE Users (
	pkid			serial NOT NULL,
	fkCustID		int NOT NULL,							-- 'customer' who is, or 'employs' this user
	fkLevel		int NOT NULL,							-- UserLevel of this user
	
	username		varchar(20) NOT NULL UNIQUE,		-- user name
	password		varchar(40) NOT NULL,				-- password

	initial		char(1),									-- single char middle initial
	fname			varchar(20),							-- first name
	lname			varchar(20),							-- last name
	title			varchar(5),								-- abbreviated title
	idnum			varchar(16),							-- national ID number
	compRef		varchar(20),							-- company reference code/number (if applicable)
	
	telH			varchar(15),							-- Home Phone number (if applicable)
	telW			varchar(15),							-- Work Phone number ("")
	fax			varchar(15),							-- Fax number
	cell			varchar(15),							-- Cellular number
	email			varchar(35),							-- email address
	website		varchar(50),							-- website address	

	PRIMARY KEY(pkid),
	FOREIGN KEY(fkCustID) REFERENCES Customer ON UPDATE RESTRICT ON DELETE CASCADE,
	FOREIGN KEY(fkLevel) REFERENCES UserLevel ON UPDATE RESTRICT ON DELETE CASCADE
);
GRANT ALL PRIVILEGES ON Users TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON users_pkid_seq TO fnctlint_ipiweb;
\d Users;

SELECT '----------------------- CREATE [Registration] ------------------------------' AS _;
DROP TABLE Registration CASCADE;
CREATE TABLE Registration (
	pkid			serial NOT NULL,

	username		varchar(20) NOT NULL UNIQUE,		-- user name
	password		varchar(40) NOT NULL,				-- password

	initial		char(1),									-- single char middle initial
	fname			varchar(20),							-- first name
	lname			varchar(20),							-- last name
	title			varchar(5),								-- abbreviated title
	idnum			varchar(16),							-- national ID number
	compRef		varchar(20),							-- company/advert reference code/number (if applicable)
	
	telH			varchar(15),							-- Home Phone number (if applicable)
	telW			varchar(15),							-- Work Phone number ("")
	fax			varchar(15),							-- Fax number
	cell			varchar(15),							-- Cellular number
	email			varchar(35),							-- email address
	
	addrH1		varchar(45),							-- home address line1
	addrH2		varchar(45),							-- home address line2
	addrH3		varchar(45),							-- home address line3
	addrH4		varchar(4),								-- home address area code
	
	addrP1		varchar(45),							-- postal address line1
	addrP2		varchar(45),							-- postal address line2
	addrP3		varchar(45),							-- postal address line3
	addrP4		varchar(4),								-- postal address area code
	
	hq				int,										-- qualification code (non-referntial fk to Qualification)
	
	emailOK		boolean DEFAULT FALSE,				-- registration status
																-- 	FALSE: initial (pending email confirmation - by user)
																-- 	TRUE:  initial (pending payment confirmation - by admin)
																	
	submittime	timestamp DEFAULT now(),			-- timestamp of when user submitted registration

	PRIMARY KEY(pkid)
);
GRANT ALL PRIVILEGES ON Registration TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON registration_pkid_seq TO fnctlint_ipiweb;
\d Registration;


SELECT '-------------------- CREATE [QUALIFICATION_CODE] ----------------------------' AS _;
DROP TABLE QUALIFICATION_CODE CASCADE;
CREATE TABLE QUALIFICATION_CODE (
	pkid		 serial NOT NULL,
	name		 varchar(127),
	
	PRIMARY KEY(pkid)
);
GRANT ALL PRIVILEGES ON QUALIFICATION_CODE TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON qualification_code_pkid_seq TO fnctlint_ipiweb;
\d QUALIFICATION_CODE;


SELECT '----------------------- CREATE [Qualification] ------------------------------' AS _;
DROP TABLE Qualification;
CREATE TABLE Qualification (
	fkUsrID	 int NOT NULL,
	fkQCode	 int NOT NULL,
	
	FOREIGN KEY(fkUsrID) REFERENCES Users ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(fkQCode) REFERENCES QUALIFICATION_CODE ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT ALL PRIVILEGES ON Qualification TO fnctlint_ipiweb;
--GRANT ALL PRIVILEGES ON qualification_pkid_seq TO fnctlint_ipiweb;
\d Qualification;


SELECT '------------------------------ [ADDRESSTYPE] ------------------------------' AS _;
-- list of constants (home, work, post, etc.)
DROP TABLE ADDRESSTYPE CASCADE;
CREATE TABLE ADDRESSTYPE (
	pkid			serial NOT NULL,
	typeDescr	varchar(10) NOT NULL,				-- user to whom this address belongs
	
	PRIMARY KEY(pkid)
);
GRANT ALL PRIVILEGES ON ADDRESSTYPE TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON addresstype_pkid_seq TO fnctlint_ipiweb;
\d ADDRESSTYPE;


SELECT '------------------------------ [Address] ------------------------------' AS _;
-- an [Address] belongs to a [User]
DROP TABLE Address CASCADE;
CREATE TABLE Address (
--	pkid			serial NOT NULL,
	fkUserID		int NOT NULL,							-- user to whom this address belongs
	fkAddrType	int NOT NULL,							-- home, work, premesis, post
	
	descr			varchar(45),							-- 'primary location 1'
	
	line1			varchar(45),							-- Address line 1
	line2			varchar(45),							-- Address line 2
	line3			varchar(45),							-- Address line 3
	areaCode		varchar(4),								-- Address area code
	
--	PRIMARY KEY(pkid),
	FOREIGN KEY(fkUserID) REFERENCES Users ON UPDATE RESTRICT ON DELETE CASCADE,
	FOREIGN KEY(fkAddrType) REFERENCES AddressType ON UPDATE RESTRICT ON DELETE CASCADE
);
GRANT ALL PRIVILEGES ON Address TO fnctlint_ipiweb;
--GRANT ALL PRIVILEGES ON address_pkid_seq TO fnctlint_ipiweb;
\d Address;


SELECT '----------------------- CREATE [Advert] ------------------------------' AS _;
DROP TABLE Advert CASCADE;
CREATE TABLE Advert (
	pkid 			serial NOT NULL,
	fkCustID 	int NOT NULL,							-- 'customer' who owns this advert
	
	descr 		varchar(127),							-- short description of advert
	issueDate 	date,										-- date on which advert was/will be issued in media

	PRIMARY KEY(pkid),
	FOREIGN KEY(fkCustID) REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE
);
GRANT ALL PRIVILEGES ON Advert TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON advert_pkid_seq TO fnctlint_ipiweb;
\d Advert;


SELECT '------------------------------ [QRE_TYPE] ------------------------------' AS _;
-- list of constants (FA, CA, JP, ..)
DROP TABLE QRE_TYPE CASCADE;
CREATE TABLE QRE_TYPE (
	pkid 			int NOT NULL,
	
	code 			char(2) NOT NULL,						-- 2-letter code
	name 			varchar(20) NOT NULL,				-- name
	
	PRIMARY KEY(pkid)
);
GRANT ALL PRIVILEGES ON QRE_TYPE TO fnctlint_ipiweb;
\d QRE_TYPE;


SELECT '------------------------------ [Questionaire] ------------------------------' AS _;
-- a [Questionaire] is a compiled set of [Super_Construct]`s that can be assigned to [Users] via an [Assignment]
DROP TABLE Questionaire CASCADE;
CREATE TABLE Questionaire (
	pkid			serial NOT NULL,
	
	name			varchar(30) UNIQUE NOT NULL,		-- name for this questionaire
	descr			varchar(250),							-- description of this q`re
	
	qWording		int DEFAULT 0,							-- the [QWording] to use for [Questions]
																--    NOTE:non-referential; handle in implementation
																
	fkTypeID		int DEFAULT -1,						-- *--> [qre_type]
	
	PRIMARY KEY(pkid),
	FOREIGN KEY(fkTypeID) REFERENCES QRE_TYPE ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT ALL PRIVILEGES ON Questionaire TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON questionaire_pkid_seq TO fnctlint_ipiweb;
\d Questionaire;


SELECT '------------------------------ [Super_Construct] ------------------------------' AS _;
-- a [Super_Construct] is a set of [Construct]`s 
DROP TABLE Super_Construct CASCADE;
CREATE TABLE Super_Construct (
	pkid			serial NOT NULL,
	
	code			char(1) NOT NULL,						-- Section code (e.g. A, B, C, ..., K)
	name			varchar(30) NOT NULL,				-- name of this Superconstruct
	descr			varchar(250),							-- textual description of the Superconstruct
	
	PRIMARY KEY(pkid)
);
GRANT ALL PRIVILEGES ON Super_Construct TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON super_construct_pkid_seq TO fnctlint_ipiweb;
\d Super_Construct;


SELECT '------------------------------ |[_Q_SC_Entry]| ------------------------------' AS _;
-- Associative entity between [Questionaire] and [Super_Construct], indicating the constituent set of SC`s in the Questionaire.
DROP TABLE _Q_SC_Entry CASCADE;
CREATE TABLE _Q_SC_Entry (
	fkQ			int NOT NULL,							-- reference to [Questionaire]
	fkSC			int NOT NULL,							-- reference to [Super_Construct]
	
	PRIMARY KEY(fkQ, fkSC),
	FOREIGN KEY(fkQ) REFERENCES Questionaire ON UPDATE RESTRICT ON DELETE RESTRICT,
	FOREIGN KEY(fkSC) REFERENCES Super_Construct ON UPDATE RESTRICT ON DELETE RESTRICT
);
GRANT ALL PRIVILEGES ON _Q_SC_Entry TO fnctlint_ipiweb;
\d _Q_SC_Entry;


SELECT '----------------------------------- [Construct] ------------------------------' AS _;
-- a [Construct] contains a set of [Question]`s, and is part of a [Super_Construct]
DROP TABLE Construct CASCADE;
CREATE TABLE Construct (
	pkid			serial NOT NULL,
	
	fkSC			int NOT NULL,							-- reference to the Super_Construct under which this constuct is grouped
	
	name			varchar(40) NOT NULL,				-- name for this Construct
	descr			varchar(250),							-- description for this construct
	isOptional	boolean DEFAULT FALSE,				-- whether or not this Construct may be excluded when its [Super_Construct]
																--		is part of a [Questionaire], via |[_Q_SC_Entry]|
	isPositive	boolean DEFAULT FALSE,				-- whether or not this Costruct is Positive
	isNeutral	boolean DEFAULT FALSE,				-- whether or not this Costruct is Neutral (neither Positive nor Negative)

	PRIMARY KEY(pkid),
	FOREIGN KEY(fkSC) REFERENCES Super_Construct ON UPDATE RESTRICT ON DELETE CASCADE
);
GRANT ALL PRIVILEGES ON Construct TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON construct_pkid_seq TO fnctlint_ipiweb;
\d Construct;


SELECT '------------------------------ |[_QSCE_C_Exclude]| ------------------------------' AS _;
-- associative entity between |[_Q_SC_Entry]| and [Construct], indicating specific constructs excluded from compiled questionaires.
DROP TABLE _QSCE_C_Exclude CASCADE;
CREATE TABLE _QSCE_C_Exclude (
	fkQ			int NOT NULL,							-- reference to [_Q_SC_Entry].fkQ	}\__(PK)
	fkSC			int NOT NULL,							-- reference to [_Q_SC_Entry].fkSC	}/
	fkC			int NOT NULL,							-- reference to the [Construct] that is excluded
	
	PRIMARY KEY(fkQ, fkSC, fkC),
	FOREIGN KEY(fkQ, fkSC)	REFERENCES _Q_SC_Entry	ON UPDATE RESTRICT ON DELETE RESTRICT,
	FOREIGN KEY(fkC)			REFERENCES Construct		ON UPDATE RESTRICT ON DELETE RESTRICT
);
GRANT ALL PRIVILEGES ON _QSCE_C_Exclude TO fnctlint_ipiweb;
\d _QSCE_C_Exclude;


SELECT '------------------------------- [Question] ------------------------------------' AS _;
-- a set of [Question]`s belongs to a [Construct], has a range and can be inverted; a [Question] can have alternative wordings ([Wording]),
-- which is why the wording is not stored in this relation.
DROP TABLE Question CASCADE;
CREATE TABLE Question (
	pkid			serial NOT NULL,
	
	fkC			int NOT NULL,							-- reference to the [Construct] which this Question is part of.
	
	cOrder		int2 NOT NULL,							-- ordered position this question occupies within its [Construct]
	isInverted	boolean DEFAULT FALSE,				-- whether this question uses an inverted scale ('negative questions')
--	range			int2 DEFAULT 5,						-- range of answers allowed for this question (aka 'K':number of response catagories), e.g. 5 (1..5)
	
	PRIMARY KEY(pkid),
	FOREIGN KEY(fkC) REFERENCES Construct ON UPDATE RESTRICT ON DELETE CASCADE
);
GRANT ALL PRIVILEGES ON Question TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON question_pkid_seq TO fnctlint_ipiweb;
\d Question;


SELECT '----------------------------- [Wording] -------------------------------------' AS _;
-- this relation provides the actual [Wording] for a [Question]. A [Question] can have more than one [Wording].
DROP TABLE Wording CASCADE;
CREATE TABLE Wording (
	fkQn			int NOT NULL,							-- reference to [Question]
	
	alt			int2 NOT NULL DEFAULT 0,			-- alternative wording number (0, 1, .. for same question)
	wording		varchar(110),							-- the actual [Question]-sentence
	
	FOREIGN KEY(fkQn) REFERENCES Question ON UPDATE RESTRICT ON DELETE CASCADE
);
GRANT ALL PRIVILEGES ON Wording TO fnctlint_ipiweb;
\d Wording;


SELECT '---------------------------- [TEST_STATUS] -----------------------------------' AS _;
-- list of constants (completed, busy, canceled, not started)
DROP TABLE TEST_STATUS CASCADE;
CREATE TABLE TEST_STATUS (
	pkid			serial NOT NULL,
	
	descr			varchar(15),							-- status description
	
	PRIMARY KEY(pkid)
);
GRANT ALL PRIVILEGES ON TEST_STATUS TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON test_status_pkid_seq TO fnctlint_ipiweb;
\d TEST_STATUS;


SELECT '---------------------------- |[_Assignment]| ------------------------------' AS _;
-- assigns a compiled [Questionaire] to a [User]
DROP TABLE _Assignment CASCADE;
CREATE TABLE _Assignment (
	pkid			serial NOT NULL,
	
	fkUser		int NOT NULL,							-- reference to the [User] to whom the [Questionaire] is assigned
	fkQ			int NOT NULL,							-- reference to the [Questionaire] that is assigned
	fkTstStatus	int NOT NULL DEFAULT 0,				-- the [TEST_STATUS] of this assignment
	submitTime	timestamp DEFAULT NULL,				-- point in time when the final answer for this assignment (or subset thereof) was submitted
	
	PRIMARY KEY(pkid),
	UNIQUE (fkUser, fkQ),
	FOREIGN KEY(fkUser)			REFERENCES Users			ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(fkQ)				REFERENCES Questionaire	ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(fkTstStatus)	REFERENCES TEST_STATUS	ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT ALL PRIVILEGES ON _Assignment TO fnctlint_ipiweb;
GRANT ALL PRIVILEGES ON _assignment_pkid_seq TO fnctlint_ipiweb;
\d _Assignment;


SELECT '------------------------------ |[_Answer]| ------------------------------' AS _;
-- weak entity associating [Assignment] with [Question], providing info on answers to particular questions in a 
-- questionaire ([_Assignment]).
DROP TABLE _Answer CASCADE;
CREATE TABLE _Answer (
--	pkid			serial NOT NULL
	fkQn			int NOT NULL,							-- reference to the [Question] to which this is an answer
	fkAssmt		int NOT NULL,							-- reference to the [Assignment] which the [Question] was part of
	
	answer		int2 NOT NULL,							-- the answer (within [Question].range) the user gave to the [Question]
	timeTaken	int NOT NULL,							-- time (in milliseconds) it took the user to answer this question
	nDoubted		int2 NOT NULL,							-- number of times the user changed his/her answer
	splitSet		int2 NOT NULL DEFAULT 1,			-- [Questionaire]`s with more than #X (350) questions must be split up into
																--   2 or more sets with an equal number of questions, each of which cannot be
																--   completed within less than #Y (45) minutes from eachother.
																--   'splitset' indicates which set this question was answered in.
	PRIMARY KEY(fkQn, fkAssmt),
	FOREIGN KEY(fkQn) REFERENCES Question ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(fkAssmt) REFERENCES _Assignment ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT ALL PRIVILEGES ON _Answer TO fnctlint_ipiweb;
-- GRANT ALL PRIVILEGES ON _answer_pkid_seq TO fnctlint_ipiweb;
\d _Answer;


---------------------------- [VIEWS] ----------------------------------------------------

SELECT '----------------------- +++ VIEWS +++ ------------------------------' AS _;
SELECT '-------------------------- {UserList} --------------------------------' AS _;
--DROP VIEW _v_UserList CASCADE;
CREATE VIEW _v_UserList AS 
	SELECT
		pkid as usrid, 
		fkCustID as custid,
		username,
		initial,
		fname,
		lname,
		title,
		idnum,
		compRef,	
		telH, 
		telW,
		fax,
		cell,
		email
	FROM Users
	WHERE fkLevel = 3;
GRANT ALL PRIVILEGES ON _v_UserList TO fnctlint_ipiweb;
--GRANT ALL PRIVILEGES ON _v_UserList TO fnctlint_export;
\d _v_UserList;

SELECT '-------------------------- {CustList} --------------------------------' AS _;
--DROP VIEW _v_CustList CASCADE;
CREATE VIEW _v_CustList AS 
	SELECT pkid as custid, name FROM Customer;
GRANT ALL PRIVILEGES ON _v_CustList TO fnctlint_ipiweb;
--GRANT SELECT ON _v_CustList TO fnctlint_export;
\d _v_CustList;

SELECT '-------------------------- {SConst} --------------------------------' AS _;
--DROP VIEW _v_SConst CASCADE;
CREATE VIEW _v_SConst AS 
	SELECT
		pkid as scid,
		code,
		name
	FROM Super_Construct;
GRANT ALL PRIVILEGES ON _v_SConst TO fnctlint_ipiweb;
--GRANT SELECT ON _v_SConst TO fnctlint_export;
\d _v_SConst;

SELECT '-------------------------- {Const} --------------------------------' AS _;
--DROP VIEW _v_Const CASCADE;
CREATE VIEW _v_Const AS 
	SELECT
		pkid as cid,
		fkSC as scid,
		name, 
		descr, 
		isOptional,
		isPositive, 
		isNeutral
	FROM Construct;
GRANT ALL PRIVILEGES ON _v_Const TO fnctlint_ipiweb;
--GRANT SELECT ON _v_Const TO fnctlint_export;
\d _v_Const;

SELECT '-------------------------- {Qre} --------------------------------' AS _;
--DROP VIEW _v_Qre CASCADE;
CREATE VIEW _v_Qre AS 
	SELECT
		pkid as qreid,
		name,
		descr
	FROM Questionaire;
GRANT ALL PRIVILEGES ON _v_Qre TO fnctlint_ipiweb;
--GRANT SELECT ON _v_Qre TO fnctlint_export;
\d _v_Qre;

SELECT '-------------------------- {Assmts} --------------------------------' AS _;
--DROP VIEW _v_Assmts CASCADE;
CREATE VIEW _v_Assmts AS 
	SELECT a.pkid AS assmt_num, q.pkid AS qre_num, q.name AS qre, u.username, t.descr AS status 
	FROM _assignment a, questionaire q, users u, test_status t 
	WHERE ((a.fkuser = u.pkid) AND (a.fkq = q.pkid) AND (t.pkid = a.fktststatus))
	ORDER BY u.username;
GRANT ALL PRIVILEGES ON _v_Assmts TO fnctlint_ipiweb;
\d _v_Assmts;

SELECT '-------------------------- {Report} --------------------------------' AS _;
--DROP VIEW _v_Report CASCADE;
CREATE VIEW _v_Report AS 
	SELECT 
		a.pkid as assmtID, a.fkUser as usrID, a.fkQ as qreID, q.name as qname, 
		to_char(a.submittime, 'Dy, DD Mon. HH24:MI') as  submittime, 
		c.pkid as custID, c.name as custName, u.username, u.title, u.fname, u.initial, u.lname 
	FROM _assignment a, users u, customer c, Questionaire q
	WHERE 
		a.fkuser=u.pkid AND a.fkQ=q.pkid AND u.fkcustid=c.pkid AND fktstStatus=2 
	ORDER BY c.name, username;
GRANT ALL PRIVILEGES ON _v_Report TO fnctlint_ipiweb;
--GRANT SELECT ON _v_Report TO fnctlint_export;
\d _v_Report;

SELECT '-------------------------- {RepAnswerList} --------------------------------' AS _;
--DROP VIEW _v_RepAnswerList CASCADE;
CREATE VIEW _v_RepAnswerList AS 
	SELECT 
		ans.fkassmt as assmtID, qn.fkc as constID, ans.answer, ans.timetaken, ans.ndoubted, qn.isinverted
	FROM _Answer ans, Question qn 
	WHERE ans.fkqn = qn.pkid 
	ORDER BY ans.fkassmt, qn.fkc;
GRANT ALL PRIVILEGES ON _v_RepAnswerList TO fnctlint_ipiweb;
--GRANT SELECT ON _v_RepAnswerList TO fnctlint_export;
\d _v_RepAnswerList;


--------------------------- [STORED PROCEDURES] -----------------------------------------
SELECT '------------------ +++ STORED PROCEDURES +++ ------------------------' AS _;
SELECT '---------------------- .countReports() ------------------------------' AS _;
--DROP FUNCTION countReports();
CREATE OR REPLACE FUNCTION countReports() RETURNS bigint AS $$ 
	SELECT COUNT(*) FROM _v_Report; 
$$ LANGUAGE SQL;
\df countReports;


SELECT '---------------------- .countCustReports() ---------------------------' AS _;
--DROP FUNCTION countCustReports(integer);
CREATE OR REPLACE FUNCTION countCustReports(integer) RETURNS bigint AS $$ 
	SELECT COUNT(*) 
	FROM (SELECT * FROM _v_Report WHERE custID = $1) as foo; 
$$ LANGUAGE SQL;
\df countCustReports;


SELECT '---------------------- .countRepAnswers() ------------------------------' AS _;
-- arg1: assmt-id
-- returns: number of answers in the assignment
--DROP FUNCTION countRepAnswers(integer);
CREATE OR REPLACE FUNCTION countRepAnswers(integer) RETURNS bigint AS $$ 
	SELECT COUNT(*) FROM _v_RepAnswerList WHERE assmtID = $1; 
$$ LANGUAGE SQL;
\df countRepAnswers;


SELECT '---------------------- .getReports() -------------------------' AS _;
--DROP FUNCTION getReports();
CREATE OR REPLACE FUNCTION getReports() RETURNS SETOF _v_Report AS $$ 
	SELECT * FROM _v_Report; 
$$ LANGUAGE SQL;
\df getReports;


SELECT '---------------------- .getReportsByCustID() -------------------------' AS _;
--DROP FUNCTION getReportsByCustID(integer);
CREATE OR REPLACE FUNCTION getReportsByCustID(integer) RETURNS SETOF _v_Report AS $$ 
	SELECT * FROM _v_Report WHERE custID = $1; 
$$ LANGUAGE SQL;
\df getReportsByCustID;


SELECT '---------------------- .getReportByAssmtID() -------------------------' AS _;
--DROP FUNCTION getReportByAssmtID(integer);
CREATE OR REPLACE FUNCTION getReportByAssmtID(integer) RETURNS SETOF _v_Report AS $$ 
	SELECT * FROM _v_Report WHERE assmtID = $1; 
$$ LANGUAGE SQL;
\df getReportByAssmtID;


SELECT '---------------------- .getRepAnswersByAssmtID() -------------------------' AS _;
--DROP FUNCTION getRepAnswersByAssmtID(integer);
CREATE OR REPLACE FUNCTION getRepAnswersByAssmtID(integer) RETURNS SETOF _v_RepAnswerList AS $$ 
	SELECT * FROM _v_RepAnswerList WHERE assmtID = $1; 
$$ LANGUAGE SQL;
\df getRepAnswersByAssmtID;


SELECT '---------------------- .getQreQnIDs() -------------------------' AS _;
-- arg1: qre-pkid
-- returns: pkid`s of questions in given qre
DROP FUNCTION getQreQnIDs(integer);
CREATE OR REPLACE FUNCTION getQreQnIDs(integer) RETURNS SETOF integer AS $$
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
$$ LANGUAGE SQL;
\df getQreQnIDs;


SELECT '---------------------- .resetAssmt() -------------------------' AS _;
-- arg1: assmt-pkid
--DROP FUNCTION resetAssmt(integer);
CREATE OR REPLACE FUNCTION resetAssmt(integer) RETURNS integer AS $$
	DELETE FROM _Answer WHERE fkAssmt = $1;
	UPDATE _Assignment 
	SET fkTstStatus = 0, submittime = NULL
	WHERE pkid = $1;
	SELECT 1;
$$ LANGUAGE SQL;
\df resetAssmt;


SELECT '---------------------- .getCustAdCount() -------------------------' AS _;
-- count responses for a given advert, i.e. count users from [Registration] and [Users] with approx. the compRef of $1||$2
-- arg1: string 3-letter customer code
-- arg2: advert pkid
--DROP FUNCTION getCustAdCount(varchar, integer);
CREATE OR REPLACE FUNCTION getCustAdCount(varchar, integer) RETURNS bigint AS $$ 
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
$$ LANGUAGE SQL;
\df getCustAdCount;


SELECT '---------------------- .getOrgUser() -------------------------' AS _;
-- retrieves the org-user (lvl 2) for the given organization ([customer])
-- arg1: custid
--DROP FUNCTION getOrgUser(integer);
CREATE OR REPLACE FUNCTION getOrgUser(integer) RETURNS SETOF Users AS $$ 
	SELECT * FROM Users 
	WHERE fkCustID = $1 AND fkLevel=2
$$ LANGUAGE SQL;
\df getOrgUser;


SELECT '---------------------- .delAddr() -------------------------' AS _;
-- delete an address with corresponding userid & type
-- arg1: userid
-- arg2: typeid
--DROP FUNCTION delAddr(integer, integer);
CREATE OR REPLACE FUNCTION delAddr(integer, integer) RETURNS integer AS $$ 
	DELETE FROM Address 
	WHERE fkUserID = $1 AND fkAddrType = $2;
	SELECT 1;
$$ LANGUAGE SQL;
\df delAddr;

SELECT '---------------------- .countParticipants() -------------------------' AS _;
-- count number of users assigned to a qre
-- arg1: qreid
--DROP FUNCTION countParticipants(integer);
CREATE OR REPLACE FUNCTION countParticipants(integer) RETURNS bigint AS $$ 
	SELECT COUNT(*) FROM _Assignment a, Users u 
	WHERE fkQ = $1 AND fkUser=u.pkid AND u.fkLevel=3;
$$ LANGUAGE SQL;
\df countParticipants;

SELECT '---------------------- .countParticipantsByCustID() -------------------------' AS _;
-- count number of users assigned to a qre for a specific customer
-- arg1: qreid
-- arg2: custID
--DROP FUNCTION countParticipantsByCustID(integer, integer);
CREATE OR REPLACE FUNCTION countParticipantsByCustID(integer, integer) RETURNS bigint AS $$ 
	SELECT COUNT(*) FROM _Assignment a, Users u 
	WHERE fkQ = $1 AND u.fkCustID = $2 AND fkUser=u.pkid AND u.fkLevel=3;
$$ LANGUAGE SQL;
\df countParticipantsByCustID;

SELECT '---------------------- .countUserAssmts() -------------------------' AS _;
-- count number of questionaires assigned to a user
-- arg1: user pkid
--DROP FUNCTION countUserAssmts(integer);
CREATE OR REPLACE FUNCTION countUserAssmts(integer) RETURNS bigint AS $$ 
	SELECT COUNT(*) FROM _Assignment a 
	WHERE fkUser = $1;
$$ LANGUAGE SQL;
\df countUserAssmts;

\d

---------------------------- [DATA] ----------------------------------------------------
SELECT '------------------ +++ DATA +++ ------------------------' AS _;
COPY Customer						FROM '/home/psnel/Projects/klient/IPI/db/data/CUSTOMER.dat';
SELECT '->' AS Customer, * 	FROM Customer;

COPY USERLEVEL						FROM '/home/psnel/Projects/klient/IPI/db/data/USERLEVEL.dat';
SELECT '->' AS UserLevel, *	FROM USERLEVEL;

COPY Users							FROM '/home/psnel/Projects/klient/IPI/db/data/USERS.dat';
SELECT '->' AS Users, * 		FROM Users;

COPY ADDRESSTYPE					FROM '/home/psnel/Projects/klient/IPI/db/data/ADDRESSTYPE.dat';
SELECT '->' AS AddressType, * FROM ADDRESSTYPE;

COPY TEST_STATUS					FROM '/home/psnel/Projects/klient/IPI/db/data/TEST_STATUS.dat';
SELECT '->' AS TEST_STATUS, * FROM TEST_STATUS;

COPY QUALIFICATION_CODE			FROM '/home/psnel/Projects/klient/IPI/db/data/QUALIFICATION_CODE.dat';
SELECT '->' AS QUALIFICATION_CODE, * FROM QUALIFICATION_CODE;

COPY QRE_TYPE						FROM '/home/psnel/Projects/klient/IPI/db/data/QRE_TYPE.dat';
SELECT '->' AS QRE_TYPE, * 	FROM QRE_TYPE;

-- Init sequence pointers
SELECT nextval('customer_pkid_seq');SELECT nextval('customer_pkid_seq');
SELECT nextval('users_pkid_seq');SELECT nextval('users_pkid_seq');SELECT nextval('users_pkid_seq');
