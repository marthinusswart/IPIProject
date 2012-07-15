<%@ page language="java" import="beans.*" %>

<%

  	String	msg			= "&nbsp;";
  	boolean	errOccurred	= false;
  	
  	OrgTree ot = null;

	// post-back delete?
	if(request.getParameter("delOrgID")!=null)
	{
  		Customer cTmp	= new Customer(request.getParameter("delOrgID"), null, 0);
  		try
		{
  			cTmp.delete();
  			msg = "The Downline was deleted successfully.";
  		}catch(Exception e)
		{
  			msg = "The Downline was NOT deleted due to the following: "+e.getMessage();
  			errOccurred	= true;
  		}
  	}
	else if ((request.getParameter("orgId") != null) && (request.getParameter("confirmation") != null) &&
		(request.getParameter("confirmation").equals("Yes")))
	{ // Going to enable / disable
		Customer customer = new Customer(request.getParameter("orgId"));
		try
		{
			customer.loadFromDB(false);
			if (request.getParameter("isDisabled") != null)
			{
				String isDisabledString = request.getParameter("isDisabled");
				boolean isDisabled = (isDisabledString.equals("true"))?true:false;
				customer.setDisabled(isDisabled);
			
				try
				{
					customer.update();
				}
				catch (Exception ex)
				{
					msg = ex.getMessage();
					errOccurred = true;
				}	
			}
		}
		catch (Exception ex)
		{
			msg = ex.getMessage();
			errOccurred = true;
		}
	}
	
  	try
	{
		
		if(request.getParameter("org")==null)
		{ // non sup-admin customer/user
			Customer cTmp = new Customer((new SessionManager(session)).getCustID(true));
			cTmp.loadFromDB(false);
			
			ot = new OrgTree( cTmp );
			
			cTmp=null;
		}
		else
		{
			ot = new OrgTree( new Customer(
									request.getParameter("org"),
									request.getParameter("orgname"), 
									Integer.parseInt(request.getParameter("credits")),
									request.getParameter("code")));
		}
		
		ot.buildTree();
 
  	}
	catch(Exception e)
	{
  		msg = Err.genericMsg(e);
  		errOccurred=true;
  	}
  	
  	
%>

<script type='text/javascript' src="script/client/sc350.js"></script>
<script type='text/javascript' src="script/client/EDTreeView/CEDTreeView.js"></script>

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

 
<h2>Organizations :: Downlines</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>


<div class='sbTitle1'>
	<h4>Organization Hierarchy</h4>
</div>
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
<div class='btnBar' style="width:380px;height:50px;">
	<div class='btnBTitle'>Actions <i>[Choose a branch]</i></div>
		<div style="float:left;width:380px;">
			<form action='index.jsp' method='post' style="float:left; margin-right:2px;">
				<input type='submit'	class='btn2' value="Delete" onclick="return setOrgs(0);" />
				<input type='hidden' name='delOrgID' id='Org0' />
				<input type='hidden' name='pg' value="-350" 	 />
			</form>
			<form action='index.jsp' method='post' style="float:left; margin-right:2px;">
				<input type='submit' class='btn2' value="More..."  onclick="return setOrgs(1);" />
				<input type='hidden' name='org'	id='Org1' />
				<input type='hidden' name='pg' value="-210" />
			</form>
			<form action='index.jsp' method='post' style="float:left">
				<input type='submit' class='btn1' value="Add Downline" onclick="return setOrgs(2);" />
				<input type='hidden' name='org' id='Org2' />
				<input type='hidden' name='addept' value="1" />
				<input type='hidden' name='pg' value="-310"/>
			</form>
			<form action='index.jsp' method='post' style="float:left;">
				<input type='submit' class='btn1' value="Enable / Disable" onclick="return setOrgs(3);" />
				<input type='hidden' name='org'	id='Org3'/>
				<input type='hidden' name='pg' value="-315" />
				<input type='hidden' name='frompg' value="-350" />
			</form>
		</div>
	</div>
</div>

