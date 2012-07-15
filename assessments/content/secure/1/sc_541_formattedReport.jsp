<%@ page language="java" import="beans.*" %>

<%
        String msg = "&nbsp;";
        boolean errOccurred = false;

        SessionManager sessionMananger = new SessionManager(session);
        boolean validLogin = (sessionMananger.getUserLvl() == 1) || (sessionMananger.getUserLvl() == 2);

        Report report = null;

        if (validLogin)
        {
            String reportId = request.getParameter("reportId");

            try
            {
                report = ReportsManager.createReport(Integer.parseInt(reportId));
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
<%=ReportsManager.displayOnScreen(report, 0)%>
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