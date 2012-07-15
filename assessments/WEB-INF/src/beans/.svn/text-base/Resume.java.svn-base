/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Vector;
import org.apache.log4j.Logger;

/**
 *
 * @author m swart
 */
public class Resume
{

    protected String pkid;
    // In the UI this is called skills qualifications
    protected String tradequalifications;
    protected String skillssummary;
    protected String qualificationdetails;
    protected String salaryrequired;
    protected String noticeperiod;
    protected String marketsegment_fkid;
    protected String career_fkid;
    protected String employmentstatus_fkid;
    protected int currentemploymentyears;
    protected int currentemploymentmonths;
    protected String comments;
    protected String hobbies;
    protected Vector references = new Vector();

    public String getCareerFKID()
    {
        return career_fkid;
    }

    public String getCareerName() throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = "SELECT name FROM career WHERE pkid=" + getCareerFKID();
        String name = "";

        try
        {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next())
            {
                name = rs.getString(1);
            }
        }
        finally
        {
            db.close();
        }

        return name;
    }

    public void setCareerFKID(String career_fkid)
    {
        this.career_fkid = career_fkid;
    }

    public String getComments()
    {
        return comments;
    }

    public void setComments(String comments)
    {
        this.comments = comments;
    }

    public void setSkillsSummary(String summary)
    {
        this.skillssummary = summary;
    }

    public String getSkillsSummary()
    {
        return this.skillssummary;
    }

    public void setNoticePeriod(String period)
    {
        this.noticeperiod = period;
    }

    public String getNoticePeriod()
    {
        return this.noticeperiod;
    }

    public void setQualificationDetails(String details)
    {
        this.qualificationdetails = details;
    }

    public String getQualificationDetails()
    {
        return this.qualificationdetails;
    }

    public void setSalaryRequired(String salaryRequired)
    {
        this.salaryrequired = salaryRequired;
    }

    public String getSalaryRequired()
    {
        return this.salaryrequired;
    }

    public int getCurrentEmploymentMonths()
    {
        return currentemploymentmonths;
    }

    public void setCurrentEmploymentMonths(int currentemploymentmonths)
    {
        this.currentemploymentmonths = currentemploymentmonths;
    }

    public int getCurrentEmploymentYears()
    {
        return currentemploymentyears;
    }

    public void setCurrentEmploymentYears(int currentemploymentyears)
    {
        this.currentemploymentyears = currentemploymentyears;
    }

    public String getEmploymentStatusFKID()
    {
        return employmentstatus_fkid;
    }

    public String getEmploymentStatus() throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = "SELECT name FROM employmentstatus WHERE pkid=" + getEmploymentStatusFKID();
        String name = "";

        try
        {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next())
            {
                name = rs.getString(1);
            }
        }
        finally
        {
            db.close();
        }

        return name;
    }

    public void setEmploymentStatusFKID(String employmentstatus_fkid)
    {
        this.employmentstatus_fkid = employmentstatus_fkid;
    }

    public String getHobbies()
    {
        return hobbies;
    }

    public void setHobbies(String hobbies)
    {
        this.hobbies = hobbies;
    }

    public String getMarketSegmentFKID()
    {
        return marketsegment_fkid;
    }

    public String getMarketSegmentName() throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = "SELECT name FROM marketsegment WHERE pkid=" + getMarketSegmentFKID();
        String name = "";

        try
        {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next())
            {
                name = rs.getString(1);
            }
        }
        finally
        {
            db.close();
        }

        return name;
    }

    public void setMarketSegmentFKID(String marketsegment_fkid)
    {
        this.marketsegment_fkid = marketsegment_fkid;
    }

    public String getPKID()
    {
        return pkid;
    }

    public void setPKID(String pkid)
    {
        this.pkid = pkid;
    }

    public String getTradeQualifications()
    {
        return tradequalifications;
    }

    public void setTradeQualifications(String tradequalifications)
    {
        this.tradequalifications = tradequalifications;
    }

    public void load(String pkid) throws Exception
    {
        load(pkid, false);
    }

    public void load(String pkid, boolean extended) throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            load(pkid, db, extended);
        }
        finally
        {
            db.close();
        }
    }

    public void load(String pkid, DBProxy db) throws Exception
    {
        load(pkid, db, false);
    }

    public void load(String pkid, DBProxy db, boolean extended) throws Exception
    {
        String sql = "SELECT * FROM usercvdetail WHERE pkid=" + pkid;
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
        }
    }

    public void loadReferences(DBProxy db) throws Exception
    {
        String sql = "SELECT cvreference_fkid FROM usercvreferences WHERE cvdetail_fkid=" + getPKID();
        ResultSet rs = null;

        Logger log = Logger.getLogger(Resume.class);
        log.info("Loading references, PKID: " + getPKID());

        try
        {
            rs = db.executeQuery(sql);

            while (rs.next())
            {
                ResumeReference reference = new ResumeReference();
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

    public void addReference(ResumeReference reference)
    {
        references.add(reference);
    }

    public void removeReference(int referenceNr)
    {
        ResumeReference reference = (ResumeReference) references.remove(referenceNr);
        if (reference.getPKID() != null)
        {
            // Remove from the DB
        }
    }

    public void save(String userId, DBProxy db) throws Exception
    {
    }

    public void save(DBProxy db) throws Exception
    {
    }

    public ResumeReference[] getReferences()
    {
        ResumeReference[] referencesArray = new ResumeReference[references.size()];
        for (int i = 0; i < references.size(); i++)
        {
            referencesArray[i] = (ResumeReference) references.get(i);
        }
        return referencesArray;
    }

    public boolean hasReferences()
    {
        return references.size() > 0;
    }

    public void saveReferences(DBProxy db) throws Exception
    {
    }

    public void delete(DBProxy db) throws Exception
    {
    }

    public boolean isValid()
    {
        boolean isValid = false;

        if ((getTradeQualifications() != null) && (!getTradeQualifications().equals("")))
        {
            isValid = true;
        }

        if ((getMarketSegmentFKID() != null) && (!getMarketSegmentFKID().equals("-1")))
        {
            isValid = true;
        }

        if ((getCareerFKID() != null) && (!getCareerFKID().equals("-1")))
        {
            isValid = true;
        }

        if ((getEmploymentStatusFKID() != null) && (!getEmploymentStatusFKID().equals("-1")))
        {
            isValid = true;
        }

        if ((getComments() != null) && (!getComments().equals("")))
        {
            isValid = true;
        }

        if ((getHobbies() != null) && (!getHobbies().equals("")))
        {
            isValid = true;
        }
        
        return isValid;
    }
}
