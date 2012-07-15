<%@ page language="java" import="beans.*" %>

<%-- 
	This page can be reached in several ways:-
		* as super-admin: via main org list, or from org-tree page (any departments below root node)
		* as org-admin: via own account, or org-tree page (" ")

	..the way in which the customer object is constructed must take this into account.
--%>

<%

        String msg = "&nbsp;";
        boolean errOccurred = false;
        String orgId = null;
        String accOrgId = null;
        int usrLvl = 3;
        boolean isAdmin = false;
        boolean allowEdit = false;
        Customer cust = null;		// the customer account to view
        Customer orgAdmin = null;	// the customer (org administrator) who is managing this department (cust) - // load only if applicable.. credit

        try
        {
            SessionManager sMan = new SessionManager(session);

            orgId = request.getParameter("org");	// orgid from request.. may be null
            accOrgId = sMan.getCustID(true);				// orgid from session.. belongs to logged in customer
            usrLvl = sMan.getUserLvl();
            isAdmin = (usrLvl == 1);
            allowEdit = orgId != null && !orgId.equals(accOrgId); // flag to allow org-level edit of some fields (of departments)
        }
        catch (Exception ex)
        {
            errOccurred = true;
            msg = Err.genericMsg(ex);
        }

        if (request.getParameter("usr") == null)
        {		// (1) first visit: load customer details
            try
            {
                // construct cust
                cust = new Customer((isAdmin) ? orgId : ((orgId != null) ? orgId : accOrgId));

                try
                {
                    // load cust
                    cust.loadFromDB(true);
                }
                catch (Exception ex)
                {
                    errOccurred = true;
                    msg = "Failed to load Customer\r\n" + "OrgId: " + orgId + "\r\nAccOrgId: " + accOrgId + "\r\n" + Err.genericMsg(ex);
                }

                // org administrator?
                if (allowEdit)
                {
                    orgAdmin = new Customer(accOrgId);
                    orgAdmin.loadFromDB(false);

                    // .. store in session for postbacks
                    session.setAttribute("orgAdmin", orgAdmin);
                }

                // put cust in session
                session.setAttribute("cust", cust);

            }
            catch (Exception e)
            {
                errOccurred = true;
                msg = Err.genericMsg(e);
            }
        }
        else
        {		// (2) post-back: cust in session; changes in request .. update

            cust = (Customer) session.getAttribute("cust"); // <-- might be null (expired?.. refresh)

            if ((orgAdmin = (Customer) session.getAttribute("orgAdmin")) != null)
            {
                allowEdit = true;
            }

            // set updated values..

            // UPDATE
            try
            {
                // ..customer details
                String orgName = request.getParameter("orgname");

                if (orgName == null)
                {
                    throw new Exception("The organisation name is null");
                }

                cust.setName(orgName);

                String credits = request.getParameter("credits");
                if (credits == null)
                {
                    throw new Exception("The credirs are null");
                }

                cust.setCredits(Integer.parseInt(credits));

                // ..user details
                User uTmp = cust.getUser();
                uTmp.setUserName(request.getParameter("usr"));
                uTmp.setPassword(request.getParameter("pw"));
                uTmp.setFirstName(request.getParameter("fname"));
                uTmp.setInitial(request.getParameter("initial"));
                uTmp.setLastName(request.getParameter("lname"));
                uTmp.setTitle(request.getParameter("title"));

                uTmp.setIDNum(request.getParameter("idnum"));
                uTmp.setCompanyRef(request.getParameter("compref"));
                uTmp.setTelW(request.getParameter("telw"));
                uTmp.setTelH(request.getParameter("telh"));
                uTmp.setTelCell(request.getParameter("telc"));
                uTmp.setTelFax(request.getParameter("telf"));
                uTmp.setEMail(request.getParameter("email"));

                uTmp.setWebsite(request.getParameter("web"));


                // ..address
                if (cust.getAddress() == null)
                {
                    cust.setAddress(new Address());
                }
                cust.getAddress().setStreet(request.getParameter("addr1"));
                cust.getAddress().setSuburb(request.getParameter("addr2"));
                cust.getAddress().setCity(request.getParameter("addr3"));
                cust.getAddress().setAreaCode(request.getParameter("arcode"));



                // complex update? ..
                // .. (dept credit updated by orgAdmin?)
                int newCreds = 0;
                if (allowEdit && !isAdmin
                    && (newCreds = Integer.parseInt(request.getParameter("credsavailable"))) < orgAdmin.getCredits())
                { // YES: ..

                    orgAdmin.setCredits(newCreds);

                    // ..update BOTH dept (cust) & orgAdmin
                    DBProxy db = new DBProxy();
                    try
                    {
                        db.executeNonQuery("BEGIN");
                        cust.update(true, db);
                        orgAdmin.update(db);
                        db.executeNonQuery("COMMIT");
                    }
                    catch (Exception e)
                    {
                        db.executeNonQuery("ROLLBACK");
                        throw e;
                    }
                    finally
                    {
                        db.close();
                    }


                }
                else
                {		// NO: simple update
                    cust.update(true);
                }

                msg = "Update Successful.";

            }
            catch (Exception e)
            {
                errOccurred = true;
                msg = Err.genericMsg(e);
            }
        }

%>

<style>
    .creditCtrl{
        vertical-align:middle;
    }

    #credits{
        width:40px;
        float:left;
    }

    .bigcell{
        border:1px solid black;
        padding: 0 3px 0 3px;
    }

    .bcHeading{
        border:1px solid black;
        padding: 0 0 4px 10px;
        background-color: #DDD;
    }
    .bcHeading H5{ margin: 0 0 0 0; }
    .bcHeading I { font-size:8pt; }

    .tbl { border-collapse:collapse; }

    #CredsAvailable{width:40px; float:left;}
    .credlinks{
        padding-top:2px;
        display:inline;
        float:left;
        font-size:8pt;
        width:45px;
        text-align:center;
    }

</style>

<script type='text/javascript' src="script/client/plusminusCtrl.js"></script>
<script type='text/javascript' src="script/client/pwGen.js"></script>
<script type='text/javascript' src="script/client/sc210.0.2.js"></script>

<h2>Organizations :: Account Profile</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<% if (errOccurred)
        {
            return;
        }%>

<form action="index.jsp" method='post'>
    <table class='tbl'>
        <tr>
            <td class='bcHeading'>
                <h5>Organization Details</h5>
                <i>(Fields marked <div class='err' style='display:inline'>*</div> are mandatory.)</i>
            </td>
            <td class='bcHeading'>
                <h5>Organization Administrator User</h5>
                <i>(Fields marked <div class='success' style='display:inline'>+</div> require <b><u>at least one</u></b> entry.)</i>
                <%=((cust.getUser() == null) ? "<p><b><div class='err' style='display:inline'>No user associated with this organization / downline,<br/>please contact the administrator</div></b></p>" : "")%>
            </td>
        </tr>
        <tr>
            <td class='bigcell'>
                <table>
                    <tr>
                        <td>Organization Name:</td>
                        <td>
                            <input type='text' class='txt1' id='orgName' name='orgname' value='<%=cust.getName()%>' <%=((isAdmin || allowEdit) ? "" : "disabled")%> />
                            <%=((isAdmin || allowEdit) ? "<div class='err' style='display:inline'>*</div> " : "")%>
                        </td>
                    </tr>
                    <tr>
                        <td>Ref# Prefix Code:</td>
                        <td><b><%=cust.getCode()%></b></td>
                    </tr>
                    <tr>

                        <%-- !! role-based access to credit control !! --%>

                        <td>Credits: <%
                                if (isAdmin)
                                {
                                    out.print("(<a href='#' onclick='return resetCreds(0)'>reset</a>)");
                                }
                                else if (allowEdit)
                                {
                                    out.print("(<a href='#' onclick='return resetCreds(1)'>reset</a>)");
                                }%>
                        </td>

                        <td align=middle>
                            <div class='creditCtrl'>
                                <%=((isAdmin) ? "<div class='smBtn' onclick=\"minus(document.getElementById('Credits'))\" style='margin:3px 5px 0 0;'><a href='#'>-</a></div>" : "")%>
                                <input type='text' id='Credits' 			name='credits' 			value='<%=cust.getCredits()%>' disabled />
                                <%=((isAdmin) ? "<div class='smBtn' onclick=\"plus(document.getElementById('Credits'))\" style='margin:3px 0 0 5px;'><a href='#'>+</a></div>" : "")%>
                                <%=((allowEdit && !isAdmin && !errOccurred)
                               ? "<div class='credlinks'><a href='#' onclick='return xferCred();'><< Add</a></div>"
                                 + " <input type='text'	id='CredsAvailable'	name='credsavailable'	value='" + orgAdmin.getCredits() + "' disabled /> (available)\n"
                                 + "<input type='hidden'	id='origAdminCreds'	name='origadmincreds'	value='" + orgAdmin.getCredits() + "' />\n"
                                 + "<input type='hidden'	id='origDeptCreds'	name='origdeptcreds'		value='" + cust.getCredits() + "' />\n"
                               : "")%>
                            </div>
                            <script type='text/javascript'>document.getElementById("Credits").disabled = true;</script>
                            <br>
                            <br>
                            <%=((isAdmin)
                               ? "<div class='creditCtrl' style='padding-left:8px;'>"
                                 + "<div class='smBtn' onclick=\"minus(document.getElementById('Credits'), 100)\" style='margin:3px 5px 0 0;'><a href='#'>-</a></div>"
                                 + "<div style='float:left;'>100</div>"
                                 + "<div class='smBtn' onclick=\"plus(document.getElementById('Credits'), 100)\" style='margin:3px 0 0 5px;'><a href='#'>+</a></div>"
                                 + "</div>" : "")%>
                        </td>

                        <%-- !! end: credit control !! --%>

                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                        <td>Website:</td>
                        <td><input type='text' class='txt1' id='Web' name='web' value='<%
                                if (!errOccurred)
                                {
                                    out.print((cust.getUser() != null && cust.getUser().getWebsite() != null) ? cust.getUser().getWebsite() : "");
                                }
                                   %>' <%=((cust.getUser() == null) ? "READONLY" : "")%>></td>
                    </tr>
                    <tr>
                        <td><b>Address (premesis):</b></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><div style='text-align:right'><i>Street</i></div></td>
                        <td><input type='text' class='txt1' id='Addr1' name='addr1' value='<%
                                if (!errOccurred)
                                {
                                    out.print((cust.getAddress() != null && cust.getAddress().getStreet() != null) ? cust.getAddress().getStreet() : "");
                                }
                                   %>'></td>

                    </tr>
                    <tr>
                        <td><div style='text-align:right'><i>Suburb</i></div></td>
                        <td><input type='text' class='txt1' id='Addr2' name='addr2' value='<%
                                if (!errOccurred)
                                {
                                    out.print((cust.getAddress() != null && cust.getAddress().getSuburb() != null) ? cust.getAddress().getSuburb() : "");
                                }
                                   %>'></td>
                    </tr>
                    <tr>
                        <td><div style='text-align:right'><i>City</i></div></td>
                        <td><input type='text' class='txt1' id='Addr3' name='addr3' value='<%
                                if (!errOccurred)
                                {
                                    out.print((cust.getAddress() != null && cust.getAddress().getCity() != null) ? cust.getAddress().getCity() : "");
                                }
                                   %>'></td>
                    </tr>
                    <tr>
                        <td><div style='text-align:right'><i>Area Code</i></div></td>
                        <td><input type='text' class='txt3' id='ArCode' name='arcode' value='<%
                                if (!errOccurred)
                                {
                                    out.print((cust.getAddress() != null && cust.getAddress().getAreaCode() != null) ? cust.getAddress().getAreaCode() : "");
                                }
                                   %>'></td>
                    </tr>

                    <tr>
                        <td><img src="images/spacer.gif" height="1" width="130"></td>
                        <td></td>
                    </tr>
                </table>
            </td>

            <td class='bigcell'>
                <table>
                    <tr>
                        <td>Username:</td>
                        <td>
                            <input type='text' class='txt1' id='userName' name='usr' value='<%=(cust != null && cust.getUser() != null) ? cust.getUser().getUserName() : ""%>' <%=((isAdmin || allowEdit) ? "" : "disabled")%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
      				Password (<a href="#" onclick="setPW(document.getElementById('Password')); return false;" >change</a>):
                        </td>
                        <td>
                            <input type='text' class='txt1' id='Password' name='pw' value='<%=(cust != null && cust.getUser() != null) ? cust.getUser().getPassword() : ""%>' disabled />
                        </td>
                    </tr>
                    <tr>
                        <td>First Name:</td>
                        <td>
                            <input type='text' class='txt1' id='firstName' name='fname' value='<%=(cust != null && cust.getUser() != null) ? cust.getUser().getFirstName() : ""%>' />
                            <div class='err' style='display:inline'>*</div>
                        </td>
                    </tr>
                    <tr>
                        <td>Initial:</td>
                        <td><input type='text' class='txt3' id='Initial' name='initial' value='<%=((cust != null && cust.getUser() != null && cust.getUser() != null && cust.getUser().getInitial() != null) ? cust.getUser().getInitial() : "")%>'></td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td>
                            <input type='text' class='txt1' id='lastName' name='lname' value='<%=(cust != null && cust.getUser() != null) ? cust.getUser().getLastName() : ""%>' />
                            <div class='err' style='display:inline'>*</div>
                        </td>
                    </tr>
                    <tr>
                        <td>Title:</td>
                        <td>
                            <select name='title'>
                                <%=((cust != null && cust.getUser() != null && cust.getUser().getTitle() != null && !cust.getUser().getTitle().equals(""))
                               ? "<option value='" + cust.getUser().getTitle() + "'>" + cust.getUser().getTitle()
                               : "<option value=''>{none}")%>
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
                        <td><input type='text' class='txt1' id='IDNum' name='idnum' value='<%=((cust != null && cust.getUser() != null && cust.getUser().getIDNum() != null) ? cust.getUser().getIDNum() : "")%>'></td>
                    </tr>
                    <tr>
                        <td>Company Reference #:</td>
                        <td><input type='text' class='txt1' id='compRef' name='compref' value='<%=((cust != null && cust.getUser() != null && cust.getUser().getCompanyRef() != null) ? cust.getUser().getCompanyRef() : "")%>'></td>
                    </tr>

                    <tr>
                        <td>Tel (W):</td>
                        <td><input type='text' class='txt1' id='telW' name='telw' value='<%=((cust != null && cust.getUser() != null && cust.getUser().getTelW() != null) ? cust.getUser().getTelW() : "")%>'>
                            <div class='success' style='display:inline'>+</div>
                        </td>
                    </tr>
                    <tr>
                        <td>Tel (H):</td>
                        <td><input type='text' class='txt1' id='telH' name='telh' value='<%=((cust != null && cust.getUser() != null && cust.getUser().getTelH() != null) ? cust.getUser().getTelH() : "")%>'>
                            <div class='success' style='display:inline'>+</div>
                        </td>
                    </tr>
                    <tr>
                        <td>Tel (Cell):</td>
                        <td><input type='text' class='txt1' id='telC' name='telc' value='<%=((cust != null && cust.getUser() != null && cust.getUser().getTelCell() != null) ? cust.getUser().getTelCell() : "")%>'>
                            <div class='success' style='display:inline'>+</div>
                        </td>
                    </tr>
                    <tr>
                        <td>Tel (Fax):</td>
                        <td><input type='text' class='txt1' id='telF' name='telf' value='<%=((cust != null && cust.getUser() != null && cust.getUser().getTelFax() != null) ? cust.getUser().getTelFax() : "")%>'></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td><input type='text' class='txt1' id='Email' name='email' value='<%=((cust != null && cust.getUser() != null && cust.getUser().getEMail() != null) ? cust.getUser().getEMail() : "")%>'>
                            <div class='err' style='display:inline'>*</div>
                        </td>
                    </tr>

                    <tr>
                        <td><img src="images/spacer.gif" height="1" width="130"></td>
                        <td></td>
                    </tr>
                </table>
            </td>
        <tr>
        <tr>
            <td colspan="2" class=''>
                <br>
                <div class='rButtons'>
                    <input type='reset'	class='btn2' style="margin:0 10px 5px 0;" value="Reset" />
                    <input type='submit' class='btn2' style="margin:0 10px 5px 0;" value="Update" onclick="return update_Click();" />
                </div>
            </td>
        </tr>
        <tr>
            <td><img src="images/spacer.gif" height="1" width="360"></td>
            <td><img src="images/spacer.gif" height="1" width="360"></td>
        </tr>
    </table>
    <input type='hidden' name='pg' value="-210"/>
</form>
