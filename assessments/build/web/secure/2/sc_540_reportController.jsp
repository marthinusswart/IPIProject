<%@ page language="java" import="beans.*" %>

<script type="text/javascript">
    function showFormattedReport(reportId)
    {
        var reportWindow = window.open("index.jsp?pg=-541&reportId="+reportId);
        return true;
    }
</script>

<%

        String msg = "&nbsp;";
        boolean errOccurred = false;

        final int DOC_SCR = 0;
        final int DOC_XLS = 1;
        final int DOC_PDF = 2;

        String reportId = request.getParameter("repid");

        int DOCTYPE = Integer.parseInt(request.getParameter("doctype"));

        Report report = null;

        try
        {
            report = ReportsManager.createReport(Integer.parseInt(request.getParameter("repid")));
        }
        catch (Exception e)
        {
            msg += "error: " + e.getMessage();
            errOccurred = true;
            //Err.printDBErr(e.getMessage(), out, false, true);
        }

        switch (DOCTYPE)
        {


            /* ------------ [ SCR ] ------------ */
            case DOC_SCR:

                int scrType = Integer.parseInt(request.getParameter("scrtype"));

%>
<h2>Assessments :: Reports</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>
<%=ReportsManager.displayOnScreen(report, scrType)%>
<hr>
<div style='float:left;'>
    <form action='index.jsp' method='post' style='float:left;'>
        <input type='submit' class='btn1' value="Back to Reports" />
        <input type='hidden' name='pg' value="-54">
    </form>
    <form action='index.jsp' method='post' style='float:left;'>
        <input type='button' class='btn1' value="Print Report" name="printreport" onclick="showFormattedReport(<%=reportId%>);" />
    </form>
</div>
<%

                    break;


                /* ------------ [ XLS ] ------------ */
                case DOC_XLS:

%>
<h2>Assessments :: Reports (Spreadsheet)</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>
Sorry, but Spreadsheet Reports are not available.
<hr>
<div style='float:right'>
    <form action='index.jsp' method='post'>
        <input type='submit' class='btn1' value=" Back to Reports " />
        <input type='hidden' name='pg' value="-54">
    </form>
</div>
<%

                    break;


                /* ------------ [ PDF ] ------------ */
                case DOC_PDF:

%>
<h2>Assessments :: Reports (PDF)</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>
Sorry, but PDF Reports are not available.
<hr>
<div style='float:right'>
    <form action='index.jsp' method='post'>
        <input type='submit' class='btn1' value="Back to Reports" />
        <input type='hidden' name='pg' value="-54">
    </form>    
</div>
<%

                break;
        }

%>