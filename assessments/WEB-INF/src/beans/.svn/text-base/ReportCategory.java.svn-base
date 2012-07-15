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
public class ReportCategory
{
    private String _pkid;
    private String _name;
    private String _image;
    private boolean _ispositive;
    private beans.extensions.Construct[] _constructs = null;
    private beans.Construct[] _relevantConstructs = null;

    public void setPKID(String pkid)
    {
        _pkid = pkid;
    }

    public String getPKID()
    {
        return _pkid;
    }

    public void setName(String name)
    {
        _name = name;
    }

    public String getName()
    {
        return _name;
    }

    public void setImage(String image)
    {
        _image = image;
    }

    public String getImage()
    {
        return _image;
    }

    public void setIsPositive(boolean isPositive)
    {
        _ispositive = isPositive;
    }

    public boolean isPositive()
    {
        return _ispositive;
    }

    public beans.extensions.Construct[] getConstructs()
    {
        return _constructs;
    }

    public beans.Construct[] getRelevantConstructs()
    {
        return _relevantConstructs;
    }

    public ReportCategory()
    {
    }

    public ReportCategory(String pkid, String name, String image, boolean isPositive)
    {
        _pkid = pkid;
        _name = name;
        _image = image;
        _ispositive = isPositive;
    }

    public static ReportCategory[] getReportCategories() throws Exception
    {
        ReportCategory[] reportCategoryArray = null;
        DBProxy db = new DBProxy();
        Vector reportCategories = new Vector();

        try
        {
            String sql = "SELECT * FROM report_category ORDER BY pkid";
            ResultSet rs = db.executeQuery(sql);

            while (rs.next())
            {
                ReportCategory reportCategory = new ReportCategory(
                        rs.getString("pkid"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getBoolean("ispositive")
                        );
                
                reportCategory.loadConstructs();
                
                reportCategories.add(reportCategory);
            }
        }
        finally
        {
            db.close();
        }

        reportCategoryArray = new ReportCategory[reportCategories.size()];
        for (int i=0;i<reportCategories.size();i++)
        {
            reportCategoryArray[i] = (ReportCategory)reportCategories.get(i);
        }

        return reportCategoryArray;
    }

    public void loadConstructs() throws Exception
    {
        DBProxy db = new DBProxy();
        Vector constructs = new Vector();

        try
        {
            String sql = "SELECT construct.* "+
                    "FROM construct, report_category_construct "+
                    "WHERE construct.pkid = report_category_construct.fkc "+
                    "AND report_category_construct.fkrc="+getPKID()+" ORDER BY report_category_construct.\"order\"";
            ResultSet rs = db.executeQuery(sql);

            while (rs.next())
            {
                constructs.add(new beans.extensions.Construct(
                        rs.getString("pkid"),
                        rs.getString("fksc"),
                        rs.getString("name"),
                        rs.getString("descr"),
                        rs.getBoolean("isoptional"),
                        rs.getBoolean("ispositive"),
                        rs.getBoolean("isneutral")
                        ));
            }
        }
        finally
        {
            db.close();
        }

        _constructs = new beans.extensions.Construct[constructs.size()];
        for (int i=0;i<constructs.size();i++)
        {
            _constructs[i] = (beans.extensions.Construct)constructs.get(i);
        }
    }

    public static void syncConstructs(beans.Construct[] relevantConstructs, ReportCategory[] reportCategories)
    {
        for (int i=0;i<reportCategories.length;i++)
        {
            reportCategories[i].syncConstructs(relevantConstructs);
        }
    }

    public void syncConstructs(beans.Construct[] relevantConstructs)
    {
        Vector newConstructs = new Vector();
        for (int i=0;i<_constructs.length;i++)
        {
            beans.extensions.Construct construct = _constructs[i];
            boolean found = false;

            for (int j=0;j<relevantConstructs.length;j++)
            {
                beans.Construct relevantConstruct = relevantConstructs[j];
                if (construct.getPKIDInt() == relevantConstruct.getPKID())
                {
                    newConstructs.add(relevantConstruct);
                    break;
                }
            }
        }

        _relevantConstructs = new beans.Construct[newConstructs.size()];
        for (int i=0;i<newConstructs.size();i++)
        {
            _relevantConstructs[i] = (beans.Construct)newConstructs.get(i);
        }
    }
}
