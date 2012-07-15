
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Err;

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
public class ContentManager
{

    private HttpServletRequest gRequest;			// main request object
    private HttpServletResponse gResponse;			// main response object
    private PrintWriter out;				// document output stream
    private String gsNavPg;			// code of page that was requested
    private static HashMap ghPgMap;			// mappings of page codes to file names
    private static String gsAppRoot;			// path of application in server filesystem
    private static final String gsContextRoot = "/";
    private static final String gsContentPath = "content/";
    private static final String gsSecContentPath = "content/secure/";
    private SecurityManager gSecMan;			// security manager for current request

    public ContentManager(HttpServletRequest req, HttpServletResponse resp, String appRoot)
            throws IOException
    {

        gRequest = req;
        gResponse = resp;
        out = resp.getWriter();
        gsAppRoot = appRoot;

        // what page was reguested?
        gsNavPg = (String) gRequest.getParameter("pg");
        if (gsNavPg == null)
        {
            gsNavPg = "0";
        }

        // Authenticator
        gSecMan = new SecurityManager(req);

        // Map pages..
        ghPgMap = new HashMap(67, 5F);

        // .. PUBLIC pages (mc_<navPg>_<name>.html):
        ghPgMap.put("0", "mc_0_home.html");
        ghPgMap.put("1", "mc_1_definitions.html");
        ghPgMap.put("2", "mc_2_products.html");
        ghPgMap.put("20", "mc_20_bee.html");
        ghPgMap.put("21", "mc_21_childFunc.html");

        ghPgMap.put("22", "mc_22_jobs.html");
        ghPgMap.put("23", "mc_23_orgScreen.html");
        ghPgMap.put("24", "mc_24_cPlan.html");
        ghPgMap.put("25", "mc_25_pprofile.html");
        ghPgMap.put("27", "mc_27_jobdef.html");

        ghPgMap.put("3", "mc_3_services.html");
        ghPgMap.put("31", "mc_31_bursaries.html");
        ghPgMap.put("32", "mc_32_cvregister.html");
        ghPgMap.put("33", "mc_33_coaching.html");
        ghPgMap.put("34", "mc_34_recruitment.html");

        ghPgMap.put("35", "mc_35_tcatalyst.html");
        ghPgMap.put("37", "mc_37_sme.html");
        ghPgMap.put("4", "mc_4_adv.html");
        ghPgMap.put("5", "mc_5_contact.html");
        ghPgMap.put("51", "mc_51_contactmail.jsp");
        ghPgMap.put("52", "mc_52_privacypolicy.html");

        ghPgMap.put("6", "mc_6_faq.html");
        ghPgMap.put("7", "mc_7_mailer.html");
        ghPgMap.put("71", "mc_71_mailSend.jsp");
        ghPgMap.put("720", "mc_720_newUsrPub.jsp");
        ghPgMap.put("721", "mc_721_newUsrPub2.jsp");
        ghPgMap.put("722", "mc_722_newUsrPub3.jsp");
        ghPgMap.put("723", "mc_723_newUsrPub4.jsp");
        ghPgMap.put("724", "mc_724_newUsrPub5.jsp");

        // .. Menus (menu_<userLevel>.html):
        ghPgMap.put("mn0", "menu_0.html");
        ghPgMap.put("mn1", "menu_1.html");
        ghPgMap.put("mn2", "menu_2.html");
        ghPgMap.put("mn3", "menu_3.html");

         // .. Embedded Menus (menu_embedded_<userLevel>.html):
        ghPgMap.put("emn0", "menu_embedded_0.html");
        ghPgMap.put("emn1", "menu_embedded_1.html");
        ghPgMap.put("emn2", "menu_embedded_2.html");
        ghPgMap.put("emn3", "menu_embedded_3.html");

        // .. nav links

        // .. SECURE pages (sc_<-1*navPg>_name.[html|jsp]):
        ghPgMap.put("-1", "mc_login.html");	// special case (see secureInclude() & SecurityManager)
        ghPgMap.put("-11", "sc_logout.html");	// "
        ghPgMap.put("-2", "sc_2_home.html");
        ghPgMap.put("-210", "sc_210_orgAcc.jsp");

        // .. SECURE (Organizations - 3xx)
        ghPgMap.put("-30", "sc_30_allOrg.jsp");
        ghPgMap.put("-310", "sc_310_newOrg.jsp");
        ghPgMap.put("-311", "sc_311_newOrg2.jsp");
        ghPgMap.put("-312", "sc_312_newOrg3.jsp");

        ghPgMap.put("-315", "sc_315_enableDisableOrg.jsp");

        ghPgMap.put("-320", "sc_320_newUsr.jsp");
        ghPgMap.put("-321", "sc_321_newUsr2.jsp");
        ghPgMap.put("-33", "sc_33_addCred.jsp");
        ghPgMap.put("-339", "sc_339_adMgmtOrg.jsp");

        ghPgMap.put("-340", "sc_340_adMgmt.jsp");
        ghPgMap.put("-341", "sc_341_newAd.jsp");
        ghPgMap.put("-350", "sc_350_orgTree.jsp");

        // .. SECURE (Individuals   - 4xx)
        ghPgMap.put("-40", "sc_40_allUsr.jsp");
        ghPgMap.put("-401", "sc_401_allUsrAssmt.jsp");
        ghPgMap.put("-41", "sc_41_newUsrOrg.jsp");

        ghPgMap.put("-42", "sc_420_regUsr.jsp");
        ghPgMap.put("-420", "sc_420_regUsr.jsp");
        ghPgMap.put("-421", "sc_421_regUsr2.jsp");
        ghPgMap.put("-422", "sc_422_regUsrAcc.jsp");
        ghPgMap.put("-423", "sc_423_searchForIndividual.jsp");
        ghPgMap.put("-424", "sc_424_searchForSkills.jsp");
        ghPgMap.put("-43", "sc_43_usrAcc.jsp");
        ghPgMap.put("-44", "sc_44_usrAccPrint.jsp");

        // .. SECURE (Assessments	- 5xx)...
        ghPgMap.put("-50", "sc_50_allQre.jsp");
        ghPgMap.put("-502", "sc_502_qreDetail.jsp");

        // ...51x: Create new Questionaire
        ghPgMap.put("-510", "sc_510_newQre.jsp");
        ghPgMap.put("-511", "sc_511_newQre2.jsp");
        ghPgMap.put("-512", "sc_512_newQre3.jsp");

        // ...52x: Assign Qre to users
        ghPgMap.put("-520", "sc_520_assQreUsr.jsp");
        ghPgMap.put("-521", "sc_521_assQreUsr2.jsp");
        ghPgMap.put("-522", "sc_522_assQreUsr3.jsp");
        ghPgMap.put("-523", "sc_523_removeQreUsr.jsp");

        // ...53x: LiveTest
        ghPgMap.put("-530", "sc_530_testConsent.jsp");
        ghPgMap.put("-531", "sc_531_test.jsp");
        ghPgMap.put("-532", "sc_532_test2.jsp");

        // ...54x: Reports
        ghPgMap.put("-54", "sc_54_reports.jsp");
        ghPgMap.put("-540", "sc_540_reportController.jsp");
        ghPgMap.put("-541", "sc_541_formattedReport.jsp");
        ghPgMap.put("-542", "sc_542_reportMatrixSelect.jsp");
        ghPgMap.put("-543", "sc_543_reportMatrix.jsp");

        // ...60x: Constructs Admin
        ghPgMap.put("-60", "sc_60_allSuperConstructs.jsp");
        ghPgMap.put("-602", "sc_602_scDetail.jsp");
        ghPgMap.put("-603", "sc_603_constructs.jsp");
        ghPgMap.put("-604", "sc_604_constructDetail.jsp");
        ghPgMap.put("-605", "sc_605_constructQuestions.jsp");
        ghPgMap.put("-606", "sc_606_questionDetail.jsp");
        ghPgMap.put("-607", "sc_607_removeConstruct.jsp");

        // ...61x: Questionnaire Admin
        ghPgMap.put("-610", "sc_610_removeSuperConstruct.jsp");
        ghPgMap.put("-611", "sc_611_addSuperConstruct.jsp");
        ghPgMap.put("-612", "sc_612_excludeConstruct.jsp");
        ghPgMap.put("-613", "sc_613_includeConstruct.jsp");

    }

    public String getNavPg()
    {
        return gsNavPg;
    }

    public SecurityManager getSecurityManager()
    {
        return gSecMan;
    }

    public void include(boolean isSecure, String filename)
    {
        if (isSecure)
        {
            includeSecure(filename);
        }
        else
        {
            includeFile(gsContentPath + filename);
        }
    }

    public void include(boolean isSecure, boolean isMapped)
    {
        include(isSecure, (String) ghPgMap.get(gsNavPg));
    }

    public void include(boolean isSecure, boolean isMapped, String key)
    {
        include(isSecure, (String) ghPgMap.get(key));
    }

    private void includeSecure(String filename)
    {
        // simple include
        if (Integer.parseInt(gsNavPg) >= 0)
        {
            includeFile(gsContentPath + filename);
        }
        else
        {
            // user logged in?
            if (gSecMan.isLoggedIn())
            {	// YES..
                // ..include page (if available to user's user-level)
                String sPath = gsSecContentPath + gSecMan.getUserLvl() + "/";
                includeFile(sPath + filename);
            }
            else
            {						// NO..
                boolean isMaxLogins = false;

                // .. previous login failed?
                if (gSecMan.getLoginAttempts() >= 1)
                {
                    // ... YES: > max logins?
                    if (gSecMan.getLoginAttempts() >= gSecMan.getMaxAttempts())
                    {
                        // .... YES: no more allowed (you are an idiot, or a hacker)
                        Err.print(Err.E_MAX_FAILED_LOGINS, out);
                        isMaxLogins = true;
                    }
                    else
                    {
                        // .... NO: try again 
                        Err.print(Err.E_LOGIN_FAILED, out);
                        out.println(
                                "<div class='info_sm'>("
                                + "Attempt: " + (gSecMan.getLoginAttempts() + 1)
                                + "&nbsp;&nbsp;&nbsp;"
                                + "logins remaining: "
                                + (gSecMan.getMaxAttempts() - gSecMan.getLoginAttempts())
                                + ")</div><br>");// --err:"+beans.DBProxy.err+" / "+ gSecMan.err);
                    }
                }
                else
                {
                    out.println("<br><br>");
                }

                // .. include login page
                if (!isMaxLogins)
                {
                    includeFile(gsSecContentPath + ghPgMap.get("-1"));
                }
            }
        }
    }

    /**
     * Performs the actual page inclusion (exceptions are printed to std out)
     * @param path - pathe from context root of the file to be included.
     */
    private void includeFile(String path)
    {
        /*File f = new File(gsAppRoot+path);
        System.out.println(f.getName()+" exists? : "+f.exists());*/
        if (!(new File(gsAppRoot + path)).exists())
        {
            Err.print(Err.E_PAGE_NOT_FOUND, out);
        }
        else
        {
            try
            {
                gRequest.getRequestDispatcher(gsContextRoot + path).include(gRequest, gResponse);
            }
            catch (Exception e)
            {
            }
        }

        //}catch (ServletException e){}
        //catch (IOException iox){}
    }
}


