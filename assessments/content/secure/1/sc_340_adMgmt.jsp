<%@ page language="java" import="beans.*" %>

<%
	boolean errOccurred = false;
	String msg = "&nbsp;";
	
	Customer cust = null;
	
	Advert [] adverts = null;
	
	// User-Level ??
	SessionManager sMan = new SessionManager(session);
	
	try{
		// .. get the customer code for the current customer
		cust = new Customer(
			(sMan.getUserLvl() == 2)
				?sMan.getCustID(true)			 // <-- org-user (2): load custid
				:request.getParameter("org")); // <-- admin (1): get from request
				
		cust.loadFromDB(false);
		
   	// post-back DELETE ?
   	if(request.getParameter("ad")!=null){
  			(new Advert(Integer.parseInt(request.getParameter("ad")))).delete();
  			msg = "Delete Successful (id:"+cust.getCode()+request.getParameter("ad")+")";
   	}
		
		// .. get all adverts for the current customer
		adverts = Advert.getAdverts(cust.getPKID());
		
	}catch(Exception e) {
		errOccurred = true;
		msg = "There was a problem while performing the operation. The following error was reported: '"+e.getMessage()+"'";
	}
	
	
%>


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

table.org{border-collapse:collapse;}

.cols1	{ padding: 0 5px 0 5px;}
.colRef	{ width:80px}
.colDesc	{ width:280px}
.colDate	{ width:100px}
.alRight { text-align:right; padding-right:5px; }

</style>

<script type='text/javascript' src='script/client/sc340.js'></script>

<h2>Organizations :: Advert Management</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>


<table class='org'>
	<tr>
		<td class='field'>Organization:</td>
		<td class='value'><%=cust.getName()%></td>
	</tr>
	<tr>
		<td class='field'>Organization Code:</td>
		<td class='value'><%=((cust.getCode()==null)?"N/A":cust.getCode())%></td>
	</tr>
</table>

<h5>List of Adverts</h5>

<script type="text/javascript">

	var adTable = new DynamicTable(
		[
		"<div class='cols1'>#</div>",
		"<div class='cols1 colRef'>Advert Ref#</div>",
		"<div class='cols1 colDesc'>Advert Description</div>",
		"<div class='cols1 colDate'>Issue Date</div>",
		"<div class='cols1 alRight'># Responses</div>"
		],
		[
<%	

		int i;
		if(adverts!=null && adverts.length>0){
   		for(i=0; i< adverts.length-1; i++){ 
   			out.println(
   			"["+
   			"'"+(i+1)+".'," +
   			"'"+adverts[i].getReference(cust.getCode())+"'," +
   			"'"+adverts[i].getDescription()+"'," +
   			"'"+adverts[i].getIssueDate()+"'," +
   			"'<div class=\"alRight\">"+adverts[i].getResponses()+"</div>'" +
   			"],"
   			);
   		}
   		out.println(
   			"[" +
   			"'"+(adverts.length)+".'," +
   			"'"+adverts[adverts.length-1].getReference(cust.getCode())+"'," +
   			"'"+adverts[adverts.length-1].getDescription()+"'," +
   			"'"+adverts[adverts.length-1].getIssueDate()+"'," +
   			"'<div class=\"alRight\">"+adverts[adverts.length-1].getResponses()+"</div>'" +
   			"]"
   			);
		}else
			 out.println("['', '', '', '', '']");

%>
		]
	);

	adTable.draw();
	
<%
	// map the Org's to an javascript array [rowid:pkid]
		if(adverts!=null && adverts.length > 0){
			out.print("var adTableMap = [");
			for(i=0; i< adverts.length-1; i++)
				out.print("["+(i)+","+adverts[i].getPKID()+"],");
			out.print("["+(adverts.length-1)+","+adverts[adverts.length-1].getPKID()+"]");
			out.print("];");
		}
%>
	
</script>

<br>
<div class='btnBar' style="width:129px;">
	<div class='btnBTitle'>Actions</div>
		<div style="float:left;">
			<form action='index.jsp' method='post' style="float:left">
				<input type='submit'	class='btn2' 	value="Delete" onclick="return setAd();" />
				<input type='hidden' name='org'		value="<%=cust.getPKID()%>" />
				<input type='hidden' name='ad'		id='Ad'	/>
				<input type='hidden' name='pg'		value="-340" />
			</form>
			<!--
			<form action='index.jsp' method='post' style="float:left">
				<input type='submit' class='btn2'	value="More..." disabled />
				<input type='hidden' name='pg'		value="" />
			</form>
			-->
			<form action='index.jsp' method='post' style="float:left">
				<input type='submit' class='btn2'	value="New Ad"	/>
				<input type='hidden' name='org'		value="<%=cust.getPKID()%>" />
				<input type='hidden' name='orgname'	value="<%=cust.getName()%>" />
				<input type='hidden' name='pg'		value="-341"/>
			</form>
		</div>
</div>