<%@ page language="java" import="beans.*" %>

<%
        String msg = "&nbsp;";
        boolean errOccurred = false;
%>

<h2>Individuals :: Search for a Skill set</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<style type="text/css">
    .sectionBlok	{
        width:400px;
        border: 1px solid #ddd;
        padding: 4px 6px 2px 4px;
    }
    .cols1	{ padding: 0 5px 0 5px;}
    .colUser	{ width:150px;}
    .colPw	{ width:100px;}
    .cellUserPw{ font-family:"Courier New", Courier, monospace;}
    .colName	{ width:200px;}

    .alRight { text-align:right; padding-right:5px; }

    #tbl_usrTable td{font-size:8pt;}


    FORM{DISPLAY: inline;}

</style>
<script type='text/javascript'>
    function setCriteria()
	{
		var skillsq = document.getElementById("skillsq").value;
		var skillss = document.getElementById("skillss").value;
		var qualifications = document.getElementById("qualifications").value;
		
		document.getElementById("skillsqOut").value = skillsq;
		document.getElementById("skillssOut").value = skillss;
		document.getElementById("qualificationsOut").value = qualifications;
		
		return true;
	}
</script>

<div align='center'>
    <div align='left'>
        <b>Please supply the search criteria:</b>
        <br/><br />
        <div class='sectionBlok'>
            <table>
                <tr><td>Skills Qualifications </td><td><input type="text" name="skillsq" id="skillsq"></td></tr>
                <tr><td>Skills Summary </td><td><input type="text" name="skillss" id="skillss"></td></tr>
                <tr><td>Qualifications </td><td><input type="text" name="qualifications" id="qualifications"></td></tr>
            </table>
            <hr>
            * Not all fields need to be supplied
        </div>
        <br>
        <div class='btnBar' style="width:220px">
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;">
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn1' value="Search" onclick="return setCriteria();"/>
                    <input type='hidden' name='action' value='searchskills'/>
                    <input type='hidden' name='skillsq' id="skillsqOut"/>
                    <input type='hidden' name='skillss' id="skillssOut">
                    <input type='hidden' name='qualifications' id="qualificationsOut">
                    <input type='hidden' name='pg' value="-40" />
                </form>
            </div>
        </div>
    </div>
</div>