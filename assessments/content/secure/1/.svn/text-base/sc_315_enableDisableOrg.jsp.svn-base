<%@ page language="java" import="beans.*" %>

<%
	String orgName = null;
	String orgId = request.getParameter("org");
	String fromPg = request.getParameter("frompg");
	
	if (fromPg == null)
	{
		fromPg = "-30";
	}
	
	Customer customer = new Customer();
	customer.setPKID(orgId);
	
	try
	{
		customer.loadFromDB(false);
	}
	catch (Exception ex)
	{
		out.println("Failed to load organization");
	}
	
	// Must be the reverse of what it currently is
	String disabledEnabledMessage = (customer.isDisabled())? "Enabled" : "Disabled";
	orgName = customer.getName();
	
%>


<h2>Organizations :: Enable or Disable</h2>
<p><h5>Confirmation required</h5></p>
<form action="index.jsp" method='post'>
<table>
	<tr>
		<td>The '<%out.print(orgName);%>' organization is going to be <b><% out.print(disabledEnabledMessage); %></b></td>
	</tr>
	<tr>
		<td>Continue with this action?</td>
	</tr>
	<tr>
		<td>
			<div>
				<input type='submit' class='btn1' value="Yes" name='confirmation'/>
				<input type='submit' class='btn1' value="No" name='confirmation'/>				
			</div>
		</td>
	</tr>
</table>

<input type='hidden' name='orgId' value="<%out.print(orgId);%>" />
<input type='hidden' name='isDisabled' value="<%out.print(!customer.isDisabled());%>" />
<input type='hidden' name='pg' value="<%=fromPg%>" />
</form>