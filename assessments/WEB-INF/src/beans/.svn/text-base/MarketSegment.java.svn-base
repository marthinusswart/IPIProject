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
public class MarketSegment
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

    public MarketSegment()
    {

    }

    public MarketSegment(String pkid, String name)
    {
        setPKID(pkid);
        setName(name);
    }

    public static MarketSegment[] getMarketSegments() throws Exception
    {
        Vector marketSegments = new Vector();
        DBProxy db = new DBProxy();
        String sql = "SELECT * FROM marketsegment ORDER BY name";
        ResultSet rs = db.executeQuery(sql);

        while (rs.next())
        {
            marketSegments.add(new MarketSegment(rs.getString("pkid"), rs.getString("name")));
        }

        MarketSegment[] marketSegmentsArray = new MarketSegment[marketSegments.size()];

        for (int i=0; i<marketSegments.size();i++)
        {
            marketSegmentsArray[i] = (MarketSegment) marketSegments.get(i);
        }

        return marketSegmentsArray;
    }
}
