/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.ResultSet;
import java.util.Vector;

/**
 *
 * @author Administrator
 */
public class EmploymentStatus
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

    public EmploymentStatus()
    {

    }

    public EmploymentStatus(String pkid, String name)
    {
        setPKID(pkid);
        setName(name);
    }

    public static EmploymentStatus[] getEmploymentStatus() throws Exception
    {
        Vector employmentStatus = new Vector();
        DBProxy db = new DBProxy();
        String sql = "SELECT * FROM employmentstatus ORDER BY pkid";
        ResultSet rs = db.executeQuery(sql);

        while (rs.next())
        {
            employmentStatus.add(new EmploymentStatus(rs.getString("pkid"), rs.getString("name")));
        }

        EmploymentStatus[] employmentStatusArray = new EmploymentStatus[employmentStatus.size()];

        for (int i=0;i<employmentStatus.size();i++)
        {
            employmentStatusArray[i] = (EmploymentStatus) employmentStatus.get(i);
        }

        return employmentStatusArray;
    }
}
