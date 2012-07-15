/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package beans;

import java.sql.ResultSet;
import java.util.Vector;

/**
 *
 * @author mswart
 */
public class SuperConstruct
{
    private String _pkid = null;
    private String _code = null;
    private String _name = null;
    private String _description = "";
    private Construct[] _constructs = null;

    public String getCode()
    {
        return _code;
    }

    public void setCode(String code)
    {
        this._code = code;
    }

    public String getDescription()
    {
        return _description;
    }

    public void setDescription(String description)
    {
        this._description = description;
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

    public int getPKIDInt()
    {
        return Integer.parseInt(_pkid);
    }

    public void setPKID(String pkid)
    {
        this._pkid = pkid;
    }

    public Construct[] getConstructs()
    {
        return _constructs;
    }

    public SuperConstruct()
    {
    }

    public SuperConstruct(String pkid)
    {
        _pkid = pkid;
    }

    public SuperConstruct(String pkid, String code, String name, String description)
    {
        _pkid = pkid;
        _code = code;
        _name = name;

        if (description != null)
        {
            _description = description;
        }
    }

    public static SuperConstruct[] getUnassignedSuperConstructs(String questionnaireId) throws Exception
    {
        Vector superConstructs = new Vector();
        DBProxy db = new DBProxy();

        String sql = "SELECT super_construct.* FROM super_construct WHERE super_construct.pkid NOT IN (SELECT _q_sc_entry.fksc FROM _q_sc_entry WHERE _q_sc_entry.fkq="+questionnaireId+") ORDER BY code";
        ResultSet res = null;


        try
        {
            res = db.executeQuery(sql);
            while (res.next())
            {
                superConstructs.add(new SuperConstruct(
                        res.getString("pkid"),
                        res.getString("code"),
                        res.getString("name"),
                        res.getString("descr")
                        ));
            }
        }
        finally
        {
            db.close();
        }

        SuperConstruct[] superConstructsArray = new SuperConstruct[superConstructs.size()];
        for (int i=0;i<superConstructs.size();i++)
        {
            superConstructsArray[i] = (SuperConstruct) superConstructs.get(i);
        }

        return superConstructsArray;
    }

    public static SuperConstruct[] getSuperConstructs(String questionnaireId) throws Exception
    {
        Vector superConstructs = new Vector();
        DBProxy db = new DBProxy();

        String sql = "SELECT super_construct.* FROM super_construct, _q_sc_entry WHERE super_construct.pkid = _q_sc_entry.fksc AND _q_sc_entry.fkq=" + questionnaireId + " ORDER BY super_construct.code";
        ResultSet res = null;


        try
        {
            res = db.executeQuery(sql);
            while (res.next())
            {
                superConstructs.add(new SuperConstruct(
                        res.getString("pkid"),
                        res.getString("code"),
                        res.getString("name"),
                        res.getString("descr")
                        ));
            }
        }
        finally
        {
            db.close();
        }

        SuperConstruct[] superConstructsArray = new SuperConstruct[superConstructs.size()];
        for (int i=0;i<superConstructs.size();i++)
        {
            superConstructsArray[i] = (SuperConstruct) superConstructs.get(i);
        }

        return superConstructsArray;
    }

    public static SuperConstruct[] getSuperConstructs() throws Exception
    {
        Vector superConstructs = new Vector();
        DBProxy db = new DBProxy();
        String sql = "SELECT * FROM super_construct ORDER BY code";
        ResultSet res = null;

        try
        {
            res = db.executeQuery(sql);
            while (res.next())
            {
                superConstructs.add(new SuperConstruct(
                        res.getString("pkid"),
                        res.getString("code"),
                        res.getString("name"),
                        res.getString("descr")
                        ));
            }
        }
        finally
        {
            db.close();
        }

        SuperConstruct[] superConstructsArray = new SuperConstruct[superConstructs.size()];
        for (int i=0;i<superConstructs.size();i++)
        {
            superConstructsArray[i] = (SuperConstruct) superConstructs.get(i);
        }

        return superConstructsArray;
    }

    public void loadFromDB() throws Exception
    {
        DBProxy db = new DBProxy();

        try
        {
            String sql = "SELECT * FROM super_construct WHERE pkid="+getPKID();
            ResultSet rs = db.executeQuery(sql);

            if (rs.next())
            {
                setName(rs.getString("name"));
                setCode(rs.getString("code"));
                setDescription(rs.getString("descr"));
            }
            else
            {
                throw new Exception("The SuperConstruct does not exist");
            }
        }
        finally
        {
            db.close();
        }

    }

    public void saveToDB() throws Exception
    {
        DBProxy db = new DBProxy();

        try
        {
            String sql = "UPDATE super_construct SET name='" + getName() + "', " +
                    "code='" + getCode() + "', descr='" + getDescription() +"' "+
                    "WHERE pkid="+getPKID();
            db.executeNonQuery(sql);
        }
        finally
        {
            db.close();
        }
    }

    public void setConstructs(Construct[] allConstructs)
    {
        Vector constructsVector = new Vector();

        for (int i=0; i<allConstructs.length; i++)
        {
            if (allConstructs[i].getFkSC() == getPKIDInt())
            {
                constructsVector.add(allConstructs[i]);
            }
        }

        _constructs = new Construct[constructsVector.size()];
        for (int i=0; i<constructsVector.size(); i++)
        {
            _constructs[i] = (Construct) constructsVector.get(i);
        }
    }
}
