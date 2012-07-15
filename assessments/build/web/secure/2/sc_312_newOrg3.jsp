<%@ page language="java" import="beans.*" %>

<jsp:useBean id="cust" class="beans.Customer" scope="session" />

<%

SessionManager sMan = new SessionManager(session);
int usrLevel = sMan.getUserLvl();

Customer	cDeptParent	= null;
if((cDeptParent = (Customer) session.getAttribute("cDeptParent"))==null) { /*donothing*/ }

String PageTitle		= null;
String Label1			= null;
String msg				=	"&nbsp;";
boolean errOccurred 	= false;


// labels: add deaprtment OR add new Org?
switch(usrLevel){
	case 1:		// Sup-admin: add org..
		PageTitle	= (cDeptParent==null)?"Organizations :: Create New Organization":"Organizations :: Add Downline";
		Label1		= "Organization";
		break;
	case 2:		// Add dept..
		PageTitle	= "My Organization :: Add Downline";
		Label1		= "Downline";
		break;
	default:
		msg = "Error: incorrect user-level";
		errOccurred = true;
}


// (1.) posted from Step 2. (check user & confirm) || (2.) posted back from self (commit + result)

if(request.getParameter("confirm")==null)
{			// (1.) first-time here..

// get user info
cust.getUser().setUserName(	request.getParameter("username"));
cust.getUser().setPassword(	request.getParameter("password"));
cust.getUser().setUserLevel(	"2");

cust.getUser().setFirstName(	request.getParameter("firstname"));
cust.getUser().setInitial(		request.getParameter("initial"));
cust.getUser().setLastName(	request.getParameter("lastname"));
cust.getUser().setTitle(		
								((request.getParameter("title")==null || request.getParameter("title").equals(""))
								?null
								:request.getParameter("title"))
								);
cust.getUser().setIDNum(		request.getParameter("idnum"));
cust.getUser().setCompanyRef(	request.getParameter("compref"));

cust.getUser().setTelW(			request.getParameter("telw"));
cust.getUser().setTelH(			request.getParameter("telh"));
cust.getUser().setTelFax(		request.getParameter("telf"));
cust.getUser().setTelCell(		request.getParameter("telc"));
cust.getUser().setEMail(		request.getParameter("email"));


// if the posted user exists(), post back to Step 2.
try{
	if(cust.getUser().exists()){ 
		%>	<jsp:forward page="/index.jsp?pg=-311&username=<%=cust.getName()%>" /> <%
	}
}catch(Exception e){Err.printDBErr(e.getMessage(), out, false, true);}


// add deaprtment OR add new Org?
switch(usrLevel){
	case 1:		// Sup-admin: add org..
		PageTitle	= (cDeptParent==null)?"Organizations :: Create New Organization":"Organizations :: Add Downline";
		Label1		= "Organization";
		break;
	case 2:		// Add dept..
		PageTitle	= "My Organization :: Add Downline";
		Label1		= "Downline";
		break;
	default:
		msg = "Error: incorrect user-level";
		errOccurred = true;
}


%>

<h2><%=PageTitle%> (cont.)</h2>
<hr>
<h3>Please check that your details are correct</h3>


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

table.confirm{border-collapse:collapse;}

#nuHR{
	margin-top:335px;
}

* html #nuHR{
	margin-top:0;
}

</style>

<div style='width:800px;'>
<div style='float:left; width:405px; height:310px;'>
<table class='confirm'>
	<tr>
		<td colspan="2"><br><b><%=Label1%> Details:</b></td>
	</tr>
	<tr>
		<td class='field'><%=Label1%> Name:</td>
		<td class='value'><%=cust.getName()%></td>
	</tr>
	<tr>
		<td class='field'>Ref# Prefix Code:</td>
		<td class='value'><%=cust.getCode()%></td>
	</tr>
	<tr>
		<td class='field'>Credits Assigned:</td>
		<td class='value'><%=cust.getCredits()%></td>
	</tr>
	<tr>
		<td class='field'>Website Address:</td>
		<td class='value'><%=cust.getUser().getWebsite()%></td>
	</tr>
	<tr>
		<td class='field' colspan="2">Address of Premesis:</td>
	</tr>
	<tr>
		<td class='value2' colspan="2"><%=cust.getAddress().getStreet()%></td>
	</tr>
	<tr>
		<td class='value2' colspan="2"><%=cust.getAddress().getSuburb()%></td>
	</tr>
	<tr>
		<td class='value2' colspan="2"><%=cust.getAddress().getCity()%></td>
	</tr>
	<tr>
		<td class='value3' colspan="2"><%=cust.getAddress().getAreaCode()%></td>
	</tr>
</table>
</div>

<div style='float:left; width:395px; height:310px;'>
<table class='confirm'>
	<tr>
		<td colspan="2"><br><b>User Details:</b></td>
	</tr>
	<tr>
		<td class='field'>Username:</td>
		<td class='value'><%=cust.getUser().getUserName()%></td>
	</tr>
	<tr>
		<td class='field'>Generated Password:</td>
		<td class='value'><%=cust.getUser().getPassword()%></td>
	</tr>
	<tr>
		<td class='field'>First Name:</td>
		<td class='value'><%=cust.getUser().getFirstName()%></td>
	</tr>
	<tr>
		<td class='field'>Initial:</td>
		<td class='value'><%=((cust.getUser().getInitial()!=null)?cust.getUser().getInitial():"&nbsp;")%></td>
	</tr>
	<tr>
		<td class='field'>Last Name:</td>
		<td class='value'><%=cust.getUser().getLastName()%></td>
	</tr>
	<tr>
		<td class='field'>Title:</td>
		<td class='value'><%=((cust.getUser().getTitle()!=null)?cust.getUser().getTitle():"&nbsp;")%></td>
	</tr>
	<tr>
		<td class='field'>ID Number:</td>
		<td class='value'><%=((cust.getUser().getIDNum()!=null)?cust.getUser().getIDNum():"&nbsp;")%></td>
	</tr>
	<tr>
		<td class='field'>Company Reference #:</td>
		<td class='value'><%=((cust.getUser().getCompanyRef()!=null)?cust.getUser().getCompanyRef():"&nbsp;")%></td>
	</tr>
	<tr>
		<td class='field'>Tel (W):</td>
		<td class='value'><%=((cust.getUser().getTelW()!=null)?cust.getUser().getTelW():"&nbsp;")%></td>
	</tr>
	<tr>
		<td class='field'>Tel (H):</td>
		<td class='value'><%=((cust.getUser().getTelH()!=null)?cust.getUser().getTelH():"&nbsp;")%></td>
	</tr>
	<tr>
		<td class='field'>Tel (Cell):</td>
		<td class='value'><%=((cust.getUser().getTelCell()!=null)?cust.getUser().getTelCell():"&nbsp;")%></td>
	</tr>
	<tr>
		<td class='field'>Tel (Fax):</td>
		<td class='value'><%=((cust.getUser().getTelFax()!=null)?cust.getUser().getTelFax():"&nbsp;")%></td>
	</tr>
	<tr>
		<td class='field'>Email:</td>
		<td class='value'><%=((cust.getUser().getEMail()!=null)?cust.getUser().getEMail():"&nbsp;")%></td>
	</tr>
</table>
</div>
</div>

<hr id='nuHR'>

<form style='float:right;' action='index.jsp' method='post'>
	<div style='text-align:right;'>
		<input type='submit' value=" Finish " />
	</div>
	<input type='hidden' name='confirm' value="1" />
	<input type='hidden' name='pg' value="-312" />
</form>
<form style='float:right; padding:0 10px 0 10px;'  action='index.jsp' method='post'>
	<div style='text-align:right;'>
		<input type='submit' value=" Start Over " />
	</div>
	
	<input type='hidden' name='pg' value="-310" />
</form>	

<%
} // end (1.)
else{																// (2.) post-back: commit

%>

<h2><%=PageTitle%> (Result)</h2>
<hr>

<%
		// --- SAVE THE CUSTOMER in DB ---
		boolean itWorked=true;
		try{
			cust.commit();
		}catch(Exception e){
			beans.Err.printDBErr(e.getMessage(), out, true, true);
			itWorked=false;
		}
		
		if(itWorked) out.println("<div class='success'>"+Label1+" '<i>"+cust.getName()+"'</i>&nbsp;&nbsp;has been created successfully.</div>");
		
		// destroy Customer & remove from session
		cust.setUser(null);
		cust.setAddress(null);
		cust = null;
		session.removeAttribute("cust");
		if(cDeptParent!=null) session.removeAttribute("cDeptParent");
	}
%>
	