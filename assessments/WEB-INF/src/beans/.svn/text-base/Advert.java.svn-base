/* Advert.java
 * 
 * Created on 31-Aug-2005
 */
package beans;

import java.sql.Date;
import java.sql.ResultSet;
import java.text.DateFormat;
import org.apache.log4j.Logger;

/**
 * @author psnel
 *
 */
public class Advert
{

    private int PKID = -99;			// db fields
    private int fkCustID = -99;		// " "
    private String description;		// " "
    private Date issueDate;			// " "
    private int responses = 0;		// number of total individuals that have the ref # of this ad

    public Advert()
    {
    }

    public Advert(int pkid)
    {
        this.PKID = pkid;
    }

    public Advert(int fkCustID, String description, Date issueDate)
    {
        this.fkCustID = fkCustID;
        this.description = description;
        this.issueDate = issueDate;
    }

    public Advert(int pkid, int fkCustID, String description, Date issueDate)
    {
        this.PKID = pkid;
        this.fkCustID = fkCustID;
        this.description = description;
        this.issueDate = issueDate;
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
            Logger log = Logger.getLogger(Advert.class);
            log.error("Failed to commit Advert");
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    public void commit(DBProxy db) throws Exception
    {

        Logger log = Logger.getLogger(Advert.class);
        log.info("Commiting Advert");

        db.executeNonQuery(
                "INSERT INTO Advert (fkCustID, descr, issueDate) "
                + "VALUES ("
                + fkCustID
                + ", '" + description + "', "
                + "'" + DateFormat.getDateInstance(DateFormat.MEDIUM).format(issueDate) + "')");

        // set the pkid
        ResultSet res = db.executeQuery("SELECT currval('advert_pkid_seq')");
        if (res.next())
        {
            this.PKID = res.getInt(1);
        }

    }

    public void delete() throws Exception
    {
        if (this.PKID < -1)
        {
            throw new Exception("No advert id specified");
        }

        Logger log = Logger.getLogger(Advert.class);
        log.info("Deleting advert. PKID:" + PKID);

        DBProxy db = new DBProxy();
        try
        {
            db.executeNonQuery("DELETE FROM Advert WHERE pkid=" + PKID);
        }
        catch (Exception e)
        {
            log.error("Failed to delete Advert. PKID:" + PKID);
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    /**
     * Generates the advert reference for this advert by appending the customer prefix (code) with the
     * primary key of this advert in the db (must be set by calling code). If the code parameter is not
     * provided (i.e. code equals null) then the method tries to retrieve the customer code from the database.
     * If the customer is found, but their code is null, the string "???" is prepended to the result; if the
     * customer is not found, an Exception is thrown.
     * 
     * @param custCode an optional customer prefix
     * @return advert reference string
     * @throws Exception if this.PKID and either custCode or this.fkCustID not set, or if the customer was not
     * found in the database.
     */
    public String getReference(String custCode) throws Exception
    {

        // err if no customer FK
        if (custCode == null && this.fkCustID < -1)
        {
            throw new Exception("No customer specified");
        }
        // err if no pkid
        if (this.PKID < -1)
        {
            throw new Exception("Advert ID not found");
        }

        StringBuffer retVal = new StringBuffer();
        DBProxy db = new DBProxy();

        try
        {
            if (custCode == null)
            {
                // 	get the customer code
                ResultSet res = db.executeQuery("SELECT code from Customer WHERE pkid=" + this.fkCustID);
                if (res.next())
                {
                    String tmp = res.getString("code");
                    if (tmp != null)
                    {
                        retVal.append(tmp);
                    }
                    else
                    {
                        retVal.append("???");
                    }
                }
                else
                {
                    throw new Exception("Customer not found");
                }
            }
            else
            {
                retVal.append(custCode);
            }

            retVal.append(PKID);

        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            db.close();
        }

        return retVal.toString();
    }

    /**
     * Retrieve and return all adverts for a customer.
     * 
     * @param custID - the primary key for a customer
     * @return array of Adverts for a customer
     * @throws Exception
     */
    public static Advert[] getAdverts(String custID) throws Exception
    {
        if (custID == null)
        {
            throw new Exception("No customer specified");
        }

        Advert[] retVals = null;

        DBProxy db = new DBProxy();

        try
        {
            ResultSet res;
            // load customer code
            String custCode = null;
            res = db.executeQuery("SELECT code FROM Customer WHERE pkid=" + custID);
            if (res.next())
            {
                custCode = res.getString("code");
            }

            // count cutomer adverts
            res = db.executeQuery("SELECT COUNT(*) FROM Advert WHERE fkCustID=" + custID);
            if (res.next())
            {
                retVals = new Advert[res.getInt(1)];
            }

            // get adverts
            res = db.executeQuery(
                    "SELECT pkid, descr, issueDate "
                    + "FROM Advert a WHERE a.fkCustID=" + custID
                    + " ORDER BY issueDate");
            int i = 0;
            while (res.next())
            {
                retVals[i++] = new Advert(
                        res.getInt("pkid"),
                        Integer.parseInt(custID),
                        res.getString("descr"),
                        res.getDate("issueDate"));

                // get response count
                retVals[i - 1].loadResponseCount(custCode, db);
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

        return retVals;
    }

    public int loadResponseCount(String custCode, DBProxy db) throws Exception
    {

        ResultSet res = db.executeQuery("SELECT * FROM getCustAdCount('" + custCode + "'," + PKID + ")");
        if (res.next())
        {
            return this.responses = res.getInt(1);
        }

        return 0;
    }

    /**
     * @return Returns the description.
     */
    public String getDescription()
    {
        return description;
    }

    /**
     * @param description The description to set.
     */
    public void setDescription(String description)
    {
        this.description = DBProxy.legalizeString(description);
    }

    /**
     * @return Returns the fkCustID.
     */
    public int getFkCustID()
    {
        return fkCustID;
    }

    /**
     * @param fkCustID The fkCustID to set.
     */
    public void setFkCustID(int fkCustID)
    {
        this.fkCustID = fkCustID;
    }

    /**
     * @return Returns the issueDate.
     */
    public Date getIssueDate()
    {
        return issueDate;
    }

    /**
     * @param issueDate The issueDate to set.
     */
    public void setIssueDate(Date issueDate)
    {
        this.issueDate = issueDate;
    }

    /**
     * @return Returns the pKID.
     */
    public int getPKID()
    {
        return PKID;
    }

    /**
     * @param pkid The pKID to set.
     */
    public void setPKID(int pkid)
    {
        PKID = pkid;
    }

    /**
     * @return Returns the responses.
     */
    public int getResponses()
    {
        return responses;
    }

    /**
     * @param responses The responses to set.
     */
    public void setResponses(int responses)
    {
        this.responses = responses;
    }
}
