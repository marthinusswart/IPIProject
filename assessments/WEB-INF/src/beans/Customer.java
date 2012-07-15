package beans;

import java.sql.ResultSet;
import java.util.Vector;
import org.apache.log4j.Logger;

/**
 * @author psnel
 *
 */
public class Customer
{

    private String gsPKID;			// primary key in the db
    private String gsName;			// name for the customer
    private int giCredits = 0;	// number of credits assigned
    private String gsCode;			// 3-letter prefix code
    private int giFKRootCust = -999;		// fkid of root customer
    private int giFKParentCust = -999;	// fkid of parent customer
    private int giLevel = 0;		// hierarchichal depth of this customer (dept) within its organization
    private int giNumIndivs;	// number of individuals registered under this customer
    private User guUser;			// user representing the customer
    private Address gaAddress;		// customer premesis
    private boolean disabled;
    private String gsUserId;
    private String gsLogo = "";

    public Customer()
    {
    }

    public Customer(String pkid)
    {
        this.gsPKID = pkid;

    }

    public Customer(String pkid, String name, String userId)
    {
        gsPKID = pkid;
        gsName = name;
        gsUserId = userId;
    }

    public Customer(String name, int credits)
    {
        gsName = DBProxy.legalizeString(name);
        giCredits = credits;
    }

    public Customer(String pkid, String name, int credits)
    {
        gsPKID = pkid;
        gsName = DBProxy.legalizeString(name);
        giCredits = credits;
    }

    public Customer(String pkid, String name, int credits, String code)
    {
        gsPKID = pkid;
        gsName = DBProxy.legalizeString(name);
        giCredits = credits;
        gsCode = code;
    }

    public Customer(String pkid, String name, int credits, String code,
            int level)
    {
        gsPKID = pkid;
        gsName = DBProxy.legalizeString(name);
        giCredits = credits;
        gsCode = code;
        giLevel = level;
    }

    public Customer(String pkid, String name, int credits, String code, 
            int level, boolean isDisabled)
    {
        gsPKID = pkid;
        gsName = DBProxy.legalizeString(name);
        giCredits = credits;
        gsCode = code;
        giLevel = level;
        disabled = isDisabled;
    }

    public Customer(String pkid, String name, int credits, String code,
                    boolean isDisabled)
    {
        gsPKID = pkid;
        gsName = DBProxy.legalizeString(name);
        giCredits = credits;
        gsCode = code;
        disabled = isDisabled;
    }

    /**
     * Load local variables with database data
     *
     *
     * @throws Exception
     */
    public void loadFromDB(boolean loadExtendedData) throws Exception
    {

        DBProxy db = new DBProxy();
        try
        {
            loadFromDB(loadExtendedData, db);
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

    public void loadFromDB(boolean loadExtendedData, DBProxy db) throws Exception
    {
        if (gsPKID == null)
        {
            throw new Exception("No Customer ID");
        }

        ResultSet res = db.executeQuery(
                "SELECT name, credits, code, fkrootcust, fkparentcust, isdisabled, logo "
                + "FROM Customer "
                + "WHERE pkid=" + gsPKID);
        if (res.next())
        {
            gsName = res.getString("name");
            giCredits = res.getInt("credits");
            gsCode = res.getString("code");
            giFKRootCust = res.getInt("fkrootcust");
            giFKParentCust = res.getInt("fkparentcust");
            disabled = res.getBoolean("isdisabled");
            gsLogo = res.getString("logo");

            // extended details..
            if (loadExtendedData)
            {
                // ..org-user
                res = db.executeQuery("SELECT * FROM getOrgUser(" + gsPKID + ")");
                if (res.next())
                {
                    guUser = new User(true, gsPKID, "2",
                                      res.getString("username"), res.getString("password"),
                                      res.getString("initial"), res.getString("fname"), res.getString("lname"),
                                      res.getString("title"), res.getString("idnum"), res.getString("compref"),
                                      res.getString("telh"), res.getString("telw"), res.getString("fax"),
                                      res.getString("cell"), res.getString("email"), res.getString("website"), null);
                    guUser.setPKID(res.getString("pkid"));
                }

                if (guUser != null)
                {
                    // ..address
                    res = db.executeQuery(
                            "SELECT * FROM Address WHERE fkUserID=" + guUser.getPKID() + " AND fkAddrType=4");
                    if (res.next())
                    {
                        gaAddress = new Address(
                                res.getString("line1"),
                                res.getString("line2"),
                                res.getString("line3"),
                                res.getString("areacode"),
                                res.getString("descr"),
                                "4");
                    }
                }

                // ..number of users
                res = db.executeQuery("SELECT COUNT(*) FROM Users WHERE fkLevel=3 AND fkCustID=" + gsPKID);
                if (res.next())
                {
                    giNumIndivs = res.getInt(1);
                }

            }
        }
    }

    public boolean exists() throws Exception
    {
        DBProxy db = new DBProxy();
        boolean retVal = false;

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
                + "FROM Customer "
                + "WHERE name='" + gsName + "' OR code='" + gsCode + "'");

        return res.next();
    }

    public void commit() throws Exception
    {
        if (gsName == null)
        {
            throw new Exception("Must specify Customer name");
        }

        Logger log = Logger.getLogger(Customer.class);
        log.info("Commiting Customer.");

        // create the [Customer]-record
        DBProxy db = new DBProxy();


        try
        {
            db.executeNonQuery("BEGIN");

            String SQL =
                   "INSERT INTO Customer "
                   + "VALUES(nextval('customer_pkid_seq'), '" + gsName + "', " + giCredits + ", '" + gsCode + "',"
                   + this.giFKRootCust + "," + this.giFKParentCust + ")";
            db.executeNonQuery(SQL);

            // create the [User]-record..
            // .. get the pkid - for fk
            ResultSet res = db.executeQuery("SELECT currval('customer_pkid_seq') as pkid");
            res.next();
            guUser.setFKCustomer(gsPKID = res.getString("pkid"));
            // .. save user
            guUser.commit(db);

            // .. get user pk - for address fk
            res = db.executeQuery("SELECT currval('users_pkid_seq') as pkid");
            res.next();
            gaAddress.setFkUserID(res.getString("pkid"));
            // .. save address
            gaAddress.commit(db);

            db.executeNonQuery("COMMIT");

            log.info("Successfully committed Customer. PKID:" + gsPKID);
        }
        catch (Exception e)
        {
            log.error("Failed to commit Customer. PKID:" + gsPKID + " Name:" + gsName);

            // failure: rollback
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
            update(db);
        }
        catch (Exception e)
        {
            Logger log = Logger.getLogger(Customer.class);
            log.error("Failed to update Customer. PKID:" + gsPKID);
            throw e;
        }
        finally
        {
            db.close();
        }

    }

    public void update(DBProxy db) throws Exception
    {
        String sql = "UPDATE Customer "
                     + "SET "
                     + "name='" + gsName + "',"
                     + "isdisabled=" + isDisabled() + ","
                     + "credits=" + giCredits + " "
                     + ((gsCode != null) ? ",code='" + gsCode + "' " : "")
                     + "WHERE pkid=" + gsPKID;

        Logger log = Logger.getLogger(Customer.class);
        log.info("Updating Customer. PKID:" + gsPKID);

        db.executeNonQuery(sql);
    }

    /**
     * Does a db-update of extended fields if extendedUpdate equals true.
     *
     * @param extendedUpdate
     * @throws Exception
     */
    public void update(boolean extendedUpdate) throws Exception
    {
        if (!extendedUpdate)
        {
            update();
        }
        else
        {
            DBProxy db = new DBProxy();

            try
            {
                // normal update
                update(db);

                // update user
                this.guUser.update(db);

                // update address
                gaAddress.setFkUserID(guUser.getPKID());
                gaAddress.setFkAddrType("4");
                this.gaAddress.update(db);


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
    }

    /**
     * see update(boolean)
     *
     * @param extendedUpdate
     * @param db
     * @throws Exception
     */
    public void update(boolean extendedUpdate, DBProxy db) throws Exception
    {
        if (!extendedUpdate)
        {
            update(db);
        }
        else
        {
            // normal update
            update(db);

            // update user
            this.guUser.update(db);

            // update address
            gaAddress.setFkUserID(guUser.getPKID());
            gaAddress.setFkAddrType("4");
            this.gaAddress.update(db);
        }
    }

    public void delete() throws Exception
    {
        DBProxy db = new DBProxy();

        Logger log = Logger.getLogger(Customer.class);
        log.info("Deleting Customer. PKID:" + gsPKID + " Name:" + gsName);

        try
        {
            if (gsPKID != null && !gsPKID.equals(""))
            {
                db.executeNonQuery("DELETE FROM Customer WHERE pkid=" + gsPKID);
            }
            else
            {
                throw new Exception("No Customer PKID");
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

    /**
     * Retrieves customers from the database
     *
     * @return an array of Customer[] from the database
     */
    public static Customer[] getCustomers() throws Exception
    {
        DBProxy db = new DBProxy();

        try
        {
            return getCustomers(-999, db);
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

    public static Customer[] getCustomers(int parentCustID, DBProxy db) throws Exception
    {
        Customer[] retVal = null;
        int count = 0;

        // count the root customers
        String SQL = "SELECT COUNT(*) as cnt FROM Customer WHERE pkid>=-1 AND fkParentCust=" + parentCustID;
        ResultSet res = db.executeQuery(SQL);
        if (res.next() && res.getInt("cnt") > 0)
        {
            count = res.getInt("cnt");
        }

        // get them
        if (count > 0)
        {
            retVal = new Customer[count];

            SQL =
            "SELECT pkid, name, credits, code, isdisabled FROM Customer "
            + "WHERE pkid>=-1 AND fkParentCust=" + parentCustID + " ORDER BY isdisabled, name";
            res = db.executeQuery(SQL);

            int i = 0;
            while (res.next())
            {
                retVal[i++] = new Customer(
                        res.getString("pkid"),
                        res.getString("name"),
                        res.getInt("credits"),
                        res.getString("code"),
                        res.getBoolean("isdisabled"));
            }
        }

        return retVal;
    }

    public static Customer[] getDownlinesByAssessmentId(String assessmentId) throws Exception
    {
        Customer[] retVal;
        DBProxy db = new DBProxy();
        Vector customers = new Vector();

        try
        {

            // retrieve users
            ResultSet res = db.executeQuery(
                    "SELECT c.name, c.pkid, u.pkid AS userid "
                    + "FROM Users u, _assignment a, customer c "
                    + "WHERE a.fkq="+ assessmentId +" AND u.pkid=a.fkuser "
                    + "AND u.fklevel=2 "
                    + "AND c.pkid=u.fkcustid "
                    + "ORDER BY c.name");
            while (res.next())
            {
                customers.add(new Customer(res.getString("pkid"),
                                   res.getString("name"),
                                   res.getString("userid")));
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

        retVal = new Customer[customers.size()];
        for (int i = 0; i < customers.size(); i++)
        {
            retVal[i] = (Customer) customers.get(i);
        }

        return retVal;
    }

    public String getName()
    {
        return gsName;
    }

    public int getCredits()
    {
        // get from db if not available
        return giCredits;
    }

    public String getPKID()
    {
        return gsPKID;
    }

    public void setName(String name)
    {
        gsName = DBProxy.legalizeString(name);
    }

    public void setCredits(int credits)
    {
        giCredits = credits;
    }

    public void setPKID(String pkid)
    {
        gsPKID = pkid;
    }

    /**
     * @return Returns the gsCode.
     */
    public String getCode()
    {
        return gsCode;
    }

    /**
     * @param gsCode The gsCode to set.
     */
    public void setCode(String code)
    {
        this.gsCode = DBProxy.legalizeString(code).toUpperCase();
    }

    public String getLogo()
    {
        return gsLogo;
    }

    public void setLogo(String logo)
    {
        gsLogo = logo;
    }

    /**
     * @return Returns the User.
     */
    public User getUser()
    {
        return guUser;
    }

    /**
     * @param guUser The User to set.
     */
    public void setUser(User user)
    {
        this.guUser = user;
    }

    public String getUserId()
    {
        return gsUserId;
    }

    public void setUserId(String userId)
    {
        gsUserId = userId;
    }

    /**
     * @return Returns the Address.
     */
    public Address getAddress()
    {
        return gaAddress;
    }

    /**
     * @param Address The Address to set.
     */
    public void setAddress(Address addr)
    {
        this.gaAddress = addr;
    }

    /**
     * @return Returns the giNumIndivs.
     */
    public int getNumIndividuals()
    {
        return giNumIndivs;
    }

    /**
     * @param giNumIndivs The giNumIndivs to set.
     */
    public void setNumIndividuals(int NumIndivs)
    {
        this.giNumIndivs = NumIndivs;
    }

    /**
     * @return Returns the FKParentCust.
     */
    public int getFKParentCust()
    {
        return giFKParentCust;
    }

    /**
     * @param fkParentCust The fkParentCust to set.
     */
    public void setFKParentCust(int fkParentCust)
    {
        this.giFKParentCust = fkParentCust;
    }

    /**
     * @return Returns the fkRootCust.
     */
    public int getFKRootCust()
    {
        return giFKRootCust;
    }

    /**
     * @param fkRootCust The fkRootCust to set.
     */
    public void setFKRootCust(int fkRootCust)
    {
        this.giFKRootCust = fkRootCust;
    }

    /**
     * @return Returns the giLevel.
     */
    public int getLevel()
    {
        return giLevel;
    }

    /**
     * @param giLevel The giLevel to set.
     */
    public void setLevel(int level)
    {
        this.giLevel = level;
    }

    /**
     *
     * @return Is this customer enabled or disabled?
     */
    public boolean isDisabled()
    {
        return disabled;
    }

    /**
     * @param isDisabled Set the enabled flag.
     */
    public void setDisabled(boolean isDisabled)
    {
        this.disabled = isDisabled;
    }
}

