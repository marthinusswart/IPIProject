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

<script type='text/javascript'>
    function getSelectedSCPKID(){
        return scTableMap[scTable.m_selectedRows[0]][1];
    }

    function getSelectedSCName(){
        return scTable.m_aRowData[scTable.m_selectedRows[0]][1];
    }

    function selectOK(){
        if(scTable.m_selectedRows.length > 0){
            return true;
        }else{
            alert("Please select a Super Construct.");
            return false;
        }
    }


    function setSCs(val){
        val=(val)?val:'';
        if(selectOK())
        {
            document.getElementById("sc"+val).value = getSelectedSCPKID();
            document.getElementById("scname"+val).value	= getSelectedSCName();
            return true;

        }else return false;
    }
</script>


<%

        SessionManager sMan = new SessionManager(session);
        int userLevel = sMan.getUserLvl();
        boolean errOccurred = false;
        String msg = "&nbsp;";
        SuperConstruct[] superConstructs = null;
        String qreId = request.getParameter("qreId");

        if (userLevel != 1)
        {
            errOccurred = true;
            msg = "Need to be Head Office Administrator";
        }
        else
        {
            if (!errOccurred)
            {
                try
                {
                    superConstructs = SuperConstruct.getSuperConstructs(qreId);
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
                    <input type='submit' class='btn1' value="Remove" onclick="return setSCs(1);" />
                    <input type='hidden' name='sc' id='sc1'/>
                    <input type='hidden' name='scname' id='scname1'/>
                    <input type='hidden' name='action' value='removesuperconstruct'/>
                    <input type='hidden' name='qre' value='<%=qreId%>' />
                    <input type='hidden' name='pg' value="-502" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn1' value="Back"/>
                    <input type='hidden' name='qre' value='<%=qreId%>' />
                    <input type='hidden' name='pg' value="-502" />
                </form>

            </div>
        </div>
    </div>

    <br>
</div>
<%}%>

