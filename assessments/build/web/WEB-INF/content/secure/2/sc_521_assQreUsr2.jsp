<%@ page language="java" import="beans.*" %>
<%

String	msg = "&nbsp;";
boolean	errOccurred = false;

SessionManager sMan = new SessionManager(session);
int		userLevel  = sMan.getUserLvl();

User []		gaUsers=null;			// array of users for a particular org/dept
Customer[]	gaDepts=null;			// array of departments for an organization (org-admin)
String custID = null;

try{
	// get the users for given customer (cust/admin)
	custID = (userLevel==2)?sMan.getCustID(true):request.getParameter("org");

  	gaUsers	= User.getUsers(custID);
  	
  	// load departments?
  	if(userLevel==2){ // YES:
  		DBProxy db = new DBProxy();
  		
  		try{ gaDepts = Customer.getCustomers(Integer.parseInt(custID), db); }
  		catch(Exception e){ throw e; }
  		finally{ db.close(); }
	  	
  	}
  	
  	session.setAttribute("assCustID", custID);

}catch(Exception e){
	msg = Err.genericMsg(e);
	errOccurred = true;
}


%>

<style>
.cols1	{ padding: 0 5px 0 5px;}
.colUser	{ width:150px;}
.colName	{ width:200px;}

.alRight { text-align:right; padding-right:5px; }

#tbl_usrTable td{font-size:8pt;}


FORM{DISPLAY: inline;}

</style>

<script type='text/javascript' src='script/client/sc52.0.1.js'></script>
<script type='text/javascript'>
var usrTable=false;
var deptTable=false;
</script>


<h2>Assessments :: Assign Participants</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div>"+msg+"</div>")%>
<hr>

<b>Assign Questionaire to:-</b><br><br>

<%

switch(userLevel){ 

	case 1:	{	// (1) Administrator: choose Org / Users
%>

	<div style="border:1px solid black; background-color:#CCC; width:250px">
		<input name='rad1' type='radio' value='0' onclick="rad1_Click(this)" checked/> Organization (-administrator)<br>
		<input name='rad1' type='radio' value='1' onclick="rad1_Click(this)" /> Candidates within the organization
		<input id='usrType' type='hidden' value='1' />
	</div>
	<hr>
	<div id='option1' style="display:block;">
		<i>The Organization's administrator user will be able to:
		<ul>
			<li>re-assign the questionaire to their downline administrators (requires no credit);
			<li>re-assign the questionaire to their candidates (requires 1 credit per assignment);
		</ul>
		</i>
	</div>
<% 
	break;
	}

	case 2:	{		// (2) Org-admin: choose Dept / Users
%>

	<div style="border:1px solid black; background-color:#CCC; width:250px">
		<input name='rad1' type='radio' value='0' onclick="rad1_Click(this)" /> My Downlines<br>
		<input name='rad1' type='radio' value='1' onclick="rad1_Click(this)" checked /> My Candidates
		<input id='usrType' type='hidden' value='2' />
	</div>
	<hr>
	<div id='option1' style="display:none;">
		<i>The Downlines' administrator users will be able to:
		<ul>
			<li>re-assign the questionaire to their downline administrators (requires no credit);
			<li>re-assign the questionaire to their candidates (requires 1 credit per assignment);
		</ul>
		</i>
		<hr>
		<div align='left'>
		<b>Choose a Downline:</b><br /><br />
		
		<%
      if(gaDepts!=null && gaDepts.length>0){ %>
      
      <script type="text/javascript">
      
      	deptTable = new DynamicTable(
      		[
      		"<div class='cols1'>#</div>",
      		"<div class='cols1 colName'>Dept. Name</div>",
      		"<div class='cols1'>Code</div>",
      		"<div class='cols1'>Credit</div>"
      		],
      		[
      <%	
         		for(int i=0; i< gaDepts.length; i++){ 
         			out.println(
         			"["+
         			"'"+(i+1)+".'," +
        				"'"+gaDepts[i].getName()+"'," +
        				"'"+gaDepts[i].getCode()+"'," +
        				"'"+gaDepts[i].getCredits()+"'" +
         			"]"+((i< gaDepts.length-1)?",":"")
         			);
         		}
      %>
      		]
      	);
      	
      	//deptTable.m_isMultiSelect = true;
      	//deptTable.m_fnClickHandler = usrTable._getClickHandler(usrTable.m_isMultiSelect);
      	deptTable.draw();
      	
      
      
<%
      
      // output deptid's to client array
      out.print("var deptidMap = [");
      for(int i=0; i< gaDepts.length; i++)
      	out.print("["+i+","+gaDepts[i].getPKID()+"]"+((i< gaDepts.length-1)?",":""));
      out.print("];");
      
%>		
		
		</script>
      
      <%
      }else		out.println("<b><i style='color:red'>No Downline found.</i></b>"); %>

		</div>
	</div>
<% 
	break;
	}
	
} %>

<% if (userLevel == 2){%>
<div id='option2' style="display:block;">
<%}else{%>
<div id='option2' style="display:none;">
<%}%>
<div align='left'>
<b>Choose Individual(s):</b><br /><br />

<%
if(gaUsers!=null && gaUsers.length>0){ %>

<script type="text/javascript">

	usrTable = new DynamicTable(
		[
		"<div class='cols1'>#</div>",
		"<div class='cols1 colUser'>UserName</div>",
		"<div class='cols1 colName'>Name</div>",
		"<div class='cols1 colName'>Organization</div>"
		],
		[
<%	
   		for(int i=0; i< gaUsers.length; i++){ 
   			out.println(
   			"["+
   			"'"+(i+1)+".'," +
   			"'"+gaUsers[i].getUserName()+"'," +
   			"'"+
   				((gaUsers[i].getTitle()!=null && !gaUsers[i].getTitle().equals(""))
   					?gaUsers[i].getTitle()+" "
   					:"") + 
   				gaUsers[i].getFirstName()+" "+
   				((gaUsers[i].getInitial()!=null && !gaUsers[i].getInitial().equals(""))
   					?gaUsers[i].getInitial()+" "
   					:"") + 
   				gaUsers[i].getLastName()+"'," +
   				"'"+gaUsers[i].getCustName()+"'" +
   			"]"+((i< gaUsers.length-1)?",":"")
   			);
   		}
%>
		]
	);
	
	usrTable.m_isMultiSelect = true;
	usrTable.m_fnClickHandler = usrTable._getClickHandler(usrTable.m_isMultiSelect);
	usrTable.draw();
	
</script>

<% }else		out.println("<b><i style='color:red'>No users found.</i></b>"); %>

</div>
<br>
<div class='btnBar' style="width:200px">
	<div class='btnBTitle'>Actions</div>
		<div style="float:left;">
			<input type='submit'	class='btn2' 	value="Select All" onclick="return btnAll_Click();" />
			<input type='submit' class='btn2'	value="Reset"		 onclick="usrTable.deselectAllRows(); return false;" />
		</div>
</div>

</div>

<hr>

<br>
<form action="index.jsp" method='post' id='mainForm'>
	<div style='text-align:right;'>
		<input type='submit' onclick="return btnStep2_Click();" value=" Finish " />
	</div>
	<input type='hidden' name='pg' value="-522" />

</form>
<br>

<input type="hidden" value="Page=521"/>