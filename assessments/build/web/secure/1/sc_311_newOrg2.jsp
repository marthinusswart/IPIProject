<%@ page language="java" import="beans.*" %>
<%@ page language="java" import="beans.*" %>

<jsp:useBean id="cust" class="beans.Customer" scope="session" />

<%

        SessionManager sMan = new SessionManager(session);
        int usrLevel = sMan.getUserLvl();

        String msg = "&nbsp;";
        boolean errOccurred = false;

        Customer cDeptParent = null;
        if ((cDeptParent = (Customer) session.getAttribute("cDeptParent")) == null)
        { /*donothing*/ }

        String PageTitle = null;
        String Label1 = null;

        if (request.getParameter("username") == null)
        {	// posted from Step 1.
            // get the posted customer info (step1)
            cust.setName(request.getParameter("orgname"));
            cust.setCode(request.getParameter("code"));
            cust.setCredits(Integer.parseInt(request.getParameter("credits")));
            cust.setAddress(new Address(
                    request.getParameter("addr1"),
                    request.getParameter("addr2"),
                    request.getParameter("addr3"),
                    request.getParameter("arcode"),
                    null,
                    "4"));
            if (cust.getUser() == null)
            {
                cust.setUser(new User(request.getParameter("web")));
            }
            else
            {
                cust.getUser().setWebsite(request.getParameter("web"));
            }

            // if the posted customer exists(), post back to Step 1.
            try
            {
                // exist error on name and code
                if (cust.exists())
                {
                    String orgParam = (cDeptParent != null) ? "&org=" + cDeptParent.getPKID() : "";
                    String fwdURI = "/index.jsp?pg=-310&orgname=" + cust.getName() + "&code=" + cust.getCode() + orgParam;

%>	<jsp:forward page="<%=fwdURI%>" /> <%
                        }
                    }
                    catch (Exception e)
                    {
                        Err.printDBErr(e.getMessage(), out, false, true);
                    }

                }
                else
                {													// posted back from Step 3.
                    // error: the user exists
                    msg = "The user '" + request.getParameter("username") + "' already exists.";
                    errOccurred = true;
                }

// add deaprtment OR add new Org?
                switch (usrLevel)
                {
                    case 1:		// Sup-admin: add org..
                        PageTitle = (cDeptParent == null) ? "Organizations :: Create New Organization" : "Organizations :: Add Downline";
                        Label1 = (cDeptParent == null) ? "organization" : "downline";
                        break;
                    case 2:		// Add dept..
                        PageTitle = "My Organization :: Add Downline";
                        Label1 = "downline";
                        break;
                    default:
                        msg = "Error: incorrect user-level";
                        errOccurred = true;
                }


%>

<h2><%=PageTitle%> (cont.)</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>
<script type='text/javascript' src="script/client/pwGen.js"></script>
<script type='text/javascript' src="script/client/sc31.0.1.js"></script>

<form action='index.jsp' method='post'>
    <p>
    <div>
        <b>Step 2: User Details</b><br>
        <i>(The person that manages the <%=Label1%>) - Fields marked <div class='err' style='display:inline'>*</div> are mandatory.</i>
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
                           <td><input type='text' class='txt1' id='firstName' name='firstname' value='<%=((cust.getUser().getFirstName() != null) ? cust.getUser().getFirstName() : "")%>'></td>
            </tr>
            <tr>
                <td>Initial:</td>
                           <td><input type='text' class='txt1' id='Initial' name='initial' value='<%=((cust.getUser().getInitial() != null) ? cust.getUser().getInitial() : "")%>'></td>
            </tr>
            <tr>
                <td><div class='err' style='display:inline'>*</div>&nbsp;&nbsp;Last Name:</td>
                           <td><input type='text' class='txt1' id='lastName' name='lastname' value='<%=((cust.getUser().getLastName() != null) ? cust.getUser().getLastName() : "")%>'></td>
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
                           <td><input type='text' class='txt1' id='IDNum' name='idnum' value='<%=((cust.getUser().getIDNum() != null) ? cust.getUser().getIDNum() : "")%>'></td>
            </tr>
            <tr>
                <td>Company Reference #:</td>
                           <td><input type='text' class='txt1' id='compRef' name='compref' value='<%=((cust.getUser().getCompanyRef() != null) ? cust.getUser().getCompanyRef() : "")%>'></td>
            </tr>

            <tr>
                <td>Tel (W):</td>
                           <td><input type='text' class='txt1' id='telW' name='telw' value='<%=((cust.getUser().getTelW() != null) ? cust.getUser().getTelW() : "")%>'></td>
            </tr>
            <tr>
                <td>Tel (H):</td>
                           <td><input type='text' class='txt1' id='telH' name='telh' value='<%=((cust.getUser().getTelH() != null) ? cust.getUser().getTelH() : "")%>'></td>
            </tr>
            <tr>
                <td>Tel (Cell):</td>
                           <td><input type='text' class='txt1' id='telC' name='telc' value='<%=((cust.getUser().getTelCell() != null) ? cust.getUser().getTelCell() : "")%>'></td>
            </tr>
            <tr>
                <td>Tel (Fax):</td>
                           <td><input type='text' class='txt1' id='telF' name='telf' value='<%=((cust.getUser().getTelFax() != null) ? cust.getUser().getTelFax() : "")%>'></td>
            </tr>
            <tr>
                <td>Email:</td>
                           <td><input type='text' class='txt1' id='Email' name='email' value='<%=((cust.getUser().getEMail() != null) ? cust.getUser().getEMail() : "")%>'></td>
            </tr>
        </table>
    </div>

    <hr>
    <br>
    <div style='text-align:right;'>
        <input type='submit' onclick='return btnStep3_Click()' value=" Step 3 >> " />
    </div>

    <input type='hidden' name='pg' value="-312" />
</form>


