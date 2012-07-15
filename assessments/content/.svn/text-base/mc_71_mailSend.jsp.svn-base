<%@ page language="java" import="mail.*" %>

<%
	MailSender ms = new MailSender();
	
	boolean ok = ms.doPost(
		request.getParameter("FromBox"),
		request.getParameter("ToBox"),
		request.getParameter("CcBox"),
		request.getParameter("BccBox"),
		request.getParameter("SubjectBox"),
		request.getParameter("BodyBox")
	);
	
	if(ok) out.println("mail send Success");
	else out.println("mail send failed");

%>
