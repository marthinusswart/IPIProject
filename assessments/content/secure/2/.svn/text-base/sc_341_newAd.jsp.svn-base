<%@ page language="java" import="beans.*" %>

<%

String	msg = "&nbsp;";
boolean	errOccurred = false;

if(request.getParameter("ok")==null){	// (1) First Visit: form

	// session: (disallow refresh on post-back refresh)
	session.setAttribute("newAd", Boolean.valueOf(true));

%>

<h2>Organizations :: Advert Management</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>
<h3>New Advert</h3>

<form action='index.jsp' method='post'>
	<table>
		<tr>
			<td>Description #:</td>
			<td colspan="3"><input type='text' class='txt1' id='Descr' name='descr' /></td>
		</tr>
		<tr>
			<td>Issue Date #:</td>
			<td>Day:<br>
				<select name='d'>
					<%
					for(int i=1; i<=31; i++) out.print("<option value='"+i+"'>"+i);
					%>
				</select>
			</td>
			<td>Month:<br>
				<select name='m'>
					<%
					for(int i=1; i<=12; i++) out.print("<option value='"+i+"'>"+i);
					%>
				</select>
			</td>
			<td>Year:<br>
				<select name='y'>
					<%
					for(int i=2005; i<=2030; i++) out.print("<option value='"+i+"'>"+i);
					%>
				</select>
			</td>
		</tr>
		
		<tr>
			<td><img src="images/spacer.gif" width="125" height="1"></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>

	<hr>
	<br>
	<div style='text-align:right;'>
		<input type='submit' value=" Create " />
	</div>
	<br>
	<input type='hidden' name='pg'		value="-341" />
	<input type='hidden' name='ok'		value="1" />
	<input type='hidden' name='org'		value="<%=request.getParameter("org")%>" />
	<input type='hidden' name='orgname'	value="<%=request.getParameter("orgname")%>" />
</form>

<% }else{ // (2) Post-back: commit	
		
		if(session.getAttribute("newAd") == null){
			%> <jsp:forward page="/index.jsp?pg=-340" /> <%
		}
		
		// construct Advert
		String day		= request.getParameter("d");
		String month	= request.getParameter("m");
		String year		= request.getParameter("y");
		
		java.text.DateFormat df1 = java.text.DateFormat.getDateInstance(java.text.DateFormat.SHORT, java.util.Locale.UK);
		java.text.DateFormat df2 = java.text.DateFormat.getDateInstance(java.text.DateFormat.LONG, java.util.Locale.UK);
		
		java.util.Date date	= df1.parse(day+"/"+month+"/"+year);
		
		Advert ad = new Advert(
			Integer.parseInt(request.getParameter("org")),
			DBProxy.legalizeString(request.getParameter("descr")),
			new java.sql.Date(date.getTime()));
			
		try{
			ad.commit();
			msg = "Advert created successfully.";
		}catch(Exception e){
			errOccurred = true;
			msg = "The operation could not be completed; the following error was reported: '"+e.getMessage()+"'";
		}
%>

<style>
.field{
	border:			1px solid black;
	background-color:#ccc;
	padding:2px 2px 2px 2px;
	font-weight: bold;
	width:150px;
}
.value{
	border:			1px solid black;
	background-color:#fff;
	padding:2px 2px 2px 2px;
	width:240px;
}
</style>

<h2>Organizations :: Advert Management</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>
<p><h5>Advert Details:</h5></p>
<p>
<table style="border-collapse:collapse;">
	<tr>
		<td class="field">Advert Ref#:</td>
		<td class="value"><%=ad.getReference(null)%></td>
	</tr>
	<tr>
		<td class="field">Description:</td>
		<td class="value"><%=ad.getDescription()%></td>
	</tr>
	<tr>
		<td class="field">Issue Date:</td>
		<td class="value"><%=df2.format(date)%></td>
	</tr>
</table>
</p>
<p>
	<form action="index.jsp" method="post">
		<input type='submit' value="Back to Adverts" />
		<input type='hidden' name='pg'	value="-340" />
		<input type='hidden' name='org'	value="<%=ad.getFkCustID()%>" />
		<input type='hidden' name='orgname' value="<%=request.getParameter("orgname")%>" />
</p>

<% 
	// disallow refresh
	session.removeAttribute("newAd");
	
	} %>
