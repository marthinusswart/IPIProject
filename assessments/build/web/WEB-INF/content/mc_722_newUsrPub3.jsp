<%@ page language="java" import="beans.*" %>
<%
        String msg = "&nbsp;";
        boolean errOccurred = false;
        boolean usrOK = false;

        String user = request.getParameter("user");
        String key = request.getParameter("key");
        boolean isTesting = (request.getParameter("testing") != null && request.getParameter("testing").equals("yes"));
        String dbkey;

        try
        {
            // confirm valid URL
            Exception err = new Exception("Invalid confirmation URL");

            if (user == null || key == null || user.equals("") || key.equals(""))
            {
                throw err;
            }

            dbkey = AutoRegUser.generateKey(user);

            if (!dbkey.equals(key))
            {
                if (!isTesting)
                {
                    throw err;
                }
            }

            // Update status of registration
            AutoRegUser newUsr = new AutoRegUser();
            newUsr.setUserName(user);
            newUsr.loadDetails();
            newUsr.updateStatus();

            // Mail confirmation 2
            //newUsr.mailConfirmation2();

            msg = "Success: Registration for user '" + user + "' confirmed.";
        }
        catch (Exception e)
        {
            msg = "Registration confirmation failed! The following was reported: \"" + e.getMessage() + "\"";
            errOccurred = true;
        }

        // output result
%>

<style>
    .toplink{
        font-size: 8pt;
        font-weight:normal;
    }

    .greyout{
        color:#777;
    }

    .infobox{
        padding: 2px 0 2px 4px;
        width:325px;
        background-color:#DDD;
        border:1px solid #777;
        font-size: 8pt;
        font-style:italic;
    }
</style>

<h2>New User Registration</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>
<%if (!errOccurred)
        {%>
<a id="q"></a>
<h3>More Info on Registration</h3>
<h4><u>General info & instructions</u></h4>
<p>
    Step #
<ol>
    <li><span class="greyout">Complete the registration form, then click the "Step 2: Confirm"-button to confirm your details. Make sure you've provided a valid e-mail address.</span></li>
    <li><span class="greyout">Click "Finish" to submit you registration.</span></li>
    <li><span class="greyout">Retrieve the confirmation e-mail that will be sent to the e-mail address you've provided.</span></li>
    <li><span class="greyout">Follow the link specified in the confirmation e-mail. This will bring you to a page that will finalise your registration, and provide you with more information. This information will also be mailed to you for safe keeping.</span></li>
    <li><span class="greyout">Once these steps have been completed, your assessment will be activated and you will be able to login and complete the questionnaire.</span></li>
</ol>

<a href="#top" class='toplink'>[ top ]</a>

<% }
else
{%>
<h3>Step 5: Submit E-Mail confirmation (-error-)</h3>
<p>There seems to be a problem with the confirmation link you used. <u>One of the following might be the case</u>:
<ul>
    <li>There might be a <i>spelling error</i> in the link, try copy/paste it into the browser's address bar.</li>
    <li>Your registration has already been confirmed, but payment has not yet been verified. In this case, you should wait for us to inform you that your payment has been confirmed, and that your account is active.</li>
    <li>Both your registration and payment has been confirmed. Your account should be active.<br>Try <a href="?pg=-2">logging in</a>.</li>
    <li>You might have taken too long (more than 10 days) to complete the registration, and your <i>registration request was canceled</i>. In this case you must <a href="?pg=720">register again</a>.</li>
</ul>

<br>
<h4>Sorry for the inconvenience</h4>
<%	}%>