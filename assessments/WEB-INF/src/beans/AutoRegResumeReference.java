/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.ResultSet;
import org.apache.log4j.Logger;

/**
 *
 * @author m swart
 */
public class AutoRegResumeReference extends ResumeReference
{

    @Override
    public void save(String resumeId, DBProxy db) throws Exception
    {
        String referenceId = null;
        String sql = "SELECT nextval('registrationcvreference_pkid_seq')";
        ResultSet rs = null;

        try
        {
            rs = db.executeQuery(sql);
            if (rs.next())
            {
                referenceId = rs.getString("nextval");
            }

            if (referenceId == null)
            {
                throw new Exception("Failed to get reference ID");
            }

            sql = "INSERT INTO registrationcvreference (pkid, referencenr, employer, employmentperiod, employerphone, "
                  +" refereename, contactpermission, keyresponsibility, skillsused, comments, grosssalary) "
                  + "VALUES (" + referenceId + ", 0, '" + getEmployer() + "', '" + getEmploymentPeriod() + "', "
                  + "'" + getEmployerPhone() + "', '" + getRefereeName() + "', '" + getContactPermission() + "', '"
                  + getKeyResponsibility() + "', '" + getSkillsUsed() +"', '" + getComments() + "', '"
                  + getGrossSalary() + "')";

            try
            {
                db.executeNonQuery(sql);
            }
            catch (Exception ex)
            {
                throw new ArrayIndexOutOfBoundsException("The SQL: " + sql);
            }

            sql = "INSERT INTO registrationcvreferences (cvdetail_fkid, cvreference_fkid) "
                  + "VALUES (" + resumeId + ", " + referenceId + ")";
            db.executeNonQuery(sql);
        }
        finally
        {
            if (rs != null)
            {
                rs.close();
            }
        }
    }

    public void saveToCVDetailReference(String resumeId, DBProxy db) throws Exception
    {
        Logger log = Logger.getLogger(AutoRegResumeReference.class);
        log.info("Commiting the Resume Reference, PKID: " + getPKID());

        String sql = "INSERT INTO usercvreference (pkid, referencenr, employer, employmentperiod, employerphone, "
                     +" refereename, contactpermission, keyresponsibility, skillsused, comments, grosssalary) "
                     + "VALUES (" + getPKID() + ", 0, '" + getEmployer() + "', '" + getEmploymentPeriod() + "', "
                     + "'" + getEmployerPhone() + "', '" + getRefereeName() + "', '" + getContactPermission() + "', '"
                  + getKeyResponsibility() + "', '" + getSkillsUsed() +"', '" + getComments() + "', '"
                  + getGrossSalary() + "')";
        db.executeNonQuery(sql);

        log.info("Commiting the Resume References, cvreference_fkid: " + getPKID());
        sql = "INSERT INTO usercvreferences (cvdetail_fkid, cvreference_fkid) "
              + "VALUES (" + resumeId + ", " + getPKID() + ")";
        db.executeNonQuery(sql);
    }

    @Override
    public void load(String pkid, DBProxy db) throws Exception
    {
        String sql = "SELECT * FROM registrationcvreference WHERE pkid=" + pkid;
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

    @Override
    public void delete(DBProxy db) throws Exception
    {
        String sql = "DELETE FROM registrationcvreference WHERE pkid=" + getPKID();
        db.executeNonQuery(sql);

        sql = "DELETE FROM registrationcvreferences WHERE cvreference_fkid=" + getPKID();
        db.executeNonQuery(sql);
    }
}
