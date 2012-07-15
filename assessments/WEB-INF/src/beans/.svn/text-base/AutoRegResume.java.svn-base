/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.ResultSet;
import org.apache.log4j.Logger;

/**
 *
 * @author Administrator
 */
public class AutoRegResume extends Resume
{

    @Override
    public void load(String pkid) throws Exception
    {
        load(pkid, false);
    }

    @Override
    public void load(String pkid, boolean extended) throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = "SELECT * FROM registrationcvdetail WHERE pkid=" + pkid;
        ResultSet rs = null;

        try
        {
            rs = db.executeQuery(sql);
            if (rs.next())
            {
                setPKID(pkid);
                setTradeQualifications(rs.getString("tradequalifications"));
                setMarketSegmentFKID(rs.getString("marketsegment_fkid"));
                setCareerFKID(rs.getString("career_fkid"));
                setEmploymentStatusFKID(rs.getString("employmentstatus_fkid"));
                setCurrentEmploymentYears(rs.getInt("currentemploymentyears"));
                setCurrentEmploymentMonths(rs.getInt("currentemploymentmonths"));
                setComments(rs.getString("comments"));
                setHobbies(rs.getString("hobbies"));
                setSkillsSummary(rs.getString("skillssummary"));
                setQualificationDetails(rs.getString("qualificationdetails"));
                setSalaryRequired(rs.getString("salaryrequired"));
                setNoticePeriod(rs.getString("noticeperiod"));

                rs.close();
                rs = null;

                if (extended)
                {
                    loadReferences(db);
                }
            }
        }
        finally
        {
            if (rs != null)
            {
                rs.close();
            }

            db.close();
        }
    }

    @Override
    public void loadReferences(DBProxy db) throws Exception
    {
        String sql = "SELECT cvreference_fkid FROM registrationcvreferences WHERE cvdetail_fkid=" + getPKID();
        ResultSet rs = null;

        try
        {
            rs = db.executeQuery(sql);

            while (rs.next())
            {
                AutoRegResumeReference reference = new AutoRegResumeReference();
                reference.load(rs.getString(1), db);
                references.add(reference);
            }
        }
        finally
        {
            if (rs != null)
            {
                rs.close();
            }
        }
    }

    // This method is very specific. It assumes no primary key.
    @Override
    public void save(String userId, DBProxy db) throws Exception
    {
        String sql = "SELECT nextval('registrationcvdetail_pkid_seq')";
        String resumeId = null;
        ResultSet rs = null;

        try
        {
            Logger log = Logger.getLogger(AutoRegResume.class);
            log.info("Saving the Resume");

            rs = db.executeQuery(sql);
            if (rs.next())
            {
                resumeId = rs.getString("nextval");
            }

            log.info("Resume ID = " + resumeId);

            if (resumeId == null)
            {
                throw new Exception("Failed to get the resume ID");
            }
            else
            {
                setPKID(resumeId);
            }

            sql = "INSERT INTO registrationcvdetail (pkid, tradequalifications, marketsegment_fkid, career_fkid, "
                  + "employmentstatus_fkid, currentemploymentyears, currentemploymentmonths, comments, hobbies, "
                  + "skillssummary, qualificationdetails, salaryrequired, noticeperiod) "
                  + "VALUES ("
                  + resumeId + ", '" + getTradeQualifications() + "', " + getMarketSegmentFKID() + ", "
                  + getCareerFKID() + ", " + getEmploymentStatusFKID() + ", " + getCurrentEmploymentYears() + ", "
                  + getCurrentEmploymentMonths() + ", '" + getComments() + "', '" + getHobbies() + "', '"
                  + getSkillsSummary() +"', '" + getQualificationDetails() +"', '" + getSalaryRequired()
                  + "', '" + getNoticePeriod() + "')";

            db.executeNonQuery(sql);

            if (hasReferences())
            {
                saveReferences(db);
            }
        }
        finally
        {
            if (rs != null)
            {
                rs.close();
            }
        }
    }

    // This method is very specific. It assumes user activation.
    @Override
    public void save(DBProxy db) throws Exception
    {
        String sql = "INSERT INTO usercvdetail (pkid, tradequalifications, marketsegment_fkid, career_fkid, "
                     + "employmentstatus_fkid, currentemploymentyears, currentemploymentmonths, comments, hobbies, "
                     + "skillssummary, qualificationdetails, salaryrequired, noticeperiod) "
                     + "VALUES ("
                     + getPKID() + ", '" + getTradeQualifications() + "', " + getMarketSegmentFKID() + ", "
                     + getCareerFKID() + ", " + getEmploymentStatusFKID() + ", " + getCurrentEmploymentYears() + ", "
                     + getCurrentEmploymentMonths() + ", '" + getComments() + "', '" + getHobbies() + "', "
                     + "'" + getSkillsSummary() + "', '" + getQualificationDetails() +"', '" + getSalaryRequired()
                     + "', '" + getNoticePeriod() + "')";

        Logger log = Logger.getLogger(AutoRegResume.class);
        log.info("Commiting the Resume, PKID: " + getPKID());

        db.executeNonQuery(sql);

        if (hasReferences())
        {
            saveReferencesToCVDetail(db);
        }
    }

    @Override
    public void saveReferences(DBProxy db) throws Exception
    {
        ResumeReference[] referenceArray = getReferences();

        for (int i = 0; i < referenceArray.length; i++)
        {
            referenceArray[i].save(getPKID(), db);
        }
    }

    public void saveReferencesToCVDetail(DBProxy db) throws Exception
    {
        ResumeReference[] referenceArray = getReferences();

        for (int i = 0; i < referenceArray.length; i++)
        {
            AutoRegResumeReference reference = (AutoRegResumeReference) referenceArray[i];
            reference.saveToCVDetailReference(getPKID(), db);
        }
    }

    @Override
    public void delete(DBProxy db) throws Exception
    {
        String sql = "DELETE FROM registrationcvdetail WHERE pkid=" + getPKID();
        db.executeNonQuery(sql);

        if (hasReferences())
        {
            ResumeReference[] referenceArray = getReferences();

            for (int i = 0; i < referenceArray.length; i++)
            {
                referenceArray[i].delete(db);
            }
        }
    }
}
