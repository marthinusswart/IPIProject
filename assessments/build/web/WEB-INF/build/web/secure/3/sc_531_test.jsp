<%@ page language="java" import="beans.*" %>
<%

// TEST_STATUS
        final int TS_NOT_STARTED = 0;
        final int TS_IN_PROGRESS = 1;
        final int TS_COMPLETED = 2;
        final int TS_CANCELED = 3;

        int part = 0, parts = 0;
        int status = -1;
        long elapsedTime = 0; // time in milliseconds since last split
        int minsLeft = 0, secsLeft = 0;

        boolean cooldownOK = true;

        SessionManager sMan = new SessionManager(session);
        LiveTest lt = null;

// questionaire
        Questionaire qre = new Questionaire(
                request.getParameter("qre"),
                request.getParameter("qrenm"), null, null);

// assignment
        Assignment assmt = new Assignment();

        assmt.setUserName(sMan.getUserName());
        assmt.setFkQre(request.getParameter("qre"));

        try
        {
            assmt.loadFromDB(true);
            status = Integer.parseInt(assmt.getFkTstStatus());

            // questionaire + assignment -> livetest..
            lt = new LiveTest(assmt, qre);

            part = lt.getSplitSet();
            parts = (lt.getNSplits() + 1);
            if (part > parts)
            {
                part = parts;
            }

            // user returning after split?

            if (part > 1)
            {	// YES:
                elapsedTime = lt.getElapsedTime(); // in millis
                cooldownOK = (elapsedTime / 60000) >= lt.getCoolDownTime(); // in mins
                if (!cooldownOK)
                {
                    minsLeft = (int) (lt.getCoolDownTime() - Math.floor(elapsedTime / 60000)) - 1;
                    secsLeft = (int) (60 - ((elapsedTime / 1000) % 60));
                }
            }

        }
        catch (Exception e)
        {
            Err.printDBErr("An unexpected error occurred: " + e.getMessage(), out, false, true);
        }

%>

<style>
    .field{
        border:			1px solid black;
        background-color:#ccc;
        padding:2px 4px 2px 4px;
        font-weight: bold;
        font-size: 8pt;
    }
    .value{
        border:			1px solid black;
        background-color:#fff;
        padding:2px 4px 2px 4px;
        font-style:italic;
        font-size: 8pt;
    }

    /* IE */
    * html LI LI{list-style-image:none;}

</style>

<h2>Test :: Instructions</h2>
<hr>
<table style='border-collapse:collapse;'>
    <tr>
        <td class='field' colspan="4">Entire Test</td>
        <td>&nbsp;</td>
        <td class='field' colspan="4">This Set</td>
    </tr>
    <tr>
        <td class='field'>Assessment Name:</td>
        <td class='value'><%=lt.getQre().getName()%></td>
        <td class='field'>Questions Remaining:</td>
        <td class='value'><%=lt.getTotQRemaining()%></td>
        <td>&nbsp;</td>
        <td class='field'>Q's Remaining:</td>
        <td class='value'><%=lt.getQRemaining()%></td>
        <td class='field'>Part:</td>
        <td class='value'><%=part%> of <%=parts%></td>
    </tr>
    <tr>
        <td class='field'>Status:</td>
        <td class='value'><%=lt.getAssmt().getTstStatusDesc()%></td>
        <td class='field'>Questions Completed:</td>
        <td class='value'><%=lt.getTotQCompleted()%></td>
        <td>&nbsp;</td>
        <td class='field'>Q's Completed:</td>
        <td class='value'><%=lt.getQCompleted()%></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td class='field'>Total Questions:</td>
        <td class='value'><%=lt.getQre().getTestLength()%></td>
        <td>&nbsp;</td>
        <td class='field'>Set Total:</td>
        <td class='value'><%=lt.getSplitLen()%></td>
        <td></td>
        <td></td>
    </tr>
</table>
<hr>

<%

        switch (status)
        {
            case TS_NOT_STARTED:
            case TS_IN_PROGRESS:
            {

                if (cooldownOK)
                {%>

<div style='color:#215E21'>
    <h3>Please read the following carefully:</h3>

    <style>
        UL OL{list-style: none;}
        UL OL LI{ font-size:8pt; padding:0 0 0 0;margin:2px 0 0 0;}
    </style>

    <ul>
        <li> The test should take approximately <b>45 minutes</b> to complete.</li>
        <li> All questions are <b>multiple-choice</b> (0..7) ranging from <u>never</u> to <u>always</u>; i.e.:
            <ol>
                <li>1: Never</li>
                <li>2: Rarely</li>
                <li>3: Sometimes</li>
                <li>4: Half the time</li>
                <li>5: Often</li>
                <li>6: Mostly</li>
                <li>7: Always</li>
            </ol></li>
        <li> Once you've started, <b>complete the test</b> uninterrupted upto the end.</li>
        <li> <b>Answer <i>all</i> questions</b>.</li>
        <li> Submit a page (roughly 10 questions) at a time. Continue to the next page by clicking <i><b>"NEXT >>"</b></i>
            <br>(NB: you <b>cannot go backward</b>).</li>
        <li> <b>Don't linger</b> on questions. If you take much longer than the allotted time, the test will be cancelled.</li>
        <li> <b>You MUST do the test yourself</b>. Do not allow others to do it on your behalf.</li>
        <li> Don't try to manipulate the outcome...</li>
        <li> Relax and answer truthfully; it is in your best interest.</li>
        <li> Enjoy!</li>
    </ul>
</div>
<hr>
<div style='text-align:right;'>
    <div style='float:right'>
        <form action='index.jsp' method='post'>
            <input type='submit' class='btn1' value=" <%=((status == TS_NOT_STARTED) ? "Start" : "Continue")%> " />
            <input type='hidden' name='pg'	 value="-532" />
        </form>
    </div>
</div>
<%
                    // ..livetest -> session
                    sMan.setLiveTest(lt);
                }
                else
                {
%>
<div style='color:#5E2121'><h3>Minimum Cool-down time not reached</h3>
    You have not allowed for the minimum cool-down time of <b><%=lt.getCoolDownTime()%> minutes</b> to elapse.<br><br>
    <i><b>Cool-down time remaining:</b> <%=minsLeft%> minutes, <%=secsLeft%> seconds.</i>
</div>
<hr>
<div style='text-align:right;'>
    <div style='float:right'>
        <form action='index.jsp' method='post'>
            <input type='submit' class='btn1' value=" Back to Assessments " />
            <input type='hidden' name='pg'		value="-50" />
        </form>
    </div>
</div>			
<%
                }
                break;
            }

            case TS_COMPLETED:
            case TS_CANCELED:
            {%>
<%=((status == TS_COMPLETED)
                               ? "<div style='color:#215E21'><h3>This test has been completed previously.</h3>"
                               : "<div style='color:#5E2121'><h3>This test has been cancelled.</h3>")%>
</div>
<hr>
<div style='text-align:right;'>
    <div style='float:right'>
        <form action='index.jsp' method='post'>
            <input type='submit' class='btn1' value=" Back to Assessments " />
            <input type='hidden' name='pg'		value="-50" />
        </form>
    </div>
</div>

<%
                break;
            }
        }

%>