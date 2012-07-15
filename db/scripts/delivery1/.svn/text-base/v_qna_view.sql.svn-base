CREATE VIEW _v_qna AS
    SELECT ans.fkassmt AS assignment_no, qn.fkc AS construct_no, ans.fkqn AS question_no, w.wording AS question, ans.answer FROM _answer ans, question qn, wording w WHERE (((ans.fkqn = qn.pkid) AND (w.fkqn = qn.pkid)) AND (w.alt = 0)) ORDER BY ans.fkassmt, ans.fkqn;


--
-- TOC entry 70 (OID 17126)
-- Name: _v_qna; Type: ACL; Schema: public; Owner: fnctlint
--

REVOKE ALL ON TABLE _v_qna FROM PUBLIC;
GRANT SELECT ON TABLE _v_qna TO fnctlint_export;