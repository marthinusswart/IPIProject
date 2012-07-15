<%@ page language="java" import="beans.*" %>

<style>
    .cols1	{ padding: 0 5px 0 5px;}
    .cols2	{ padding: 0 5px 0 0;}
    .colName	{ width:150px;}
    .colDescr	{ width:300px;}
    .colSection	{ width:50px;}

    .alRight { text-align:right; padding-right:5px; }

    #tbl_scTable td{font-size:8pt;}

</style>
<script type='text/javascript' src='script/client/sc60.js'></script>

<%

        SessionManager sMan = new SessionManager(session);
        int userLevel = sMan.getUserLvl();
        boolean errOccurred = false;
        String msg = "&nbsp;";
        SuperConstruct[] superConstructs = null;

        if (userLevel != 1)
        {
            errOccurred = true;
            msg = "Need to be Head Office Administrator";
        }
        else
        {
            if ((request.getParameter("action") != null)
                && (request.getParameter("action").equals("update_super_construct")))
            { // First to the update before reloading
                SuperConstruct superConstruct = new SuperConstruct(request.getParameter("scid"));
                try
                {
                    superConstruct.loadFromDB();
                    superConstruct.setName(request.getParameter("scname"));
                    superConstruct.setCode(request.getParameter("scsection"));
                    superConstruct.setDescription(request.getParameter("scdescription"));
                    superConstruct.saveToDB();
                }
                catch (Exception ex)
                {
                    msg = "Failed to update Super Construct. " + ex.getMessage();
                    errOccurred = true;
                }
            }

            if (!errOccurred)
            {
                try
                {
                    superConstructs = SuperConstruct.getSuperConstructs();
                }
                catch (Exception ex)
                {
                    errOccurred = true;
                    msg = ex.getMessage();
                }
            }
        }

%>

<h2>Assessments :: List of Super Constructs</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<%if (!errOccurred)
        {%>

<div align='center'>
    <div align='left'>
        The following Super Constructs are available:<br /><br />


        <script type="text/javascript">

            var scTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colName'>Name</div>",
                "<div class='cols1 colSection'>Section</div>",
                "<div class='cols2 colDescr'>Description</div>"],
            [
            <%
            int i;
            if (superConstructs != null && superConstructs.length > 0)
            {
                for (i = 0; i < superConstructs.length - 1; i++)
                {
                    out.println(
                            "["
                            + "'" + (i + 1) + ".',"
                            + "'" + superConstructs[i].getName() + "',"
                            + "'" + superConstructs[i].getCode() + "',"
                            + "'" + superConstructs[i].getDescription() + "'"
                            + "],");
                }
                out.println(
                        "["
                        + "'" + (superConstructs.length) + ".',"
                        + "'" + superConstructs[superConstructs.length - 1].getName() + "',"
                        + "'" + superConstructs[superConstructs.length - 1].getCode() + "',"
                        + "'" + superConstructs[superConstructs.length - 1].getDescription() + "'"
                        + "]");
            }
            else
            {
                out.println("['', '', '', '']");
            }

            %>
            ]
        );

            scTable.draw();
	
            <%
            // map the SC's to a javascript array [rowid:pkid]
            if (superConstructs != null && superConstructs.length > 0)
            {
                out.print("var scTableMap = [");
                for (i = 0; i < superConstructs.length - 1; i++)
                {
                    out.print("[" + (i) + "," + superConstructs[i].getPKID() + "],");
                }

                out.print("[" + (superConstructs.length - 1) + "," + superConstructs[superConstructs.length - 1].getPKID() + "]");
                out.print("];");
            }
            %>
		
        </script>

        <br>

        <div class='btnBar'>
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;">
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn1' value="Edit" onclick="return setSCs(1);" />
                    <input type='hidden' name='sc' id='sc1'/>
                    <input type='hidden' name='scname' id='scname1'/>
                    <input type='hidden' name='pg' value="-602" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn1' value="Constructs ..." onclick="return setSCs(2);" />
                    <input type='hidden' name='sc' id='sc2'/>
                    <input type='hidden' name='scname' id='scname2'/>
                    <input type='hidden' name='pg' value="-603" />
                </form>

            </div>
        </div>
    </div>

    <br>
</div>
<%}%>
