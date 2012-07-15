<%@ page language="java" import="beans.*" %>

<%
        String msg = "&nbsp;";
        boolean errOccurred = false;
%>

<h2>Individuals :: Search for an Individual</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<style>
    .sectionBlok	{
        width:220px;
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
<script type='text/javascript' src='script/client/sc423.js'></script>

<div align='center'>
    <div align='left'>
        <b>Please supply the search criteria:</b>
        <br/><br />
        <div class='sectionBlok'>
            <table>
                <tr><td>Firstname: </td><td><input type="text" name="firstname" id="firstname"></td></tr>
                <tr><td>Lastname: </td><td><input type="text" name="lastname" id="lastname"></td></tr>
                <tr><td>Username: </td><td><input type="text" name="username" id="username"></td></tr>
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
                    <input type='hidden' name='action' value='search'/>
                    <input type='hidden' name='username' id="usernameOut"/>
                    <input type='hidden' name='firstname' id="firstnameOut">
                    <input type='hidden' name='lastname' id="lastnameOut">
                    <input type='hidden' name='pg' value="-40" />
                </form>
            </div>
        </div>
    </div>
</div>