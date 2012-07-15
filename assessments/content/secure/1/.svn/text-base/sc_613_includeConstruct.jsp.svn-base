<%@ page language="java" import="beans.extensions.*,beans.SessionManager" %>

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
    function getSelectedCPKID(){
        return scTableMap[scTable.m_selectedRows[0]][1];
    }

    function getSelectedCName(){
        return scTable.m_aRowData[scTable.m_selectedRows[0]][1];
    }

    function selectOK(){
        if(scTable.m_selectedRows.length > 0){
            return true;
        }else{
            alert("Please select a Construct.");
            return false;
        }
    }


    function setCs(val){
        val=(val)?val:'';
        if(selectOK())
        {
            document.getElementById("c"+val).value = getSelectedCPKID();
            document.getElementById("cname"+val).value	= getSelectedCName();
            return true;

        }else return false;
    }
</script>


<%

        SessionManager sMan = new SessionManager(session);
        int userLevel = sMan.getUserLvl();
        boolean errOccurred = false;
        String msg = "&nbsp;";
        Construct[] constructs = null;
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
                    constructs = Construct.getExcludedConstructs(qreId);
                }
                catch (Exception ex)
                {
                    errOccurred = true;
                    msg = ex.getMessage();
                }
            }
        }

%>

<h2>Assessments :: List of Constructs</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<%if (!errOccurred)
        {%>

<div align='center'>
    <div align='left'>
        The following Constructs are excluded<br /><br />


        <script type="text/javascript">

            var scTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colName'>Name</div>",
                "<div class='cols1 colName'>Super Construct</div>",
                "<div class='cols1 colSection'>Is Neutral</div>",
                "<div class='cols1 colSection'>Is Positive</div>"],
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
                                        + "'" + constructs[i].getSuperConstructName() + "',"
                                        + "'" + constructs[i].isNeutral() + "',"
                                        + "'" + constructs[i].isPositive() + "'"
                                        + "],");
                            }
                            out.println(
                                    "["
                                    + "'" + (constructs.length) + ".',"
                                    + "'" + constructs[constructs.length - 1].getName() + "',"
                                    + "'" + constructs[constructs.length - 1].getSuperConstructName() + "',"
                                    + "'" + constructs[constructs.length - 1].isNeutral() + "',"
                                    + "'" + constructs[constructs.length - 1].isPositive() + "'"
                                    + "]");
                        }
                        else
                        {
                            out.println("['', '', '', '', '']");
                        }

            %>
                ]
            );

                scTable.draw();

            <%
                        // map the SC's to a javascript array [rowid:pkid]
                        if (constructs != null && constructs.length > 0)
                        {
                            out.print("var scTableMap = [");
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

        <div class='btnBar'>
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;">
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn1' value="Include" onclick="return setCs(1);" />
                    <input type='hidden' name='c' id='c1'/>
                    <input type='hidden' name='cname' id='cname1'/>
                    <input type='hidden' name='action' value='includeconstruct'/>
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

