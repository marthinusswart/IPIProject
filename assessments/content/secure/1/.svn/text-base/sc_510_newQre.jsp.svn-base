<%@ page language="java" import="java.sql.*" %>

<jsp:useBean id="db" class="beans.DBProxy" scope="page" />


<%

	// get the Super_Constructs from the db
	String SQL = 
		"SELECT pkid, code, name " +
		"FROM Super_Construct ORDER BY code";
		
	ResultSet res = db.executeQuery(SQL);	
	
	// load the select object further down ->> 
%>

<h2>Assessments :: New Questionaire</h2>
<hr>
<%	if(request.getParameter("err")!=null)
		out.print("<div style='color:red'>Sorry, but the Questionaire '"+request.getParameter("qname")+"' already exists.</div>");
	else out.println("<div>&nbsp;</div>"); %>
<hr>

<style>
.selBox1{
	width: 300px;
	height: 150px;
}
.selBox2{
	width: 300px;
	height: 50px;
}

.linkBtn1{
	width:100px;
	text-align:center;
	cursor:pointer;
}
</style>

<script type='text/javascript' src='script/client/sc51.js'></script>

<form action='index.jsp' method='post'>
	<p>
	<div>
	<b>Step 1: Assessment Details</b><br><br>
	<table>
		<tr>
			<td>Assessment Name:</td>
			<td><input id='qName' class='txt2' type='text' name='qname' value=''></td>
		</tr>
		<tr>
			<td>Description:</td>
			<td><input id='qDesc' class='txt2' type='text' name='qdesc' value='' /></td>
		</tr>
		<tr>
			<td class='field'>Type:</td>
			<td class='value'>
				<select id='Type' name='type' class='txt2' >
					<option value="1">VA: Values Profile Assessment
					<option value="2">FA: Full Assessment
					<option value="3">JP: Job Definition Profile
					<option value="4">SI: Organization Screening Inventory
					<option value="5">PP: Personal Profile
					<option value="6">HA: Highschool Assessment
					<option value="7">CP: Career Planning Inventory
				</select>
			</td>
		</tr>
	</table>
	</div>
	</p>
	<hr>
	<p>
	<a id='add'></a>
	<b>Step 2: Add Super-Constructs</b><br><br>
	<i style='color:#494'>(CTRL+Click or Drag to select multiple items)</i><br><br>
	<table>
		<tr>
		<td>
			Available:-<br>
   		<select id='box1' class='selBox1' multiple>
   			<% // Load Select with super-constructs
   			
   			try{
					while(res.next()){
						out.println("<option value='"+ // 'pkid:code:name'
							res.getInt("pkid")+":"+res.getString("code")+":"+res.getString("name")+"'>"+ 
							res.getString("code")+". "+res.getString("name"));
					}
				}catch(Exception e){ out.print(e.getMessage());}
				
				%>	

   		</select>
		</td>
		<td style='vertical-align:middle'>
			<a href="#add" onclick='lnAdd_Click()'><div class='linkBtn1'>Add >></div></a><br>
			<a href="#add" onclick='lnRem_Click()'><div class='linkBtn1'><< Remove</div></a>
		</td>
		<td>
			To be included:-<br>
   		<select id='box2' name='selSC' class='selBox1' multiple>
   		</select>
		</td>
		</tr>
	</table>
	</p>
	<hr>
	<br>
	<div style='text-align:right;'>
		<input type='submit' onclick='return btnStep3_Click()' value=" Step 3 >> " />
	</div>
	
	<input type='hidden' name='pg' value="-511" />
</form>

<% db.close(); %>
