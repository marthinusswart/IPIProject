<%@ page language="java" import="beans.*" %>

<style>
H4{ margin: 0;}
.sectionBlok	{
	width:650px;
	border: 1px solid #ddd;
	padding: 4px 6px 2px 4px;
}.sbTitle1{ 
	border: 1px solid #ddd;
	margin-top:20px;
	width:200px;
	padding: 5px 0 5px 5px;
	background-color: #eee;
}
.subtreeHIDE{
	display: none;
	margin-left:30px;
}
.subtreeSHOW{
	display: block;
	margin:3px 0 3px 30px;
}
.nodeCmd{
	font-size: 8pt;
	margin-left:38px;
	color:#666;
	font-weight:normal;
}
.nodeDisabled{
	font-size: 11pt;
	cursor:pointer;
	font-style:italic;
	color:#666;
}

#treeview  {
	font-size: 11pt;
	cursor:pointer;
	font-weight:bold;
}

</style>

<script type='text/javascript' src="script/client/EDTreeView/CEDTreeView.js"></script>
<script type='text/javascript' src="script/client/sc520.js"></script>

<%

	SessionManager sMan = new SessionManager(session);
	String msg = "";
	boolean errOccurred=false;
	OrgTree ot = null;

	sMan.setQre(new Questionaire(
		request.getParameter("qre"),
		request.getParameter("qrenm"), null, null));

// Customer / Admin ?
int		usrLvl = sMan.getUserLvl();

// 1. forward customers (in session)
if(usrLvl==2)
{
	%> <jsp:forward page="/index.jsp?pg=-521" /> <%
}
// 2. Admins: ask for customer
else
{
	try
	{	
		Customer customer = new Customer(sMan.getCustID(true));
		customer.loadFromDB(false);
		ot = new OrgTree(customer);
		ot.buildTree(); 
  	}
	catch(Exception e)
	{
  		msg = Err.genericMsg(e);
  		errOccurred=true;
  	}

%>

<h2>Assessments :: Assign Participants</h2>
<hr>
<%if (!errOccurred){%>
<div>&nbsp;</div>
<%}else{%>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<%}%>
<hr>

<% if(!errOccurred){%>
	<div class='sectionBlok'>

	<!-- TREE VIEW -->
	<script type="text/javascript">selectedNodeVal=<%=ot.getNode().getPKID()%></script>

		<div id='treeview'>
			<%=ot.htmlString() %>
		</div>

   <!-- END: TREE VIEW -->
	<hr>
	[
	<a id='collapseLink' style="display:none" href="#" onclick="toggleLink(this); return collapseTree();">Collapse All</a>
	<a id='expandLink' style="display:inline" href="#" onclick="toggleLink(this); return expandTree();">Expand All</a>
	]
	<hr>
	Downlines marked with * are disabled
	</div>
	
	<br>
	<div class='btnBar' style="width:280px;height:50px;">
		<div class='btnBTitle'>Actions <i>[Choose a branch]</i></div>
			<div style="float:left;width:280px;">
				<form action='index.jsp' method='post' style="float:left; margin-right:2px;">
					<input type='submit' class='btn1' value="Assign Assessment" onclick="return setOrgs(0);" />
					<input type='hidden' name='org' id='Org0' />
					<input type='hidden' name='pg' value="-521" />
				</form>
			</div>
		</div>
<%}}%>

<input type="hidden" value="Page=520"/>