<%@ page language="java" import="beans.*" %>

<%
        String msg = "&nbsp;";
        boolean errOccurred = false;

        SessionManager sessionMananger = new SessionManager(session);
        boolean validLogin = (sessionMananger.getUserLvl() == 1) || (sessionMananger.getUserLvl() == 2);

        Report[] matrix = null;
        String matrixType = "0";
        String reportType = "0";

        if (validLogin)
        {
            String reportIds = request.getParameter("reportIds");
            matrixType = request.getParameter("matrixtype");
            reportType = request.getParameter("reporttype");

            try
            {
                matrix = ReportsManager.createMatrix(reportIds);
            }
            catch (Exception e)
            {
                msg += "error: " + e.getMessage();
                errOccurred = true;
            }
        }
%>

<% if (validLogin)
        {
            if (!errOccurred)
            {%>
<hr>
<%=ReportsManager.displayOnScreen(matrix, Integer.parseInt(matrixType), Integer.parseInt(reportType))%>
<hr>
<%}
                    else
                    {%>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<%}
 }
 else
 {%>
<h2>You are not logged into the FunctionalIntelligence system</h2>
<%}%>