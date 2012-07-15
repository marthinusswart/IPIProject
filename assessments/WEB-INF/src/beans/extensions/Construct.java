/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans.extensions;

import beans.DBProxy;
import java.sql.ResultSet;
import java.util.Vector;

/**
 *
 * @author mswart
 * Didn't want to bugger around with the existing Construct class. So
 * I created a new one in a different package for adminisration purposes.
 */
public class Construct
{

    private String _pkid;
    private String _fksc;
    private String _name;
    private String _description = "";
    private boolean _isOptional;
    private boolean _isPositive;
    private boolean _isNeutral;
    private String _superConstructName;

    public String getDescription()
    {
        return _description;
    }

    public void setDescription(String description)
    {
        if (description != null)
        {
            this._description = description;
        }
    }

    public String getFKSC()
    {
        return _fksc;
    }

    public void setFKSC(String fksc)
    {
        this._fksc = fksc;
    }

    public void setSuperConstructName(String name)
    {
        this._superConstructName = name;
    }

    public String getSuperConstructName()
    {
        return this._superConstructName;
    }

    public boolean isNeutral()
    {
        return _isNeutral;
    }

    public void setIsNeutral(boolean isNeutral)
    {
        this._isNeutral = isNeutral;
    }

    public boolean isOptional()
    {
        return _isOptional;
    }

    public void setIsOptional(boolean isOptional)
    {
        this._isOptional = isOptional;
    }

    public boolean isPositive()
    {
        return _isPositive;
    }

    public void setIsPositive(boolean isPositive)
    {
        this._isPositive = isPositive;
    }

    public String getName()
    {
        return _name;
    }

    public void setName(String name)
    {
        this._name = name;
    }

    public String getPKID()
    {
        return _pkid;
    }

    public void setPKID(String pkid)
    {
        this._pkid = pkid;
    }

    public int getPKIDInt()
    {
        return Integer.parseInt(_pkid);
    }

    public Construct()
    {
    }

    public Construct(String pkid)
    {
        _pkid = pkid;
    }

    public Construct(String pkid, String fksc, String name,
                     String description, boolean isOptional, boolean isPositive,
                     boolean isNeutral)
    {
        _pkid = pkid;
        _fksc = fksc;
        _name = name;
        setDescription(description);
        _isOptional = isOptional;
        _isPositive = isPositive;
        _isNeutral = isNeutral;
    }

     public Construct(String pkid, String fksc, String name,
                     String description, boolean isOptional, boolean isPositive,
                     boolean isNeutral, String superConstructName)
     {
         _pkid = pkid;
        _fksc = fksc;
        _name = name;
        setDescription(description);
        _isOptional = isOptional;
        _isPositive = isPositive;
        _isNeutral = isNeutral;
        _superConstructName = superConstructName;
     }

    public static Construct[] getConstructs(String superConstructId) throws Exception
    {
        DBProxy db = new DBProxy();
        Vector constructs = new Vector();
        String sql = "SELECT * FROM construct WHERE fksc=" + superConstructId + " "
                     + "ORDER BY pkid";

        try
        {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next())
            {
                constructs.add(new Construct(
                        rs.getString("pkid"),
                        rs.getString("fksc"),
                        rs.getString("name"),
                        rs.getString("descr"),
                        rs.getBoolean("isoptional"),
                        rs.getBoolean("ispositive"),
                        rs.getBoolean("isneutral")));
            }
        }
        finally
        {
            db.close();
        }

        Construct[] constructsArray = new Construct[constructs.size()];
        for (int i = 0; i < constructs.size(); i++)
        {
            constructsArray[i] = (Construct) constructs.get(i);
        }
        return constructsArray;
    }

    public static Construct[] getIncludedConstructs(String questionnaireId) throws Exception
    {
        DBProxy db = new DBProxy();
        Vector constructs = new Vector();
        String sql = "SELECT construct.*, super_construct.name AS scname FROM construct, super_construct WHERE construct.fksc IN "
                     + "(SELECT super_construct.pkid FROM super_construct, _q_sc_entry WHERE super_construct.pkid=_q_sc_entry.fksc AND _q_sc_entry.fkq=" + questionnaireId + ") "
                     + "AND construct.pkid NOT IN (SELECT _qsce_c_exclude.fkc FROM _qsce_c_exclude WHERE fkq=" + questionnaireId + ") "
                     + "AND super_construct.pkid=construct.fksc "
                     + "ORDER BY name";

        try
        {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next())
            {
                constructs.add(new Construct(
                        rs.getString("pkid"),
                        rs.getString("fksc"),
                        rs.getString("name"),
                        rs.getString("descr"),
                        rs.getBoolean("isoptional"),
                        rs.getBoolean("ispositive"),
                        rs.getBoolean("isneutral"),
                        rs.getString("scname")));
            }
        }
        finally
        {
            db.close();
        }

        Construct[] constructsArray = new Construct[constructs.size()];
        for (int i = 0; i < constructs.size(); i++)
        {
            constructsArray[i] = (Construct) constructs.get(i);
        }
        return constructsArray;
    }

    public static Construct[] getExcludedConstructs(String questionnaireId) throws Exception
    {
        DBProxy db = new DBProxy();
        Vector constructs = new Vector();
        String sql = "SELECT construct.*, super_construct.name AS scname FROM construct, super_construct WHERE construct.fksc IN "
                     + "(SELECT super_construct.pkid FROM super_construct, _q_sc_entry WHERE super_construct.pkid=_q_sc_entry.fksc AND _q_sc_entry.fkq=" + questionnaireId + ") "
                     + "AND construct.pkid IN (SELECT _qsce_c_exclude.fkc FROM _qsce_c_exclude WHERE fkq=" + questionnaireId + ") "
                     + "AND super_construct.pkid=construct.fksc "
                     + "ORDER BY name";

        try
        {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next())
            {
                constructs.add(new Construct(
                        rs.getString("pkid"),
                        rs.getString("fksc"),
                        rs.getString("name"),
                        rs.getString("descr"),
                        rs.getBoolean("isoptional"),
                        rs.getBoolean("ispositive"),
                        rs.getBoolean("isneutral"),
                        rs.getString("scname")));
            }
        }
        finally
        {
            db.close();
        }

        Construct[] constructsArray = new Construct[constructs.size()];
        for (int i = 0; i < constructs.size(); i++)
        {
            constructsArray[i] = (Construct) constructs.get(i);
        }
        return constructsArray;
    }

    public static void excludeConstruct(String questionaireId, String constructId) throws Exception
    {
        Construct construct = new Construct(constructId);
        construct.loadFromDB();
        String superConstructId = construct.getFKSC();

        String sql = "INSERT INTO _qsce_c_exclude (fkq, fksc, fkc) VALUES ("+questionaireId+", " + superConstructId +", " + constructId +")";
        DBProxy db = new DBProxy();

        try
        {
            db.executeNonQuery(sql);
        }
        finally
        {
            db.close();
        }
    }

    public static void includeConstruct(String questionaireId, String constructId) throws Exception
    {
        Construct construct = new Construct(constructId);
        construct.loadFromDB();
        String superConstructId = construct.getFKSC();

        String sql = "DELETE FROM _qsce_c_exclude WHERE fkq="+questionaireId+" AND fksc="+superConstructId+" AND fkc="+constructId;
        DBProxy db = new DBProxy();

        try
        {
            db.executeNonQuery(sql);
        }
        finally
        {
            db.close();
        }
    }

    public void loadFromDB() throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = "SELECT * FROM construct WHERE pkid=" + getPKID();

        try
        {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next())
            {
                setFKSC(rs.getString("fksc"));
                setDescription(rs.getString("descr"));
                setName(rs.getString("name"));
                setIsNeutral(rs.getBoolean("isneutral"));
                setIsOptional(rs.getBoolean("isoptional"));
                setIsPositive(rs.getBoolean("ispositive"));
            }
        }
        catch (Exception ex)
        {
            throw new Exception("SQL: " + sql + " - Exception: " + ex.getMessage());
        }
        finally
        {
            db.close();
        }
    }

    public void loadFromDBExtended() throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = "SELECT construct.*, super_construct.name AS scname FROM construct"+
                " WHERE construct.pkid=" + getPKID() +
                " AND super_construct.pkid=construct.fksc";

        try
        {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next())
            {
                setFKSC(rs.getString("fksc"));
                setDescription(rs.getString("descr"));
                setName(rs.getString("name"));
                setIsNeutral(rs.getBoolean("isneutral"));
                setIsOptional(rs.getBoolean("isoptional"));
                setIsPositive(rs.getBoolean("ispositive"));
                setSuperConstructName(rs.getString("scname"));
            }
        }
        catch (Exception ex)
        {
            throw new Exception("SQL: " + sql + " - Exception: " + ex.getMessage());
        }
        finally
        {
            db.close();
        }
    }

    public void saveToDB() throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = "UPDATE construct SET name='" + getName() + "', "
                     + "descr='" + getDescription() + "', "
                     + "isoptional=" + isOptional() + ", "
                     + "ispositive=" + isPositive() + ", "
                     + "isneutral=" + isNeutral() + " "
                     + "WHERE pkid=" + getPKID();

        try
        {
            db.executeNonQuery(sql);
        }
        catch (Exception ex)
        {
            throw new Exception("SQL: " + sql + " - Exception: " + ex.getMessage());
        }
        finally
        {
            db.close();
        }
    }
}
