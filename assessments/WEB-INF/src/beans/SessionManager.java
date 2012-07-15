/* SessionManager.java
 * 
 * Created on 08-Jul-2005
 */
package beans;

import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

/**
 * @author psnel
 *
 * TODO implement this class as a Singleton
 */
public class SessionManager
{

    private HttpSession gSession;

    public SessionManager(HttpSession session)
    {
        gSession = session;
    }

    public int getUserLvl()
    {
        try
        {
            return ((Integer) gSession.getAttribute("userLvl")).intValue();
        }
        catch (Exception ex)
        {
        }

        return -1;
    }

    public String getUserName()
    {
        return (String) gSession.getAttribute("user");
    }

    public String getCustID(boolean getDBIfNull) throws Exception
    {
        String custID = (String) gSession.getAttribute("custID");

        if (custID == null && getDBIfNull)
        {
            DBProxy db = new DBProxy();
            ResultSet res = db.executeQuery(
                    "SELECT fkCustID "
                    + "FROM Users "
                    + "WHERE username='" + getUserName() + "'");
            if (res.next())
            {
                custID = res.getString("fkCustID");
                gSession.setAttribute("custID", custID);
            }

            db.close();

        }

        return custID;
    }

    public void setQre(Questionaire qre)
    {
        // save Questionaire in session
        gSession.setAttribute("qre1", qre);
    }

    public Questionaire getQre()
    {
        return (Questionaire) gSession.getAttribute("qre1");
    }

    public void setAssmt(Assignment assmt)
    {
        gSession.setAttribute("assmt1", assmt);
    }

    public Assignment getAssmt()
    {
        return (Assignment) gSession.getAttribute("assmt1");
    }

    public void setLiveTest(LiveTest lt)
    {
        if (lt != null)
        {
            gSession.setAttribute("lt1", lt);
        }
        else
        {
            gSession.removeAttribute("lt1");
        }
    }

    public LiveTest getLiveTest()
    {
        return (LiveTest) gSession.getAttribute("lt1");
    }

    /**
     * @param uacc - object array of {User(), Address(), Address()}
     */
    public void setUserAcc(Object[] uacc)
    {
        gSession.setAttribute("usracc", uacc);
    }

    public Object[] getUserAcc()
    {
        return (Object[]) gSession.getAttribute("usracc");
    }

    public void setSuperConstructId(String superConstructId)
    {
        gSession.setAttribute("superconstructid", superConstructId);
    }

    public String getSuperConstructId()
    {
        return (String) gSession.getAttribute("superconstructid");
    }

    public void setConstructId(String constructId)
    {
        gSession.setAttribute("constructid", constructId);
    }

    public String getConstructId()
    {
        return (String) gSession.getAttribute("constructid");
    }
}
