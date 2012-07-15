<%@ page language="java" import="mail.*" %>

<%
	/*
	final int TO_GENERAL	=	0;
	final int TO_SALES	=	1;
	final int TO_SUPPORT	=	2;
	*/

	int 		iMailTo;
	String	sMailFrom	= request.getParameter("mailfrom");
	String	sName			= "Name: "+request.getParameter("name")+"\n---\n";
	String	sBody			= sName + request.getParameter("msgbox");

	String [] subjects = {
		"Website: General info request",
		"Website: Sales request",
		"Website: Support request"
	};

	String [] mailTOs = {
		"info@fqinstitute.com",
		"sales@fqinstitute.com",
		"support@fqinstitute.com"
	};

	
	// construct mail and send via mail-system
	iMailTo = Integer.parseInt(request.getParameter("target"));
		
	MailSender ms = new MailSender();
	boolean ok = ms.doPost(
		sMailFrom,
		mailTOs[iMailTo],
		"",
		"support@brooklynguesthouses.co.za",
		subjects[iMailTo],
		sBody
	);

%>

<style>
.field{
	border:			1px solid black;
	background-color:#ccc;
	padding:2px 2px 2px 2px;
	font-weight: bold;
}
.value{
	border:			1px solid black;
	background-color:#fff;
	padding:2px 2px 2px 2px;
}
.msgbox{
	width: 550px;
	overflow:auto;
}
</style>

<h2>Send Message: Result</h2>
<hr>

<%
	if(ok){
%>
		<div class='success'>Your message was successfully sent.</div>
<%
	}else{ %>
		<div class='err'>
		Sorry, your request could not be sent.<br>
		Try again, or contact us via Telephone or Fax.
		</div>	
<%
	}
%>
		<hr>
		<h3>Message Details</h3>
		<table style='border-collapse:collapse'>
   		<tr>
   			<td class='field'>From:</td>
   			<td class='value'><%=sMailFrom%></td></tr>
   		<tr>
   			<td class='field'>Subject:</td>
   			<td class='value'><%=subjects[iMailTo]%></td></tr>
   		<tr>
   			<td class='field' colspan="2">Message:</td><td></td></tr>
   		<tr><td class='value' colspan="2">
   			<div class='msgbox'><%=(new String(sBody)).replaceAll("\n", "\n<br>")%></div></td></tr>
		</table>
		<br>
		Back to [ <a href="index.jsp?pg=5">Contact Page</a> ]