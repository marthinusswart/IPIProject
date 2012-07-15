<%@ page language="java" import="beans.*" %>
<jsp:useBean id="newUsr" class="beans.AutoRegUser" scope="session" />

<%

        String msg = "&nbsp;";
        boolean errOccurred = false;
        session.setAttribute("newuser", null);

        // post-back (error): user exists OR invalid ref #
        if (request.getParameter("err") != null)
        {
            String username = session.getAttribute("username").toString();
            msg = (request.getParameter("err").equals("1"))
                  ? "User '" + username + "' already exists. Please choose another (e.g. " + username + "_123)."
                  : "You've provided an invalid <i>Reference #</i>; consult your company or the advert you're responding to.";

            errOccurred = true;
        }

%>

<h2>New User Registration</h2>
<span class='toplink'>Already registered? [ <a href="?pg=-1">Login</a> ]</span>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>
<script type='text/javascript' src="script/client/GLib.js"></script>
<script type='text/javascript' src="script/client/pwGen.js"></script>
<script type='text/javascript' src="script/client/mc72.0.2.js"></script>

<style>
    .toplink{
        font-size: 8pt;
        font-weight:normal;
    }
    .txt1_{
        width:165px;
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
    .mandatory{
        font-size:12pt;
        font-weight:normal;
        color:red;
    }
</style>

<form action='index.jsp' method='post'>
    <p>
    <div>
        <h3>Step 1: Your Details</h3>
        <div class='infobox'>
            <span class='toplink'>[ <a href="#q">more info on registration</a> ]</span><br>
		Fields marked with <span class='mandatory' style='display:inline'>*</span>&nbsp;are mandatory.<br>
		Groups marked with <span class='mandatory' style='display:inline'>+</span>&nbsp;require AT LEAST ONE entry.<br>
        </div>
        <br><br>
        <table>
            <tr>
                <td>Username:</td>
                <td>
                    <input type='text' class='txt1' id='userName' name='username' value=''>
                    &nbsp;<div class='err' style='display:inline'>*</div>&nbsp;Please choose your own username</td>
            </tr>
            <tr>
                <td>Generated Password:</td>
                <td>
                    <input type='text'	class='txt1' id='Password' name='password' value='' readonly>
                    <script type='text/javascript'>
                        setPW(document.getElementById("Password"));
                    </script>
                    <input type='submit' value="Generate Password" onclick="setPW(Password); return false;" />
                </td>
            </tr>
            <tr>
                <td>First Name:</td>
                <td><input type='text' class='txt1' id='firstName' name='firstname' value='<%=((newUsr.getFirstName() != null) ? newUsr.getFirstName() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><input type='text' class='txt1' id='lastName' name='lastname' value='<%=((newUsr.getLastName() != null) ? newUsr.getLastName() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td>Title:</td>
                <td>
                    <select name='title'>
                        <%=((newUsr.getTitle() != null)
                              ? "<option value=\"" + newUsr.getTitle() + "\">" + newUsr.getTitle()
                              : "")%>
                        <option value=""		>{none}
                        <option value="Mr."	>Mr.
                        <option value="Me."	>Me.
                        <option value="Mrs."	>Mrs.
                        <option value="Miss"	>Miss
                        <option value="Dr."	>Dr.
                        <option value="Prof.">Prof.
                        <option value="Ds."	>Ds.
                    </select>
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td>ID Number:</td>
                <td><input type='text' class='txt1' id='IDNum' name='idnum' value='<%=((newUsr.getIDNum() != null) ? newUsr.getIDNum() : "")%>'></td>
            </tr>
            <tr>
                <td>Advert Reference #:</td>
                <td><input type='text' class='txt1' id='compRef' name='compref' value='<%=((newUsr.getCompanyRef() != null) ? newUsr.getCompanyRef() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td></td>
                <td colspan="4"><span class='toplink'>[ <a href="#q1">1. What is this <i>Advert Reference #</i>?</a> ]</span></td>
            </tr>
            <tr><td colspan="5">&nbsp;</td></tr>

            <tr>
                <td>Tel (W):</td>
                <td><input type='text' class='txt1' id='telW' name='telw' value='<%=((newUsr.getTelW() != null) ? newUsr.getTelW() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td>Tel (H):</td>
                <td><input type='text' class='txt1' id='telH' name='telh' value='<%=((newUsr.getTelH() != null) ? newUsr.getTelH() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td>Tel (Cell):</td>
                <td><input type='text' class='txt1' id='telC' name='telc' value='<%=((newUsr.getTelCell() != null) ? newUsr.getTelCell() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td>Tel (Fax):</td>
                <td><input type='text' class='txt1' id='telF' name='telf' value='<%=((newUsr.getTelFax() != null) ? newUsr.getTelFax() : "")%>'></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type='text' class='txt1' id='Email' name='email' value='<%=((newUsr.getEMail() != null) ? newUsr.getEMail() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td></td>
                <td colspan="4"><span class='toplink'>[ <a href="#q2">2. I have no e-mail address (+ more on email)</a> ]</span></td>
            </tr>
            <tr><td colspan="5">&nbsp;</td></tr>
            <!--
		<tr>
			<td>Website:</td>
			<td><input type='text' class='txt1' id='Web' name='web' value='<%=((newUsr.getWebsite() != null) ? newUsr.getWebsite() : "")%>'></td>
		</tr>
		-->
            <tr>
                <td><img src="images/spacer.gif" width="125" height="1"></td>
                <td></td>
            </tr>
        </table>
        <table>
            <tr>
                <td><b>Address (Home):</b></td>
                <td></td>
                <td></td>
                <td><b>Address (Post):</b></td>
                <td></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>Street:</i> </div></td>
                <td><input type='text' class='txt1_' id='Addr1H' name='addr1h' value='<%=((newUsr.getAddrHome().getStreet() != null) ? newUsr.getAddrHome().getStreet() : "")%>'></td>
                <td></td>
                <td><div style='text-align:right'><i>P.O. Box:</i> </div></td>
                <td><input type='text' class='txt1_' id='Addr1P' name='addr1p' value='<%=((newUsr.getAddrPost().getStreet() != null) ? newUsr.getAddrPost().getStreet() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>Suburb:</i> </div></td>
                <td><input type='text' class='txt1_' id='Addr2H' name='addr2h' value='<%=((newUsr.getAddrHome().getSuburb() != null) ? newUsr.getAddrHome().getSuburb() : "")%>'></td>
                <td></td>
                <td><div style='text-align:right'><i>Suburb:</i> </div></td>
                <td><input type='text' class='txt1_' id='Addr2P' name='addr2p' value='<%=((newUsr.getAddrPost().getSuburb() != null) ? newUsr.getAddrPost().getSuburb() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>City:</i> </div></td>
                <td><input type='text' class='txt1_' id='Addr3H' name='addr3h' value='<%=((newUsr.getAddrHome().getCity() != null) ? newUsr.getAddrHome().getCity() : "")%>'></td>
                <td></td>
                <td><div style='text-align:right'><i>City:</i> </div></td>
                <td><input type='text' class='txt1_' id='Addr3P' name='addr3p' value='<%=((newUsr.getAddrPost().getCity() != null) ? newUsr.getAddrPost().getCity() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>Area Code:</i> </div></td>
                <td><input type='text' class='txt3' id='ArCodeH' name='arcodeh' value='<%=((newUsr.getAddrHome().getAreaCode() != null) ? newUsr.getAddrHome().getAreaCode() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>+</div></td>
                <td></td>
                <td><div style='text-align:right'><i>Area Code:</i> </div></td>
                <td><input type='text' class='txt3' id='ArCodeP' name='arcodep' value='<%=((newUsr.getAddrPost().getAreaCode() != null) ? newUsr.getAddrPost().getAreaCode() : "")%>'>
                    &nbsp;<div class='err' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td></td>
                <td colspan="4"><span class='toplink'>[ <a href="#q3">3. Why do you want my area code?</a> ]</span></td>
            </tr>
            <tr><td colspan="5">&nbsp;</td></tr>

            <tr>
                <td>Highest Qualification:</td>
                <td colspan="4">
                    <select name='hq' class='txt1'>
                        <%=((newUsr.getQualification() != AutoRegUser.HQ_NONE)
                               ? "<option value=\"" + newUsr.getQualification() + "\">" + AutoRegUser.getQualificationString(newUsr.getQualification())
                               : "")%>
                        <option value="0"	>{none}
                        <option value="1"	>High School - Grade 10
                        <option value="2"	>High School - Grade 12 (matric)
                        <option value="3"	>College Diploma
                        <option value="4"	>University Course
                        <option value="5"	>Bachelors Degree
                        <option value="6" >Postgraduate Degree (Honours)
                        <option value="7"	>Postgraduate Degree (Masters)
                        <option value="8"	>Postgraduate Degree (Doctors)
                    </select>
                    &nbsp;<div class='err' style='display:inline'>*</div>
                </td>
            </tr>
            <tr>
                <td><img src="images/spacer.gif" height="1" width="125"></td>
                <td><img src="images/spacer.gif" height="1" width=""></td>
                <td><img src="images/spacer.gif" height="1" width="15"></td>
                <td><img src="images/spacer.gif" height="1" width="125"></td>
                <td><img src="images/spacer.gif" height="1" width=""></td>
            </tr>
        </table>
    </div>


    <hr>
    <br>
    <div style='text-align:right;'>
        <input type='submit' onclick='return btnStep2_Click()' value=" Step 2: Resum&eacute; >> " />
    </div>
    <br>
    <input type='hidden' id='Initial' name='initial'/>
    <input type='hidden' name='pg' value="723" />
</form>

<hr>
<a id="q"></a>
<h3>More Info on Registration</h3>
<h4><u>General info & instructions</u></h4>
<p>
    Step #
<ol>
    <li><b>Complete the registration form, then click the "Step 2: Resum&eacute;"-button to add your employment details. Make sure you've provided a valid e-mail address.</b></li>
    <li><span class="greyout">Complete the resum&eacute; form, then click the "Step 3: Confirm"-button to confirm your details. Make sure you've provided a valid e-mail address.</span></li>
    <li><span class="greyout">Click "Finish" to submit you registration.</span></li>
    <li><span class="greyout">Retrieve the confirmation e-mail that will be sent to the e-mail address you've provided.</span></li>
    <li><span class="greyout">Once these steps have been completed, your assessment will be activated and you will be able to login and complete the questionnaire.</span></li></ol>

<a href="#top" class='toplink'>[ top ]</a>

<br><br>
<h4><u>Frequently Asked Questions (FAQ)</u></h4>
<a id="q1"></a>
<h5>1. What is the <i>Advert Reference#</i>?</h5>
<p>The <i>advert reference number</i> can be one of two codes:
<ol>
    <li>We and our customers send out adverts in newspapers and through other marketing channels to reach you, the candidate. In this case, the <i>Advert Reference#</i> is a code that is specified in the ad.
        <br><b><i>If you are responding to an ad</i></b>, provide the code specified therein.</li>
    <li>Our customers that are companies may instruct you, their employee / candidate, to register yourself as part of a organizational assessment. In this case the <i>Advert Reference#</i> is a code that the company will provide.
        <br><b><i>If you are an employee</i></b>, please provide the reference your employer / organization provided.</li>
</ol>

<p><b>If you are neither responding to an ad, nor registering as an employee, <u>ignore this field</u></b>.</p>
<a href="#top" class='toplink'>[ top ]</a>

<a id="q2"></a>
<h5>2. I have no e-mail address (+more)</h5>
<p>It is important for us to contact you, for example, to inform you of any job-/bursary- matches, or, to sort out any issues with payment. It is also part of the registration process, so - </p>
<p><b>If you do not provide or have a valid e-mail address, you cannot continue!</b></p>
<p>You should already be aware that certain websites provide free online mail accounts. The following is a (non-exhaustive) list of some of them:
<ul>
    <li><a href="http://mail.yahoo.com">Yahoo! mail</a></li>
    <li><a href="http://www.webmail.co.za">WebMail (SA)</a></li>
    <li><a href="http://www.hotmail.com">Hotmail</a></li>
</ul>
<a href="#top" class='toplink'>[ top ]</a>

<a id="q3"></a>
<h5>3. Why do you want my area code?</h5>
<p>After we've found job-/bursary- matches for your profile, we need to organize candidates according to geographical areas. This is also important because once your profile has been selected, you will have to complete a more comprehensive assessment at a designated <b>site in your vicinity</b>, or at our customer's premesis.</p>
<a href="#top" class='toplink'>[ top ]</a>