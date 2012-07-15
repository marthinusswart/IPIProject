/* Report.java
 * 
 * Created on 27-Jul-2005
 */
package beans;

import java.sql.ResultSet;
import java.util.Vector;

/**
 * @author psnel
 *
 */
public class Report
{

    private Assignment assignment;
    private String sAssmtTime;
    private String qreName;
    private String userFullName;
    private String customerName;
    private String reportId;
    private QandA[] qnaAnswerList;
    private Construct[] constructs;		// set of constructs in report
    private SuperConstruct[] superConstructs;
    //(only in detailed report.. load via loadConstructs())

    public Report(Assignment assmt, String assmtTime, String qrename, 
            String usrFullName, String custName)
    {
        assignment = assmt;
        sAssmtTime = assmtTime;
        qreName = qrename;
        userFullName = usrFullName;
        customerName = custName;
        reportId = assmt.getPKID();
    }

    /**
     * @return Returns the assignment.
     */
    public Assignment getAssignment()
    {
        return assignment;
    }

    public String getReportId()
    {
        return reportId;
    }

    public void loadConstructs(DBProxy db) throws Exception
    {
        ResultSet res;

        boolean isNewConstruct = true;

        // 1. count constructs
        int i;
        int index = 0;
        int tmpCurrCID = -1;
        for (i = 0; i < qnaAnswerList.length; i++)
        {
            if (qnaAnswerList[i].getFkC() != tmpCurrCID)
            {
                tmpCurrCID = qnaAnswerList[i].getFkC();
                index++;
            }
        }

        // 2. instantiate global array
        constructs = new Construct[index];

        // 3. construct constructs (:-&)
        index = 0;
        for (i = 0; i < qnaAnswerList.length; i++)
        {
            // new construct?
            if (index < constructs.length && (i == 0
                                              || qnaAnswerList[i].getFkC() != constructs[index - 1].getPKID()))
            { // YES: new Construct
                res = db.executeQuery(
                        "SELECT name, isPositive, isNeutral, fksc "
                        + "FROM Construct "
                        + "WHERE pkid=" + qnaAnswerList[i].getFkC());
                if (res.next())
                {
                    constructs[index++] =
                    new Construct(
                            res.getString("name"), qnaAnswerList[i].getFkC(), res.getInt("fksc"),
                            res.getBoolean("isPositive"), res.getBoolean("isNeutral"));
                }
                isNewConstruct = true;
            }
            else
            {
                isNewConstruct = false;				// NO: ignore
            }
            // add answer to construct
            constructs[index - 1].addAnswer(qnaAnswerList[i]);
        }

    }

    /**
     * Will load all the super constructs.
     * @param db
     * @return
     * @throws Exception
     * @deprecated We now use the ReportCategory to create sections and not the super construct anymore.
     */
    public void loadSuperConstructs(DBProxy db) throws Exception
    {
        ResultSet rs = null;
        Vector superConstructsVector = new Vector();
        String sql = "SELECT pkid, name FROM super_construct";
        rs = db.executeQuery(sql);

        while (rs.next())
        {
            SuperConstruct superConstruct = new SuperConstruct(rs.getString("pkid"),
                    "",
                    rs.getString("name"),
                    "");
            superConstructsVector.add(superConstruct);
        }

        superConstructs = new SuperConstruct[superConstructsVector.size()];
        for (int i=0; i<superConstructsVector.size(); i++)
        {
            superConstructs[i] = (SuperConstruct) superConstructsVector.get(i);
        }
        
    }

    /**
     * @return Returns the qreName.
     */
    public String getQreName()
    {
        return qreName;
    }

    /**
     * @return Returns the customerName.
     */
    public String getCustomerName()
    {
        return customerName;
    }

    /**
     * @return Returns the sAssmtTime.
     */
    public String getAssmtTime()
    {
        return sAssmtTime;
    }

    /**
     * @return Returns the userFullName.
     */
    public String getUserFullName()
    {
        return userFullName;
    }

    /**
     * @return Returns the qnaAnswerList.
     */
    public QandA[] getQnaAnswerList()
    {
        return qnaAnswerList;
    }

    /**
     * @return Returns the constructs.
     */
    public Construct[] getConstructs()
    {
        return constructs;
    }

    public SuperConstruct[] getSuperConstructs()
    {
        return superConstructs;
    }

    /**
     * @param qnaAnswerList The qnaAnswerList to set.
     */
    public void setQnaAnswerList(QandA[] qnaAnswerList)
    {
        this.qnaAnswerList = qnaAnswerList;
    }

    public Construct getConstructById(int constructId)
    {
        Construct result = null;

        for (int i=0;i<constructs.length;i++)
        {
            if (constructs[i].getPKID() == constructId)
            {
                result = constructs[i];
                break;
            }
        }

        return result;
    }
}
