<%@ page language="java" import="beans.Customer" %>
<jsp:useBean id="cust" class="beans.Customer" scope="session" />

<%

	cust.setCredits(Integer.parseInt(request.getParameter("credits")));

	String	msg = "&nbsp;";
	boolean	errOccurred=false;
	
	// post-back (OK): update
	if(request.getParameter("ok")!=null){
		try{
			cust.update();
			msg="Update Successful";
		}catch(Exception e){
			msg="Update Failed with: "+e.getMessage();
			errOccurred=true;
		}
	}else{
		cust.setPKID(request.getParameter("org"));
		cust.setName(request.getParameter("orgname"));
	}
	
%>

<script type='text/javascript' src="script/client/sc33.js"></script>
<script type='text/javascript' src="script/client/plusminusCtrl.js"></script>


<h2>Organizations :: Assign Credit</h2>
<hr>
<%=((errOccurred)?"<div class='err'>"+msg+"</div>":"<div class='success'>"+msg+"</div>")%>
<hr>
<b>Assign credit for organization '<div class='success' style='display:inline'><%=cust.getName()%></div>'</b><br>

<style>
	.creditCtrl{
		vertical-align:middle;
	}

	#credits{
		width:40px;
		float:left;
	}
</style>

<br><br>
<form action='index.jsp' method='post'>
	<table>
		<tr>
			<td>Credits: (<a href="#" onclick="credits.value=0;">reset</a>)</td>
			<td align=middle>
				<div class='creditCtrl'>
					<div class='smBtn' onclick="minus(Credits)" style="margin:3px 5px 0 0;"><a href="#">-</a></div>
					<input type='text' id='Credits' name='credits' value='<%=cust.getCredits()%>' disabled />
					<div class='smBtn' onclick="plus(Credits)" style="margin:3px 0 0 5px;"><a href="#">+</a></div>
				</div>
				<script type='text/javascript'>document.getElementById("Credits").disabled = true;</script>
				<br>
				<br>
				<div class='creditCtrl' style="padding-left:8px;">
					<div class='smBtn' onclick="minus(Credits, 100)" style="margin:3px 5px 0 0;"><a href="#">-</a></div>
					<div style="float:left;">100</div>
					<div class='smBtn' onclick="plus(Credits, 100)" style="margin:3px 0 0 5px;"><a href="#">+</a></div>
				</div>
			</td>
		</tr>
	</table>
	<hr>
	<div style='text-align:right;'>
<%	if(request.getParameter("ok")==null) { %>
	<div style='float:right; padding:0 10px 0 10px'>
		<form action='index.jsp' method='post'>
			<input type='submit' class='btn1' value=" OK " onclick="btnOK_Click();" />
			<input type='hidden' name='ok' value="1">
			<input type='hidden' name='pg' value="-33">
		</form>
	</div>
	<div style='float:right'>
		<form action='index.jsp' method='post'>
			<input type='submit' class='btn1' value=" Cancel " />
			<input type='hidden' name='pg' value="-30">
		</form>
	</div>
<% }else { %>
	<div style='float:right'>
		<form action='index.jsp' method='post'>
			<input type='submit' class='btn1' value=" Back " />
			<input type='hidden' name='pg' value="-30">
		</form>
	</div>
<% 
		// destroy everyting
		cust = null;
		session.removeAttribute("cust");
	}
%>
	</div>	
</form>