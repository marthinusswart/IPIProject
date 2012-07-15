/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.ResultSet;
import java.util.Vector;

/**
 *
 * @author m swart
 */
public class Career
{
    protected String pkid;
    protected String name;

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getPKID()
    {
        return pkid;
    }

    public void setPKID(String pkid)
    {
        this.pkid = pkid;
    }

    public Career()
    {
    }

    public Career(String pkid, String name)
    {
        setPKID(pkid);
        setName(name);
    }

    public static Career[] getCareers() throws Exception
    {
        Vector careers = new Vector();
        DBProxy db = new DBProxy();

        String sql = "SELECT * FROM career ORDER BY name";
        ResultSet rs = db.executeQuery(sql);

        while (rs.next())
        {
            careers.add(new Career(rs.getString("pkid"), rs.getString("name")));
        }

        rs.close();
        db.close();

        Career[] careersArray = new Career[careers.size()];
        for (int i=0; i<careers.size();i++)
        {
            careersArray[i] = (Career) careers.get(i);
        }

        return careersArray;
    }
}
