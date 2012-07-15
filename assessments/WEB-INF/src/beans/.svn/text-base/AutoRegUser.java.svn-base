/* AutoRegUser.java
 * 
 * Created on 24-Aug-2005
 */
package beans;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Vector;

import org.apache.log4j.*;

import mail.MailSender;
import utils.HashUtils;

/**
 * This class extends beans.User by adding a hq field, and also by encapsulating Address objects. 
 * It is customized for "auto registration users, or users that register themselves online.
 * 
 * @author psnel
 *
 */
public class AutoRegUser extends User
{

    public static final int HQ_NONE = 0;
    public static final int HQ_GR10 = 1;
    public static final int HQ_GR12 = 2;
    public static final int HQ_DIPL = 3;
    public static final int HQ_UNC = 4;
    public static final int HQ_B = 5;
    public static final int HQ_HONS = 6;
    public static final int HQ_M = 7;
    public static final int HQ_PHD = 8;
    private static String[] _hq =
    {
        "N/A",
        "High School - Grade 10",
        "High School - Grade 12 (matric)",
        "College Diploma",
        "University Course",
        "Bachelors Degree",
        "Postgraduate Degree (Honours)",
        "Postgraduate Degree (Masters)",
        "Postgraduate Degree (Doctors)"
    };
    private int hq = HQ_NONE;		// highest qualification (see constants HQ_*)
    private boolean emailOK = false;	// status (F:email confirm pending / T:payment verify pending)
    private Timestamp tsSubmittime;	// db-timestamp of when user submitted registration
    private Address addrHome;		// home address
    private Address addrPost;		// postal address

    public AutoRegUser()
    {
        super();
        addrHome = new Address();
        addrPost = new Address();
    }

    public AutoRegUser(String username)
    {
        this.gsUserName = username;
    }

    public AutoRegUser(String username, String fname, String lname, String initial,
                       String title, boolean emailok,
                       Timestamp tsSubmittime, String compref, String password)
    {
        this.gsUserName = username;
        this.gsFirstName = fname;
        this.gsLastName = lname;
        this.gsTitle = title;
        this.gsInitial = initial;
        this.gsCompanyRef = compref;
        this.tsSubmittime = tsSubmittime;
        this.emailOK = emailok;
        this.gsPassword = password;
    }

    /*
     * Overriding method that also checks for usernames in the pending Registrations table.
     * @see beans.User#exists()
     */
    @Override
    public boolean exists() throws Exception
    {
        DBProxy db = null;
        ResultSet res = null;
        try
        {
            db = new DBProxy();

            res = db.executeQuery(
                    "SELECT pkid FROM Users WHERE username='" + gsUserName + "' "
                    + "UNION "
                    + "SELECT pkid FROM Registration WHERE username='" + gsUserName + "'");

        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            db.close();
        }

        return res.next();
    }

    @Override
    public void commit() throws Exception
    {

        DBProxy db = null;

        try
        {
            db = new DBProxy();

            String SQL = "SELECT nextval('registration_pkid_seq')";
            ResultSet rs = db.executeQuery(SQL);
            String userId = null;

            if (rs.next())
            {
                userId = rs.getString("nextval");
                setPKID(userId);
            }

            if (userId == null)
            {
                throw new Exception("Failed to get the next User ID");
            }

            // Save the general user details
            SQL =
            "INSERT INTO Registration (pkid, "
            + "username, password, initial, fname, lname, title, "
            + "idnum, compRef, telH, telW, fax, cell, email,"
            + "addrH1, addrH2, addrH3, addrH4, addrP1, addrP2, addrP3, "
            + "addrP4, hq, fkcustid) "
            + "VALUES ("
            + getPKID() + ", "
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
            + addrHome.csv4String() + ","
            + addrPost.csv4String() + "," + hq + "," + gsFKCustomer
            + ")";

            db.executeNonQuery(SQL);

            if ((getResume() != null) && (getResume().isValid()))
            {
                Logger log = Logger.getLogger(AutoRegUser.class);
                log.info("Saving the Resume");
                getResume().save(userId, db);

                String sql = "UPDATE registration SET resume_fkid=" + getResume().getPKID() + " WHERE pkid=" + getPKID();
                db.executeNonQuery(sql);
            }
            else
            {
                Logger log = Logger.getLogger(AutoRegUser.class);
                log.info("The Resume is null");
            }

        }
        catch (Exception e)
        {
            Logger log = Logger.getLogger(AutoRegUser.class);
            log.error("Failed to save the new user: " + e.toString());
            throw e;
        }
        finally
        {
            db.close();
        }

    }

    /* Deletes the entry with associated username from the Registration table.
     * 
     * @see beans.User#delete()
     */
    @Override
    public void delete() throws Exception
    {
        DBProxy db = new DBProxy();

        try
        {
            db.executeNonQuery("DELETE FROM Registration WHERE username='" + gsUserName + "'");
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

    public static String generateKey(String username) throws Exception
    {
        String md5Key = null;

        DBProxy db = new DBProxy();

        try
        {
            // get username + timestamp..
            ResultSet res = db.executeQuery(
                    "SELECT submittime FROM Registration WHERE username='" + username + "'");

            if (res.next())
            {
                String tmpTime = res.getString("submittime");

                // run MD5 on username + timestamp => key
                md5Key = HashUtils.md5(username + "!" + tmpTime);

            }
            else
            { // ..invalid user - Exception!
                throw new Exception("User '" + username + "' does not exist");
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

        return md5Key;
    }

    public boolean hasValidRef() throws Exception
    {
        boolean hasValid = false;

        // none.. use default
        // Removed the default
        /*if (this.gsCompanyRef == null || this.gsCompanyRef.equals(""))
        {
        this.gsCompanyRef = "IPI0";
        this.gsFKCustomer = getCustomerId(gsCompanyRef);
        hasValid = true;
        }*/

        if (gsCompanyRef.equals("NEW") || gsCompanyRef.equals("CPA"))
        {
            this.gsFKCustomer = getCustomerId(gsCompanyRef);
            hasValid = true;
        }

        if (!hasValid)
        {
            DBProxy db = new DBProxy();

            // check for advert ref# (cust_code + ad_pk)
            try
            {
                ResultSet res = db.executeQuery(
                        "SELECT c.pkid FROM Customer c, Advert a "
                        + "WHERE a.fkcustid=c.pkid AND (c.code || a.pkid) = '" + this.gsCompanyRef + "'");
                if (res.next())
                {
                    hasValid = true;
                    gsFKCustomer = res.getString("pkid");
                }
                else
                {
                    hasValid = false;
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

        return hasValid;
    }

    public void loadDetails() throws Exception
    {
        loadDetails(false);
    }

    public void loadDetails(boolean loadExtended) throws Exception
    {
        if (gsUserName == null)
        {
            throw new Exception("No username specified");
        }

        DBProxy db = new DBProxy();
        ResultSet res;
        String SQL = (!loadExtended)
                     ? "SELECT password, fname, lname, initial, title, email, emailOK, resume_fkid "
                       + "FROM Registration "
                       + "WHERE username='" + gsUserName + "'"
                     : "SELECT * FROM Registration WHERE username='" + gsUserName + "'";

        // db load user details
        try
        {
            res = db.executeQuery(SQL);
            if (res.next())
            {
                this.gsPassword = res.getString("password");
                this.gsFirstName = res.getString("fname");
                this.gsLastName = res.getString("lname");
                this.gsInitial = res.getString("initial");
                this.gsTitle = res.getString("title");
                this.gsEMail = res.getString("email");
                this.emailOK = res.getBoolean("emailOK");
                this.resumeFKID = res.getString("resume_fkid");

                if (loadExtended)
                {
                    this.gsCompanyRef = res.getString("compref");
                    this.gsIDNum = res.getString("idnum");
                    this.gsTelH = res.getString("telh");
                    this.gsTelW = res.getString("telh");
                    this.gsTelFax = res.getString("fax");
                    this.gsTelCell = res.getString("cell");

                    this.hq = res.getInt("hq");

                    Address addrTmp = new Address(
                            res.getString("addrH1"),
                            res.getString("addrH2"),
                            res.getString("addrH3"),
                            res.getString("addrH4"), null, "1");
                    if (!addrTmp.isEmpty())
                    {
                        this.addrHome = addrTmp;
                    }

                    addrTmp = new Address(
                            res.getString("addrP1"),
                            res.getString("addrP2"),
                            res.getString("addrP3"),
                            res.getString("addrP4"), null, "3");
                    if (!addrTmp.isEmpty())
                    {
                        this.addrPost = addrTmp;
                    }

                    this.tsSubmittime = res.getTimestamp("submittime");

                    // load resume
                    if (getResume() == null)
                    {
                        setResume(new AutoRegResume());
                    }

                    if ((getResumeFKID() != null) && (!getResumeFKID().equals("")))
                    {
                        getResume().load(getResumeFKID(), true);
                    }
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

    public void updateStatus() throws Exception
    {
        if (this.gsUserName == null)
        {
            throw new Exception("No username specified");
        }
        if (emailOK)
        {
            return;
        }

        // update status to emailOK=true (i.e. pending payment verification)
        DBProxy db = new DBProxy();
        try
        {
            db.executeNonQuery(
                    "UPDATE Registration SET "
                    + "emailOK=TRUE,"
                    + "submittime=now() "
                    + "WHERE username='" + gsUserName + "'");
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

    private String createConfirmationBody1()
    {
        return "PLEASE DO NOT REPLY TO THIS MESSAGE\n"
               + "- - - - - - - - - - - - - - - - - -\n"
               + "\n"
               + "Hello " + getFullName() + ",\n"
               + "\n"
               + "This e-mail provides you with your login details. "
               + "Please save it in a safe place.\n"
               + "\n"
               + "\n"
               + "1. YOUR ACCOUNT DETAILS\n"
               + "-----------------------\n"
               + "\n"
               + "Username: " + this.gsUserName + "\n"
               + "Password: " + this.gsPassword + "\n"
               + "\n"
               + "(NOTE: The above login details will only work once your assessment has been authorised by the company. "
               + "You will be notified via e-mail once this is done.)"
               + "\n"
               + "\n"
               + "2. PLEASE TAKE NOTE\n"
               + "----------------------\n"
               + "\n"
               + "- This is not a test.  There is no right or wrong answer.  Your answer is the correct one.\n"
               + "- Do not try to manipulate the answers to reflect what you think we should see.  "
               + "This will be detected and your results will be unreliable, which will affect you.\n"
               + "- Be honest and open.\n"
               + "- The results of this assessment will assist us to help you achieve the maximum from your inner potential.\n"
               + "\n"
               + "\n"
               + "Thank You.\n"
               + "Functional Intelligence Team\n"
               + "\n"
               + "[ FQ Global Limited. ]\n"
               + "- \"...helping you reach your true potential!\""
               + "\n\n"
               + "- - -\nvisit our website at www.functionalaudit.com\n\n"
               + "Disclaimer:\nYou have received this e-mail because you, or someone else have submitted "
               + "a query on our website. If you did not request it - simply delete the message. If you "
               + "receive repeated unwanted from us, please inform us via our contact page on our website.\n";
    }

    private String createNewCandidateBody(Customer accountCustomer)
    {
        return "PLEASE DO NOT REPLY TO THIS MESSAGE\n"
               + "- - - - - - - - - - - - - - - - - -\n"
               + "\n"
               + "Hello " + accountCustomer.getUser().getFullName()
               + " (" + accountCustomer.getUser().getUserName() + "),\n"
               + "\n"
               + "This is an automated response to inform you that a new candidate " + getFullName() + " registered "
               + "to the " + accountCustomer.getName() + " Organization / Downline.\n"
               + "\n"
               + "http://www.functionalaudit.com/\n"
               + "\n"
               + "Thank You.\n"
               + "\n"
               + "[ FQ Global Limited. ]\n"
               + "- \"...helping you reach your true potential!\""
               + "\n\n"
               + "- - -\nvisit our website at www.functionalaudit.com\n\n";
    }

    public void mailConfirmation1() throws Exception
    {

        String MsgSubject = "Functional Intelligence Registration Summary";
        String MsgBody = createConfirmationBody1();

        Logger log = Logger.getLogger(AutoRegUser.class);
        log.info("Going to send cofirmation email 1");
        log.info("Sender: Functional Intelligence Registration <no-reply@functionalaudit.com>");
        log.info("Subject: " + MsgSubject);

        if (!(new MailSender()).doPost(
                "Functional Intelligence Registration <no-reply@functionalaudit.com>",
                this.gsEMail, "", "",
                MsgSubject,
                MsgBody))
        {
            log.error("Failed to send cofirmation email 1");
            log.error("Sender: Functional Intelligence Registration <no-reply@functionalaudit.com>");
            log.error("Subject: " + MsgSubject);

            // Mail ERROR:
            throw new Exception("Sending e-mail failed");
        }

        mailAccountManager();

    }

    private String getCustomerId(String companyRef) throws Exception
    {
        String customerId = null;

        String companyCode = companyRef.substring(0, 3);
        DBProxy db = new DBProxy();
        ResultSet res = null;
        String sql = "SELECT pkid FROM customer WHERE code='" + companyCode + "'";
        res = db.executeQuery(sql);

        if (res.next())
        {
            customerId = res.getString("pkid");
        }
        else
        {
            res.close();
            sql = "SELECT pkid FROM customer WHERE fkrootcust=-999";
            res = db.executeQuery(sql);

            if (res.next())
            {
                customerId = res.getString("pkid");
            }
        }

        return customerId;
    }

    private Customer getAccountCustomer(String customerId) throws Exception
    {
        Customer customer = new Customer(customerId);
        customer.loadFromDB(true);
        return customer;
    }

    public void mailConfirmation3() throws Exception
    {

        String MsgSubject = "Functional Intelligence Assessment Authorised";
        String MsgBody = "PLEASE DO NOT REPLY TO THIS MESSAGE\n"
                         + "- - - - - - - - - - - - - - - - - -\n"
                         + "\n"
                         + "Hello again " + getFullName() + ",\n"
                         + "\n"
                         + "We'd like to inform you that your assessment has been authorised and you are able to log into "
                         + "the website.\n"
                         + "\n"
                         + "Please follow the link below to go to the LOGIN page:\n"
                         + "\n"
                         + "http://www.functionalaudit.com/?pg=-1\n"
                         + "\n"
                         + "Thank You.\n"
                         + "Functional Intelligence Team\n"
                         + "\n"
                         + "[ FQ Global Limited. ]\n"
                         + "- \"...helping you reach your true potential!\""
                         + "\n\n"
                         + "- - -\nvisit our website at www.functionalaudit.com\n\n"
                         + "Disclaimer:\nYou have received this e-mail because you, or someone else have submitted "
                         + "a query on our website. If you did not request it - simply delete the message. If you "
                         + "receive repeated unwanted from us, please inform us via our contact page on our website.\n";


        Logger log = Logger.getLogger(AutoRegUser.class);
        log.info("Going to send cofirmation email 3");
        log.info("Sender: Functional Intelligence Registration <no-reply@functionalaudit.com>");
        log.info("Subject: " + MsgSubject);

        if (!(new MailSender()).doPost(
                "Functional Intelligence Registration <no-reply@functionalaudit.com>",
                this.gsEMail, "", "",
                MsgSubject,
                MsgBody))
        {
            log.error("Failed to send cofirmation email 3");
            log.error("Sender: Functional Intelligence Registration <no-reply@functionalaudit.com>");
            log.error("Subject: " + MsgSubject);

            // Mail ERROR:
            throw new Exception("Sending e-mail failed [e-mail:" + this.gsEMail + "]");
        }


    }

    public void register(String qreID) throws Exception
    {
        Logger log = Logger.getLogger(AutoRegUser.class);

        if (this.gsUserName == null)
        {
            throw new Exception("No user specified");
        }

        boolean assignQuestionnaire = (!qreID.equals("-1"));
        int availableCredits = 0;
        Customer customer = null;

        // If we assign Q then get available credits
        if (assignQuestionnaire)
        {
            customer = new Customer(gsFKCustomer);
            customer.loadFromDB(false);
            availableCredits = customer.getCredits();
        }

        //System.out.println("register new user; custid("+this.gsFKCustomer+") / qreid("+qreID+")");

        DBProxy db = new DBProxy();
        try
        {
            // promote user (+addresses) to user (+address) table

            // ..begin transaction
            db.executeNonQuery("BEGIN");

            // ..get user pkid
            ResultSet res = db.executeQuery("SELECT nextval('users_pkid_seq')");
            if (res.next())
            {
                this.gsPKID = res.getString(1);
            }

            log.info("Comitting user, pkid: " + getPKID());

            // ..store user
            super.commit(db);

            log.info("save addresses with userpk=" + this.gsPKID);

            // ..save addresses
            if (this.addrHome != null)
            {
                this.addrHome.setFkUserID(this.gsPKID);
                this.addrHome.commit(db);
            }

            if (this.addrPost != null)
            {
                this.addrPost.setFkUserID(this.gsPKID);
                this.addrPost.commit(db);
            }

            // ..save qualification
            if (this.hq != HQ_NONE)
            {
                db.executeNonQuery(
                        "INSERT INTO Qualification (fkUsrID, fkQCode) "
                        + "VALUES (" + this.gsPKID + "," + this.hq + ")");
            }


            // ..save assignment (note: implementation specific "-1" = no qre)
            if ((assignQuestionnaire) && (availableCredits > 0))
            {
                Assignment assmt = new Assignment(this.gsPKID, qreID, "0");
                assmt.commit(db);
            }

            // ..save the cv details
            if ((getResume() != null) && (getResume().isValid()))
            {
                getResume().save(db);
            }

            // ..delete pending user            
            db.executeNonQuery("DELETE FROM Registration WHERE username='" + gsUserName + "'");

            // ..delete resume
            if ((getResume() != null) && (getResume().isValid()))
            {
                getResume().delete(db);
            }

            // ..e-mail payment/activation to user
            mailConfirmation3();

            // ..commit the transaction
            db.executeNonQuery("COMMIT");

            // If we assigned a Q then deduct credits
            if (assignQuestionnaire)
            {
                customer.setCredits(availableCredits - 1);
                customer.update();
            }
        }
        catch (Exception e)
        {
            // ..rollback transaction
            db.executeNonQuery("ROLLBACK");
            log.error(e.toString());
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    private static String getCustomerCode(String customerId) throws Exception
    {
        String customerCode = null;
        Customer customer = new Customer(customerId);
        customer.loadFromDB(false);
        customerCode = customer.getCode();
        return customerCode;
    }

    public static AutoRegUser[] getUsers(boolean emailok, boolean all) throws Exception
    {
        return getUsers(emailok, all, null);
    }

    public static AutoRegUser[] getUsers(boolean emailok, boolean all,
                                         String customerId) throws Exception
    {
        AutoRegUser[] retVal = null;

        DBProxy db = new DBProxy();
        Vector registrations = new Vector();

        String SQL2 = null;

        if (all)
        {
            SQL2 = "SELECT username, fname, lname, initial, title, emailok, "
                   + "submittime, password, compref "
                   + "FROM Registration ";

            if (customerId != null)
            {
                SQL2 += "WHERE fkcustid =" + customerId + " ";
            }

            SQL2 += "ORDER BY emailok, submittime";
        }
        else
        {
            SQL2 = "SELECT username, fname, lname, initial, title, emailok, "
                   + "submittime, password, compref "
                   + "FROM Registration WHERE emailok=" + emailok;

            if (customerId != null)
            {
                SQL2 += "WHERE fkcustid =" + customerId + " ";
            }

            SQL2 += " ORDER BY submittime";
        }

        try
        {
            ResultSet res = db.executeQuery(SQL2);

            while (res.next())
            {
                registrations.add(new AutoRegUser(
                        res.getString("username"),
                        res.getString("fname"),
                        res.getString("lname"),
                        res.getString("initial"),
                        res.getString("title"),
                        res.getBoolean("emailok"),
                        res.getTimestamp("submittime"),
                        res.getString("compref"),
                        res.getString("password")));
            }

            retVal = new AutoRegUser[registrations.size()];
            for (int i = 0; i < registrations.size(); i++)
            {
                retVal[i] = (AutoRegUser) registrations.get(i);
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

    /**
     * @return Returns the addrHome.
     */
    public Address getAddrHome()
    {
        return addrHome;
    }

    /**
     * @param addrHome The addrHome to set.
     */
    public void setAddrHome(Address addrHome)
    {
        this.addrHome = addrHome;
    }

    /**
     * @return Returns the addrPost.
     */
    public Address getAddrPost()
    {
        return addrPost;
    }

    /**
     * @param addrPost The addrPost to set.
     */
    public void setAddrPost(Address addrPost)
    {
        this.addrPost = addrPost;
    }

    /**
     * @return Returns the hq.
     */
    public int getQualification()
    {
        return hq;
    }

    /**
     * @param hq The hq to set.
     */
    public void setQualification(int hq)
    {
        this.hq = hq;
    }

    /**
     * @return Returns the emailOK.
     */
    public boolean isEmailOK()
    {
        return emailOK;
    }

    /**
     * @param emailOK The emailOK to set.
     */
    public void setEmailOK(boolean emailOK)
    {
        this.emailOK = emailOK;
    }

    /**
     * @return Returns the tsSubmittime.
     */
    public Timestamp getSubmittime()
    {
        return tsSubmittime;
    }

    /**
     * @param tsSubmittime The tsSubmittime to set.
     */
    public void setSubmittime(Timestamp tsSubmittime)
    {
        this.tsSubmittime = tsSubmittime;
    }

    public static String getQualificationString(int hq)
    {
        if (hq > HQ_PHD || hq < HQ_NONE)
        {
            return null;
        }
        else
        {
            return _hq[hq];
        }
    }

    private void mailAccountManager() throws Exception
    {
        // Mail the accounts manager
        Customer accountCustomer = null;
        User accountManager = null;
        String customerId = getCustomerId(getCompanyRef());
        try
        {
            accountCustomer = getAccountCustomer(customerId);
            accountManager = accountCustomer.getUser();
        }
        catch (Exception ex)
        {
            throw new Exception("Failed: " + ex.getMessage() + "customerId = " + customerId);
        }

        String MsgSubject = "New candidate registered. Activation required.";
        String MsgBody = "";

        try
        {
            MsgBody = createNewCandidateBody(accountCustomer);
        }
        catch (Exception ex)
        {
            throw new Exception("Failed: Customer = " + accountCustomer + " CustomerId = " + customerId);
        }

        Logger log = Logger.getLogger(AutoRegUser.class);
        log.info("Going to send account manager email");
        log.info("Sender: Functional Intelligence Registration <no-reply@functionalaudit.com>");
        log.info("Subject: " + MsgSubject);

        if (!(new MailSender()).doPost(
                "Functional Intelligence Registration <no-reply@functionalaudit.com>",
                accountManager.getEMail(), "", "",
                MsgSubject,
                MsgBody))
        {
            log.error("Failed to send manager email");
            log.error("Sender: Functional Intelligence Registration <no-reply@functionalaudit.com>");
            log.error("Subject: " + MsgSubject);

            // Mail ERROR:
            throw new Exception("Sending account manager e-mail failed");
        }
    }
}
