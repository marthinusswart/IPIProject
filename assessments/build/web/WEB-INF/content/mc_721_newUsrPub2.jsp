<%@ page language="java" import="beans.*,mail.*" %>

<%
        AutoRegUser newUsr = (AutoRegUser) session.getAttribute("newuser");

        if (request.getParameter("confirm") == null)
        {
            Resume resume = newUsr.getResume();

            resume.setTradeQualifications(request.getParameter("tradeq3"));
            resume.setMarketSegmentFKID(request.getParameter("marketsegment3"));
            resume.setCareerFKID(request.getParameter("occupation3"));
            resume.setEmploymentStatusFKID(request.getParameter("employment3"));
            String value = request.getParameter("years3");

            if (value != null)
            {
                resume.setCurrentEmploymentYears(Integer.parseInt(value));
            }

            value = request.getParameter("months3");
            if (value != null)
            {
                resume.setCurrentEmploymentMonths(Integer.parseInt(value));
            }

            resume.setComments(request.getParameter("comments3"));
            resume.setHobbies(request.getParameter("hobbies3"));

%>

<style>
    .field{
        border:			1px solid black;
        background-color:#ccc;
        padding:2px 2px 2px 2px;
        font-weight: bold;
    }
    .value{
        border:			1px solid black;
        background-color:#fff;
        padding:2px 2px 2px 5px;
    }
    .value2{
        border-left:	1px solid black;
        border-right:	1px solid black;
        background-color:#fff;
        padding:0 2px 0 5px;
    }
    .value3{
        border-left:	1px solid black;
        border-right:	1px solid black;
        border-bottom:	1px solid black;
        background-color:#fff;
        padding:0 2px 2px 5px;
    }

    table.confirm{border-collapse:collapse;}

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
<div>&nbsp;</div>
<hr>
<script type='text/javascript' src="script/client/mc72.js"></script>
<h3>Step 3: Please confirm your details</h3>
<div class='infobox'>
    <span class='toplink'>[ <a href="#q">more info on registration</a> ]</span><br>
</div>
<br><br>
<table class='confirm'>
    <tr>
        <td class='field'>Username:</td>
        <td class='value'><%=newUsr.getUserName()%></td>
    </tr>
    <tr>
        <td class='field'>Password:</td>
        <td class='value'><%=newUsr.getPassword()%></td>
    </tr>
    <tr>
        <td class='field'>First Name:</td>
        <td class='value'><%=newUsr.getFirstName()%></td>
    </tr>
    <tr>
        <td class='field'>Initial:</td>
        <td class='value'><%=((newUsr.getInitial() != null) ? newUsr.getInitial() : "")%></td>
    </tr>
    <tr>
        <td class='field'>Last Name:</td>
        <td class='value'><%=newUsr.getLastName()%></td>
    </tr>
    <tr>
        <td class='field'>Title:</td>
        <td class='value'><%=((newUsr.getTitle() != null) ? newUsr.getTitle() : "")%></td>
    </tr>
    <tr>
        <td class='field'>ID Number:</td>
        <td class='value'><%=((newUsr.getIDNum() != null) ? newUsr.getIDNum() : "")%></td>
    </tr>
    <tr>
        <td class='field'>Company Reference #:</td>
        <td class='value'><%=((newUsr.getCompanyRef() != null) ? newUsr.getCompanyRef() : "")%></td>
    </tr>
    <tr>
        <td class='field'>Tel (W):</td>
        <td class='value'><%=((newUsr.getTelW() != null) ? newUsr.getTelW() : "")%></td>
    </tr>
    <tr>
        <td class='field'>Tel (H):</td>
        <td class='value'><%=((newUsr.getTelH() != null) ? newUsr.getTelH() : "")%></td>
    </tr>
    <tr>
        <td class='field'>Tel (Cell):</td>
        <td class='value'><%=((newUsr.getTelCell() != null) ? newUsr.getTelCell() : "")%></td>
    </tr>
    <tr>
        <td class='field'>Tel (Fax):</td>
        <td class='value'><%=((newUsr.getTelFax() != null) ? newUsr.getTelFax() : "")%></td>
    </tr>
    <tr>
        <td class='field'>Email:</td>
        <td class='value'><%=((newUsr.getEMail() != null) ? newUsr.getEMail() : "")%></td>
    </tr>
    <tr>
        <td class='field'>Qualification:</td>
        <td class='value'><%=AutoRegUser.getQualificationString(newUsr.getQualification())%></td>
    </tr>
    <!--
	<tr>
		<td class='field'>Website:</td>
		<td class='value'><%=((newUsr.getWebsite() != null) ? newUsr.getWebsite() : "")%></td>
	</tr>
	-->
    <tr>
        <td><img src="images/spacer.gif" width="135" height="1"></td>
        <td><img src="images/spacer.gif" width="192" height="1"></td>
    </tr>
</table>
<table class='confirm'>
    <tr>
        <td class='field' colspan="2"><b>Address (Home):</b></td>
        <td></td>
        <td class='field' colspan="2"><b>Address (Post):</b></td>
    </tr>
    <tr>
        <td class='value2' colspan="2"><%=((newUsr.getAddrHome().getStreet() != null) ? newUsr.getAddrHome().getStreet() : "")%></td>
        <td></td>
        <td class='value2' colspan="2"><%=((newUsr.getAddrPost().getStreet() != null) ? newUsr.getAddrPost().getStreet() : "")%></td>
    </tr>
    <tr>
        <td class='value2' colspan="2"><%=((newUsr.getAddrHome().getSuburb() != null) ? newUsr.getAddrHome().getSuburb() : "")%></td>
        <td></td>
        <td class='value2' colspan="2"><%=((newUsr.getAddrPost().getSuburb() != null) ? newUsr.getAddrPost().getSuburb() : "")%></td>
    </tr>
    <tr>
        <td class='value2' colspan="2"><%=((newUsr.getAddrHome().getCity() != null) ? newUsr.getAddrHome().getCity() : "")%></td>
        <td></td>
        <td class='value2' colspan="2"><%=((newUsr.getAddrPost().getCity() != null) ? newUsr.getAddrPost().getCity() : "")%></td>
    </tr>
    <tr>
        <td class='value3' colspan="2"><%=((newUsr.getAddrHome().getAreaCode() != null) ? newUsr.getAddrHome().getAreaCode() : "")%></td>
        <td></td>
        <td class='value3' colspan="2"><%=((newUsr.getAddrPost().getAreaCode() != null) ? newUsr.getAddrPost().getAreaCode() : "")%></td>
    </tr>
    <tr>
        <td><img src="images/spacer.gif" height="1" width="135" alt=""></td>
        <td><img src="images/spacer.gif" height="1" width="150" alt=""></td>
        <td><img src="images/spacer.gif" height="1" width="30" alt=""></td>
        <td><img src="images/spacer.gif" height="1" width="135" alt=""></td>
        <td><img src="images/spacer.gif" height="1" width="150" alt=""></td>
    </tr>
</table>

<hr>
<br>
<form action="index.jsp" method='post' style="float:right">
    <div style='text-align:right;'>
        <input type='submit' class='btn2' value=" Finish " />
    </div>
    <input type='hidden' name='pg' value="721" />
    <input type='hidden' name='confirm' value="1" />
</form>
<form action="index.jsp" method='post' style="float:right;padding-right:5px;">
    <div style='text-align:right;'>
        <input type='submit' class='btn2' value=" << Back " />
    </div>
    <input type='hidden' name='pg' value="720" />
</form>
<br><br>
<hr>
<a id="q"></a>
<h3>More Info on Registration</h3>
<h4><u>General info & instructions</u></h4>
<p>
    Step #
<ol>
    <li><span class="greyout">Complete the registration form, then click the "Step 2: Resum&eacute;"-button to add your employment details. Make sure you've provided a valid e-mail address.</span></li>
    <li><span class="greyout">Complete the resum&eacute; form, then click the "Step 3: Confirm"-button to confirm your details. Make sure you've provided a valid e-mail address.</span></li>
    <li><b>Click "Finish" to submit you registration.</b></li>
    <li><span class="greyout">Retrieve the confirmation e-mail that will be sent to the e-mail address you've provided.</span></li>
    <li><span class="greyout">Once these steps have been completed, your assessment will be activated and you will be able to login and complete the questionnaire.</span></li>
</ol>

<a href="#top" class='toplink'>[ top ]</a>
<%



            /* ----------------------------------- ----------------------------------- ----------------------------------- */
        }
        else
        {															// (2.) posted back to self: commit & email
            String msg = "&nbsp;";
            boolean errOccurred = false;
            boolean usrOK = false;

            // Store nwe Registration
            try
            {
                // save new registration
                newUsr.commit();


                // mail details to user
                try
                {
                    newUsr.mailConfirmation1();

                }
                catch (Exception ex)
                {
                    // Delete registration if e-mail failed
                    newUsr.delete();

                    throw ex;
                }

                msg = "Registration request for user '" + newUsr.getUserName() + "' submitted successfully.";

            }
            catch (Exception e)
            {
                msg = "User account '" + newUsr.getUserName() + "' could not be saved. The following error was reported:" + e.getMessage();
                errOccurred = true;
            }


            // output result
%>

<style>
    .toplink{e: 8pt;
             font-weight:normal;
    }

    .greyout{
        color:#777;
    }

    .infobox{
        padding: 2px 0 2px 4px;
        width:325px;
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
<%

            if (!errOccurred)
            {
%>
<h3>E-mail confirmation</h3>
<p>Your details have been sent to the e-mail address you've provided. You should receive it within a few minutes.</p>
<p>Please keep your details in a safe place.</p>
<br><br>
<hr>

<a id="q"></a>
<h3>More Info on Registration</h3>
<h4><u>General info & instructions</u></h4>
<p>
    Step #
<ol>
    <li><span class="greyout">Complete the registration form, then click the "Step 2: Resum&eacute;"-button to add your employment details. Make sure you've provided a valid e-mail address.</span></li>
    <li><span class="greyout">Complete the resum&eacute; form, then click the "Step 3: Confirm"-button to confirm your details. Make sure you've provided a valid e-mail address.</span></li>
    <li><b>Click "Finish" to submit you registration.</b></li>
    <li><span class="greyout">Retrieve the confirmation e-mail that will be sent to the e-mail address you've provided.</span></li>
    <li><span class="greyout">Once these steps have been completed, your assessment will be activated and you will be able to login and complete the questionnaire.</span></li></ol>
<a href="#top" class='toplink'>[ top ]</a>

<%
        // email details to user


        // clear session
        session.removeAttribute("newUsr");

    }
    else
    {%>
<h3>Step 3 & 4: -error-</h3>
<p>There seems to be a problem with your registration. Please <a href="?pg=720">check your details</a>. If the problem persists, please <a href="?pg=5">contact us</a>.</p>
<%	} //end-if-else %>

<%	}%>