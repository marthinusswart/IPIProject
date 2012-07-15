<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="beans.*" %>

<%

        Customer[] gaCusts = null;			// array of customers in the db
        Customer cTmp = null;
        // details of current logged in user
        SessionManager sMan = new SessionManager(session);

        int usrLvl = sMan.getUserLvl();
        String custId = null;
        if (usrLvl == 2)
        {
            custId = sMan.getCustID(true);
        }

        // (1.) if this was posted back to self (delete operation)..
        // ..error messages
        String msg = "&nbsp;";
        boolean errOccurred = false;

        // When we deleted an org.
        if (request.getParameter("org") != null)
        {
            cTmp = new Customer(request.getParameter("org"), request.getParameter("orgname"), 0);
            try
            {
                cTmp.delete();
                msg = "The Organization '" + cTmp.getName() + "' was deleted successfully.";
            }
            catch (Exception e)
            {
                msg = "The Organization '" + cTmp.getName() + "' was NOT deleted due to the following: " + e.getMessage();
                errOccurred = true;
            }
        }
        else if (request.getParameter("orgId") != null)// When we enabled / disabled an org
        {
            String buttonValue = request.getParameter("confirmation");

            if (buttonValue.equals("Yes"))
            {

                String orgId = request.getParameter("orgId");
                String isDisabledString = request.getParameter("isDisabled");

                boolean isDisabled = (isDisabledString.equals("true")) ? true : false;

                Customer customer = new Customer();
                customer.setPKID(orgId);
                customer.loadFromDB(false);
                customer.setDisabled(isDisabled);

                try
                {
                    customer.update();
                }
                catch (Exception ex)
                {
                    out.println("Failed to update");
                }
            }
        }

        if (usrLvl == 1)
        { // Admin lookup
            // get the customers
            gaCusts = Customer.getCustomers();
        }
        else if (usrLvl == 2)
        { // Org. Admin. Lookup
            Customer customer = new Customer(custId);
            customer.loadFromDB(false);
            gaCusts = new Customer[1];
            gaCusts[0] = customer;
        }

        // how many individuals for each?
        DBProxy db = new DBProxy();
        try
        {
            ResultSet res = db.executeQuery(
                    "SELECT c.pkid, COUNT(*) as cnt "
                    + "FROM Customer c, Users u "
                    + "WHERE c.pkid=u.fkCustID AND u.fkLevel>2"
                    + "GROUP BY c.pkid");

            while (res.next())
            {
                for (int i = 0; i < gaCusts.length; i++)
                {
                    if (gaCusts[i].getPKID().equals(res.getString("pkid")))
                    {	// found: assign
                        gaCusts[i].setNumIndividuals(res.getInt("cnt"));
                        break;
                    }
                }
            }

        }
        catch (Exception e)
        {
            msg = "There was an error reading from the database; the following error was reported: \"" + e.getMessage() + "\"";
            errOccurred = true;
        }
        finally
        {
            db.close();
        }

%>

<h2>Organizations :: List of Organizations</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<style>
    .cols1	{ padding: 0 5px 0 5px;}
    .colName	{ width:299px;}

    .alRight { text-align:right; padding-right:5px; }

    #tbl_orgTable td{font-size:8pt;}


    FORM{DISPLAY: inline;}

</style>
<script type='text/javascript' src='script/client/sc30.0.1.js'></script>

<div align='center'>
    <div align='left'>
        <b>Choose an Organization:</b><br /><br />

        <script type="text/javascript">

            var orgTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colName'>Name</div>",
                "<div class='cols1'>Ref#</div>",
                "<div class='cols1 alRight'>Credits</div>",
                "<div class='cols1 alRight'># Individuals</div>",
                "<div class='cols1 alRight'>Status</div>"
            ],
            [
            <%
                int i;
                boolean addedDisabledHeader = false;
                if (gaCusts != null)
                {
                    String enabledDisabled = "";

                    // Loop everything to count - 1, the comma is an issue
                    for (i = 0; i < gaCusts.length - 1; i++)
                    {

                        if ((gaCusts[i].isDisabled()) && (!addedDisabledHeader))
                        {
                            out.println(
                                    "["
                                    + "'<div></div>',"
                                    + "'<div><b>Disabled organizations</b></div>',"
                                    + "'<div></div>',"
                                    + "'<div></div>',"
                                    + "'<div></div>',"
                                    + "'<div></div>'"
                                    + "],");

                            addedDisabledHeader = true;
                        }

                        enabledDisabled = (gaCusts[i].isDisabled()) ? "Disabled" : "Enabled";
                        out.println(
                                "["
                                + "'" + (i + 1) + ".',"
                                + "'" + gaCusts[i].getName() + "',"
                                + "'" + gaCusts[i].getCode() + "',"
                                + "'<div class=\"alRight\">" + gaCusts[i].getCredits() + "</div>',"
                                + "'<div class=\"alRight\">" + gaCusts[i].getNumIndividuals() + "</div>',"
                                + "'<div class=\"alRight\">" + enabledDisabled + "</div>'"
                                + "],");
                    }

                    // Now add the last one without the comma
                    enabledDisabled = (gaCusts[i].isDisabled()) ? "Disabled" : "Enabled";

                    if ((gaCusts[i].isDisabled()) && (!addedDisabledHeader))
                    {
                        out.println(
                                "["
                                + "'<div></div>',"
                                + "'<div><b>Disabled organizations</b></div>',"
                                + "'<div></div>',"
                                + "'<div></div>',"
                                + "'<div></div>',"
                                + "'<div></div>'"
                                + "],");
                    }

                    out.println(
                            "["
                            + "'" + (gaCusts.length) + ".',"
                            + "'" + gaCusts[gaCusts.length - 1].getName() + "',"
                            + "'" + gaCusts[gaCusts.length - 1].getCode() + "',"
                            + "'<div class=\"alRight\">" + gaCusts[gaCusts.length - 1].getCredits() + "</div>',"
                            + "'<div class=\"alRight\">" + gaCusts[gaCusts.length - 1].getNumIndividuals() + "</div>',"
                            + "'<div class=\"alRight\">" + enabledDisabled + "</div>'"
                            + "]");
                }
                else
                {
                    out.println("['', '', '', '', '', '']");
                }

            %>
            ]
        );

            orgTable.draw();
	
            <%

                // map the Org's to an javascript array [rowid:pkid]
                if (gaCusts != null)
                {
                    addedDisabledHeader = false;

                    out.print("var orgTableMap = [");

                    for (i = 0; i < gaCusts.length - 1; i++)
                    {
                        if ((gaCusts[i].isDisabled()) && (!addedDisabledHeader))
                        {
                            addedDisabledHeader = true;
                            out.print("[" + (i) + "," + gaCusts[i].getPKID() + "],");
                        }

                        out.print("[" + (i) + "," + gaCusts[i].getPKID() + "],");
                    }

                    if ((gaCusts[i].isDisabled()) && (!addedDisabledHeader))
                    {
                        addedDisabledHeader = true;
                        out.print("[" + (i) + "," + gaCusts[i].getPKID() + "],");
                    }

                    out.print("[" + (gaCusts.length - 1) + "," + gaCusts[gaCusts.length - 1].getPKID() + "]");

                    out.print("];");
                }

            %>
		
        </script>

        <br>
        <div class='btnBar' style="width:425px; height:72px;">
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;width:425px;">
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2' value="Delete" onclick="return setOrgs();" />
                    <input type='hidden' name='org' id='Org'/>
                    <input type='hidden' name='orgname'	id='OrgName'/>
                    <input type='hidden' name='pg' value="-30" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2' value="More..." onclick="return setOrgs(5);" />
                    <input type='hidden' name='org' id='Org5'		 />
                    <input type='hidden' name='pg' value="-210" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2' value="New"	/>
                    <input type='hidden' name='pg' value="-310"/>
                </form>
                <div class='rButtons' style="width:240px;float:left;margin-left:3px;">
                    <form action='index.jsp' method='post' style="float:left;margin-top:0px;">
                        <input type='submit' class='btn1' value="Assign Credit" onclick="return setOrgs(2);" />
                        <input type='hidden' name='org'	id='Org2'		/>
                        <input type='hidden' name='orgname' id='OrgName2'/>
                        <input type='hidden' name='credits' id='OrgCred2'/>
                        <input type='hidden' name='pg' value="-33" />
                    </form>
                    <form action='index.jsp' method='post' style="float:left;margin-top:0px;">
                        <input type='submit' class='btn1' value="Manage Adverts" onclick="return setOrgs(4);" />
                        <input type='hidden' name='org'	id='Org4'		/>
                        <input type='hidden' name='orgname' id='OrgName4'/>
                        <input type='hidden' name='pg' value="-340" />
                    </form>
                    <form action='index.jsp' method='post' style="float:left;margin-top:2px;">
                        <input type='submit' class='btn1' value="Downlines ..." onclick="return setOrgs(6);" />
                        <input type='hidden' name='org'	id='Org6'		/>
                        <input type='hidden' name='orgname' id='OrgName6'/>
                        <input type='hidden' name='credits' id='OrgCred6'/>
                        <input type='hidden' name='code' 	id='OrgCode6'/>
                        <input type='hidden' name='pg' value="-350" />
                    </form>
                    <form action='index.jsp' method='post' style="float:left;margin-top:2px;">
                        <input type='submit' class='btn1' value="Enable / Disable" onclick="return setOrgs(7);" />
                        <input type='hidden' name='org'	id='Org7'/>
                        <input type='hidden' name='orgname' id='OrgName7'/>
                        <input type='hidden' name='pg' value="-315" />
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>