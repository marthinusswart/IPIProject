<%@ page language="java" import="beans.SessionManager,beans.extensions.Construct" %>

<style>
    H4{ margin: 0;}
    .sectionBlok	{
        width:620px;
        border: 1px solid #ddd;
        padding: 4px 2px 2px 4px;
    }.sbTitle1{
        border: 1px solid #ddd;
        margin-top:20px;
        width:200px;
        padding: 5px 0 5px 5px;
        background-color: #eee;
    }

    .tbl		{ border-collapse:collapse;padding:0;}

    .field	{ border: 1px solid #000; background-color: #bbb; padding: 3px 0 3px 3px; vertical-align:middle; }
    .field2	{ border: 1px solid #000; background-color: #bbb; padding: 3px 0 3px 3px; vertical-align:top; height:50px;}
    .value	{ border: 1px solid #000; padding: 2px 0 3px 3px; }
    .value2	{ border: 1px solid #000; padding: 2px 0 3px 3px; height:50px;}
    .alR	{ text-align:right; padding-right:15px; }
    .smVal	{ width:56px; }
    .smnote	{ font-size:8pt; font-style:italic; }

    .cols1	{ padding: 0 5px 0 5px;}
    .cellUserPw{ font-family:"Courier New", Courier, monospace;}
    .colUser	{ width:130px;}
    .colName	{ width:155px;}
    .colOrg	{ width:190px;}
    .colStat	{ width:70px;}

    .text { width:465px;}
    .text3 { width:20px;}
    .text2 { width:465px; height:50px;}
    .checkbox {width:10px;}

    /* ieHX */
    * html .colUser	{ width:140px;}
    * html .colName	{ width:170px;}
    * html .colOrg	{ width:205px;}
    * html .colStat	{ width:70px;}

</style>

<%
        SessionManager sMan = new SessionManager(session);

        String msg = "&nbsp;";
        boolean errOccurred = false;
        int userLvl = sMan.getUserLvl();
        String constructId = request.getParameter("c");
        String constructName = request.getParameter("cname");
        Construct construct = new Construct(constructId);
        String superConstructId = request.getParameter("sc");

        try
        {
            construct.loadFromDB();
        }
        catch (Exception ex)
        {
            msg = "Failed to load Construct: " + ex.getMessage();
            errOccurred = true;
        }
%>

<h2>Assessments :: Construct Detail</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<div class='sbTitle1'>
    <h4>Construct Details</h4>
</div>

<%if (!errOccurred)
        {%>
<div class='sectionBlok'>
    <form action='index.jsp' method='post'>
        <table class='tbl' cellpadding="0" cellspacing="0">
            <tr>
                <td class='field'>Construct Name:</td>
                <td class='value'><input id='cname' class='text' type='text' name='cname' value='<%=construct.getName()%>'/></td>
            </tr>
            <tr>
                <td class='field2'>Description:</td>
                <td class='value2'><textarea id='cdescription' class='text2' name='cdescription'><%=construct.getDescription()%></textarea></td>
            </tr>
            <tr>
                <td class='field'>Is Optional:</td>
                <td class='value'><input id='cisoptional' class='checkbox' type='checkbox' name='cisoptional' value='yes' <%=(construct.isOptional()) ? "checked" : ""%>/></td>
            </tr>
            <tr>
                <td class='field'>Is Positive:</td>
                <td class='value'><input id='cispositive' class='checkbox' type='checkbox' name='cispositive' value='yes' <%=(construct.isPositive()) ? "checked" : ""%>/></td>
            </tr>
            <tr>
                <td class='field'>Is Neutral:</td>
                <td class='value'><input id='cisneutral' class='checkbox' type='checkbox' name='cisneutral' value='yes' <%=(construct.isNeutral()) ? "checked" : ""%>/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr>
                    <div style='text-align:right;'>
                        <input type='submit' value=" Update "/>
                    </div>

                    <input type='hidden' name='action' value='update_construct'/>
                    <input type='hidden' name='cid' value='<%=construct.getPKID()%>'/>
                    <input type='hidden' name='pg' value="-603" />
                </td>
            </tr>


            <tr>
                <td><img src="images/spacer.gif" width="140" height="1"></td>
                <td><img src="images/spacer.gif" width="475" height="1"></td>
            </tr>
        </table>
    </form>
</div>
<%}%>
<hr>
