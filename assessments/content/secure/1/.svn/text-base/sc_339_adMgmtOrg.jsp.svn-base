<%@ page language="java" import="beans.*" %>

<%

String	msg = "&nbsp;";
boolean	errOccurred = false;

Customer [] customers = null;

// get all customers
try{
	customers = Customer.getCustomers();
}catch(Exception e){
	errOccurred = true;
	msg = Err.genericMsg(e);
}


%>


<h2>Organizations :: Advert Management</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>
<p><h5>Please choose an Organization:</h5></p>
<form action="index.jsp" method='post'>
<table>
	<tr>
		<td>Customer:</td>
		<td>
			<select name="org">
				<%
					if(customers!=null)
					for(int i=0; i < customers.length; i++){
						out.println("<option value='"+customers[i].getPKID()+"'>"+customers[i].getName());
					}
				%>
			</select>
		</td>
	</tr>
	<tr><td colspan="2" style="text-align:right;"><input type='submit' class='btn2' value="OK" /></td></tr>
</table>

<input type='hidden' name='pg' value="-340" />
</form>