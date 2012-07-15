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

            gaUsers = User.getAssmtUsers(custID);
        }
        catch (Exception e)
        {
            Err.printDBErr(e.getMessage(), out, false, true);
        }

%>

<h2>Individuals :: Assignment Stats</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<style>
    .cols1	{ padding: 0 5px 0 5px;}
    .colUser	{ width:150px;}
    .cellUserPw{ font-family:"Courier New", Courier, monospace;}
    .colName	{ width:180px;}
    .colTotal{ width:50px; text-align:center; padding:0;}

    .colTbl	{ border-collapse:collapse; }
    .colStats{ background-color:#273; }
    .colStatHead { text-align:center; color:#eee;padding:0 0 3px 0; border-bottom:1px solid #ccc; }
    .subCol	{ width: 30px; text-align:center; background-color:#3a3; border-left:1px solid #ccc; font-style:italic; }
    .subCol2	{ width: 52px; text-align:center; background-color:#3a3; border-left:1px solid #ccc; font-style:italic; }
    .subColR { border-right:1px solid #ccc; }
    .subVal	{ width:30px; text-align:right; float:left; font-style:italic; color:#3a3; }
    .subVal2	{ width:52px; text-align:right; float:left; font-style:italic; color:#77e; }

    .alRight { text-align:right; padding-right:10px; }

    #tbl_usrTable td{font-size:8pt;}


    FORM{DISPLAY: inline;}

</style>
<script type='text/javascript' src='script/client/sc40.js.jsp'></script>

<div align='center'>
    <div align='left'>
        <b>Choose an Individual:</b><br /><br />

        <script type="text/javascript">

            var usrTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colUser'>UserName</div>",
                "<div class='cols1 colName'>Name</div>",
                "<div class='cols1 '>Org. Code</div>",
                "<div class='cols1 colTotal'>Total<br>Assmts</div>",
                "<div class='colStats'><table class='colTbl' cellpadding='0' cellspacing='0'> <tr> <td colspan='7' class='colStatHead'><b>Type</b></td> </tr>   <tr> <td><div class='subCol'>VA<br>&nbsp;</div></td> <td><div class='subCol'>FA<br>&nbsp;</div></td> <td><div class='subCol'>JP<br>&nbsp;</div></td> <td><div class='subCol'>SI<br>&nbsp;</div></td><td><div class='subCol'>PP<br>&nbsp;</div></td><td><div class='subCol'>HA<br>&nbsp;</div></td><td><div class='subCol subColR'>CP<br>&nbsp;</div></td></tr> </table></div>",
                "<div class='colStats'><table class='colTbl' cellpadding='0' cellspacing='0'> <tr> <td colspan='3' class='colStatHead'><b>Status</b></td> </tr>   <tr> <td><div class='subCol2'>Not<br>Started</div></td> <td><div class='subCol2'>In<br>Progress</div></td> <td><div class='subCol2 subColR' style='padding:0 8px 0 2px'>Completed<br>&nbsp;</div></td> </tr> </table></div>"
            ],
            [
            <%
                int i;
                if (gaUsers != null && gaUsers.length > 0)
                {
                    for (i = 0; i < gaUsers.length; i++)
                    {
                        out.println(
                                "["
                                + "'" + (i + 1) + ".',"
                                + "'<div class=\"cellUserPw\">" + gaUsers[i].getUserName() + "</div>',"
                                + "'" + gaUsers[i].getFullName() + "',"
                                + "'" + gaUsers[i].getCustName() + "',"
                                + "'<div class=\"alRight\">" + gaUsers[i].getWebsite() + "</div>',"
                                + "'<div class=\"subVal\">" + gaUsers[i].getAssmtCount("QT_VA")
                                + "</div><div class=\"subVal\">" + gaUsers[i].getAssmtCount("QT_FA")
                                + "</div><div class=\"subVal\">" + gaUsers[i].getAssmtCount("QT_JP")
                                + "</div><div class=\"subVal\">" + gaUsers[i].getAssmtCount("QT_SI")
                                + "</div><div class=\"subVal\">" + gaUsers[i].getAssmtCount("QT_PP")
                                + "</div><div class=\"subVal\">" + gaUsers[i].getAssmtCount("QT_HA")
                                + "</div><div class=\"subVal\">" + gaUsers[i].getAssmtCount("QT_CP")
                                + "</div>',"
                                + "'<div class=\"subVal2\">" + gaUsers[i].getAssmtCount("AS_NS") + "</div><div class=\"subVal2\">" + gaUsers[i].getAssmtCount("AS_IP") + "</div><div class=\"subVal2\">" + gaUsers[i].getAssmtCount("AS_CP") + "</div>'"
                                + "]" + ((i == gaUsers.length - 1) ? "" : ","));
                    }

                }
                else
                {
                    out.println("['', '', '', '', '', '', '']");
                }

            %>
            ],
            '','','','','','','background-color:#006; color:white;'
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
                    <input type='hidden' name='pg'		value="-401" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2'	value="More..." onclick="return setUser(2);" />
                    <input type='hidden' name='user'		id='Usr2'/>
                    <input type='hidden' name='pg'		value="-43" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2'	value="New"	/>
                    <input type='hidden' name='pg'		value="-41"/>
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