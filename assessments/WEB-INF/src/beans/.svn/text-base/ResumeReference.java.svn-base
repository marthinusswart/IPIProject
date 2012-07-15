/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.ResultSet;

/**
 *
 * @author m swart
 */
public class ResumeReference
{

    protected String pkid;
    protected String employer;
    // The UI calls it referee phone number
    protected String employerphone;
    protected String refereename;
    protected String contactpermission;
    protected String keyresponsibility;
    protected String skillsused;
    protected String comments;
    protected String grosssalary;
    protected String employmentperiod;
    protected String referencenr;

    public String getEmployer()
    {
        return employer;
    }

    public void setEmployer(String employer)
    {
        this.employer = employer;
    }

    public void setRefereeName(String referee)
    {
        this.refereename = referee;
    }

    public String getRefereeName()
    {
        return this.refereename;
    }

    public void setContactPermission(String permission)
    {
        this.contactpermission = permission;
    }

    public String getContactPermission()
    {
        return this.contactpermission;
    }

    public void setKeyResponsibility(String responsibility)
    {
        this.keyresponsibility = responsibility;
    }

    public String getKeyResponsibility()
    {
        return this.keyresponsibility;
    }

    public void setSkillsUsed(String skillsUsed)
    {
        this.skillsused = skillsUsed;
    }

    public String getSkillsUsed()
    {
        return this.skillsused;
    }

    public void setComments(String comments)
    {
        this.comments = comments;
    }

    public String getComments()
    {
        return this.comments;
    }

    public void setGrossSalary(String salary)
    {
        this.grosssalary = salary;
    }

    public String getGrossSalary()
    {
        return this.grosssalary;
    }

    public String getEmployerPhone()
    {
        return employerphone;
    }

    public void setEmployerPhone(String employerphone)
    {
        this.employerphone = employerphone;
    }

    public String getEmploymentPeriod()
    {
        return employmentperiod;
    }

    public void setEmploymentPeriod(String employmentperiod)
    {
        this.employmentperiod = employmentperiod;
    }

    public String getPKID()
    {
        return pkid;
    }

    public void setPKID(String pkid)
    {
        this.pkid = pkid;
    }

    public String getReferenceNr()
    {
        return referencenr;
    }

    public void setReferenceNr(String referencenr)
    {
        this.referencenr = referencenr;
    }

    public ResumeReference()
    {
    }

    public ResumeReference(String pkid, String employer, String employerphone,
                           String employmentperiod, String referencenr)
    {
        setPKID(pkid);
        setEmployer(employer);
        setEmployerPhone(employerphone);
        setEmploymentPeriod(employmentperiod);
        setReferenceNr(referencenr);
    }

    public void loadByUserId(String userId)
    {
    }

    public void load(String pkid, DBProxy db) throws Exception
    {
        String sql = "SELECT * FROM usercvreference WHERE pkid=" + pkid;
        ResultSet rs = null;

        try
        {
            rs = db.executeQuery(sql);
            if (rs.next())
            {
                setPKID(rs.getString("pkid"));
                setReferenceNr(rs.getString("referencenr"));
                setEmployer(rs.getString("employer"));
                setEmploymentPeriod(rs.getString("employmentperiod"));
                setEmployerPhone(rs.getString("employerphone"));
                setRefereeName(rs.getString("refereename"));
                setContactPermission(rs.getString("contactpermission"));
                setKeyResponsibility(rs.getString("keyresponsibility"));
                setSkillsUsed(rs.getString("skillsused"));
                setComments(rs.getString("comments"));
                setGrossSalary(rs.getString("grosssalary"));
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

    public void save(String resumeId, DBProxy db) throws Exception
    {
    }

    public void delete(DBProxy db) throws Exception
    {
    }
}
