<%@ page language="java" import="beans.*" %>

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
        String questionId = request.getParameter("qid");
        Question question = new Question(questionId);

        try
        {
            question.loadFromDB();
        }
        catch (Exception ex)
        {
            msg = ex.getMessage();
            errOccurred = true;
        }
%>

<h2>Assessments :: Question Detail</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<div class='sbTitle1'>
    <h4>Question Details</h4>
</div>

<%if (!errOccurred)
        {%>
<div class='sectionBlok'>
    <form action='index.jsp' method='post'>
        <table class='tbl' cellpadding="0" cellspacing="0">
            <tr>
                <td class='field2'>Wording:</td>
                <td class='value2'><textarea id='wording' class='text2' name='wording'><%=question.getWording()%></textarea></td>
            </tr>
            <tr>
                <td class='field2'>Alternative Wording:</td>
                <td class='value2'><textarea id='altwording' class='text2' name='altwording'><%=(question.getAltWording() != null) ? question.getAltWording() : ""%></textarea></td>
            </tr>
            <tr>
                <td class='field'>Is Inverted:</td>
                <td class='value'><input type='checkbox' value='yes' name='isinverted' id='isinverted' class='checkbox' <%=(question.isInverted() ? "checked" : "")%>/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr>
                    <div style='text-align:right;'>
                        <input type='submit' value=" Update "/>
                    </div>

                    <input type='hidden' name='action' value='update_question' />
                    <input type='hidden' name='qid' value='<%=question.getPKID()%>'/>
                    <input type='hidden' name='pg' value="-605" />
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
