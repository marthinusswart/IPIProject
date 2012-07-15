/*
 * Created on 06-Jul-2005
 *
 */
package beans;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Vector;
import org.apache.log4j.Logger;

/**
 * @author psnel
 *
 */
public class User
{

    protected String resumeFKID;
    protected String gsPKID;
    protected String gsUserLevel;
    protected String gsFKCustomer;
    protected String gsUserName;
    protected String gsPassword;
    protected String gsInitial;
    protected String gsFirstName;
    protected String gsLastName;
    protected String gsTitle;
    protected String gsIDNum;
    protected String gsCompanyRef;
    protected String gsTelH;
    protected String gsTelW;
    protected String gsTelFax;
    protected String gsTelCell;
    protected String gsEMail;
    protected String gsWebsite;
    protected String gsQualification;
    protected Resume resume;
    private String gsCustName;
    private Questionaire[] qres = null;			// array of questionaires assigned to this user
    private HashMap assmtCounts = null;		// map of assignment counts for this user; keys are
    //  type:["QT_VA", "QT_FA", "QT_JP"] and
    //  status:["AS_NS", "AS_IP", "AS_CP"]
    // map key constatnts
    public static final String QT_VA = "QT_VA";
    public static final String QT_FA = "QT_FA";
    public static final String QT_JP = "QT_JP";
    public static final String QT_SI = "QT_SI";
    public static final String QT_PP = "QT_PP";
    public static final String QT_HA = "QT_HA";
    public static final String QT_CP = "QT_CP";
    public static final String AS_NS = "AS_NS";
    public static final String AS_IP = "AS_IP";
    public static final String AS_CP = "AS_CP";


    public User()
    {
    }

    public User(String web)
    {
        gsWebsite = DBProxy.legalizeString(web);
    }

    /**
     * @param userName
     * @param password
     */
    public User(String userName, String password)
    {
        gsUserName = DBProxy.legalizeString(userName);
        gsPassword = password;
    }

    public User(String pkId, String username, String firstname, String lastname, String organization)
    {
        gsPKID = pkId;
        gsUserName = username;
        gsFirstName = firstname;
        gsLastName = lastname;
        gsCustName = organization;
    }

    /**
     * @param PKID
     * @param UserName
     * @param Password
     */
    public User(String PKID, String UserName, String Password)
    {
        this.gsPKID = PKID;
        this.gsUserName = DBProxy.legalizeString(UserName);
        this.gsPassword = Password;
    }

    /**
     * All user input strings are checked through DBProxy.legalizeString()
     * 
     * @param UserName
     * @param Password
     * @param Initial
     * @param FirstName
     * @param LastName
     * @param Title
     * @param IDNum
     * @param CompanyRef
     * @param TelH
     * @param TelW
     * @param TelFax
     * @param TelCell
     * @param EMail
     * @param Website
     */
    public User(String UserName, String Password, String Initial,
                String FirstName, String LastName, String Title,
                String IDNum, String CompanyRef, String TelH, String TelW,
                String TelFax, String TelCell, String EMail, String Website)
    {
        this.gsUserName = DBProxy.legalizeString(UserName);
        this.gsPassword = Password;
        this.gsInitial = DBProxy.legalizeString(Initial);
        this.gsFirstName = DBProxy.legalizeString(FirstName);
        this.gsLastName = DBProxy.legalizeString(LastName);
        this.gsTitle = Title;
        this.gsIDNum = DBProxy.legalizeString(IDNum);
        this.gsCompanyRef = DBProxy.legalizeString(CompanyRef);
        this.gsTelH = DBProxy.legalizeString(TelH);
        this.gsTelW = DBProxy.legalizeString(TelW);
        this.gsTelFax = DBProxy.legalizeString(TelFax);
        this.gsTelCell = DBProxy.legalizeString(TelCell);
        this.gsEMail = DBProxy.legalizeString(EMail);
        this.gsWebsite = DBProxy.legalizeString(Website);
    }

    /**
     * Strings are not checked, so this is faster.
     * 
     * @param rawStrings
     * @param UserName
     * @param Password
     * @param Initial
     * @param FirstName
     * @param LastName
     * @param Title
     * @param IDNum
     * @param CompanyRef
     * @param TelH
     * @param TelW
     * @param TelFax
     * @param TelCell
     * @param EMail
     * @param Website
     */
    public User(boolean rawStrings, String FKCustomer, String UserLevel, String UserName,
                String Password, String Initial, String FirstName, String LastName, String Title,
                String IDNum, String CompanyRef, String TelH, String TelW,
                String TelFax, String TelCell, String EMail, String Website, String CustName)
    {
        this.gsFKCustomer = FKCustomer;
        this.gsUserLevel = UserLevel;
        this.gsUserName = UserName;
        this.gsPassword = Password;
        this.gsInitial = Initial;
        this.gsFirstName = FirstName;
        this.gsLastName = LastName;
        this.gsTitle = Title;
        this.gsIDNum = IDNum;
        this.gsCompanyRef = CompanyRef;
        this.gsTelH = TelH;
        this.gsTelW = TelW;
        this.gsTelFax = TelFax;
        this.gsTelCell = TelCell;
        this.gsEMail = EMail;
        this.gsWebsite = Website;

        this.gsCustName = CustName;
    }

    public boolean exists() throws Exception
    {   
        DBProxy db = new DBProxy();
        boolean retVal;
        try
        {
            retVal = exists(db);
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            db.close();
        }
        return retVal;
    }

    public boolean exists(DBProxy db) throws Exception
    {
        ResultSet res = db.executeQuery(
                "SELECT pkid "
                + "FROM Users "
                + "WHERE username='" + gsUserName + "'");
        return res.next();
    }

    public void commit() throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            commit(db);
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
     * Commits this user to the database, using the provided DBProxy - this esures that subsequent
     * db-commits will be in the same session (NB currval(<seq>)).
     * 
     * @param db
     * @throws Exception
     */
    public void commit(DBProxy db) throws Exception
    {
        if (getPKID() == null)
        {
            // ..get user pkid
            ResultSet res = db.executeQuery("SELECT nextval('users_pkid_seq')");
            if (res.next())
            {
                this.gsPKID = res.getString(1);
            }
            res.close();
        }

        String SQL =
               "INSERT INTO Users ("
               + "pkid, fkCustID,fkLevel, username, password, initial,"
               + "fname, lname, title, idnum, compRef, telH, "
               + "telW, fax, cell, email, website, resume_fkid) "
               + "VALUES ("
               + gsPKID +  ", "
               + gsFKCustomer + ", "
               + gsUserLevel + ", "
               + "'" + gsUserName + "', "
               + "'" + gsPassword + "', "
               + ((gsInitial != null && !gsInitial.equals("")) ? "'" + gsInitial + "'" : "null") + ", "
               + ((gsFirstName != null && !gsFirstName.equals("")) ? "'" + gsFirstName + "'" : "null") + ", "
               + ((gsLastName != null && !gsLastName.equals("")) ? "'" + gsLastName + "'" : "null") + ", "
               + ((gsTitle != null && !gsTitle.equals("")) ? "'" + gsTitle + "'" : "null") + ", "
               + ((gsIDNum != null && !gsIDNum.equals("")) ? "'" + gsIDNum + "'" : "null") + ", "
               + ((gsCompanyRef != null && !gsCompanyRef.equals("")) ? "'" + gsCompanyRef + "'" : "null") + ", "
               + ((gsTelH != null && !gsTelH.equals("")) ? "'" + gsTelH + "'" : "null") + ", "
               + ((gsTelW != null && !gsTelW.equals("")) ? "'" + gsTelW + "'" : "null") + ", "
               + ((gsTelFax != null && !gsTelFax.equals("")) ? "'" + gsTelFax + "'" : "null") + ", "
               + ((gsTelCell != null && !gsTelCell.equals("")) ? "'" + gsTelCell + "'" : "null") + ", "
               + ((gsEMail != null && !gsEMail.equals("")) ? "'" + gsEMail + "'" : "null") + ", "
               + ((gsWebsite != null && !gsWebsite.equals("")) ? "'" + gsWebsite + "'" : "null") + ", "
               + getResumeFKID()
               + ")";

        db.executeNonQuery(SQL);
    }

    public void delete() throws Exception
    {
        DBProxy db = new DBProxy();

        Logger log = Logger.getLogger(User.class);
        log.info("Deleting user. PKID:" + gsPKID + " Name:" + gsFirstName);
        
        try
        {
            delete(db);
            db.close();
        }
        catch (Exception e)
        {
            db.close();
            throw e;
        }

    }

    public void delete(DBProxy db) throws Exception
    {
        if (gsPKID != null)
        {
            db.executeNonQuery("DELETE FROM Users WHERE pkid=" + gsPKID);
        }
        else if (gsUserName != null)
        {
            db.executeNonQuery("DELETE FROM Users WHERE username='" + gsUserName + "'");
        }
        else
        {
            throw new Exception("Must Specify either PKID or UserName");
        }

        //db.close();
    }

    public void update() throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            update(db);
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

    public void update(DBProxy db) throws Exception
    {
        if (gsPKID == null && gsUserName == null)
        {
            throw new Exception("No user specified");
        }

        //if(this.exists(db)) throw new Exception("user '"+gsUserName+"' already exists");

        db.executeNonQuery("UPDATE Users SET "
                           + "fkCustID=" + gsFKCustomer + ", "
                           + "username='" + gsUserName + "', "
                           + "password='" + gsPassword + "', "
                           + "initial=" + ((gsInitial != null && !gsInitial.equals("")) ? "'" + gsInitial + "'" : "null") + ", "
                           + "fname=" + ((gsFirstName != null && !gsFirstName.equals("")) ? "'" + gsFirstName + "'" : "null") + ", "
                           + "lname=" + ((gsLastName != null && !gsLastName.equals("")) ? "'" + gsLastName + "'" : "null") + ", "
                           + "title=" + ((gsTitle != null && !gsTitle.equals("")) ? "'" + gsTitle + "'" : "null") + ", "
                           + "idnum=" + ((gsIDNum != null && !gsIDNum.equals("")) ? "'" + gsIDNum + "'" : "null") + ", "
                           + "compRef=" + ((gsCompanyRef != null && !gsCompanyRef.equals("")) ? "'" + gsCompanyRef + "'" : "null") + ", "
                           + "telH=" + ((gsTelH != null && !gsTelH.equals("")) ? "'" + gsTelH + "'" : "null") + ", "
                           + "telW=" + ((gsTelW != null && !gsTelW.equals("")) ? "'" + gsTelW + "'" : "null") + ", "
                           + "fax=" + ((gsTelFax != null && !gsTelFax.equals("")) ? "'" + gsTelFax + "'" : "null") + ", "
                           + "cell=" + ((gsTelCell != null && !gsTelCell.equals("")) ? "'" + gsTelCell + "'" : "null") + ", "
                           + "email=" + ((gsEMail != null && !gsEMail.equals("")) ? "'" + gsEMail + "'" : "null") + ", "
                           + "website=" + ((gsWebsite != null && !gsWebsite.equals("")) ? "'" + gsWebsite + "'" : "null") + " "
                           + "WHERE " + ((gsPKID != null) ? "pkid=" + gsPKID : "username='" + gsUserName + "'"));
    }

    public void updateWithAddresses(Address[] addressList) throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            updateWithAddresses(db, addressList);
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

    public void updateWithAddresses(DBProxy db, Address[] addressList) throws Exception
    {
        try
        {
            db.executeNonQuery("BEGIN");

            this.update(db);

            for (int i = 0; i < addressList.length; i++)
            {
                addressList[i].update(db);
            }
            db.executeNonQuery("COMMIT");
        }
        catch (Exception e)
        {
            db.executeNonQuery("ROLLBACK");
            throw e;
        }

    }

    public void load(boolean loadExtended) throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            load(db, loadExtended);
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

    public static User loadById(String userId) throws Exception
    {
        User user = new User();
        user.setPKID(userId);
        user.load(false);
        return user;
    }

    public void load(DBProxy db, boolean loadExtended) throws Exception
    {
        if ((this.gsUserName == null || this.gsUserName.equals("")) && (this.gsPKID == null || this.gsPKID.equals("")))
        {
            throw new Exception("No user ID specified");
        }

        ResultSet res = db.executeQuery(
                "SELECT * FROM Users "
                + "WHERE " + ((gsUserName != null) ? "username='" + gsUserName + "'" : "pkid=" + gsPKID));

        if (res.next())
        {
            this.gsPKID = res.getString("pkid");
            this.gsFKCustomer = res.getString("fkcustid");
            this.gsUserName = res.getString("username");
            this.gsUserLevel = res.getString("fklevel");
            this.gsPassword = res.getString("password");
            this.gsInitial = res.getString("initial");
            this.gsFirstName = res.getString("fname");
            this.gsLastName = res.getString("lname");
            this.gsTitle = res.getString("title");
            this.gsIDNum = res.getString("idnum");
            this.gsCompanyRef = res.getString("compref");
            this.gsTelH = res.getString("telH");
            this.gsTelW = res.getString("telW");
            this.gsTelFax = res.getString("fax");
            this.gsTelCell = res.getString("cell");
            this.gsEMail = res.getString("email");
            this.resumeFKID = res.getString("resume_fkid");
        }

        if (loadExtended)
        {
            // assignment counts..
            assmtCounts = User.initAssmtCounts();
            // .. qre types
            User.loadCountQreTypes(db, this);
            // .. assmt status
            User.loadCountAssmtStatus(db, this);
            // .. total;  (WARNING: risky.. reusing var:website)
            //User.loadCountAssmtTotal(db, this);

            loadQualification(db);

            if (getResume() == null)
            {
                setResume(new Resume());
            }

            getResume().load(getResumeFKID(), db, loadExtended);
        }

    }

    private void loadQualification(DBProxy db) throws Exception
    {
        String sql = "SELECT qc.name FROM qualification q, qualification_code qc WHERE q.fkusrid="+getPKID()+" AND qc.pkid=fkqcode";
        ResultSet rs = null;

        try
        {
            rs = db.executeQuery(sql);
            if (rs.next())
            {
                setHighestQualification(rs.getString(1));
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

    /**
     * @return Returns the companyRef.
     */
    public String getCompanyRef()
    {
        return gsCompanyRef;
    }

    /**
     * @param CompanyRef The CompanyRef to set.
     */
    public void setCompanyRef(String companyRef)
    {
        this.gsCompanyRef = DBProxy.legalizeString(companyRef);
    }

    /**
     * @return Returns the EMail.
     */
    public String getEMail()
    {
        return gsEMail;
    }

    /**
     * @param EMail The EMail to set.
     */
    public void setEMail(String EMail)
    {
        this.gsEMail = DBProxy.legalizeString(EMail);
    }

    public Resume getResume()
    {
        return resume;
    }

    public void setResume(Resume resume)
    {
        this.resume = resume;
    }

    /**
     * @return Returns the FirstName.
     */
    public String getFirstName()
    {
        return gsFirstName;
    }

    /**
     * @param FirstName The FirstName to set.
     */
    public void setFirstName(String firstName)
    {
        this.gsFirstName = DBProxy.legalizeString(firstName);
    }

    /**
     * @return Returns the IDNum.
     */
    public String getIDNum()
    {
        return gsIDNum;
    }

    /**
     * @param IDNum The IDNum to set.
     */
    public void setIDNum(String IDNum)
    {
        this.gsIDNum = DBProxy.legalizeString(IDNum);
    }

    public String getResumeFKID()
    {
        return resumeFKID;
    }

    public void setResumeFKID(String resume_fkid)
    {
        resumeFKID = resume_fkid;
    }

    /**
     * @return Returns the Initial.
     */
    public String getInitial()
    {
        return gsInitial;
    }

    /**
     * @param Initial The Initial to set.
     */
    public void setInitial(String Initial)
    {
        this.gsInitial = DBProxy.legalizeString(Initial);
    }

    /**
     * @return Returns the LastName.
     */
    public String getLastName()
    {
        return gsLastName;
    }

    /**
     * @param LastName The LastName to set.
     */
    public void setLastName(String LastName)
    {
        this.gsLastName = DBProxy.legalizeString(LastName);
    }

    /**
     * @return Returns the Password.
     */
    public String getPassword()
    {
        return gsPassword;
    }

    /**
     * @param Password The Password to set.
     */
    public void setPassword(String Password)
    {
        this.gsPassword = Password;
    }

    /**
     * @return Returns the PKID.
     */
    public String getPKID()
    {
        return gsPKID;
    }

    /**
     * @param PKID The PKID to set.
     */
    public void setPKID(String PKID)
    {
        this.gsPKID = PKID;
    }

    public String getHighestQualification()
    {
        return gsQualification;
    }

    public void setHighestQualification(String value)
    {
        gsQualification = value;
    }

    /**
     * @return Returns the TelCell.
     */
    public String getTelCell()
    {
        return gsTelCell;
    }

    /**
     * @param TelCell The TelCell to set.
     */
    public void setTelCell(String TelCell)
    {
        this.gsTelCell = DBProxy.legalizeString(getValidNo(TelCell));
    }

    private String getValidNo(String telNo)
    {
        String result = telNo;

        if ((telNo.length() > 0) && (!telNo.startsWith("+")))
        {
            result = "+" + telNo;
        }

        return result;
    }

    /**
     * @return Returns the TelFax.
     */
    public String getTelFax()
    {
        return gsTelFax;
    }

    /**
     * @param TelFax The TelFax to set.
     */
    public void setTelFax(String TelFax)
    {
        this.gsTelFax = DBProxy.legalizeString(getValidNo(TelFax));
    }

    /**
     * @return Returns the TelH.
     */
    public String getTelH()
    {
        return gsTelH;
    }

    /**
     * @param TelH The TelH to set.
     */
    public void setTelH(String TelH)
    {
        this.gsTelH = DBProxy.legalizeString(getValidNo(TelH));
    }

    /**
     * @return Returns the TelW.
     */
    public String getTelW()
    {
        return gsTelW;
    }

    public String getTel(String telType, String portion)
    {
        String telNo = "";
        String number = "";
        String areaCode = "";
        String countryCode = "";

        if (telType.equals("work"))
        {
            telNo = getTelW();
        }
        else if (telType.equals("home"))
        {
            telNo = getTelH();
        }
        else if (telType.equals("fax"))
        {
            telNo = getTelFax();
        }
        else if (telType.equals("cell"))
        {
            telNo = getTelCell();
        }

        if ((telNo != null) && (!telNo.equals("")))
        {
            number = telNo.substring(telNo.length() - 7);
            if (portion.equals("telno"))
            {
                telNo = number;
            }
        }

        return telNo;
    }

    /**
     * @param TelW The TelW to set.
     */
    public void setTelW(String TelW)
    {
        this.gsTelW = DBProxy.legalizeString(getValidNo(TelW));
    }

    /**
     * @return Returns the Title.
     */
    public String getTitle()
    {
        return gsTitle;
    }

    /**
     * @param Title The Title to set.
     */
    public void setTitle(String Title)
    {
        this.gsTitle = Title;
    }

    /**
     * @return Returns the UserName.
     */
    public String getUserName()
    {
        return gsUserName;
    }

    /**
     * @param UserName The UserName to set.
     */
    public void setUserName(String UserName)
    {
        this.gsUserName = DBProxy.legalizeString(UserName);
    }

    /**
     * @return Returns the Website.
     */
    public String getWebsite()
    {
        return gsWebsite;
    }

    /**
     * @param Website The Website to set.
     */
    public void setWebsite(String Website)
    {
        this.gsWebsite = DBProxy.legalizeString(Website);
    }

    /**
     * @return Returns the UserLevel.
     */
    public String getUserLevel()
    {
        return gsUserLevel;
    }

    /**
     * @param UserLevel The UserLevel to set.
     */
    public void setUserLevel(String UserLevel)
    {
        this.gsUserLevel = UserLevel;
    }

    /**
     * @return Returns the FKCustomer.
     */
    public String getFKCustomer()
    {
        return gsFKCustomer;
    }

    /**
     * @param FKCustomer The FKCustomer to set.
     */
    public void setFKCustomer(String FKCustomer)
    {
        this.gsFKCustomer = FKCustomer;
    }

    /**
     * @return Returns the CustName.
     */
    public String getCustName()
    {
        return gsCustName;
    }

    /**
     * @param gsCustName The CustName to set.
     */
    public void setCustName(String CustName)
    {
        this.gsCustName = CustName;
    }

    /**
     * @return Returns the assmtCounts.
     */
    public HashMap getAssmtCounts()
    {
        return assmtCounts;
    }

    /**
     * @param assmtCounts The assmtCounts to set.
     */
    public void setAssmtCounts(HashMap assmtCounts)
    {
        this.assmtCounts = assmtCounts;
    }

    /** 
     * @param key - the hash key 
     * @return Returns the integer count corresponding to 'key' in the assmtCounts map
     */
    public int getAssmtCount(String key)
    {
        return ((Integer) assmtCounts.get(key)).intValue();
    }

    /** Sets the value of a corresponding key in this User's assmtCounts map
     * @param key - the hash key
     * @param value - the value corresponding to the key
     */
    public void setAssmtCount(String key, int value)
    {
        this.assmtCounts.put(key, new Integer(value));
    }

    public String getFullName()
    {
        return fullName(this.gsTitle, this.gsFirstName, this.gsInitial, this.gsLastName);
    }

    /**
     * Loads the assignments (with associated Questionaires) assigned to a specific user. (sc_<43>)
     * 
     * TODO - ** Watch memory consumption here (Questionaire() is one of bigger obj's.. 
     * +Assignment() +QreType()! .. all in array[] compounded by possible concurrent usage)
     * 
     * @param db
     * @param userpk
     * @return - array of Assignment's
     * @throws Exception
     */
    public static Assignment[] getAssmts(DBProxy db, String userpk) throws Exception
    {
        // count assmts
        ResultSet res = db.executeQuery("SELECT * FROM countUserAssmts(" + userpk + ")");
        int count = 0;
        if (res.next())
        {
            count = res.getInt(1);
        }
        else
        {
            return null;
        }

        Assignment[] retVal = new Assignment[count];

        // retrieve assmts
        res = db.executeQuery(
                "SELECT q.pkid, q.name, q.descr, qt.pkid AS qtpkid, ts.descr AS tsdescr "
                + "FROM _Assignment a, Questionaire q, TEST_STATUS ts, QRE_TYPE qt "
                + "WHERE a.fkUser=" + userpk + " AND a.fkQ=q.pkid AND q.fkTypeID=qt.pkid AND a.fkTstStatus=ts.pkid "
                + "ORDER BY ts.descr, qt.pkid");

        int i = 0;
        while (res.next())
        {

            // construct assignment with qre&type + status_descr.
            // [**]
            retVal[i] = new Assignment(
                    new Questionaire(
                    new QreType(res.getInt("qtpkid")),
                    res.getString("pkid"), res.getString("name"), res.getString("descr")),
                    res.getString("tsdescr"));
            // ..init qre's #q's 
            retVal[i++].getQre().getTestLength(db);
        }

        return retVal;
    }

    /**
     * Returns an array of User's for a given customer (pk). If the parameter is null then all Users are retrieved.
     * NOTE: users data is not complete; only the following fields are
     * retrieved:
     * username, password, fname, lname, initial, title, customer_name
     * 
     * @param fkCustID pkid of customer to whom the users belong.
     * @return array of users
     * @throws Exception on database error
     */
    public static User[] getUsers(String fkCustID) throws Exception
    {
        User[] retVal;
        DBProxy db = new DBProxy();
        Vector users = new Vector();

        try
        {
            String allCustomerIds = null;

            if (fkCustID != null)
            {
                allCustomerIds = fkCustID;
                String childIds = getAllCustomerIds(fkCustID);
                if (childIds != null)
                {
                    allCustomerIds += ", " + childIds;
                }
            }

            // retrieve users
            ResultSet res = db.executeQuery(
                    "SELECT u.username, u.password, u.initial, u.fname, u.lname, u.title, c.name "
                    + "FROM Users u, Customer c "
                    + "WHERE (u.fkCustID=c.pkid) AND (u.fkLevel = 3)"
                    + ((fkCustID != null) ? " AND fkCustID IN (" + allCustomerIds + ")" : "")
                    + " AND (c.isdisabled=false) "
                    + " ORDER BY u.lname, u.fname");
            while (res.next())
            {
                users.add(new User(true,
                                   null, null,
                                   res.getString("username"), res.getString("password"),
                                   res.getString("initial"), res.getString("fname"),
                                   res.getString("lname"), res.getString("title"),
                                   null, null,
                                   null, null,
                                   null, null,
                                   null, null,
                                   res.getString("name")));
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

        retVal = new User[users.size()];
        for (int i = 0; i < users.size(); i++)
        {
            retVal[i] = (User) users.get(i);
        }

        return retVal;
    }

    public static User[] getUsersByAssessmentId(String assessmentId, boolean excludeCompleted) throws Exception
    {

        User[] retVal;
        DBProxy db = new DBProxy();
        Vector users = new Vector();

        try
        {

            // retrieve users
            String sql = "SELECT u.pkid, u.username, u.password, u.initial, u.fname, u.lname, u.title, c.name "
                    + "FROM Users u, _assignment a, customer c "
                    + "WHERE a.fkq="+ assessmentId +" AND u.pkid=a.fkuser "
                    + "AND u.fklevel=3 "
                    + "AND c.pkid=u.fkcustid "
                    + ((excludeCompleted) ? "AND a.fktststatus=0 " : "")
                    + "ORDER BY u.lname, u.fname";

            ResultSet res = db.executeQuery(sql);
            while (res.next())
            {
                users.add(new User(res.getString("pkid"),
                                   res.getString("username"),
                                   res.getString("fname"),
                                   res.getString("lname"),
                                   res.getString("name")));
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

        retVal = new User[users.size()];
        for (int i = 0; i < users.size(); i++)
        {
            retVal[i] = (User) users.get(i);
        }

        return retVal;
    }    

    private static String getAllCustomerIds(String rootCustomerId) throws Exception
    {
        Vector customerIds = new Vector();
        String sql = "SELECT pkid FROM customer WHERE fkparentcust=" + rootCustomerId;
        DBProxy db = new DBProxy();

        try
        {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next())
            {
                String pkid = rs.getString("pkid");
                customerIds.add(pkid);
            }
        }
        finally
        {
            db.close();
        }

        String pkids = null;

        for (int i = 0; i < customerIds.size(); i++)
        {
            String pkid = (String) customerIds.get(i);

            if (i == 0)
            {
                pkids = pkid;
            }
            else
            {
                pkids += ", " + pkid;
            }

            String childIds = getAllCustomerIds(pkid);
            if (childIds != null)
            {
                pkids += ", " + childIds;
            }
        }

        return pkids;
    }

    /**
     * Will search the database for the user(s) matching the criteria.
     * @param username The username to search
     * @param firstname The first name to search
     * @param lastname The last name to search
     * @return All the users matching the search criteria
     * @throws Exception
     */
    public static User[] searchForUser(String username, String firstname,
                                       String lastname, String fkCustID) throws Exception
    {
        Vector users = new Vector();
        DBProxy db = new DBProxy();

        if (username.equals(""))
        {
            username = null;
        }

        if (lastname.equals(""))
        {
            lastname = null;
        }

        if (firstname.equals(""))
        {
            firstname = null;
        }

        String allCustomerIds = null;

        if (fkCustID != null)
        {
            allCustomerIds = fkCustID;
            String childIds = getAllCustomerIds(fkCustID);
            if (childIds != null)
            {
                allCustomerIds += ", " + childIds;
            }
        }

        String sql = "SELECT u.username, u.password, u.initial, u.fname, u.lname, u.title, c.name "
                     + "FROM Users u, Customer c "
                     + "WHERE (u.fkCustID=c.pkid) AND (u.fkLevel = 3)"
                     + ((username != null) ? " AND LOWER(u.username) LIKE '%" + username.toLowerCase() + "%'" : "")
                     + ((firstname != null) ? " AND LOWER(u.fname) LIKE '%" + firstname.toLowerCase() + "%'" : "")
                     + ((lastname != null) ? " AND LOWER(u.lname) LIKE '%" + lastname.toLowerCase() + "%'" : "")
                     + ((fkCustID != null) ? " AND fkCustID IN (" + allCustomerIds + ")" : "")
                     + " AND (c.isdisabled=false) "
                     + " ORDER BY c.name, u.lname, u.fname";
        try
        {
            ResultSet res = db.executeQuery(sql);
            while (res.next())
            {
                users.add(new User(true,
                                   null, null,
                                   res.getString("username"), res.getString("password"),
                                   res.getString("initial"), res.getString("fname"),
                                   res.getString("lname"), res.getString("title"),
                                   null, null,
                                   null, null,
                                   null, null,
                                   null, null,
                                   res.getString("name")));
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            db.close();
        }

        User[] usersArray = new User[users.size()];

        for (int i = 0; i < users.size(); i++)
        {
            usersArray[i] = (User) users.get(i);
        }

        return usersArray;
    }

    /**
     * Will search the database for the skill(s) matching the criteria.
     * @param skillssummary The skills summary
     * @param skillsqualification The skills qualifications
     * @param qualification The qualifications
     * @return All the users matching the search criteria
     * @throws Exception
     */
    public static User[] searchForSkills(String skillssummary, String skillsqualifications,
                                       String qualifications, String fkCustID) throws Exception
    {
        Vector users = new Vector();
        DBProxy db = new DBProxy();

        if (skillssummary.equals(""))
        {
            skillssummary = null;
        }

        if (skillsqualifications.equals(""))
        {
            skillsqualifications = null;
        }

        if (qualifications.equals(""))
        {
            qualifications = null;
        }

        String allCustomerIds = null;

        if (fkCustID != null)
        {
            allCustomerIds = fkCustID;
            String childIds = getAllCustomerIds(fkCustID);
            if (childIds != null)
            {
                allCustomerIds += ", " + childIds;
            }
        }

        String sql = "SELECT u.username, u.password, u.initial, u.fname, u.lname, u.title, c.name "
                     + "FROM Users u, Customer c, usercvdetail cv "
                     + "WHERE (u.fkCustID=c.pkid) AND (u.fkLevel = 3) "
                     + "AND cv.pkid = u.resume_fkid"
                     + ((skillssummary != null) ? " AND LOWER(cv.skillssummary) LIKE '%" + skillssummary.toLowerCase() + "%'" : "")
                     + ((skillsqualifications != null) ? " AND LOWER(cv.qualificationdetails) LIKE '%" + skillsqualifications.toLowerCase() + "%'" : "")
                     + ((qualifications != null) ? " AND LOWER(cv.tradequalifications) LIKE '%" + qualifications.toLowerCase() + "%'" : "")
                     + ((fkCustID != null) ? " AND fkCustID IN (" + allCustomerIds + ")" : "")
                     + " AND (c.isdisabled=false) "
                     + " ORDER BY u.lname, u.fname";
        try
        {
            ResultSet res = db.executeQuery(sql);
            while (res.next())
            {
                users.add(new User(true,
                                   null, null,
                                   res.getString("username"), res.getString("password"),
                                   res.getString("initial"), res.getString("fname"),
                                   res.getString("lname"), res.getString("title"),
                                   null, null,
                                   null, null,
                                   null, null,
                                   null, null,
                                   res.getString("name")));
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            db.close();
        }

        User[] usersArray = new User[users.size()];

        for (int i = 0; i < users.size(); i++)
        {
            usersArray[i] = (User) users.get(i);
        }

        return usersArray;
    }

    /**
     * Similar to getUsers(). Also counts assignment-/types per user;
     * the following fields are retrieved:
     * => username, fname, lname, initial, title, customer_code
     * The following assignment counts are calculated:
     * => type:[VA, FA, JP], status:[not_started, in_progress, completed];
     * 
     * @param fkCustID pkid of customer to whom the users belong.
     * @return array of users
     * @throws Exception on database error
     */
    public static User[] getAssmtUsers(String fkCustID) throws Exception
    {
        User[] retVal;
        DBProxy db = new DBProxy();

        try
        {
            // count users
            ResultSet res = db.executeQuery(
                    "SELECT COUNT(*) as cnt "
                    + "FROM Users WHERE fkLevel = 3"
                    + ((fkCustID != null) ? " AND fkCustID=" + fkCustID : ""));
            res.next();
            retVal = new User[res.getInt("cnt")];

            // retrieve users
            res = db.executeQuery(
                    "SELECT u.pkid, u.username, u.initial, u.fname, u.lname, u.title, c.code "
                    + "FROM Users u, Customer c "
                    + "WHERE (u.fkCustID=c.pkid) AND (u.fkLevel = 3)"
                    + ((fkCustID != null) ? " AND fkCustID=" + fkCustID : "")
                    + " ORDER BY c.code, u.lname, u.username");
            int i = 0;
            while (res.next())
            {
                retVal[i] = new User(true,
                                     null, null,
                                     res.getString("username"), null,
                                     res.getString("initial"), res.getString("fname"),
                                     res.getString("lname"), res.getString("title"),
                                     null, null,
                                     null, null,
                                     null, null,
                                     null, null,
                                     res.getString("code"));
                retVal[i].setPKID(res.getString("pkid"));

                // assignment counts..
                retVal[i].setAssmtCounts(User.initAssmtCounts());
                // .. qre types
                User.loadCountQreTypes(db, retVal[i]);
                // .. assmt status
                User.loadCountAssmtStatus(db, retVal[i]);
                // .. total;  (WARNING: risky.. reusing var:website)
                User.loadCountAssmtTotal(db, retVal[i]);


                i++;
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

        return retVal;
    }

    private static void loadCountQreTypes(DBProxy db, User user) throws Exception
    {
        ResultSet res = db.executeQuery(
                "SELECT fkTypeID as type, COUNT(*) "
                + "FROM Questionaire q, _Assignment a "
                + "WHERE q.pkid=a.fkQ AND a.fkUser=" + user.getPKID()
                + " GROUP BY type");
        while (res.next())
        {
            switch (res.getInt("type"))
            {
                case 1:		// VA
                    user.setAssmtCount(User.QT_VA, res.getInt(2));
                    break;
                case 2:		// FA
                    user.setAssmtCount(User.QT_FA, res.getInt(2));
                    break;
                case 3:		// JP
                    user.setAssmtCount(User.QT_JP, res.getInt(2));
                    break;
                case 4:		// SI
                    user.setAssmtCount(User.QT_SI, res.getInt(2));
                    break;
                case 5:		// PP
                    user.setAssmtCount(User.QT_PP, res.getInt(2));
                    break;
                case 6:		// HA
                    user.setAssmtCount(User.QT_HA, res.getInt(2));
                    break;
                case 7:		// CP
                    user.setAssmtCount(User.QT_CP, res.getInt(2));
                    break;
            }
        }
    }

    private static void loadCountAssmtStatus(DBProxy db, User user) throws Exception
    {
        ResultSet res = db.executeQuery(
                "SELECT fkTstStatus as status, COUNT(*) "
                + "FROM _Assignment a "
                + "WHERE a.fkUser=" + user.getPKID()
                + " GROUP BY status");
        while (res.next())
        {
            switch (res.getInt("status"))
            {
                case 0:		// not started
                    user.setAssmtCount(User.AS_NS, res.getInt(2));
                    break;
                case 1:		// in progress
                    user.setAssmtCount(User.AS_IP, res.getInt(2));
                    break;
                case 2:		// completed
                    user.setAssmtCount(User.AS_CP, res.getInt(2));
                    break;
            }
        }
    }

    private static void loadCountAssmtTotal(DBProxy db, User user) throws Exception
    {
        // (WARNING: risky.. reusing var:website)
        ResultSet res = db.executeQuery("SELECT COUNT(*) FROM _Assignment WHERE fkUser=" + user.getPKID());
        if (res.next())
        {
            user.setWebsite(res.getString(1));
        }
        else
        {
            user.setWebsite("0");
        }
    }

    private static HashMap initAssmtCounts()
    {
        HashMap retVal = new HashMap(6);

        // qre types
        retVal.put("QT_VA", new Integer(0));
        retVal.put("QT_FA", new Integer(0));
        retVal.put("QT_JP", new Integer(0));
        retVal.put("QT_SI", new Integer(0));
        retVal.put("QT_PP", new Integer(0));
        retVal.put("QT_HA", new Integer(0));
        retVal.put("QT_CP", new Integer(0));

        // assmt status
        retVal.put("AS_NS", new Integer(0));	// not started
        retVal.put("AS_IP", new Integer(0));	// in progress
        retVal.put("AS_CP", new Integer(0));	// completed

        return retVal;
    }

    public static String fullName(String title, String fname, String initial, String lname)
    {
        return ((title != null && !title.equals("")) ? title + " " : "")
               + fname + " "
               + ((initial != null && !initial.equals("")) ? initial + " " : "")
               + lname;
    }
}

