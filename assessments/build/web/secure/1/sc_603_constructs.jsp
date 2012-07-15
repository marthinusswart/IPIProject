<%@ page language="java" import="beans.SuperConstruct,beans.SessionManager,beans.extensions.Construct" %>

<style>
    .cols1	{ padding: 0 5px 0 5px;}
    .cols2	{ padding: 0 5px 0 0;}
    .colName	{ width:150px;}
    .colDescr	{ width:300px;}
    .colFlags	{ width:75px;}

    H4{ margin: 0;}
    .sectionBlok	{
        width:620px;
        border: 1px solid #ddd;
        padding: 4px 2px 2px 4px;
    }.sbTitle1{
        border: 1px solid #ddd;
        margin-top:20px;
        width:200px;
        padding: 5px 0 5px 5px;
        background-color: #eee;
    }

    .alRight { text-align:right; padding-right:5px; }

    .btnBar2{
        width:600px;
        height: 50px;
        border:1px solid black;
        padding: 3px 3px 0 3px;
        font-size:8pt;
    }

    #tbl_cTable td{font-size:8pt;}

</style>
<script type='text/javascript' src='script/client/sc63.js'></script>

<%
        SessionManager sMan = new SessionManager(session);
        int userLevel = sMan.getUserLvl();
        boolean errOccurred = false;
        String msg = "&nbsp;";
        Construct[] constructs = null;
        String superConstructId = request.getParameter("sc");
        SuperConstruct superConstruct = null;

        if (superConstructId != null)
        {
            sMan.setSuperConstructId(superConstructId);
        }
        else
        {
            superConstructId = sMan.getSuperConstructId();
        }

        if (superConstructId == null)
        {
            errOccurred = true;
            msg = "The super construct id is null";
        }
        else if (userLevel != 1)
        {
            errOccurred = true;
            msg = "Need to be Head Office Administrator";
        }
        else if (!errOccurred)
        {
            try
            {
                superConstruct = new SuperConstruct(superConstructId);
                superConstruct.loadFromDB();
            }
            catch (Exception ex)
            {
                msg = ex.getMessage();
                errOccurred = true;
            }

            if (request.getParameter("action") != null)
            {
                if (request.getParameter("action").equals("update_construct"))
                { // First to the update before reloading
                    Construct construct = new Construct(request.getParameter("cid"));
                    try
                    {
                        construct.loadFromDB();
                        construct.setName(request.getParameter("cname"));
                        construct.setDescription(request.getParameter("cdescription"));

                        if ((request.getParameter("cisoptional") != null)
                            && (request.getParameter("cisoptional").equals("yes")))
                        {
                            construct.setIsOptional(true);
                        }
                        else
                        {
                            construct.setIsOptional(false);
                        }

                        if ((request.getParameter("cispositive") != null)
                            && (request.getParameter("cispositive").equals("yes")))
                        {
                            construct.setIsPositive(true);
                        }
                        else
                        {
                            construct.setIsPositive(false);
                        }

                        if ((request.getParameter("cisneutral") != null)
                            && (request.getParameter("cisneutral").equals("yes")))
                        {
                            construct.setIsNeutral(true);
                        }
                        else
                        {
                            construct.setIsNeutral(false);
                        }

                        construct.saveToDB();
                    }
                    catch (Exception ex)
                    {
                        msg = "Failed to update Construct. " + ex.getMessage();
                        errOccurred = true;
                    }

                }
            }

            if (!errOccurred)
            {
                try
                {
                    constructs = Construct.getConstructs(superConstructId);
                    if (constructs.length == 0)
                    {
                        throw new Exception("ERROR: " + superConstructId);
                    }
                }
                catch (Exception ex)
                {
                    errOccurred = true;
                    msg = ex.getMessage();
                }
            }
        }

%>

<h2>Super Construct :: <%=superConstruct.getName()%></h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<%if (!errOccurred)
        {%>

<div align='center'>
    <div align='left'>
        <div class='sbTitle1'>
            <h4>Constructs</h4>
        </div>

        <script type="text/javascript">

            var cTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colName'>Name</div>",
                "<div class='cols1 colFlags'>Is Optional</div>",
                "<div class='cols1 colFlags'>Is Positive</div>",
                "<div class='cols1 colFlags'>Is Neutral</div>",
                "<div class='cols2 colDescr'>Description</div>"],
            [
            <%
                        int i;
                        if (constructs != null && constructs.length > 0)
                        {
                            for (i = 0; i < constructs.length - 1; i++)
                            {
                                out.println(
                                        "["
                                        + "'" + (i + 1) + ".',"
                                        + "'" + constructs[i].getName() + "',"
                                        + "'" + ((constructs[i].isOptional()) ? "Yes" : "No") + "',"
                                        + "'" + ((constructs[i].isPositive()) ? "Yes" : "No") + "',"
                                        + "'" + ((constructs[i].isNeutral()) ? "Yes" : "No") + "',"
                                        + "'" + constructs[i].getDescription() + "'"
                                        + "],");
                            }
                            out.println(
                                    "["
                                    + "'" + (constructs.length) + ".',"
                                    + "'" + constructs[constructs.length - 1].getName() + "',"
                                    + "'" + ((constructs[constructs.length - 1].isOptional()) ? "Yes" : "No") + "',"
                                    + "'" + ((constructs[constructs.length - 1].isPositive()) ? "Yes" : "No") + "',"
                                    + "'" + ((constructs[constructs.length - 1].isNeutral()) ? "Yes" : "No") + "',"
                                    + "'" + constructs[constructs.length - 1].getDescription() + "'"
                                    + "]");
                        }
                        else
                        {
                            out.println("['', '', '', '', '', '']");
                        }

            %>
                ]
            );

                cTable.draw();
	
            <%
                        // map the SC's to a javascript array [rowid:pkid]
                        if (constructs != null && constructs.length > 0)
                        {
                            out.print("var cTableMap = [");
                            for (i = 0; i < constructs.length - 1; i++)
                            {
                                out.print("[" + (i) + "," + constructs[i].getPKID() + "],");
                            }

                            out.print("[" + (constructs.length - 1) + "," + constructs[constructs.length - 1].getPKID() + "]");
                            out.print("];");
                        }
            %>
		
        </script>

        <br>

        <div class='btnBar2'>
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;">
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn1' value="Edit" onclick="return setCs(1);" />
                    <input type='hidden' name='c' id='c1'/>
                    <input type='hidden' name='cname' id='cname1'/>
                    <input type='hidden' name='pg' value="-604" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn1' value="Questions ..." onclick="return setCs(2);" />
                    <input type='hidden' name='c' id='c2'/>
                    <input type='hidden' name='cname' id='cname2'/>
                    <input type='hidden' name='pg' value="-605" />
                </form>

            </div>
        </div>
    </div>

    <br>
</div>
<%}%>
