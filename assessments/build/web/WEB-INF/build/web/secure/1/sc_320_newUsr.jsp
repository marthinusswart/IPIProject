<%@ page language="java" import="beans.*" %>
<jsp:useBean id="cust"		class="beans.Customer"	scope="session" />
<jsp:useBean id="newUsr"	class="beans.User"		scope="session" />
<jsp:useBean id="newAddrH"	class="beans.Address"	scope="session" />
<jsp:useBean id="newAddrP"	class="beans.Address"	scope="session" />

<%

        String msg = "&nbsp;";
        boolean errOccurred = false;

        // post-back (error): user exists
        if (request.getParameter("username") != null)
        {
            msg = "User '" + newUsr.getUserName() + "' already exists.";
            errOccurred = true;
        }
        // first visit
        else
        {

            // new customer and user..
            if (request.getParameter("org") != null)
            {				// from request
                cust.setPKID(request.getParameter("org"));
                //cust.setName(request.getParameter("orgname"));
            }
            else
            {															// from session
                SessionManager sMan = new SessionManager(session);
                cust.setPKID(sMan.getCustID(true));
            }

            // address-types
            newAddrH.setFkAddrType("1");
            newAddrP.setFkAddrType("3");
        }


%>

<h2>Individuals :: New Individual</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>
<script type='text/javascript' src="script/client/pwGen.js"></script>
<script type='text/javascript' src="script/client/sc31.0.1.js"></script>

<form action='index.jsp' method='post'>
    <p>
    <div>
        <b>Step 1: User Details</b><br>
        <i>Fields marked <div class='err' style='display:inline'>*</div> are mandatory.</i>
        <br><br>
        <table>
            <tr>
                <td><div class='err' style='display:inline'>*</div>&nbsp;&nbsp;Username:</td>
                <td><input type='text' class='txt1' id='userName' name='username' value=''></td>
            </tr>
            <tr>
                <td><div class='err' style='display:inline'>*</div>&nbsp;&nbsp;Generated Password:</td>
                <td>
                    <input type='text'	class='txt1' id='Password' name='password' value='' disabled>
                    <script type='text/javascript'>
                        setPW(document.getElementById("Password"));
                        document.getElementById("Password").disabled = true;
                    </script>
                    <input type='submit' value="Generate Password" onclick="setPW(Password); return false;" />
                </td>
            </tr>
            <tr>
                <td><div class='err' style='display:inline'>*</div>&nbsp;&nbsp;First Name:</td>
                           <td><input type='text' class='txt1' id='firstName' name='firstname' value='<%=((newUsr.getFirstName() != null) ? newUsr.getFirstName() : "")%>'></td>
            </tr>
            <tr>
                <td>Initial:</td>
                           <td><input type='text' class='txt1' id='Initial' name='initial' value='<%=((newUsr.getInitial() != null) ? newUsr.getInitial() : "")%>'></td>
            </tr>
            <tr>
                <td><div class='err' style='display:inline'>*</div>&nbsp;&nbsp;Last Name:</td>
                           <td><input type='text' class='txt1' id='lastName' name='lastname' value='<%=((newUsr.getLastName() != null) ? newUsr.getLastName() : "")%>'></td>
            </tr>
            <tr>
                <td>Title:</td>
                <td>
                    <select name='title'>
                        <option value=""		>{none}
                        <option value="Mr."	>Mr.
                        <option value="Me."	>Me.
                        <option value="Mrs."	>Mrs.
                        <option value="Miss"	>Miss
                        <option value="Dr."	>Dr.
                        <option value="Prof.">Prof.
                        <option value="Ds."	>Ds.
                    </select>
                </td>
            </tr>
            <tr>
                <td>ID Number:</td>
                           <td><input type='text' class='txt1' id='IDNum' name='idnum' value='<%=((newUsr.getIDNum() != null) ? newUsr.getIDNum() : "")%>'></td>
            </tr>
            <tr>
                <td>Company Reference #:</td>
                           <td><input type='text' class='txt1' id='compRef' name='compref' value='<%=((newUsr.getCompanyRef() != null) ? newUsr.getCompanyRef() : "")%>'></td>
            </tr>

            <tr>
                <td>Tel (W):</td>
                           <td><input type='text' class='txt1' id='telW' name='telw' value='<%=((newUsr.getTelW() != null) ? newUsr.getTelW() : "")%>'></td>
            </tr>
            <tr>
                <td>Tel (H):</td>
                           <td><input type='text' class='txt1' id='telH' name='telh' value='<%=((newUsr.getTelH() != null) ? newUsr.getTelH() : "")%>'></td>
            </tr>
            <tr>
                <td>Tel (Cell):</td>
                           <td><input type='text' class='txt1' id='telC' name='telc' value='<%=((newUsr.getTelCell() != null) ? newUsr.getTelCell() : "")%>'></td>
            </tr>
            <tr>
                <td>Tel (Fax):</td>
                           <td><input type='text' class='txt1' id='telF' name='telf' value='<%=((newUsr.getTelFax() != null) ? newUsr.getTelFax() : "")%>'></td>
            </tr>
            <tr>
                <td>Email:</td>
                           <td><input type='text' class='txt1' id='Email' name='email' value='<%=((newUsr.getEMail() != null) ? newUsr.getEMail() : "")%>'></td>
            </tr>
            <!--
		<tr>
			<td>Website:</td>
			<td><input type='text' class='txt1' id='Web' name='web' value='<%=((newUsr.getWebsite() != null) ? newUsr.getWebsite() : "")%>'></td>
		</tr>
		-->
            <tr>
                <td><img src="images/spacer.gif" width="135" height="1"></td>
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
                           <td><input type='text' class='txt1' id='Addr1H' name='addr1h' value='<%=((newAddrH.getStreet() != null) ? newAddrH.getStreet() : "")%>'></td>
                <td></td>
                <td><div style='text-align:right'><i>P.O. Box:</i> </div></td>
                           <td><input type='text' class='txt1' id='Addr1P' name='addr1p' value='<%=((newAddrP.getStreet() != null) ? newAddrP.getStreet() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>Suburb:</i> </div></td>
                           <td><input type='text' class='txt1' id='Addr2H' name='addr2h' value='<%=((newAddrH.getSuburb() != null) ? newAddrH.getSuburb() : "")%>'></td>
                <td></td>
                <td><div style='text-align:right'><i>Suburb:</i> </div></td>
                           <td><input type='text' class='txt1' id='Addr2P' name='addr2p' value='<%=((newAddrP.getSuburb() != null) ? newAddrP.getSuburb() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>City:</i> </div></td>
                           <td><input type='text' class='txt1' id='Addr3H' name='addr3h' value='<%=((newAddrH.getCity() != null) ? newAddrH.getCity() : "")%>'></td>
                <td></td>
                <td><div style='text-align:right'><i>City:</i> </div></td>
                           <td><input type='text' class='txt1' id='Addr3P' name='addr3p' value='<%=((newAddrP.getCity() != null) ? newAddrP.getCity() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>Area Code:</i> </div></td>
                           <td><input type='text' class='txt3' id='ArCodeH' name='arcodeh' value='<%=((newAddrH.getAreaCode() != null) ? newAddrH.getAreaCode() : "")%>'></td>
                <td></td>
                <td><div style='text-align:right'><i>Area Code:</i> </div></td>
                           <td><input type='text' class='txt3' id='ArCodeP' name='arcodep' value='<%=((newAddrP.getAreaCode() != null) ? newAddrP.getAreaCode() : "")%>'></td>
            </tr>
            <tr>
                <td><img src="images/spacer.gif" height="1" width="135"></td>
                <td><img src="images/spacer.gif" height="1" width="200"></td>
                <td><img src="images/spacer.gif" height="1" width="30"></td>
                <td><img src="images/spacer.gif" height="1" width="135"></td>
                <td><img src="images/spacer.gif" height="1" width="200"></td>
            </tr>
        </table>
    </div>
<hr>
<br>
<div style='text-align:right;'>
    <input type='submit' onclick='return btnStep2_3_Click()' value=" Step 2 >> " />
</div>

<input type='hidden' name='pg' value="-321" />
</form>