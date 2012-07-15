<%@ page language="java" import="beans.*" %>

<%

        User[] gaUsers = null;			// array of users in the db
        User uTmp = null;

        // (1.) if this was posted back to self (delete operation)..
        // ..error messages
        String msg = "&nbsp;";
        boolean errOccurred = false;

        if (request.getParameter("user") != null)
        {
            uTmp = new User(request.getParameter("user"), null);
            try
            {
                uTmp.delete();
                msg = "The User '" + uTmp.getUserName() + "' was deleted successfully.";
            }
            catch (Exception e)
            {
                msg = "The User '" + uTmp.getUserName() + "' was NOT deleted. The following error was reported: " + e.getMessage();
                errOccurred = true;
            }
        }

        if (request.getParameter("action") != null)
        { // Search for a user
            if (request.getParameter("action").equals("search"))
            {
                // details of current logged in user
                SessionManager sMan = new SessionManager(session);

                int usrLvl = sMan.getUserLvl();
                String custID = null;
                if (usrLvl == 2)
                {
                    custID = sMan.getCustID(true);
                }

                String username = request.getParameter("username");
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");

                gaUsers = User.searchForUser(username, firstname, lastname, custID);
            }
            else if (request.getParameter("action").equals("searchskills"))
            {
                // details of current logged in user
                SessionManager sMan = new SessionManager(session);

                int usrLvl = sMan.getUserLvl();
                String custID = null;
                if (usrLvl == 2)
                {
                    custID = sMan.getCustID(true);
                }

                String skillsq = request.getParameter("skillsq");
                String skillss = request.getParameter("skillss");
                String qualification = request.getParameter("qualifications");

                gaUsers = User.searchForSkills(skillsq, skillss, qualification, custID);
            }
        }
        else
        {
            // get the users
            try
            {
                // details of current logged in user
                SessionManager sMan = new SessionManager(session);

                int usrLvl = sMan.getUserLvl();
                String custID = null;
                if (usrLvl == 2)
                {
                    custID = sMan.getCustID(true);
                }
                gaUsers = User.getUsers(custID);
            }
            catch (Exception e)
            {
                Err.printDBErr(e.getMessage(), out, false, true);
            }
        }

%>

<h2>Individuals :: List of Individuals</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<style>
    .cols1	{ padding: 0 5px 0 5px;}
    .colUser	{ width:150px;}
    .colPw	{ width:100px;}
    .cellUserPw{ font-family:"Courier New", Courier, monospace;}
    .colName	{ width:200px;}

    .alRight { text-align:right; padding-right:5px; }

    #tbl_usrTable td{font-size:8pt;}


    FORM{DISPLAY: inline;}

</style>
<script type='text/javascript' src='script/client/sc40.js'></script>

<div align='center'>
    <div align='left'>
        <b>Choose an Individual:</b><br /><br />

        <script type="text/javascript">

            var usrTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colUser'>UserName</div>",
                "<div class='cols1 colPw'>Password</div>",
                "<div class='cols1 colName'>Name</div>",
                "<div class='cols1 colName'>Organization</div>"
            ],
            [
            <%
                    int i;
                    if (gaUsers != null && gaUsers.length > 0)
                    {
                        for (i = 0; i < gaUsers.length - 1; i++)
                        {
                            out.println(
                                    "["
                                    + "'" + (i + 1) + ".',"
                                    + "'<div class=\"cellUserPw\">" + gaUsers[i].getUserName() + "</div>',"
                                    + "'<div class=\"cellUserPw\">" + gaUsers[i].getPassword() + "</div>',"
                                    + "'"
                                    + ((gaUsers[i].getTitle() != null && !gaUsers[i].getTitle().equals(""))
                                       ? gaUsers[i].getTitle() + " "
                                       : "")
                                    + gaUsers[i].getFirstName() + " "
                                    + ((gaUsers[i].getInitial() != null && !gaUsers[i].getInitial().equals(""))
                                       ? gaUsers[i].getInitial() + " "
                                       : "")
                                    + gaUsers[i].getLastName() + "',"
                                    + "'" + gaUsers[i].getCustName() + "'"
                                    + //   			"'<div class=\"alRight\">-</div>'" +
                                    "],");
                        }
                        out.println(
                                "["
                                + "'" + (gaUsers.length) + ".',"
                                + "'<div class=\"cellUserPw\">" + gaUsers[gaUsers.length - 1].getUserName() + "</div>',"
                                + "'<div class=\"cellUserPw\">" + gaUsers[gaUsers.length - 1].getPassword() + "</div>',"
                                + "'"
                                + ((gaUsers[gaUsers.length - 1].getTitle() != null && !gaUsers[gaUsers.length - 1].getTitle().equals(""))
                                   ? gaUsers[gaUsers.length - 1].getTitle() + " "
                                   : "")
                                + gaUsers[gaUsers.length - 1].getFirstName() + " "
                                + ((gaUsers[gaUsers.length - 1].getInitial() != null && !gaUsers[gaUsers.length - 1].getInitial().equals(""))
                                   ? gaUsers[gaUsers.length - 1].getInitial() + " "
                                   : "")
                                + gaUsers[gaUsers.length - 1].getLastName() + "',"
                                + "'" + gaUsers[gaUsers.length - 1].getCustName() + "'"
                                + //   			"'<div class=\"alRight\">-</div>'" +
                                "]");
                    }
                    else
                    {
                        out.println("['', '', '', '', '']");
                    }

            %>
                ]
            );

                usrTable.draw();
	
        </script>

        <br>
        <div class='btnBar' style="width:440px">
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;">
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit'	class='btn2' 	value="Delete" onclick="return setUser();" />
                    <input type='hidden' name='user'		id='Usr'/>
                    <input type='hidden' name='pg'		value="-40" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2' value="More..." onclick="return setUser(2);" />
                    <input type='hidden' name='user' id='Usr2'/>
                    <input type='hidden' name='pg' value="-43" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2' value="Print" onclick="return setUser(3);" />
                    <input type='hidden' name='user' id='Usr3'/>
                    <input type='hidden' name='pg' value="-44" />
                </form>
            </div>
            <div class='rButtons'  style="width:250px">
                <form action='index.jsp' method='post' style="float:right">
                    <input type='submit' class='btn1' value="Assign Questionaire" disabled />
                    <input type='hidden' name='user'		id='Usr2'/>
                    <input type='hidden' name='pg' value="-521" />
                </form>
            </div>
        </div>
    </div>
</div>