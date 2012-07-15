
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import beans.DBProxy;
import java.util.Date;
import org.apache.log4j.Logger;


/*
 * Created on 13-Jun-2005
 *
 * 
 */
/**
 * @author psnel
 *
 * 
 */
public class SecurityManager
{

    private String gsUser = null;	// username of logged in user (if available)
    private String gsPassw = null;	// user's password
    private int giUserLvl = 0;		// security level of current user (default 0:public)
    private int giLoginAttempts = 0;		// number of times user failed to login this session.
    private int giMaxAttempts = 5;		// maximum number of failed logins allowed
    private boolean gbIsLoggedIn = false;
//public String err=null;
    HttpSession session = null;

    public SecurityManager(HttpServletRequest req)
    {

        // Login procedure..
        //HttpSession
        session = req.getSession(false); // session should have been created in portal
        gsUser = (String) session.getAttribute("user");

        // ..logged in?
        if (gsUser != null)
        { // YES:
            // ..trying to logout?
            String sPG = req.getParameter("pg");
            if (sPG != null && sPG.equals("-11"))
            {	// YES:
                Logger log = Logger.getLogger(SecurityManager.class);
                log.info("User logged out in using standard logout page. User:" + gsUser);

                // clear globals
                session.invalidate();
                gsUser = null;
                gsPassw = null;
                giUserLvl = 0;
                giLoginAttempts = 0;
                gbIsLoggedIn = false;                
            }
            else
            {									// NO:
                // init globals
                gbIsLoggedIn = true;
                gsPassw = (String) session.getAttribute("password");
                giUserLvl = ((Integer) session.getAttribute("userLvl")).intValue();
            }
        }
        else
        { 				// NO..
            // .. login-attempts:
            Integer iAttempts = (Integer) session.getAttribute("li_attempts");
            giLoginAttempts = (iAttempts == null) ? 0 : iAttempts.intValue();

            // ..trying to log in?
            String sLogin = (String) req.getParameter("login");
            if (sLogin != null)
            {	// YES..
                // .. do login
                gsUser = (String) req.getParameter("user");
                gsPassw = (String) req.getParameter("passw");
                if (gbIsLoggedIn = login())
                {
                    // session...
                    session.setAttribute("user", gsUser);
                    session.setAttribute("password", gsPassw);
                    session.setAttribute("userLvl", new Integer(giUserLvl));

                    Logger log = Logger.getLogger(SecurityManager.class);
                    log.info("User logged in. User:" + gsUser + ", max time for session timeout:" + (session.getMaxInactiveInterval()/60) + " minutes");
                }

                // ..howmanieth attempt is this?
                session.setAttribute("li_attempts", new Integer(++giLoginAttempts));

            }
        }
    }

    public String getUser()
    {
        return gsUser;
    }

    public String getPassword()
    {
        return gsPassw;
    }

    public int getUserLvl()
    {
        return giUserLvl;
    }

    public boolean isLoggedIn()
    {
        return gbIsLoggedIn;
    }

    public int getLoginAttempts()
    {
        return giLoginAttempts;
    }

    public int getMaxAttempts()
    {
        return giMaxAttempts;
    }

    public void setMaxAttempts(int iMax)
    {
        giMaxAttempts = iMax;
    }

    /**
     * Checks if (user, password) is in the database. Also sets the global user-level.
     *
     * @return true if user exists
     */
    private boolean login()
    {
        DBProxy db = new DBProxy();
        boolean ret = false;
        try
        {
            ResultSet res = db.executeQuery(
                    "SELECT fkLevel, username, password "
                    + "FROM USERS "
                    + "WHERE	username ='" + gsUser + "' AND "
                    + "password='" + gsPassw + "'");

            if (res.next())
            {
                giUserLvl = res.getInt("fkLevel");
                db.close();
                ret = true;
            }
        }
        catch (SQLException se)
        {
            se.printStackTrace();
            //err=se.getMessage();
        }
        catch (Exception e)
        {
            e.printStackTrace();
            //err=e.getMessage();
        }
        finally
        {
            db.close();
        }

        return ret;
    }
}
