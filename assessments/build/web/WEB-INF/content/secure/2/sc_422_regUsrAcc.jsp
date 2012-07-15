<%@ page language="java" import="beans.*" %>
<%@ page language="java" import="java.text.DateFormat" %>

<%
	boolean errOccurred=false;
	String msg="&nbsp;";

  	AutoRegUser usr = new AutoRegUser(request.getParameter("user"));
  	
  	try{
	  	usr.loadDetails(true);
	}catch(Exception e){
		msg=Err.genericMsg(e);
		errOccurred=true;
	}

%>


<style>
H4{ margin: 0;}
.sectionBlok	{
	width:650px;
	border: 1px solid #ddd;
	padding: 4px 6px 2px 4px;
}.sbTitle1{ 
	border: 1px solid #ddd;
	margin-top:20px;
	width:150px;
	padding: 5px 0 5px 5px;
	background-color: #eee;
}

.tbl		{ border-collapse:collapse;padding:0;}

.field	{ border: 1px solid #000; background-color: #bbb; padding: 3px 0 3px 3px; vertical-align:middle; }
.field2	{ border: 1px solid #000; background-color: #ddd; padding: 3px 0 3px 3px; vertical-align:middle; }
.value	{ border: 1px solid #000; padding: 2px 0 3px 3px; }

.txt_1	{width:153px;}


</style>


<h2>Individuals :: Pending User - Details</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>


<div class='sbTitle1'>
	<h4>User Details</h4>
</div>

<div class='sectionBlok'>

<form action='index.jsp' method='post'>
	<table class='tbl' cellpadding="0" cellspacing="0">
		<tr>
			<td class='field'>Username:</td>
			<td class='value'><%=usr.getUserName()%></td>
		</tr>
		<tr>
			<td class='field'>Password:</td>
			<td class='value'><%=usr.getPassword()%></td>
		</tr>
		<tr>
			<td class='field'>Title:</td>
			<td class='value'><%=((usr.getTitle()!=null && !usr.getTitle().equals(""))?usr.getTitle():"")%></td>
		</tr>
		<tr>
			<td class='field'>First Name:</td>
			<td class='value'><%=usr.getFirstName()%></td>
		</tr>
		<tr>
			<td class='field'>Initial:</td>
			<td class='value'><%=((usr.getInitial()!=null)?usr.getInitial():"")%></td>
		</tr>
		<tr>
			<td class='field'>Last Name:</td>
			<td class='value'><%=usr.getLastName()%></td>
		</tr>
		<tr>
			<td class='field'>Reference #:</td>
			<td class='value'><%=((usr.getCompanyRef()!=null)?usr.getCompanyRef():"")%></td>
		</tr>
		<tr>
			<td class='field'>Submit Time:</td>
			<td class='value'><%=DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.SHORT).format(usr.getSubmittime())%></td>
		</tr>
		<tr>
			<td class='field'>ID Number:</td>
			<td class='value'><%=((usr.getIDNum()!=null)?usr.getIDNum():"")%></td>
		</tr>
		<tr>
			<td class='field'>Tel (Cell):</td>
			<td class='value'><%=((usr.getTelCell()!=null)?usr.getTelCell():"")%></td>
		</tr>
		<tr>
			<td class='field'>Tel (H):</td>
			<td class='value'><%=((usr.getTelH()!=null)?usr.getTelH():"")%></td>
		</tr>
		<tr>
			<td class='field'>Tel (W):</td>
			<td class='value'><%=((usr.getTelW()!=null)?usr.getTelW():"")%></td>
		</tr>
		<tr>
			<td class='field'>Tel (Fax):</td>
			<td class='value'><%=((usr.getTelFax()!=null)?usr.getTelFax():"")%></td>
		</tr>
		<tr>
			<td class='field'>E-Mail:</td>
			<td class='value'><%=((usr.getEMail()!=null)?usr.getEMail():"")%></td>
		</tr>
		<tr>
			<td><img src="images/spacer.gif" width="140" height="1"></td>
			<td><img src="images/spacer.gif" width="475" height="1"></td>
		</tr>
	</table>
	<table class='tbl' cellpadding="0" cellspacing="0">
	<tr>
		<td class='field' colspan="2">Home Address</td>
		<td></td>
		<td class='field' colspan="2">Postal Address</td>
	</tr>
	<tr>
		<td class='field2'>Street:</td>
		<td class='value'><%=((usr.getAddrHome()!=null && usr.getAddrHome().getStreet()!=null)?usr.getAddrHome().getStreet():"")%></td>
		<td></td>
		<td class='field2'>P.O. Box:</td>
		<td class='value'><%=((usr.getAddrPost()!=null && usr.getAddrPost().getStreet()!=null)?usr.getAddrPost().getStreet():"")%></td>
	</tr>
	<tr>
		<td class='field2'>Suburb:</td>
		<td class='value'><%=((usr.getAddrHome()!=null && usr.getAddrHome().getSuburb()!=null)?usr.getAddrHome().getSuburb():"")%></td>
		<td></td>
		<td class='field2'>Suburb:</td>
		<td class='value'><%=((usr.getAddrPost()!=null && usr.getAddrPost().getSuburb()!=null)?usr.getAddrPost().getSuburb():"")%></td>
	</tr>
	<tr>
		<td class='field2'>City:</td>
		<td class='value'><%=((usr.getAddrHome()!=null && usr.getAddrHome().getCity()!=null)?usr.getAddrHome().getCity():"")%></td>
		<td></td>
		<td class='field2'>City:</td>
		<td class='value'><%=((usr.getAddrPost()!=null && usr.getAddrPost().getCity()!=null)?usr.getAddrPost().getCity():"")%></td>
	</tr>
	<tr>
		<td class='field2'>Area Code:</td>
		<td class='value'><%=((usr.getAddrHome()!=null && usr.getAddrHome().getAreaCode()!=null)?usr.getAddrHome().getAreaCode():"")%></td>
		<td></td>
		<td class='field2'>Area Code:</td>
		<td class='value'><%=((usr.getAddrPost()!=null && usr.getAddrPost().getAreaCode()!=null)?usr.getAddrPost().getAreaCode():"")%></td>
	</tr>
	<tr>
		<td><img src="images/spacer.gif" width="140" height="1"></td>
		<td><img src="images/spacer.gif" width="160" height="1"></td>
		<td><img src="images/spacer.gif" width="15" height="1"></td>
		<td><img src="images/spacer.gif" width="140" height="1"></td>
		<td><img src="images/spacer.gif" width="160" height="1"></td>
	</tr>

</table>
<p>Back to [<a href="index.jsp?pg=-420">Pending Users</a>]</p>
