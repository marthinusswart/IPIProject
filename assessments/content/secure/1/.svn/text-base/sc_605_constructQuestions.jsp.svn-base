<%@ page language="java" import="beans.SessionManager,beans.Question,beans.extensions.Construct" %>

<style>
    .cols1	{ padding: 0 5px 0 5px;}
    .cols2	{ padding: 0 5px 0 0;}
    .colName	{ width:150px;}
    .colWording { width:300px;}
    .colFlags	{ width:75px;}

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

    .alRight { text-align:right; padding-right:5px; }

    #tbl_qTable td{font-size:8pt;}

</style>
<script type='text/javascript' src='script/client/sc65.js'></script>

<%
        SessionManager sMan = new SessionManager(session);
        int userLevel = sMan.getUserLvl();
        boolean errOccurred = false;
        String msg = "&nbsp;";
        Question[] questions = null;
        String constructId = request.getParameter("c");
        Construct construct = null;

        if (constructId != null)
        {
            sMan.setConstructId(constructId);
        }
        else
        {
            constructId = sMan.getConstructId();
        }

        if (constructId == null)
        {
            errOccurred = true;
            msg = "The construct id is null";
        }
        else if (userLevel != 1)
        {
            errOccurred = true;
            msg = "Need to be Head Office Administrator";
        }
        else
        {
            if ((request.getParameter("action") != null)
                && (request.getParameter("action").equals("update_question")))
            { // First to the update before reloading
                Question question = new Question(request.getParameter("qid"));
                try
                {
                    question.loadFromDB();

                    if ((request.getParameter("isinverted")) != null
                        && (request.getParameter("isinverted").equals("yes")))
                    {
                        question.setIsInverted(true);
                    }
                    else
                    {
                        question.setIsInverted(false);
                    }

                    question.setWording(request.getParameter("wording"));

                    if (!request.getParameter("altwording").equals("n/a"))
                    {
                        question.setAltWording(request.getParameter("altwording"));
                    }

                    question.saveToDB();
                }
                catch (Exception ex)
                {
                    msg = "Failed to update Question. " + ex.getMessage();
                    errOccurred = true;
                }
            }

            if (!errOccurred)
            {
                try
                {
                    questions = Question.getQuestions(constructId);
                    construct =  new Construct(constructId);
                    construct.loadFromDB();
                }
                catch (Exception ex)
                {
                    errOccurred = true;
                    msg = ex.getMessage();
                }
            }
        }

%>

<h2>Construct :: <%=construct.getName()%></h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<%if (!errOccurred)
        {%>

<div align='center'>
    <div align='left'>
        <div class='sbTitle1'>
            <h4>Questions</h4>
        </div>

        <script type="text/javascript">

            var qTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colWording'>Wording</div>",
                "<div class='cols2 colWording'>Alternative Wording</div>",
                "<div class='cols1 colFlags'>Is Inverted</div>"],
            [
            <%
                        int i;
                        if (questions != null && questions.length > 0)
                        {
                            for (i = 0; i < questions.length - 1; i++)
                            {
                                out.println(
                                        "["
                                        + "'" + (i + 1) + ".',"
                                        + "\"" + questions[i].getWording() + "\","
                                        + "\"" + ((questions[i].getAltWording() != null) ? questions[i].getAltWording() : "") + "\","
                                        + "'" + ((questions[i].isInverted()) ? "Yes" : "No") + "'"
                                        + "],");
                            }

                            out.println(
                                    "["
                                    + "'" + (questions.length) + ".',"
                                    + "\"" + questions[i].getWording() + "\","
                                    + "\"" + ((questions[i].getAltWording() != null) ? questions[i].getAltWording() : "") + "\","
                                    + "'" + ((questions[i].isInverted()) ? "Yes" : "No") + "'"
                                    + "]");
                        }
                        else
                        {
                            out.println("['', '', '', '']");
                        }

            %>
                ]
            );

                qTable.draw();
	
            <%
                        // map the SC's to a javascript array [rowid:pkid]
                        if (questions != null && questions.length > 0)
                        {
                            out.print("var qTableMap = [");
                            for (i = 0; i < questions.length - 1; i++)
                            {
                                out.print("[" + (i) + "," + questions[i].getPKID() + "],");
                            }

                            out.print("[" + (questions.length - 1) + "," + questions[questions.length - 1].getPKID() + "]");
                            out.print("];");
                        }
            %>
		
        </script>

        <br>

        <div class='btnBar'>
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;">
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn1' value="Edit" onclick="return setQs(1);" />
                    <input type='hidden' name='qid' id='qid1'/>
                    <input type='hidden' name='pg' value="-606" />
                </form>
            </div>
        </div>
    </div>

    <br>
</div>
<%}%>
