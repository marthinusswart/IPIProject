
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.http.HttpSession;
import beans.ReportsManager;
import beans.Customer;

import org.apache.log4j.*;


/*
 * Created on 07-Jun-2005
 * 
 * 
 */
/**
 * @author psnel
 *
 * 
 */
public class PortalServlet extends HttpServlet
{

    private PrintWriter out;		// document output stream    
    private static ContentManager gPgMan;		// handles (secure) including of content
    private String logfilePath;
    private String logfileSettings;
    private String logfileFullPath;
    private String logInitErrors = "";
    private boolean logInitWasSuccess = false;
    private boolean isEmbedded = false;

    @Override
    public void init() throws ServletException
    {
        super.init();

        InitializeLogMechanism();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        String mode = req.getParameter("mode");
        String page = req.getParameter("pg");
        boolean showLogs = (req.getParameter("showlogdetails") != null);
        boolean isResumePrint = (page != null) && (page.equals("-44"));

        if (showLogs)
        {
            showLogDetails(resp);
        }
        else
        {
            if (mode == null)
            {
                HttpSession session = req.getSession(false);
                if (session != null)
                {
                    if (session.getAttribute("mode") != null)
                    {
                        mode = session.getAttribute("mode").toString();
                    }
                }
            }

            // init
            gPgMan = new ContentManager(req, resp, getServletContext().getRealPath("/"));
            out = resp.getWriter();

            // HTTP Header
            resp.setContentType("text/html");

            // 1. Caching mgmt ..
            // ..disallow cache-ing for secure pages:
            //if(gPgMan.getSecurityManager().isLoggedIn()){
            // ..Set to expire far in the past.
            resp.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
            // ..Set standard HTTP/1.1 no-cache headers.
            resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
            // ..Set IE extended HTTP/1.1 no-cache headers (use addHeader).
            resp.addHeader("Cache-Control", "post-check=0, pre-check=0");
            // ..Set standard HTTP/1.0 no-cache header.
            resp.setHeader("Pragma", "no-cache");
            resp.setHeader("P3P", "CP=\"ALL DSP COR CUR OUR STP ONL\"");
            //}

            // 2. Session mgmt
            HttpSession session = req.getSession(true);
            if (session.isNew())
            {
                //session.setMaxInactiveInterval(420); // 7 mins
                session.setMaxInactiveInterval(2940); // 49 mins
                if (mode != null)
                {
                    session.setAttribute("mode", mode);
                }
            }

            if (mode != null)
            {
                session.setAttribute("mode", mode);                
            }

            Object sessionMode = session.getAttribute("mode");

            if (sessionMode != null)
            {
                mode = sessionMode.toString();
            }
            else
            {
                mode = "";
            }
           
            isEmbedded = mode.equals("embedded");
            boolean showReport = req.getParameter("reportId") != null;
            boolean showReportMatrix = req.getParameter("reportIds") != null;

            // 3. Document Output..
            if (!isEmbedded)
            {
                if ((!showReport) && (!showReportMatrix))
                {
                    // ..alt titles, meta, styles, scripts
                    doDocHeader();
                }
                else
                {
                    doReportHeader(req.getParameter("reportId"), req.getParameter("reportIds"));
                }
            }
            else
            {
                // the embedded doc header
                doEmbeddedDocHeader();
            }

            if ((!showReport) && (!showReportMatrix) && (!isResumePrint))
            {
                if (!isEmbedded)
                {
                    // ..alt menus
                    doDocMenu();
                }
                else
                {
                    // do the embedded menu
                    doEmbeddedDocMenu();
                }

                // ..alt NavBar, Contents [Main], Sidebar (eg. customer comment)
                doDocBody();
            }
            else
            {
                doReportBody();
            }

            if (isEmbedded)
            {
                setLoggedInUserInfo();
            }

            // .. std footer
            doDocFooter();

            out.close();
        }
    }

    private void setLoggedInUserInfo()
    {
        if (gPgMan.getSecurityManager().isLoggedIn())
        {
            out.print("<script type=\"text/javascript\">\n");
            out.print("setLoggedInUser('" + gPgMan.getSecurityManager().getUser() + "', \"loggedInId\");\n");
            out.print("</script>\n");
        }
    }

    /**
     * doDocXXX() methods
     *
     * These methods output their respective sections of the HTML document.
     */
    private void doReportHeader(String reportId, String reportIds)
    {
        Customer customer = null;

        if (reportId != null)
        {
            customer = ReportsManager.getCustomerByReportId(reportId);
        }
        else
        {
            String[] reports = reportIds.split(",");
            if (reports.length > 0)
            {
                customer = ReportsManager.getCustomerByReportId(reports[0]);
            }
        }

        String html = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n"
                + "<html>\n"
                + "<head>\n"
                + "	<title>Functional Intelligence</title>\n"
                // META
                + "	<meta content='text/html; charset=windows-1252' http-equiv=Content-Type>\n"
                + // styles
                "	<link rel='stylesheet' type='text/css' href='css/main.css'>\n"
                + "	<link rel='stylesheet' type='text/css' href='css/pop2Xmenus.css'>\n"
                + " <link rel='shortcut icon' href='images/logo.ico' >"
                + "	<style>div.loggedinmsg{	position:absolute;	top:150px;	left:6px;	font-size:9px;	color:#AC6;}"
                + "	span.loggedinusr{	color:#FFF;}</style>\n"
                + // scripts
                "	<script type='text/javascript' src='script/client/menus/pop2Xmenus.js'></script>\n"
                + ((gPgMan.getSecurityManager().isLoggedIn())
                   ? "	<script type='text/javascript' src='script/client/GLib.js'></script>\n"
                     + "	<script type='text/javascript' src='script/client/CDynamicTable.js'></script>\n" : "")
                + "</head>\n"
                + "<body>\n"
                + "	<table border='0' width='100%'>\n"
                + "		<tr>\n";

        /*
                if (customer == null)
                {
                    html += "			<td style='vertical-align:middle'><img border='0' src='images/ipilogo.jpg'></td>\n";
                }
                else
                {
                    if (customer.getLogo() != null && !(customer.getLogo().equals("")))
                    {
                        html += "			<td style='vertical-align:middle'><img border='0' src='images/" + customer.getLogo() + "'></td>\n";
                    }
                    else
                    {
                        html += "			<td style='vertical-align:middle'><img border='0' src='images/ipilogo.jpg'></td>\n";
                    }
                }

                html += "		</tr>\n" + "	</table>\n";
*/
        out.print(html);
    }

    private void doDocHeader()
    {
        out.print(
                "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n"
                + "<html>\n"
                + "<head>\n"
                + "	<title>Functional Intelligence</title>\n"
                // META
                + "	<meta content='text/html; charset=windows-1252' http-equiv=Content-Type>\n"
                + // styles
                "	<link rel='stylesheet' type='text/css' href='css/main.css'>\n"
                + "	<link rel='stylesheet' type='text/css' href='css/pop2Xmenus.css'>\n"
                + " <link rel='shortcut icon' href='images/logo.ico' >"
                + "	<style>div.loggedinmsg{	position:absolute;	top:150px;	left:6px;	font-size:9px;	color:#AC6;}"
                + "	span.loggedinusr{	color:#FFF;}</style>\n"
                + // scripts
                "	<script type='text/javascript' src='script/client/menus/pop2Xmenus.js'></script>\n"
                + ((gPgMan.getSecurityManager().isLoggedIn())
                   ? "	<script type='text/javascript' src='script/client/GLib.js'></script>\n"
                     + "	<script type='text/javascript' src='script/client/CDynamicTable.js'></script>\n" : "")
                + "</head>\n"
                + "<body>\n"
                + "	<table border='0' width='100%'>\n"
                + "		<tr>\n"
                + "			<td style='vertical-align:middle'><img border='0' src='images/ipilogo.jpg'></td>\n"
                + "			<td width='180px' style='text-align:right'>\n"
                + "				<img border='0' src='images/compas.jpg' width='170' height='100'></td>\n"
                + "		</tr>\n"
                + "	</table>\n");
    }

    private void doEmbeddedDocHeader()
    {
        out.print(
                "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n"
                + "<html>\n"
                + "<head>\n"
                + "	<title>Embedded Functional Intelligence</title>\n"
                + // META
                "	<meta content='text/html; charset=windows-1252' http-equiv=Content-Type>\n"
                + // styles
                "	<link rel='stylesheet' type='text/css' href='css/main.css'>\n"
                + "	<link rel='stylesheet' type='text/css' href='css/pop2Xmenus.css'>\n"
                + " <link rel='shortcut icon' href='images/logo.ico' >"
                + "	<style>div.loggedinmsg{	position:absolute;	top:150px;	left:6px;	font-size:9px;	color:#AC6;}"
                + "	span.loggedinusr{	color:#FFF;}</style>\n"
                + // scripts
                "	<script type='text/javascript' src='script/client/menus/pop2Xmenus.js'></script>\n"
                + ((gPgMan.getSecurityManager().isLoggedIn())
                   ? "	<script type='text/javascript' src='script/client/GLib.js'></script>\n"
                     + "	<script type='text/javascript' src='script/client/CDynamicTable.js'></script>\n" : "")
                + "</head>\n"
                + "<body>\n");
    }

    private void doDocMenu()
    {
        out.print(
                "	<table border=0 cellPadding=0 cellSpacing=0 width='100%'>\n"
                + "		<tr>\n"
                + "			<td>\n");

        gPgMan.include(false, true, "mn" + gPgMan.getSecurityManager().getUserLvl());
        out.print(
                "			</td>\n"
                + "		</tr>\n"
                + "		<tr>\n"
                + "			<td>\n");
    }

    private void doEmbeddedDocMenu()
    {
        out.print(
                "	<table border=0 cellPadding=0 cellSpacing=0 width='100%'>\n"
                + "		<tr>\n"
                + "			<td>\n");

        gPgMan.include(false, true, "emn" + gPgMan.getSecurityManager().getUserLvl());


        out.print(
                "			</td>\n"
                + "		</tr>\n"
                + "		<tr>\n"
                + "			<td>\n");
    }

    private void doDocBody()
    {
        String htmlBody = "	<table border=0 cellPadding=0 cellSpacing=0 width='100%'>\n"
                          + "		<tr>\n"
                          + "			<td>\n"
                          + "				<table border='0' cellPadding=0 cellSpacing=0 width='100%' height='100%'>\n"
                          + "					<tr>\n";

        out.print(htmlBody);        

        generateMainBody();        

        out.print("					</tr>\n"
                  + "				</table>\n"
                  + "			</td>\n"
                  + "		</tr>\n"
                  + "	</table>\n");
    }

   /**
     * @deprecated
     * We do not generate the comments anymore.
     */
    @Deprecated
    private void generateComments()
    {
        out.print("<td width='20%'>");
        // <!-- [Sidebar: Customer Comments] -->
        if (!gPgMan.getSecurityManager().isLoggedIn())
        {
            gPgMan.include(false, "sb_1.html");
        }
        out.print("</td>");
    }

    private void generateMainBody()
    {
        String size = "100%";       

        String htmlBody = "<td width='" + size + "'>\n"
                          + //<!-- [MAIN Content (protected)] -->
                "<div class='mainContent'>\n";

        out.print(htmlBody);

        gPgMan.include(true, true);

        htmlBody = "</div>\n"
                   + "						</td>\n";

        out.print(htmlBody);
    }

    /**
     * @deprecated
     * We do not generate the side navigation anymore.
     */
    @Deprecated
    private void generateNavigation()
    {
        String htmlNavigation = "						<td style='border-right:1px solid #AC6; background-color:#215E21;'>\n"
                                + // <!-- [Navigation Links - LEFT] -->
                "						<div class='navLinkBar'>\n";

        out.print(htmlNavigation);

        if (gPgMan.getNavPg().length() < 3
            || (gPgMan.getNavPg().length() >= 3 && !gPgMan.getNavPg().substring(1, 3).equals("53")))
        { // <<-- WTF!?

            gPgMan.include(false, "nav_" + ((gPgMan.getSecurityManager().getUserLvl() >= 1) ? 1 : 0) + ".html");
        }
        else
        {
            gPgMan.include(false, "nav_X.html");
        }

        htmlNavigation = "						<div>\n"
                         + // <!-- [logged-in msg - LEFT] -->
                "						<div class='loggedinmsg'>"
                         + ((gPgMan.getSecurityManager().isLoggedIn())
                            ? "logged in as: <span class='loggedinusr'>"
                              + gPgMan.getSecurityManager().getUser() + "</span>" : "&nbsp;") + "</div>\n"
                         + "						</td>\n";
        out.print(htmlNavigation);
    }

    private void doReportBody()
    {
        gPgMan.include(true, true);
    }

    private void doDocFooter()
    {
        out.print(  "</td></tr><tr><td>"
                + "  <div class='footer'>&copy; 2010 FQGlobal Limited - All rights reserved </div>\n"
                + "</td></tr></table>"
                + "</body>\n"
                + "</html>\n");
    }

    private void showLogDetails(HttpServletResponse resp) throws IOException
    {
        if (!logInitWasSuccess)
        {
            InitializeLogMechanism();
        }

        out = resp.getWriter();

        // HTTP Header
        resp.setContentType("text/html");

        out.print(
                "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n"
                + "<html>\n"
                + "<head>\n"
                + "	<title>Functional Intelligence</title>\n"
                + // META
                "	<meta content='text/html; charset=windows-1252' http-equiv=Content-Type>\n"
                + // styles
                "	<link rel='stylesheet' type='text/css' href='css/main.css'>\n"
                + "	<link rel='stylesheet' type='text/css' href='css/pop2Xmenus.css'>\n"
                + " <link rel='shortcut icon' href='images/logo.ico' >"
                + "	<style>div.loggedinmsg{	position:absolute;	top:150px;	left:6px;	font-size:9px;	color:#AC6;}"
                + "	span.loggedinusr{	color:#FFF;}</style>\n"
                + "</head>\n"
                + "<body>\n"
                + "	<table border='0' width='100%'>\n"
                + "		<tr>\n"
                + "			<td width='50%'><img border='0' src='images/ipilogo.jpg' width='360' height='90'></td>\n"
                + "			<td width='50%' style='text-align:right'>\n"
                + "				<img border='0' src='images/compas.jpg' width='170' height='100'></td>\n"
                + "		</tr>\n"
                + "	</table>\n");

        out.print("Log file path: " + logfilePath);
        out.print("<p>");
        out.print("Log file full path: " + logfileFullPath);
        out.print("<p>");
        out.print("Log file settings: " + logfileSettings);
        out.print("<p>");
        out.print("Log init errors: " + logInitErrors);
        out.print("</body>");

    }

    private void InitializeLogMechanism()
    {
        logfilePath = getServletContext().getRealPath("/");
        logfilePath += "WEB-INF/";

        logfileSettings = logfilePath + "log4j.properties";
        logfileFullPath = logfilePath + "functionalintelligence.log";

        try
        {
            PropertyConfigurator.configure(logfileSettings);
            RollingFileAppender fileAppender = (RollingFileAppender) Logger.getRootLogger().getAppender("FileLog");
            fileAppender.setFile(logfileFullPath);
            fileAppender.activateOptions();
        }
        catch (Exception ex)
        {
            logInitErrors += "Failed to reconfig file: " + ex.getMessage();
        }

        Logger log = Logger.getLogger(PortalServlet.class);
        log.info("PortalServlet Initialized");

        File file = new File(logfileFullPath);
        if (!(file.exists()))
        {
            logInitErrors += "There is no log file after the log to the logger";

            try
            {
                file.createNewFile();
            }
            catch (Exception ex)
            {
                logInitErrors += ex.getMessage();
            }
        }
        else
        {
            logInitWasSuccess = true;
        }
    }
}
