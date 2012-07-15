/*
 * Created on 06-Jul-2005
 *
 */
package beans;

import java.sql.ResultSet;
import org.apache.log4j.Logger;

/**
 * @author psnel
 *
 *
 */
public class Address
{

    private String gsFkUserID;		// reference to user that owns this address
    private String gsFkAddrType;	// reference to Address_Type
    private String gsStreet;		// line 1
    private String gsSuburb;		// line 2
    private String gsCity;			// line 3
    private String gsAreaCode;		// area code
    private String gsDescription;	// optional description

    public Address()
    {
    }

    /**
     * @param Street
     * @param Suburb
     * @param City
     * @param AreaCode
     * @param Description
     * @param FkAddrType
     */
    public Address(String Street, String Suburb, String City,
                   String AreaCode, String Description, String FkAddrType)
    {
        this.gsStreet = DBProxy.legalizeString(Street);
        this.gsSuburb = DBProxy.legalizeString(Suburb);
        this.gsCity = DBProxy.legalizeString(City);
        this.gsAreaCode = DBProxy.legalizeString(AreaCode);
        this.gsDescription = DBProxy.legalizeString(Description);
        this.gsFkAddrType = FkAddrType;
    }

    public void commit() throws Exception
    {
        // don't save if there's nothing
        if (this.isEmpty())
        {
            return;
        }

        DBProxy db = new DBProxy();
        try
        {
            commit(db);
        }
        catch (Exception e)
        {
            Logger log = Logger.getLogger(Address.class);
            log.error("Failed to commit the address");
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    /**
     * see User.commit(db)
     * 
     * @param db
     * @throws Exception
     */
    public void commit(DBProxy db) throws Exception
    {
        // don't save if there's nothing
        if (this.isEmpty())
        {
            return;
        }

        Logger log = Logger.getLogger(Address.class);
        log.info("Committing the address");

        db.executeNonQuery(
                "INSERT INTO Address (fkUserID, fkAddrType, descr, line1, line2, line3, areaCode) "
                + "VALUES ("
                + gsFkUserID + ","
                + gsFkAddrType + ","
                + ((gsDescription != null && !gsDescription.equals("")) ? "'" + gsDescription + "'" : "null") + ","
                + ((gsStreet != null && !gsStreet.equals("")) ? "'" + gsStreet + "'" : "null") + ","
                + ((gsSuburb != null && !gsSuburb.equals("")) ? "'" + gsSuburb + "'" : "null") + ","
                + ((gsCity != null && !gsCity.equals("")) ? "'" + gsCity + "'" : "null") + ","
                + ((gsAreaCode != null && !gsAreaCode.equals("")) ? "'" + gsAreaCode + "'" : "null") + ")");
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
            Logger log = Logger.getLogger(Address.class);
            log.error("Failed to update the address");
            throw e;
        }
        finally
        {
            db.close();
        }
    }

    public void update(DBProxy db) throws Exception
    {
        if (this.isEmpty())
        {
            this.delete(db);
        }

        Logger log = Logger.getLogger(Address.class);
        log.info("Updating the address. FKUserID:" + gsFkUserID);

        // does address exist?
        if (this.exists(db))
        {	// YES: update..

            db.executeNonQuery(
                    "UPDATE Address SET "
                    + "descr=" + ((gsDescription != null && !gsDescription.equals(""))
                                  ? "'" + gsDescription + "'" : "null") + ", "
                    + "line1=" + ((gsStreet != null && !gsStreet.equals(""))
                                  ? "'" + gsStreet + "'" : "null") + ", "
                    + "line2=" + ((gsSuburb != null && !gsSuburb.equals(""))
                                  ? "'" + gsSuburb + "'" : "null") + ", "
                    + "line3=" + ((gsCity != null && !gsCity.equals(""))
                                  ? "'" + gsCity + "'" : "null") + ", "
                    + "areaCode=" + ((gsAreaCode != null && !gsAreaCode.equals(""))
                                     ? "'" + gsAreaCode + "'" : "null") + " "
                    + "WHERE fkUserID=" + gsFkUserID + " AND fkAddrType=" + gsFkAddrType);
        }
        else
        {	// NO: create..
            commit(db);
        }
    }

    public void delete() throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            Logger log = Logger.getLogger(Address.class);
            log.info("Deleting Address. FKUserID:" + gsFkUserID + " Street:" + gsStreet);
            delete(db);
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

    public void delete(DBProxy db) throws Exception
    {
        if (gsFkUserID == null || gsFkUserID.equals("")
            || gsFkAddrType == null || gsFkAddrType.equals(""))
        {
            throw new Exception("Unspecified user or addresstype");
        }

        Logger log = Logger.getLogger(Address.class);
        log.info("Deleting the address. FKUserID:" + gsFkUserID);

        db.executeQuery("SELECT delAddr(" + gsFkUserID + "," + gsFkAddrType + ")");
    }

    public boolean exists() throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            return this.exists(db);
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
     * Checks if there's a record in the db with the same userid and addresstype as this Address.
     * 
     * @param db
     * @return
     * @throws Exception
     */
    public boolean exists(DBProxy db) throws Exception
    {
        if (gsFkUserID == null || gsFkUserID.equals("")
            || gsFkAddrType == null || gsFkAddrType.equals(""))
        {
            throw new Exception("Unspecified user or addresstype");
        }

        ResultSet res = db.executeQuery(
                "SELECT fkUserID FROM Address WHERE fkUserID=" + gsFkUserID + " AND fkAddrType=" + gsFkAddrType);

        return res.next();
    }

    public boolean isEmpty()
    {
        if ((gsStreet == null || gsStreet.equals(""))
            && (gsSuburb == null || gsSuburb.equals(""))
            && (gsCity == null || gsCity.equals(""))
            && (gsAreaCode == null || gsAreaCode.equals(""))/* &&
                (gsDescription == null || gsDescription.equals(""))*/)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public void load() throws Exception
    {
        DBProxy db = new DBProxy();
        try
        {
            load(db);
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

    public void load(DBProxy db) throws Exception
    {
        if (gsFkUserID == null || gsFkUserID.equals("")
            || gsFkAddrType == null || gsFkAddrType.equals(""))
        {
            throw new Exception("Unspecified user or addresstype");
        }

        ResultSet res = db.executeQuery(
                "SELECT * FROM Address WHERE fkUserID=" + gsFkUserID + " AND fkAddrType=" + gsFkAddrType);

        if (res.next())
        {
            this.gsStreet = res.getString("line1");
            this.gsSuburb = res.getString("line2");
            this.gsCity = res.getString("line3");
            this.gsAreaCode = res.getString("areaCode");
            this.gsDescription = res.getString("descr");
        }
    }

    public String csv4String()
    {
        return (isEmpty())
               ? "null, null, null, null"
               : "'" + gsStreet + "','" + gsSuburb + "','" + gsCity + "','" + gsAreaCode + "'";
    }

    public String getStreet()
    {
        return gsStreet;
    }

    public String getSuburb()
    {
        return gsSuburb;
    }

    public String getCity()
    {
        return gsCity;
    }

    public String getAreaCode()
    {
        return gsAreaCode;
    }

    public String getDescription()
    {
        return gsDescription;
    }

    public void setStreet(String street)
    {
        gsStreet = DBProxy.legalizeString(street);
    }

    public void setSuburb(String subrb)
    {
        gsSuburb = DBProxy.legalizeString(subrb);
    }

    public void setCity(String city)
    {
        gsCity = DBProxy.legalizeString(city);
    }

    public void setAreaCode(String arcode)
    {
        gsAreaCode = DBProxy.legalizeString(arcode);
    }

    public void setDescription(String desc)
    {
        gsDescription = DBProxy.legalizeString(desc);
    }

    /**
     * @return Returns the FkAddrType.
     */
    public String getFkAddrType()
    {
        return gsFkAddrType;
    }

    /**
     * @param FkAddrType The FkAddrType to set.
     */
    public void setFkAddrType(String FkAddrType)
    {
        this.gsFkAddrType = FkAddrType;
    }

    /**
     * @return Returns the FkUserID.
     */
    public String getFkUserID()
    {
        return gsFkUserID;
    }

    /**
     * @param FkUserID The FkUserID to set.
     */
    public void setFkUserID(String FkUserID)
    {
        this.gsFkUserID = FkUserID;
    }
}
