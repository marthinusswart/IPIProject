<%@ page language="java" import="beans.*" %>

<%

  	AutoRegUser []	gaUsers=null;			// array of pending users in the db
  	AutoRegUser		uTmp=null;
	SessionManager sMan = new SessionManager(session);
	int usrLvl = sMan.getUserLvl();
	String	custId = null;
	if(usrLvl==2) custId = sMan.getCustID(true);
  	
  	// (1.) if this was posted back to self (delete operation)..
  	// ..error messages
  	String	msg			= "&nbsp;";
  	boolean	errOccurred	= false;

  	if(request.getParameter("user")!=null)
	{
  		uTmp = new AutoRegUser(request.getParameter("user"));
  		try
		{
  			uTmp.delete();
  			msg = "The User '"+uTmp.getUserName()+"' was deleted successfully.";
  		}
		catch(Exception e)
		{
  			msg = "The User '"+uTmp.getUserName()+"' was NOT deleted. The following error was reported: "+e.getMessage();
  			errOccurred	= true;
  		}
  	}
  	
  	// get the users
  	try
	{ 	
		if (usrLvl == 1)
		{
			gaUsers	= AutoRegUser.getUsers(false, true);
		}
		else
		{
			gaUsers = AutoRegUser.getUsers(false, true, custId);
		}
	}
	catch(Exception e)
	{
		msg = "There was a problem reading from the database. The following error was reported: "+e.getMessage();
		errOccurred	= true;
	}
  	
%>
 
<h2>Individuals :: Pending Registrations</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>

<style>
.cols1	{ padding: 0 5px 0 5px;}
.colUser	{ width:120px;}
.colPwd	{ width:120px;}
.colCRef	{ width:80px;}
.cellCRef{ font-family:"Courier New", Courier, monospace;}
.colName	{ width:180px;}
.colStat { width:100px;}
.colTime { width:150px;}

.alRight { text-align:right; padding-right:5px; }

#tbl_usrTable td{font-size:8pt;}


FORM{DISPLAY: inline;}

</style>
<script type='text/javascript' src='script/client/sc42.0.1.js'></script>

<h5>Inactive Self-Registered Accounts:</h5>
<p>The following users have confirmed valid e-mail addresses, and are waiting for their accounts to be activated. If <b>payment has been verified</b>, select the user and click the <i>"Activate Account"</i> button.</p>

<script type="text/javascript">

	var usrTable = new DynamicTable(
		[
		"<div class='cols1'>#</div>",
		"<div class='cols1 colUser'>UserName</div>",
		"<div class='cols1 colPwd'>Password</div>",
		"<div class='cols1 colName'>Full Name</div>",
		"<div class='cols1 colCRef'>Company Ref #</div>",
		"<div class='cols1 colTime'>Submit Time</div>"
		],
		[
<%	
		int i;
		if(gaUsers!=null && gaUsers.length>0){
   		for(i=0; i< gaUsers.length-1; i++){ 
   			out.println(
   			"["+
   			"'"+(i+1)+".'," +
   			"'<div class=\"cellCRef\">"+gaUsers[i].getUserName()+"</div>'," +
   			"'<div class=\"colPwd\">"+((gaUsers[i].getPassword()!=null)?gaUsers[i].getPassword():"<i>Invalid Password</i>")+"</div>'," +
   			"'"+gaUsers[i].getFullName()+"'," +
			"'<div class=\"cellCRef\">"+gaUsers[i].getCompanyRef()+"</div>'," +
			"'"+gaUsers[i].getSubmittime()+"'" +
//   			"'<div class=\"alRight\">-</div>'" +
   			"],"
   			);
   		}
   		out.println(
   			"[" +
   			"'"+(gaUsers.length)+".'," +
   			"'<div class=\"cellCRef\">"+gaUsers[gaUsers.length-1].getUserName()+"</div>'," +
   			"'<div class=\"cellCRef\">"+
   				((gaUsers[gaUsers.length-1].getPassword()!=null)
   					?gaUsers[gaUsers.length-1].getPassword():"<i>Invalid Password</i>")+"</div>'," +
   			"'"+gaUsers[gaUsers.length-1].getFullName()+"'," +
			"'<div class=\"cellCRef\">"+gaUsers[i].getCompanyRef()+"</div>'," +
 			"'"+gaUsers[gaUsers.length-1].getSubmittime()+"'" +
//   			"'<div class=\"alRight\">-</div>'" +
     			"]"
   			);
		}else
			 out.println("['', '', '', '', '', '']");

%>
		]
	);

	usrTable.draw();
	
</script>

<br>
<div class='btnBar' style="width:340px">
	<div class='btnBTitle'>Actions</div>
		<div style="float:left;">
			<form action='index.jsp' method='post' style="float:left">
				<input type='submit'	class='btn2' value="Delete" onclick="return setUser(1);" />
				<input type='hidden' name='user' id='Usr1'/>
				<input type='hidden' name='pg' value="-420" />
			</form>
			<form action='index.jsp' method='post' style="float:left">
				<input type='submit' class='btn2' value="More..." onclick="return setUser(3);" />
				<input type='hidden' name='user' id='Usr3'/>
				<input type='hidden' name='pg' value="-422" />
			</form>
		</div>
		<div class='rButtons'  style="width:100px">
			<!--
			<form action='index.jsp' method='post' style="float:right">
				<input type='submit' class='btn1' value="Assign Credit" onclick="return false;" />
				<input type='hidden' name='pg' value="-33" />
			</form>
			-->
			<form action='index.jsp' method='post' style="float:right">
				<input type='submit' class='btn1' value="Activate Account" onclick="return setUser(2);" />
				<input type='hidden' name='user' id='Usr2'/>
				<input type='hidden' name='ref' id='Ref'/>
				<input type='hidden' name='pg' value="-421" />
			</form>
		</div>
</div>
