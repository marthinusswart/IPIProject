<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="beans.*" %>
<jsp:useBean id="cust"		class="beans.Customer"	scope="session" />
<jsp:useBean id="newUsr"	class="beans.User"		scope="session" />
<jsp:useBean id="newAddrH"	class="beans.Address"	scope="session" />
<jsp:useBean id="newAddrP"	class="beans.Address"	scope="session" />

<%

if(request.getParameter("confirm")==null){			// (1.) firt time here
   // get user info
   newUsr.setFKCustomer(cust.getPKID());
   newUsr.setUserName(	request.getParameter("username"));
   newUsr.setPassword(	request.getParameter("password"));
   newUsr.setUserLevel(	"3");
   
   newUsr.setFirstName(	request.getParameter("firstname"));
   newUsr.setInitial(	request.getParameter("initial"));
   newUsr.setLastName(	request.getParameter("lastname"));
   newUsr.setTitle(		((request.getParameter("title")==null || request.getParameter("title").equals(""))
   							?null
   							:request.getParameter("title"))
   							);
   newUsr.setIDNum(		request.getParameter("idnum"));
   newUsr.setCompanyRef(request.getParameter("compref"));
   
   newUsr.setTelW(		request.getParameter("telw"));
   newUsr.setTelH(		request.getParameter("telh"));
   newUsr.setTelFax(		request.getParameter("telf"));
   newUsr.setTelCell(	request.getParameter("telc"));
   newUsr.setEMail(		request.getParameter("email"));
   //newUsr.setWebsite(	request.getParameter("web"));
   
   // get user's addresses
   newAddrH.setStreet(	request.getParameter("addr1h"));
   newAddrH.setSuburb(	request.getParameter("addr2h"));
   newAddrH.setCity(		request.getParameter("addr3h"));
   newAddrH.setAreaCode(request.getParameter("arcodeh"));
   
   newAddrP.setStreet(	request.getParameter("addr1p"));
   newAddrP.setSuburb(	request.getParameter("addr2p"));
   newAddrP.setCity(		request.getParameter("addr3p"));
   newAddrP.setAreaCode(request.getParameter("arcodep"));
   
   
   try{
   	if(newUsr.exists()){
   		%>	<jsp:forward page="/index.jsp?pg=-320&username=<%=newUsr.getUserName()%>" /> <%
   	}
   }catch(Exception e){
   	Err.printDBErr(e.getMessage(), out, false, true);
   }

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
	padding:2px 2px 2px 5px;
}
.value2{
	border-left:	1px solid black;
	border-right:	1px solid black;
	background-color:#fff;
	padding:0 2px 0 5px;
}
.value3{
	border-left:	1px solid black;
	border-right:	1px solid black;
	border-bottom:	1px solid black;
	background-color:#fff;
	padding:0 2px 2px 5px;
}

table.confirm{border-collapse:collapse;}

</style>

<h2>Individuals :: New Individual (confirm)</h2>
<hr>
<div>&nbsp;</div>
<hr>
<script type='text/javascript' src="script/client/sc31.js"></script>
<h3>Please check your details</h3>
<table class='confirm'>
	<tr>
		<td class='field'>Username:</td>
		<td class='value'><%=newUsr.getUserName()%></td>
	</tr>
	<tr>
		<td class='field'>Password:</td>
		<td class='value'><%=newUsr.getPassword()%></td>
	</tr>
	<tr>
		<td class='field'>First Name:</td>
		<td class='value'><%=newUsr.getFirstName()%></td>
	</tr>
	<tr>
		<td class='field'>Initial:</td>
		<td class='value'><%=((newUsr.getInitial()!=null)?newUsr.getInitial():"")%></td>
	</tr>
	<tr>
		<td class='field'>Last Name:</td>
		<td class='value'><%=newUsr.getLastName()%></td>
	</tr>
	<tr>
		<td class='field'>Title:</td>
		<td class='value'><%=((newUsr.getTitle()!=null)?newUsr.getTitle():"")%></td>
	</tr>
	<tr>
		<td class='field'>ID Number:</td>
		<td class='value'><%=((newUsr.getIDNum()!=null)?newUsr.getIDNum():"")%></td>
	</tr>
	<tr>
		<td class='field'>Company Reference #:</td>
		<td class='value'><%=((newUsr.getCompanyRef()!=null)?newUsr.getCompanyRef():"")%></td>
	</tr>
	<tr>
		<td class='field'>Tel (W):</td>
		<td class='value'><%=((newUsr.getTelW()!=null)?newUsr.getTelW():"")%></td>
	</tr>
	<tr>
		<td class='field'>Tel (H):</td>
		<td class='value'><%=((newUsr.getTelH()!=null)?newUsr.getTelH():"")%></td>
	</tr>
	<tr>
		<td class='field'>Tel (Cell):</td>
		<td class='value'><%=((newUsr.getTelCell()!=null)?newUsr.getTelCell():"")%></td>
	</tr>
	<tr>
		<td class='field'>Tel (Fax):</td>
		<td class='value'><%=((newUsr.getTelFax()!=null)?newUsr.getTelFax():"")%></td>
	</tr>
	<tr>
		<td class='field'>Email:</td>
		<td class='value'><%=((newUsr.getEMail()!=null)?newUsr.getEMail():"")%></td>
	</tr>
	<!--
	<tr>
		<td class='field'>Website:</td>
		<td class='value'><%=((newUsr.getWebsite()!=null)?newUsr.getWebsite():"")%></td>
	</tr>
	-->
	<tr>
		<td><img src="images/spacer.gif" width="135" height="1"></td>
		<td><img src="images/spacer.gif" width="192" height="1"></td>
	</tr>
</table>
<table class='confirm'>
	<tr>
		<td class='field' colspan="2"><b>Address (Home):</b></td>
		<td></td>
		<td class='field' colspan="2"><b>Address (Post):</b></td>
	</tr>
	<tr>
		<td class='value2' colspan="2"><%=((newAddrH.getStreet()!=null)?newAddrH.getStreet():"")%></td>
		<td></td>
		<td class='value2' colspan="2"><%=((newAddrP.getStreet()!=null)?newAddrP.getStreet():"")%></td>
	</tr>
	<tr>
		<td class='value2' colspan="2"><%=((newAddrH.getSuburb()!=null)?newAddrH.getSuburb():"")%></td>
		<td></td>
		<td class='value2' colspan="2"><%=((newAddrP.getSuburb()!=null)?newAddrP.getSuburb():"")%></td>
	</tr>
	<tr>
		<td class='value2' colspan="2"><%=((newAddrH.getCity()!=null)?newAddrH.getCity():"")%></td>
		<td></td>
		<td class='value2' colspan="2"><%=((newAddrP.getCity()!=null)?newAddrP.getCity():"")%></td>
	</tr>
	<tr>
		<td class='value3' colspan="2"><%=((newAddrH.getAreaCode()!=null)?newAddrH.getAreaCode():"")%></td>
		<td></td>
		<td class='value3' colspan="2"><%=((newAddrP.getAreaCode()!=null)?newAddrP.getAreaCode():"")%></td>
	</tr>
	<tr>
		<td><img src="images/spacer.gif" height="1" width="135"></td>
		<td><img src="images/spacer.gif" height="1" width="200"></td>
		<td><img src="images/spacer.gif" height="1" width="30"></td>
		<td><img src="images/spacer.gif" height="1" width="135"></td>
		<td><img src="images/spacer.gif" height="1" width="200"></td>
	</tr>
</table>
</div>
</p>

<hr>
<br>
<form action="index.jsp" method='post'>
	<div style='text-align:right;'>
		<input type='submit' value=" Done " />
	</div>
	<input type='hidden' name='pg' value="-321" />
	<input type='hidden' name='confirm' value="1" />
</form>
<br>
<%
}else{															// (2.) posted back to self: commit
	String	msg="&nbsp;";
	boolean	errOccurred=false;
	boolean	usrOK=false;
	
	// save new user + addresses
	DBProxy db = new DBProxy();
	try{

		newUsr.setPKID(null);
		newUsr.commit(db);
		usrOK=true;

		// get user pk -> addr.fk
		ResultSet res = db.executeQuery("SELECT currval('users_pkid_seq') as pkid");

		res.next();

		newUsr.setPKID(res.getString("pkid"));
		newAddrH.setFkUserID(newUsr.getPKID());
		newAddrP.setFkUserID(newUsr.getPKID());

		// save addresses
		newAddrH.commit(db);
		newAddrP.commit(db);

		msg = "The User '"+newUsr.getUserName()+"' was created successfully.";
	}catch(Exception e){
		if(usrOK){
			newUsr.delete(db);
		}
		msg = "The User '"+newUsr.getUserName()+"' could not be saved. The following error was reported:"+e.getMessage();
		errOccurred=true;
	}finally{
		db.close();
	}
	
	// result
%>
	<h2>Individuals :: New Individual (result)</h2>
	<hr>
	<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
	<hr>
	<br>
	<div style='text-align:right;'>
		<form action="index.jsp" method='post'>
			<input type='submit' onclick='return btnStep2_3_Click()' value=" Create Another " />
			
			<input type='hidden' name='org' value="<%=cust.getPKID()%>" />
			<input type='hidden' name='pg'  value="-320" />
		</form>
	</div>
	
<%
	
	// clear session
	session.removeAttribute("cust");
	session.removeAttribute("newUsr");
	session.removeAttribute("newAddrH");
	session.removeAttribute("newAddrP");	
}
%>