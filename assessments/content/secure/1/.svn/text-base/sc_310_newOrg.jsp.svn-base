<%@ page language="java" import="beans.*" %>

<%

        SessionManager sMan = new SessionManager(session);
        int usrLevel = sMan.getUserLvl();

        String msg = "&nbsp;";
        boolean errOccurred = false;
        String PageTitle = null;
        String Label1 = null;
        String Label2 = null;

// dept vars (if applicable)
        Customer cust = null;
        if ((cust = (Customer) session.getAttribute("cust")) == null)
        {
            cust = new Customer();
        }

        Customer cDeptParent = null;


// postback: error?
        if (request.getParameter("orgname") != null)
        {	// this was a post-back (error)
            msg = "The Organization '" + request.getParameter("orgname") + "' already exists -OR- the code '" + request.getParameter("code") + "' is already used by another organization.";
            errOccurred = true;
        }
        else
        {
            // reset any invalid session vars
            cust = new Customer();
        }

// add downline
        boolean isAddingDownline = request.getParameter("addept") != null;
        boolean isOrgAdmin = (usrLevel == 2);

        if (isAddingDownline || isOrgAdmin)
        {
            if (isAddingDownline)
            {
                // YES: setup hierarchical data
                cDeptParent = new Customer(request.getParameter("org"));
            }
            else
            {	// Get the current logged in admin's cust id
                cDeptParent = new Customer(sMan.getCustID(true));
            }

            cDeptParent.loadFromDB(false);

            Label2 = "<i>(Downline of '<b>" + cDeptParent.getName() + "</b>')</i>";

            // set dept vars
            cust.setFKParentCust(Integer.parseInt(cDeptParent.getPKID()));
            cust.setFKRootCust((cDeptParent.getFKRootCust() > -999) ? cDeptParent.getFKRootCust() : cust.getFKParentCust());

            // save for next steps
            session.setAttribute("cDeptParent", cDeptParent);

        }// NO: simple add org (sup-admin only)

// labels
        switch (usrLevel)
        {
            case 1:		// Sup-admin: ..
                PageTitle = (cDeptParent == null) ? "Organizations :: Create New Organization" : "Organizations :: Add Downline";
                Label1 = (cDeptParent == null) ? "Organization" : "Downline";
                break;
            case 2:		// Org-admin..
                PageTitle = "My Organization :: Add Downline";
                Label1 = "Downline";
                break;
            default:
                msg = "Error: incorrect user-level";
                errOccurred = true;
        }


// put 'cust' in session
        session.setAttribute("cust", cust);

%>

<h2><%=PageTitle%></h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>
<script type='text/javascript' src="script/client/sc31.0.1.js"></script>
<script type='text/javascript' src="script/client/pwGen.js"></script>
<script type='text/javascript' src="script/client/plusminusCtrl.js"></script>

<style>
    .creditCtrl{
        vertical-align:middle;
    }

    #credits{
        width:40px;
        float:left;
    }
</style>
<%=((Label2 != null) ? Label2 : "")%>
<form action='index.jsp' method='post'>
    <p>
    <div>
        <b>Step 1: <%=Label1%> Details</b><br>
        <i>(Fields marked <div class='err' style='display:inline'>*</div> are mandatory.)</i>
        <br><br>
        <table>
            <tr>
                <td><div class='err' style='display:inline'>*</div> <%=Label1%> Name:</td>
                <td><input type='text' class='txt1' id='orgName' name='orgname' value='<%=((cust.getName() != null) ? cust.getName() : "")%>'></td>
            </tr>
            <tr>
                <td><div class='err' style='display:inline'>*</div> Ref# Prefix Code:</td>
                <td><input type='text' class='txt3' id='Code' name='code' style="text-transform:uppercase;"
                           value='<%=((cust.getCode() != null) ? cust.getCode() : "")%>'>
                    <script type='text/javascript'>
                        if(document.getElementById("Code").value == '') setStr(document.getElementById("Code"), 3);
                    </script>
                </td>
            </tr>
            <% if (usrLevel == 1)
        {%>
            <tr>
                <td>Credits: (<a href="#" onclick="credits.value=0;">reset</a>)</td>
                <td align=middle>
                    <div class='creditCtrl'>
                        <div class='smBtn' onclick="minus(Credits)" style="margin:3px 5px 0 0;"><a href="#">-</a></div>
                        <input type='text' id='Credits' name='credits' value='<%=cust.getCredits()%>' disabled />
                        <div class='smBtn' onclick="plus(Credits)" style="margin:3px 0 0 5px;"><a href="#">+</a></div>
                    </div>
                    <script type='text/javascript'>document.getElementById("Credits").disabled = true;</script>
                    <br>
                    <Br>
                    <div class='creditCtrl' style="padding-left:8px;">
                        <div class='smBtn' onclick="minus(Credits, 100)" style="margin:3px 5px 0 0;"><a href="#">-</a></div>
                        <div style="float:left;">100</div>
                        <div class='smBtn' onclick="plus(Credits, 100)" style="margin:3px 0 0 5px;"><a href="#">+</a></div>
                    </div>
                </td>
            </tr>
            <% }
 else
 {%>
            <tr><td colspan="2"><input type="hidden" id='Credits' name='credits' value="0" /></td></tr>
                    <% }%>
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr>
                <td>Website:</td>
                           <td><input type='text' class='txt1' id='Web' name='web' value='<%=((cust.getUser() != null && cust.getUser().getWebsite() != null) ? cust.getUser().getWebsite() : "")%>'></td>
            </tr>
            <tr>
                <td><b>Address (premesis):</b></td>
                <td></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>Street</i></div></td>
                           <td><input type='text' class='txt1' id='Addr1' name='addr1' value='<%=((cust.getAddress() != null && cust.getAddress().getStreet() != null) ? cust.getAddress().getStreet() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>Suburb</i></div></td>
                           <td><input type='text' class='txt1' id='Addr2' name='addr2' value='<%=((cust.getAddress() != null && cust.getAddress().getSuburb() != null) ? cust.getAddress().getSuburb() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>City</i></div></td>
                           <td><input type='text' class='txt1' id='Addr3' name='addr3' value='<%=((cust.getAddress() != null && cust.getAddress().getCity() != null) ? cust.getAddress().getCity() : "")%>'></td>
            </tr>
            <tr>
                <td><div style='text-align:right'><i>Area Code</i></div></td>
                           <td><input type='text' class='txt3' id='ArCode' name='arcode' value='<%=((cust.getAddress() != null && cust.getAddress().getAreaCode() != null) ? cust.getAddress().getAreaCode() : "")%>'></td>
            </tr>
        </table>
    </div>

<hr>
<br>
<div style='text-align:right;'>
    <input type='submit' onclick='return btnStep2_Click()' value=" Step 2 >> " />
</div>

<input type='hidden' name='pg' value="-311" />
</form>
