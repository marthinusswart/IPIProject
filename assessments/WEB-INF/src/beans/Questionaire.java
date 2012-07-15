/*
 * Created on 30-Jun-2005
 *
 */
package beans;

import java.io.Serializable;
import java.sql.ResultSet;
import org.apache.log4j.Logger;

/**
 * @author psnel
 *
 */
public class Questionaire implements Serializable
{

    private String gsPKID;		// primary-key of the questionaire (if available)
    private String gsName;		// name of Questionaire
    private String gsDesc;		// desciption of Questionaire
    private String gsWording;	// alternative wording set chosen for this questionaire
    // NOTE: currently only alternatives 0 & 1 is implemented
    private QreType type;		// questionaire type info
    private String[][] gSCs;		// array of Super-construct string tripairs (pkid, code, name)
    //   included in the questionaire
    private String[][] gOptCs;		// optional Construct string pairs (pkid, name) to be excluded
    //   from the questionaire
    private int giAssCount = 0;// number of assignments that reference this Qre
    private int[] aStatCounts = // array of status counts e.g. [0:w, 1:x, 2:y, 3:z] where 0..3 is the
                  new int[4];		// status-code and w..z is the count.
    private int giTstLen = 0;	// total number of questions (counted from db)
    private User[] users = null;	// list of users (particpants) to whom this qre is assigned.
    private static String[] strStatus =
    {
        "not started",
        "in progress",
        "completed",
        "canceled"
    };

    // default Constructor
    public Questionaire()
    {
    }

    public Questionaire(String pkid)
    {
        this.gsPKID = pkid;
    }

    public Questionaire(String pkid, String name, String desc, String wording)
    {
        gsPKID = pkid;
        gsName = name;
        gsDesc = desc;
        gsWording = wording;
    }

    public Questionaire(String name, String desc, String wording)
    {
        gsName = name;
        gsDesc = desc;
        gsWording = wording;
    }

    public Questionaire(QreType type, String pkid, String name, String descr)
    {
        this.gsPKID = pkid;
        this.gsName = name;
        this.gsDesc = descr;
        this.type = type;

    }

    public String getPKID()
    {
        return gsPKID;
    }

    public String getName()
    {
        return gsName;
    }

    public String getDesc()
    {
        return gsDesc;
    }

    /**
     * @return array of Super-Construct's
     */
    public String[][] getSCs()
    {
        return gSCs;
    }

    public String[][] getOptCs()
    {
        return gOptCs;
    }

    public User[] getUsers()
    {
        return users;
    }

    /**
     * @param custID - id of customer (lvl 2) for which users must be loaded. Specify null for administrators
     * or if loadExtendedDetails = false
     * @param loadExtendedDetails - whether or not to load details (like participating user-list) that are
     * not directly related to the [Questionaire] entity (+[QRE_TYPE])
     * @throws Exception
     */
    public void loadFromDB(String custID, boolean loadExtendedDetails) throws Exception
    {
        if (gsPKID == null || gsPKID.equals(""))
        {
            throw new Exception("No questionaire specified");
        }

        DBProxy db = new DBProxy();
        try
        {
            ResultSet res = db.executeQuery(
                    "SELECT q.name as qname, q.descr, q.qWording, t.pkid, t.code, t.name as tname "
                    + "FROM Questionaire q, QRE_TYPE t "
                    + "WHERE "
                    + "q.pkid=" + this.gsPKID + " AND "
                    + "(q.fkTypeID=-1 OR q.fkTypeID=t.pkid)");
            if (res.next())
            {
                this.gsName = res.getString("qname");
                this.gsDesc = res.getString("descr");
                this.gsWording = res.getString("qwording");
                this.type = new QreType(
                        res.getInt("pkid"),
                        res.getString("code"),
                        res.getString("tname"));

                // load qre extended details..
                if (loadExtendedDetails)
                {

                    // ..admins only
                    if (custID == null)
                    {
                        // .. Super-Constructs
                        loadDbSCs(db);
                        // .. Excluded Constructs
                        loadDbOptCs(db);
                    }

                    // ..number of questions
                    getTestLength(db);

                    // ..number of users assigned
                    loadDbAssmtCount(db, custID);

                    // .. load status counts
                    loadDbStatCounts(db, custID);

                    // ..load user list
                    loadDbUsers(db, custID);
                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    private void loadDbSCs(DBProxy db) throws Exception
    {
        ResultSet res;

        // count SC's
        res = db.executeQuery(
                "SELECT COUNT(*) FROM _Q_SC_Entry "
                + "WHERE fkQ=" + gsPKID);
        if (res.next())
        {
            this.gSCs = new String[res.getInt(1)][3];
        }

        // load SC-tripairs: [][pkid,code,name]
        res = db.executeQuery(
                "SELECT sc.pkid, sc.code, sc.name "
                + "FROM Super_Construct sc, _Q_SC_Entry sce "
                + "WHERE sce.fkQ=" + gsPKID + " AND sce.fkSC=sc.pkid "
                + "ORDER BY sc.code");
        int i = 0;
        while (res.next())
        {
            gSCs[i][0] = res.getString("pkid");
            gSCs[i][1] = res.getString("code");
            gSCs[i++][2] = res.getString("name");
        }
    }

    private void loadDbOptCs(DBProxy db) throws Exception
    {
        ResultSet res;

        // count optC's
        res = db.executeQuery(
                "SELECT COUNT(*) FROM _QSCE_C_Exclude "
                + "WHERE fkQ=" + gsPKID);
        if (res.next())
        {
            this.gOptCs = new String[res.getInt(1)][2];
        }

        // load optC-pars: [][pkid,name]
        res = db.executeQuery(
                "SELECT c.pkid, c.name "
                + "FROM _QSCE_C_Exclude cx, Construct c "
                + "WHERE cx.fkQ=" + this.gsPKID + " AND cx.fkC=c.pkid "
                + "ORDER BY c.pkid");
        int i = 0;
        while (res.next())
        {
            gOptCs[i][0] = res.getString("pkid");
            gOptCs[i++][1] = res.getString("name");
        }
    }

    private void loadDbAssmtCount(DBProxy db, String custID) throws Exception
    {
        ResultSet res = (custID == null)
                        ? db.executeQuery("SELECT * FROM countParticipants(" + this.gsPKID + ")")
                        : db.executeQuery("SELECT * FROM countParticipantsByCustID(" + this.gsPKID + "," + custID + ")");
        if (res.next())
        {
            this.giAssCount = res.getInt(1);
        }
    }

    /**
     * Retrieve the sum totals of each status for this Questionaire. If custID is not null the counts
     * apply to the specified customer.
     *
     * @param db
     * @throws Exception
     */
    private void loadDbStatCounts(DBProxy db, String custID) throws Exception
    {
        ResultSet res;

        res = db.executeQuery(
                "SELECT fkTstStatus as stat, COUNT(*) FROM _Assignment a, Users u "
                + "WHERE fkQ=" + this.gsPKID + " AND a.fkUser=u.pkid AND u.fkLevel=3"
                + ((custID == null) ? "" : " AND u.fkCustID=" + custID)
                + " GROUP BY stat");
        int stat;
        while (res.next())
        {
            stat = res.getInt("stat");
            aStatCounts[stat] = res.getInt(2);
        }
    }

    /**
     * Loads users array with participants. The users[] array is initialized to the size of the total
     * number of users assigned to a questionaire (i.e. as seen at admin level). Calling code must check
     * for null users.
     *
     * Pre: giAssCount must be known (see loadDbAssmtCount())
     *
     * @param db - open DBProxy
     * @param custID - null if users of all customers are to be retrieved, else, the pk of the customer.
     * @throws Exception
     */
    private void loadDbUsers(DBProxy db, String custID) throws Exception
    {
        ResultSet res;

        // ..reset
        this.users = new User[this.giAssCount];


        // .. get participants
        res = db.executeQuery(
                "SELECT u.pkid, u.fkCustID, u.username, u.initial, u.fname, u.lname, u.title, "
                + "c.name, a.fkTstStatus "
                + "FROM Users u, _Assignment a, Customer c "
                + "WHERE a.fkQ = " + gsPKID + " AND a.fkUser=u.pkid AND u.fkLevel=3 AND u.fkCustID=c.pkid"
                + ((custID == null) ? "" : " AND c.pkid=" + custID)
                + " ORDER BY c.pkid, a.fkTstStatus, u.username");

        int i = 0;
        while (res.next())
        {
            users[i] = new User();
            users[i].setCustName(res.getString("name"));
            users[i].setFirstName(res.getString("fname"));
            users[i].setLastName(res.getString("lname"));
            users[i].setInitial(res.getString("initial"));
            users[i].setTitle(res.getString("title"));
            users[i].setUserName(res.getString("username"));
            users[i].setPKID(res.getString("pkid"));
            // .. reuse hack: see sc_502_qreDetail
            users[i].setWebsite(res.getString("fkTstStatus")); // <- Yikes!! hack reuse www<=>test status

            i++;
        }
    }

    public String getWording() throws Exception
    {
        if (gsWording == null)
        {
            DBProxy db = new DBProxy();
            try
            {
                ResultSet res = db.executeQuery("SELECT qWording FROM Questionaire WHERE pkid=" + gsPKID);
                if (res.next())
                {
                    gsWording = res.getString("qWording");
                }

            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                db.close();
            }
        }
        return gsWording;
    }

    public int getAssCount()
    {
        return giAssCount;
    }

    public int getComplCount()
    {
        return this.aStatCounts[2];
    }

    /**
     * Returns the Super-Construct tripair with the given pkid, if that SC is stored in the
     * SCs [][] array. If the Super-Construct is not found null is returned.
     *
     * @param pkid the pkid of the Super-Construct
     * @return the Super-Construct tripair that has the given pkid, or null if not found.
     */
    public String[] getSC(String pkid)
    {
        String[] retVal = null;
        for (int i = 0; i < gSCs.length; i++)
        {
            if (gSCs[i][0].equals(pkid))
            {
                retVal = gSCs[i];
                break;
            }
        }

        return retVal;
    }

    public void setPKID(String pkid)
    {
        gsPKID = pkid;
    }

    public void setName(String name)
    {
        gsName = DBProxy.legalizeString(name);
    }

    public void setDesc(String desc)
    {
        gsDesc = DBProxy.legalizeString(desc);
    }

    /**
     * Sets the array of Super-Construct included in this Questionaire.
     *
     * @param pkids - Super-Construct pkid's (primary keys)
     */
    public void setSCs(String[][] scs)
    {
        gSCs = scs;
    }

    public void setOptCs(String[][] optcs)
    {
        gOptCs = optcs;
    }

    public void setWording(String w)
    {
        gsWording = w;
    }

    public void setAssCount(int asscnt)
    {
        giAssCount = asscnt;
    }

    public void setComplCount(int cmplcnt)
    {
        this.aStatCounts[2] = cmplcnt;
    }

    /**
     * @return Returns the type.
     */
    public QreType getType()
    {
        return type;
    }

    /**
     * @param type The type to set.
     */
    public void setType(QreType type)
    {
        this.type = type;
    }

    public int getStatCount(int statCode)
    {
        return this.aStatCounts[statCode];
    }

    /**
     * Insert record in [Questionaire] and all referencing entities (|[_Q_SC_Entry]| & |[_QSCE_C_Exclude]|).
     * If an error occurs after having written to the db, those written records are deleted, and the db Exception
     * is forwarded to the caller.
     *
     * @throws Exception on db error
     */
    public void commit() throws Exception
    {
        if (gSCs == null)
        {
            throw new Exception("No Super-Constructs are present");
        }
        if (gsName == null)
        {
            throw new Exception("No name specified");
        }
        if (gsDesc == null)
        {
            gsDesc = "";
        }

        DBProxy db = new DBProxy();

        try
        {
            db.executeNonQuery("BEGIN");

            // Create [Questionaire]
            String SQL =
                   "INSERT INTO Questionaire (name, descr, qWording, fkTypeID) "
                   + "VALUES ('" + gsName + "', '" + gsDesc + "', " + gsWording + ", " + type.getPKID() + ")";

            db.executeNonQuery(SQL);

            // Create |[_Q_SC_Entry]| 's (included Super-Constructs)
            int i;
            for (i = 0; i < gSCs.length; i++)
            {
                SQL =
                "INSERT INTO _Q_SC_Entry "
                + "VALUES (currval('questionaire_pkid_seq'), " + gSCs[i][0] + ")";

                db.executeNonQuery(SQL);
            }

            // Create |[_QSCE_C_Exclude]| 's (excluded Constructs)
            if (gOptCs != null)
            {
                for (i = 0; i < gOptCs.length; i++)
                {
                    SQL =
                    "INSERT INTO _QSCE_C_Exclude "
                    + "VALUES ("
                    + "currval('questionaire_pkid_seq'), "
                    + gOptCs[i][0] + ", "
                    + gOptCs[i][1] + ")";

                    db.executeNonQuery(SQL);
                }
            }

            db.executeNonQuery("COMMIT");

        }
        catch (Exception e)
        {
            db.executeNonQuery("ROLLBACK");
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    public void update() throws Exception
    {
        DBProxy db = new DBProxy();

        try
        {
            db.executeNonQuery(
                    "UPDATE Questionaire SET "
                    + "name = '" + this.gsName + "',"
                    + "descr='" + this.gsDesc + "',"
                    + "qWording=" + this.gsWording + ","
                    + "fkTypeID=" + type.getPKID()
                    + " WHERE pkid=" + gsPKID);
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    /**
     * Delete entries, excludes, and the Qre itself from the DB
     *
     * @throws Exception if there are any [Assignment]'s referencing this questionaire
     */
    public void delete() throws Exception
    {
        DBProxy db = new DBProxy();

        Logger log = Logger.getLogger(Questionaire.class);
        log.info("Deleting the Questionnaire. PKID:" + gsPKID + " Name:" + gsName);

        try
        {

            // check that there are no [_Assignment]'s
            ResultSet res = db.executeQuery(
                    "SELECT COUNT(*) as cnt "
                    + "FROM _Assignment "
                    + "WHERE fkQ=" + gsPKID);
            if (res.next() && res.getInt("cnt") > 0)
            {
                db.close();
                throw new Exception("The Questionaire has participants assigned to it");
            }

            // delete
            db.executeNonQuery(
                    "DELETE FROM _QSCE_C_Exclude "
                    + "WHERE fkQ = " + gsPKID);
            db.executeNonQuery(
                    "DELETE FROM _Q_SC_Entry "
                    + "WHERE fkQ = " + gsPKID);
            db.executeNonQuery(
                    "DELETE FROM Questionaire "
                    + "WHERE pkid = " + gsPKID);
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    /**
     * Retrieve and return questionaires in the db.
     *
     * Userlevel and Username is retrieved via the SessionManager class.
     * If userLevel is:
     * - 1:		returns all questionaires
     * - 2:		returns all questionaires assigned to the customer and/or its users.
     * - 3:		returns all questionaires assigned to user (Username)
     *
     * @return array of Questionaires
     * @throws Exception
     */
    public static Questionaire[] getQres(SessionManager sMan) throws Exception
    {
        Questionaire[] retVal = null;
        DBProxy db = new DBProxy();
        String lastError = "";

        try
        {

            ResultSet res;
            int nQre = 0;

            String userName = sMan.getUserName();
            int userLevel = sMan.getUserLvl();

            String SQL1, SQL2, SQL3, SQL4;
            SQL1 = SQL2 = SQL3 = SQL4 = null;

            switch (userLevel)
            {

                case 1:	// admin

                    SQL1 = // count
                    "SELECT COUNT(*) as nQre "
                    + "FROM Questionaire q";
                    SQL2 = // get
                    "SELECT q.pkid, q.name, q.descr, q.qWording, q.fkTypeID "
                    + "FROM Questionaire q "
                    + "ORDER BY q.fkTypeID, q.name";
                    SQL3 = // count assmts
                    "SELECT q.pkid, count(*) as assmts "
                    + "FROM Questionaire q, _Assignment a "
                    + "WHERE q.pkid = a.fkQ "
                    + "GROUP BY q.pkid";
                    SQL4 = // count completed assmts
                    "SELECT q.pkid, count(*) as cnt "
                    + "FROM Questionaire q, _Assignment a "
                    + "WHERE q.pkid = a.fkQ AND a.fkTstStatus=2 "
                    + "GROUP BY q.pkid";
                    break;

                case 2: // org

                    SQL1 = // count
                    "SELECT COUNT(DISTINCT q.pkid) as nQre "
                    + "FROM Questionaire q, _Assignment a, Users u "
                    + "WHERE "
                    + "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND (u.username='" + userName + "')";
                    // Changed to only show assessments currently assigned to an Org., not all from all users
                    //+ "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND "
                    //+ "(u.fkCustID IN (SELECT fkCustID FROM Users WHERE username='" + userName + "'))";
                    SQL2 = // get
                    "SELECT DISTINCT q.pkid, q.name, q.descr, q.qWording, q.fkTypeID "
                    + "FROM Questionaire q, _Assignment a, Users u "
                    + "WHERE "
                    + "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND (u.username='" + userName + "')"
                    // Changed to only show assessments currently assigned to an Org., not all from all users
                    //+ "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND "
                    //+ "(u.fkCustID IN (SELECT fkCustID FROM Users WHERE username='" + userName + "')) "
                    + "ORDER BY q.fkTypeID, q.name";
                    SQL3 = // count assmts
                    "SELECT q.pkid, count(*) as assmts "
                    + "FROM Questionaire q, _Assignment a, Users u "
                    + "WHERE "
                    + "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND (u.fkLevel>2) "
                    // Changed to only show assessments currently assigned to an Org., not all from all users
                    //+ "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND (u.fkLevel>2) AND "
                    //+ "(u.fkCustID IN (SELECT fkCustID FROM Users WHERE username='" + userName + "')) "
                    + "GROUP BY q.pkid";
                    SQL4 = // count completed assmts
                    "SELECT q.pkid, count(*) as cnt "
                    + "FROM Questionaire q, _Assignment a, Users u "
                    + "WHERE "
                    + "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND (a.fkTstStatus=2) AND (u.fkLevel>2) "
                    // Changed to only show assessments currently assigned to an Org., not all from all users
                    //+ "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND (a.fkTstStatus=2) AND (u.fkLevel>2) AND "
                    //+ "(u.fkCustID IN (SELECT fkCustID FROM Users WHERE username='" + userName + "')) "
                    + "GROUP BY q.pkid";
                    break;

                case 3: // user

                    SQL1 = // count
                    "SELECT COUNT(*) as nQre "
                    + "FROM Questionaire q, _Assignment a, Users u "
                    + "WHERE "
                    + "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND "
                    + "(u.username='" + userName + "')";
                    SQL2 = // get
                    "SELECT q.pkid, q.name, q.descr, q.qWording, q.fkTypeID "
                    + "FROM Questionaire q, _Assignment a, Users u "
                    + "WHERE "
                    + "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND "
                    + "(u.username='" + userName + "') "
                    + "ORDER BY q.fkTypeID, q.name";
                    SQL3 = // count assmts
                    "SELECT q.pkid, count(*) as assmts "
                    + "FROM Questionaire q, _Assignment a, Users u "
                    + "WHERE "
                    + "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND "
                    + "(u.username='" + userName + "') "
                    + "GROUP BY q.pkid";
                    SQL4 = // count completed assmts
                    "SELECT q.pkid, count(*) as cnt "
                    + "FROM Questionaire q, _Assignment a, Users u "
                    + "WHERE "
                    + "(a.fkQ=q.pkid) AND (a.fkUser=u.pkid) AND (a.fkTstStatus=2) AND "
                    + "(u.username='" + userName + "') "
                    + "GROUP BY q.pkid";
                    break;

                default:
                    throw new Exception("Incorrect userlevel");
            }

            lastError = "Count Questionaires";
            // count questionaires
            res = db.executeQuery(SQL1);

            if (res.next())
            {
                nQre = res.getInt("nQre");
            }

            if (nQre > 0)
            {
                retVal = new Questionaire[nQre];

                res = db.executeQuery(SQL2);

                int qCount = 0;
                while (res.next())
                {
                    retVal[qCount] = new Questionaire(
                            res.getString("pkid"),
                            res.getString("name"),
                            res.getString("descr"),
                            res.getString("qWording"));
                    lastError = "Reading the TypeId";
                    int typeId = res.getInt("fkTypeID");
                    retVal[qCount++].setType(new QreType(res.getInt("fkTypeID")));
                }

                // count assignments for each Qre
                res = db.executeQuery(SQL3);
                int i;
                while (res.next())
                {	// loop [pkid, ass_counts]
                    // find the Qre with that pkid and set its ass_count
                    for (i = 0; i < retVal.length; i++)
                    {
                        if (retVal[i].getPKID().equals(res.getString("pkid")))
                        {
                            retVal[i].setAssCount(res.getInt("assmts"));
                            break;
                        }
                    }
                }

                // count COMPLETED assignments for each Qre
                res = db.executeQuery(SQL4);
                while (res.next())
                {	// loop [pkid, ass_counts]
                    // find the Qre with that pkid and set its ass_count
                    for (i = 0; i < retVal.length; i++)
                    {
                        if (retVal[i].getPKID().equals(res.getString("pkid")))
                        {
                            retVal[i].setComplCount(res.getInt("cnt"));
                            break;
                        }
                    }
                }

            }

        }
        catch (Exception e)
        {
            if (lastError.equals(""))
            {
                throw new Exception("Error in getQRes:" + e.getMessage());
            }
            else
            {
                throw new Exception(lastError);
            }
        }
        finally
        {
            db.close();
        }

        return retVal;
    }

    /**
     * Returns the number of questions in this qre. if giTstLen == 0, then the value is calculated from the db.
     * @return giTstLen
     * @throws Exception
     */
    public int getTestLength() throws Exception
    {
        int retVal = giTstLen;

        if (giTstLen == 0)
        {
            DBProxy db = new DBProxy();

            try
            {
                retVal = getTestLength(db);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                db.close();
            }
        }

        return retVal;
    }

    /**
     * Caculates the number of questions in this are, initiates giTstLen, and returns it.
     * @param db
     * @return
     * @throws Exception
     */
    public int getTestLength(DBProxy db) throws Exception
    {
        if (gsPKID == null || gsPKID.equals(""))
        {
            throw new Exception("No questionaire specified");
        }


        // .. length of test (all questions)
        ResultSet res = db.executeQuery(
                "SELECT COUNT(*) as cnt "
                + "FROM ("
                + "SELECT qn.pkid "
                + "FROM "
                + "questionaire q, _q_sc_entry qe, super_construct sc, Construct c, question qn "
                + "WHERE "
                + "(q.pkid=" + gsPKID + ") AND (qe.fkQ=q.pkid) AND "
                + "(qe.fkSC=sc.pkid) AND (c.fkSC=sc.pkid) AND (qn.fkC=c.pkid) "
                + "EXCEPT ALL "
                + "SELECT qn.pkid "
                + "FROM "
                + "questionaire q, _q_sc_entry qe, super_construct sc, "
                + "_qsce_c_exclude qx, Construct c, question qn "
                + "WHERE "
                + "(q.pkid=" + gsPKID + ") AND (qe.fkQ=q.pkid) AND "
                + "(qe.fkSC=sc.pkid) AND (qx.fkQ=q.pkid) AND (qx.fkSC=sc.pkid) AND "
                + "(qx.fkC=c.pkid) AND (c.fkSC=sc.pkid) AND (qn.fkC=c.pkid) "
                + ") as foo");

        if (res.next())
        {
            giTstLen = res.getInt("cnt");
        }

        return giTstLen;

    }

    public static String getStatString(String strIndex)
    {
        return getStatString(Integer.parseInt(strIndex));
    }

    public static String getStatString(int strIndex)
    {
        return strStatus[strIndex];
    }

    public static void removeSuperConstruct(String superConstructId, String questionnaireId) throws Exception
    {
        DBProxy db = new DBProxy();

        String removeExludedConstructsSql = "DELETE FROM _qsce_c_exclude WHERE fksc=" + superConstructId
                                            + " AND fkq=" + questionnaireId;

        String sql = "DELETE FROM _q_sc_entry WHERE _q_sc_entry.fksc=" + superConstructId
                     + " AND _q_sc_entry.fkq=" + questionnaireId;

        try
        {
            db.executeNonQuery(removeExludedConstructsSql);
            db.executeNonQuery(sql);
        }
        finally
        {
            db.close();
        }
    }

    public static void addSuperConstruct(String superConstructId, String questionnaireId) throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = "INSERT INTO _q_sc_entry (fksc, fkq) VALUES (" + superConstructId + "," + questionnaireId + ")";
        db.executeNonQuery(sql);
        db.close();
    }
}
