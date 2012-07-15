<%@ page language="java" import="beans.*" %>
<%

// is logged-in user an Customer -OR- Administrator
SessionManager sMan = new SessionManager(session);

int		usrLvl = sMan.getUserLvl();

if(usrLvl==2){
	%> <jsp:forward page="/index.jsp?pg=-320" /> <%
}else{

Customer [] gaCusts = Customer.getCustomers();

%>

<h2>Individuals :: New Individual</h2>
<hr>
<div>&nbsp;</div>
<hr>
<b>Step 0: Choose Organization</b>
<form action="index.jsp" method='post'>
   <select name="org">
<%
   	for(int i=0; i< gaCusts.length; i++)
   		out.println("<option value='"+gaCusts[i].getPKID()+"'>"+gaCusts[i].getName());
%>
   </select>
	<hr>
	<div style='text-align:right;'>
		<input type='submit' value=" Step 1 >> " />
	</div>
	<input type='hidden' name='pg' value="-320" />
</form>

<% } %>