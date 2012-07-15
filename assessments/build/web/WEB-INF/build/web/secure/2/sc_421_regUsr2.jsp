<%@ page language="java" import="beans.*" %>

<%
	// ..error messages
  	String	msg			= "&nbsp;";
  	boolean	errOccurred	= false;
	SessionManager sMan = new SessionManager(session);
	int usrLvl = sMan.getUserLvl();
	String	custId = null;
	if(usrLvl==2) custId = sMan.getCustID(true);
  	
  	if(request.getParameter("ok")==null)
	{	// (1.) First visit: get user input
	
		Customer[] custList = null;
		Questionaire[] qreList = null;

	// get lists of customers and Qre's
	try
	{	
		if (usrLvl == 1)
		{
			// ..get list of customers
			custList = Customer.getCustomers();
		}
	
		// ..get list of questionaires
		qreList = Questionaire.getQres(new SessionManager(session));		
	}
	catch(Exception e)
	{
		msg = "There was a problem reading from the database; the following error was reported: "+e.getMessage();
		errOccurred = true;
	}

%>

<style>
SELECT{
	width:250px;
	height:150px;
}

.field{
	border:			1px solid black;
	background-color:#ccc;
	padding:2px 2px 2px 2px;
	font-weight: bold;
}
.value{
	border:			1px solid black;
	background-color:#fff;
	padding:2px 2px 2px 5px;
	width: 200px;
}
</style>

<script type='text/javascript' src='script/client/sc42.0.1.js'></script>

<h2>Individuals :: Activate Account</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>

<form action='index.jsp' method='post'>
   <p><b>Activate account for user:-</b></p>
   <table cellpadding="0" cellspacing="0" style="border-collapse:collapse">
   	<tr>
   		<td class='field'>Username: </td>
   		<td class='value'><%=request.getParameter("user")%></td></tr>
   	<tr>
   		<td class='field'>Reference #: </td>
   		<td class='value'>'<%=request.getParameter("ref")%>'</td></tr>
   </table>
   
   <%if (usrLvl == 1){%>
   <p>   
   <h5>Assign to a company</h5>
   <i>(Default: [Website Registrations] )</i><br><br>
   <select name="cust" id='Cust' multiple>
   <option value="-1" selected>[Website Registrations]
	<%
	if(custList!=null)
		for(int i=0; i<custList.length; i++)
			out.println(
				((!custList[i].getPKID().equals("-1"))
					?"<option value='"+custList[i].getPKID()+"'>" + custList[i].getName()
					:""));
	%>
   </select>
   
   <%}else{%>
   <input type="hidden" name="cust" value="<%=custId%>">
   <%}%>
   
   <p>
   <h5>Assign Questionaire</h5>
   <select name="qre" id='Qre' multiple>
   	<option value="-1" selected>{none}
	<%
	if(qreList!=null)
		for(int i=0; i<qreList.length; i++)
			out.println("<option value='"+qreList[i].getPKID()+"'>"+qreList[i].getName());
	%>
   </select>
   
   
   <br>
   <hr>
   
   <br>
   <div style='float:right; padding:0 10px 0 10px'>
      <input type='submit' class='btn1' value="Activate" onclick="return activate_Click();" />
      <input type='hidden' name='ok' value="1">
      <input type='hidden' name='user' value="<%=request.getParameter("user")%>">
      <input type='hidden' name='pg' value="-421">
   </div>
   
</form>
<br>

<%
	}
	else
	{		// (2.) Post back: update db
		
	try
	{
   		AutoRegUser newUsr = new AutoRegUser(request.getParameter("user"));

   		newUsr.loadDetails(true);
   		
   		newUsr.setUserLevel("3");
   		newUsr.setFKCustomer(request.getParameter("cust"));
   		
   		newUsr.register(request.getParameter("qre"));

   		msg = "The user '"+newUsr.getUserName()+"' has been successfully <b>activated</b> and will be notified via <b>e-mail</b>.";
   	}
	catch(Exception e)
	{
   		msg = "Your operation could not be completed due to the following error: '"+e.getMessage()+"'";
   		errOccurred = true;
   	}

%>

<h2>Individuals :: Activate Account (result)</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>		
Back to <a href="?pg=-420">Pending Registrations</a>
<%
	}
%>