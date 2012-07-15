/* Assignment.java
 * 
 * Created on 10-Jul-2005
 */
package beans;

import java.sql.ResultSet;
import org.apache.log4j.Logger;

/**
 * @author psnel
 *
 * 
 */
public class Assignment
{

    private String PKID;
    private String fkUser;
    private String fkQre;
    private String fkTstStatus;
    // extended fields
    private String TstStatusDesc;
    private String userName;		// no pk?
    private Questionaire qre = null;	// an instance of the Questionaire associated with the Assignment.

    public Assignment()
    {
    }

    /**
     * @param fkUser
     * @param fkQre
     * @param fkTstStatus
     */
    public Assignment(String fkUser, String fkQre, String fkTstStatus)
    {
        this.fkUser = fkUser;
        this.fkQre = fkQre;
        this.fkTstStatus = fkTstStatus;
    }

    /**
     * @param pkid
     * @param fkUser
     * @param fkQre
     * @param fkTstStatus
     */
    public Assignment(String pkid, String fkUser, String fkQre, String fkTstStatus)
    {
        PKID = pkid;
        this.fkUser = fkUser;
        this.fkQre = fkQre;
        this.fkTstStatus = fkTstStatus;
    }

    public Assignment(Questionaire qre, String statusDescr)
    {
        this.qre = qre;
        this.TstStatusDesc = statusDescr;
    }

    public void commit() throws Exception
    {
        DBProxy db = new DBProxy();

        Logger log = Logger.getLogger(Assignment.class);
        log.info("Commiting Assignment");

        try
        {
            commit(db);
        }
        catch (Exception e)
        {
            log.error("Failed to commit Assignment");
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    public void commit(DBProxy db) throws Exception
    {

        if (fkUser == null && userName != null)
        {
            // retrieve the userPK
            ResultSet res = db.executeQuery(
                    "SELECT pkid "
                    + "FROM Users "
                    + "WHERE username='" + userName + "'");
            if (res.next())
            {
                fkUser = res.getString("pkid");
            }
        }

        Logger log = Logger.getLogger(Assignment.class);
        log.info("Commiting Assignment");

        if (fkUser != null)
        {
            db.executeNonQuery(
                    "INSERT INTO _Assignment (pkid, fkUser, fkQ, fkTstStatus) "
                    + "VALUES ("
                    + "nextval('_assignment_pkid_seq'), "
                    + fkUser + ", "
                    + fkQre + ", "
                    + fkTstStatus + ")");
            //db.close();
        }
        else
        {
            //db.close();
            throw new Exception("User not found, or user not specified");
        }

    }

    public void update() throws Exception
    {
        DBProxy db = new DBProxy();

        Logger log = Logger.getLogger(Assignment.class);
        log.info("Updating Assignment. PKID:" + PKID);

        db.executeNonQuery(
                "UPDATE _Assignment "
                + "SET "
                + "fkUser=" + fkUser + ", "
                + "fkQ=" + fkQre + ", "
                + "fkTstStatus=" + fkTstStatus + ", "
                + "submittime= 'now' "
                + "WHERE pkid=" + PKID);
        db.close();
    }

    public void loadFromDB(boolean loadExtendedFields) throws Exception
    {
        String SQL = null;
        DBProxy db;
        if ((fkUser != null || userName != null) && fkQre != null)
        {
            db = new DBProxy();
            SQL = (loadExtendedFields)
                  ? "SELECT a.pkid, a.fkQ, a.fkUser, a.fkTstStatus, t.descr, u.username "
                    + "FROM _Assignment a, TEST_STATUS t, Users u "
                    + "WHERE "
                    + " a.fkTstStatus=t.pkid AND "
                    + ((fkUser != null)
                       ? "a.fkUser=u.pkid AND u.pkid=" + fkUser
                       : "a.fkUser=u.pkid AND u.username='" + userName + "' ")
                    + " AND fkQ=" + fkQre
                  // no extended fields
                  : "SELECT * "
                    + "FROM _Assignment a "
                    + "WHERE "
                    + ((fkUser != null)
                       ? "a.fkUser=u.pkid AND u.pkid=" + fkUser
                       : "a.fkUser=u.pkid AND u.username='" + userName + "' ")
                    + " AND fkQ=" + fkQre;

            ResultSet res = db.executeQuery(SQL);

            if (res.next())
            {
                this.PKID = res.getString("pkid");
                this.fkQre = res.getString("fkQ");
                this.fkUser = res.getString("fkUser");
                this.fkTstStatus = res.getString("fkTstStatus");
                if (loadExtendedFields)
                {
                    this.TstStatusDesc = res.getString("descr");
                    this.userName = res.getString("username");
                }
            }

            db.close();

            return;
        }
        else if (PKID != null)
        {
            db = new DBProxy();
            SQL = (loadExtendedFields)
                  ? "SELECT a.pkid, a.fkQ, a.fkUser, a.fkTstStatus, t.descr, u.username "
                    + "FROM _Assignment a, TEST_STATUS t, Users u "
                    + "WHERE (a.pkid=" + PKID + ") AND (a.fkUser=u.pkid) AND (a.fkTstStatus=t.pkid)"
                  // no extended fields
                  : "SELECT * "
                    + "FROM _Assignment a "
                    + "WHERE a.pkid=" + PKID;

            ResultSet res = db.executeQuery(SQL);

            if (res.next())
            {
                this.PKID = res.getString("pkid");
                this.fkQre = res.getString("fkQ");
                this.fkUser = res.getString("fkUser");
                this.fkTstStatus = res.getString("fkTstStatus");
                if (loadExtendedFields)
                {
                    this.TstStatusDesc = res.getString("descr");
                    this.userName = res.getString("username");
                }
            }
            db.close();
            return;
        }
        else
        {
            throw new Exception("No keys specified.");
        }

    }

    /**
     * @return Returns the fkQre.
     */
    public String getFkQre()
    {
        return fkQre;
    }

    /**
     * @return Returns the fkTstStatus.
     */
    public String getFkTstStatus()
    {
        return fkTstStatus;
    }

    /**
     * @return Returns the fkUser.
     */
    public String getFkUser()
    {
        return fkUser;
    }

    /**
     * @return Returns the pKID.
     */
    public String getPKID()
    {
        return PKID;
    }

    public static boolean removeAssessmentFromDownline(String assessmentId, String downlineId) throws Exception
    {
        boolean result = false;
        DBProxy db = new DBProxy();
        String sql = "select u.pkid "
                     + "FROM _assignment a, users u, customer c "
                     + "WHERE a.fkq=" + assessmentId + " "
                     + "AND c.pkid=" + downlineId + " "
                     + "AND u.fkcustid = c.pkid "
                     + "AND a.fkuser = u.pkid "
                     + "AND u.fklevel = 2 "
                     + "ORDER BY u.username";

        ResultSet rs = null;

        try
        {
            rs = db.executeQuery(sql);
            if (rs.next())
            {
                String userId = rs.getString("pkid");
                sql = "DELETE FROM _assignment WHERE fkuser=" + userId + " AND fkq=" + assessmentId;
                if (db.executeNonQuery(sql) > 0)
                {
                    result = true;
                }
            }

            rs.close();
            rs = null;


            // Now remove all the assignments from users associated with this downline
            sql = "SELECT u.pkid, u.username, u.fklevel, a.fktststatus FROM users u, customer c, _assignment a "
                  + "WHERE u.pkid = a.fkuser "
                  + "AND u.fkcustid = c.pkid "
                  + "AND a.fkq=" + assessmentId + " "
                  + "AND c.pkid=" + downlineId + " "
                  + "AND a.fktststatus=0 "
                  + "AND u.fklevel=3";

            rs = db.executeQuery(sql);

            while (rs.next())
            {
                String userId = rs.getString("pkid");
                if (!removeAssessmentFromUser(assessmentId, userId, db))
                {
                    result = false;
                }
            }

        }
        finally
        {
            if (rs != null)
            {
                rs.close();
            }

            if (db != null)
            {
                db.close();
            }
        }

        return result;
    }

    public static boolean removeAssessmentFromUser(String assessmentId, String userId) throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            return removeAssessmentFromUser(assessmentId, userId, db);
        }
        finally
        {
            db.close();
        }
    }

    public static boolean removeAssessmentFromUser(String assessmentId, String userId, DBProxy db) throws Exception
    {
        boolean result = false;

        String sql = "DELETE FROM _assignment WHERE fkuser=" + userId + " AND fkq=" + assessmentId;
        if (db.executeNonQuery(sql) > 0)
        {
            result = true;
        }

        return result;
    }

    /**
     * @param fkQre The fkQre to set.
     */
    public void setFkQre(String fkQre)
    {
        this.fkQre = fkQre;
    }

    /**
     * @param fkTstStatus The fkTstStatus to set.
     */
    public void setFkTstStatus(String fkTstStatus)
    {
        this.fkTstStatus = fkTstStatus;
    }

    /**
     * @param fkUser The fkUser to set.
     */
    public void setFkUser(String fkUser)
    {
        this.fkUser = fkUser;
    }

    /**
     * @param pkid The pKID to set.
     */
    public void setPKID(String pkid)
    {
        PKID = pkid;
    }

    /**
     * @return Returns the userName.
     */
    public String getUserName()
    {
        return userName;
    }

    /**
     * @param userName The userName to set.
     */
    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    /**
     * @return Returns the tstStatusDesc.
     */
    public String getTstStatusDesc()
    {
        return TstStatusDesc;
    }

    /**
     * @param tstStatusDesc The tstStatusDesc to set.
     */
    public void setTstStatusDesc(String tstStatusDesc)
    {
        TstStatusDesc = tstStatusDesc;
    }

    /**
     * @return Returns the qre.
     */
    public Questionaire getQre()
    {
        return qre;
    }

    /**
     * @param qre The qre to set.
     */
    public void setQre(Questionaire qre)
    {
        this.qre = qre;
    }
}
