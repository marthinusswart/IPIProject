<%@ page language="java" import="java.sql.*" %>

<jsp:useBean id="newQre" class="beans.Questionaire" scope="session" />

<%
	// (1.) Display confirmation and  (2.) Commit to db (post back to self)
	
	if(request.getParameter("confirm")==null){		// (1.)
	
		// get request data
   	String[]		tmpOptCs	= request.getParameterValues("optC");							// tmp [] of fSC:pkid:name (optional constructs)
   	String[][] 	sOptCs	= (tmpOptCs==null)?null:new String[tmpOptCs.length][3];	// tokenized [] of [fSC,pkid,name]
   	String		sWording	= request.getParameter("radWording");
   
   	if(tmpOptCs!=null){
   		String[] s;
   		for(int i=0; i< tmpOptCs.length; i++){
   			s=tmpOptCs[i].split(":");
   			sOptCs[i][0] = s[0];
   			sOptCs[i][1] = s[1];
   			sOptCs[i][2] = s[2];
   		}
   	}
   	
   	// put eveything so far into the session
   	newQre.setOptCs(sOptCs);
   	newQre.setWording(sWording);
%>
<h2>Assessments :: New Questionaire (confirm)</h2>
<hr>
<h3>Please check that your details are correct</h3>


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
.value2{
	border-left:	1px solid black;
	border-right:	1px solid black;
	background-color:#fff;
	padding:0 2px 0 2px;
}
.value3{
	border-left:	1px solid black;
	border-right:	1px solid black;
	border-bottom:	1px solid black;
	background-color:#fff;
	padding:0 2px 2px 2px;
}

</style>

<% try{ %>
<table style='border-collapse:collapse;'>
	<tr>
		<td class='field'>Assessment Name:</td><td class='value'><%=newQre.getName()%></td>
	</tr>
	<tr>
		<td class='field'>Description:</td><td class='value'><%=newQre.getDesc()%></td>
	</tr>
	<tr>
		<td class='field'>Type:</td><td class='value'><%=newQre.getType().getName()%> (<%=newQre.getType().getCode()%>)</td>
	</tr>
	<tr>
		<td class='field' colspan="2">Super-Constructs Included:-</td>
	<tr>
<%	
		// print SC's here
		String[][] SCs = newQre.getSCs();
		if(SCs!=null && SCs.length>0){
			for(int i=0; i< SCs.length-1; i++){	%>

	<tr>
		<td class='value2' colspan="2"><%=SCs[i][1]%>. <%=SCs[i][2]%></td>
	<tr>
<%
			} // end-for
%>
	<tr>
		<td class='value3' colspan="2"><%=SCs[SCs.length-1][1]%>. <%=SCs[SCs.length-1][2]%></td>
	<tr>
<%
		} // end-if
		
%>

	<tr>
		<td class='field' colspan="2">Excluded optional Constructs:-</td>
	</tr>
<%
		// print excluded c's here
		if(sOptCs!=null){
			for(int i=0; i< sOptCs.length-1; i++)
				out.println("<tr><td class='value2' colspan='2'>"+sOptCs[i][1]+". "+sOptCs[i][2]+"</td></tr>");
			out.println("<tr><td class='value3' colspan='2'>"+sOptCs[sOptCs.length-1][1]+". "+sOptCs[sOptCs.length-1][2]+"</td></tr>");
		}else{
				out.println("<tr><td class='value' colspan='2'>-</td></tr>");
		}// end-if-else
%>
		<tr>
			<td class='field'>Chosen Wording set:</td>
			<td class='value'><%=((sWording.equals("0"))?"1. Individual":"2. Organizational (if available)")%></td>
		</tr>
<%


		// TODO - print total questions here


%>

	<tr>
		<td><img src="images/spacer.gif" width="150" height="1"></td>
		<td><img src="images/spacer.gif" width="300" height="1"></td>
	</tr>
</table>
<% } // try
catch (Exception ex)
{
	out.println("Failed to load full questionaire detail: " + ex.getMessage());
}
%>
<hr>

<style>
.btn1{ width:90px; }
</style>

<div style='text-align:right;'>
	<div style='float:right; padding:0 10px 0 10px'>
		<!-- FINISH: POST tp self -->
		<form action='index.jsp' method='post'>
			<input type='submit' class='btn1' value=" Finish " />
			<input type='hidden' name='confirm' value="1">
			<input type='hidden' name='pg' value="-512">
		</form>
	</div>
	<div style='float:right'>
		<!-- RESTART: POST to 1st page -->
		<form action='index.jsp' method='post'>
			<input type='submit' class='btn1' value=" Start Over " />
			<input type='hidden' name='pg' value="-510">
		</form>
	</div>
</div>


<%
	}else{														// (2.)
%>

<h2>Assessments :: New Questionaire (Result)</h2>
<hr>

<%
		// --- SAVE THE QUESTIONAIRE in DB ---
		boolean itWorked=true;
		try{
			newQre.commit();
		}catch(Exception e){
			beans.Err.printDBErr(e.getMessage(), out, true, true);
			itWorked=false;
		}
		
		if(itWorked) out.println("<div class='success'>Questionaire '<i>"+newQre.getName()+"'</i>&nbsp;&nbsp;has been created successfully.</div>");
		
		// destroy Questionaire & remove from session
		newQre = null;
		session.removeAttribute("newQre");
	}
%>