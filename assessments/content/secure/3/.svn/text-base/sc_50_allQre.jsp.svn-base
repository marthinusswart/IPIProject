<%@ page language="java" import="beans.*" %>

<%

        SessionManager sMan = new SessionManager(session);

        int userLevel = sMan.getUserLvl();


        Questionaire[] gaQre = null;					// array of questionaires (from db)
        Questionaire gQre;								// used for deleting & messages
        int nQre;								// number of questionaires in db
        String SQL;


        // (1.) if this was posted back to self (delete operation)..
        // ..error messages
        String msg = "&nbsp;";
        boolean errOccurred = false;

        if (userLevel == 1)
        {	// only Admins can Delete Qre's
            // ..try to delete the questionaire "qre"
            if (request.getParameter("qre") != null)
            {
                gQre = new Questionaire(request.getParameter("qre"), request.getParameter("qrenm"), null, null);
                try
                {
                    gQre.delete();
                    msg = "Questionaire \"" + gQre.getName() + "\" was deleted successfully.";
                }
                catch (Exception e)
                {
                    errOccurred = true;
                    msg = "Questionaire \"" + gQre.getName() + "\" could NOT be deleted due to the following - " + e.getMessage();
                }
            }
        }
        else if (userLevel > 2)
        { // ensure no active tests for lost users
            sMan.setLiveTest(null);
        }


        // (2.) get all the questionaires..
        try
        {
            gaQre = Questionaire.getQres(sMan);
        }
        catch (Exception e)
        {
            Err.printDBErr(e.getMessage(), out, false, true);
        }

%>

<h2>Assessments :: List of Questionaires</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<style>
    .cols1	{ padding: 0 5px 0 5px;}
    .cols2	{ padding: 0 5px 0 0;}
    .colName	{ width:150px;}
    .colDesc	{ width:300px;}
    .colType	{ width:25px;}
    .colWord	{ width:55px;}
    .colAss 	{ width:60px;}
    .colComp	{ width:60px;}

    .alRight { text-align:right; padding-right:5px; }

    #tbl_qTable td{font-size:8pt;}

</style>
<script type='text/javascript' src='script/client/sc50.js'></script>

<div align='center'>
    <div align='left'>
        The following Questionaires are available:<br /><br />


        <script type="text/javascript">

            var qTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colName'>Name</div>",
                "<div class='cols1 colDesc'>Description</div>",
                "<div class='cols2 colType'>Type</div>",
                "<div class='cols1 colWord'>Word Set</div>",
                "<div class='cols1 colAss'># assigned</div>",
                "<div class='cols1 colComp'># completed</div>"],
            [
            <%

                    int i;
                    if (gaQre != null && gaQre.length > 0)
                    {
                        for (i = 0; i < gaQre.length - 1; i++)
                        {
                            out.println(
                                    "["
                                    + "'" + (i + 1) + ".',"
                                    + "'" + gaQre[i].getName() + "',"
                                    + "'" + gaQre[i].getDesc() + "',"
                                    + "'" + gaQre[i].getType().getCode() + "',"
                                    + "'" + ((gaQre[i].getWording().equals("0")) ? "(1) Indiv" : "(2) Org") + "',"
                                    + "'<div class=\"alRight\">" + gaQre[i].getAssCount() + "</div>',"
                                    + "'<div class=\"alRight\">" + gaQre[i].getComplCount() + "</div>',"
                                    + "],");
                        }
                        out.println(
                                "["
                                + "'" + (gaQre.length) + ".',"
                                + "'" + gaQre[gaQre.length - 1].getName() + "',"
                                + "'" + gaQre[gaQre.length - 1].getDesc() + "',"
                                + "'" + gaQre[gaQre.length - 1].getType().getCode() + "',"
                                + "'" + ((gaQre[gaQre.length - 1].getWording().equals("0")) ? "(1) Indiv" : "(2) Org") + "',"
                                + "'<div class=\"alRight\">" + gaQre[gaQre.length - 1].getAssCount() + "</div>',"
                                + "'<div class=\"alRight\">" + gaQre[gaQre.length - 1].getComplCount() + "</div>',"
                                + "]");
                    }
                    else
                    {
                        out.println("['', '', '', '', '', '']");
                    }

            %>
                ]
            );

                qTable.draw();
	
            <%		// map the Qre's to an javascript array [rowid:pkid]
                    if (gaQre != null && gaQre.length > 0)
                    {
                        out.print("var qTableMap = [");
                        for (i = 0; i < gaQre.length - 1; i++)
                        {
                            out.print("[" + (i) + "," + gaQre[i].getPKID() + "],");
                        }
                        out.print("[" + (gaQre.length - 1) + "," + gaQre[gaQre.length - 1].getPKID() + "]");
                        out.print("];");
                    }
            %>
		
        </script>

        <br>

        <div class='btnBar'>
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;">
                <% if (userLevel == 1)
                        {	// only Admins can Delete Qre's
                %>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2'	value="Delete" onclick="return setQREs();" />
                    <input type='hidden' name='qre'		id='Qre'/>
                    <input type='hidden' name='qrenm'	id='QreName'/>
                    <input type='hidden' name='pg'		value="-50" />
                </form>
                <% }
                        if (userLevel == 1 || userLevel == 2)
                        {
                %>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2'	value="More..." onclick="return setQREs(1);" />
                    <input type='hidden' name='qre'		id='Qre1'/>
                    <input type='hidden' name='qrenm'	id='QreName1'/>
                    <input type='hidden' name='pg'		value="-502" />
                </form>
                <form action='index.jsp' method='post' style="float:left">
                    <input type='submit' class='btn2'	value="Report..." disabled />
                    <!--<input type='hidden' name='pg' value="" /> -->
                </form>
                <% }%>
            </div>
            <div class='rButtons' style="width:120px">
                <% if (userLevel == 1 || userLevel == 2)
                        {%>
                <form action='index.jsp' method='post' style="float:right">
                    <input type='submit' class='btn1' value="Assign Participants" onclick="return setQREs(2);" />
                    <input type='hidden' name='qre'	id='Qre2'/>
                    <input type='hidden' name='qrenm' id='QreName2'/>
                    <input type='hidden' name='pg' value="-520" />
                </form>
                <%}
                 else if (userLevel == 3)
                 {%>
                <form action='index.jsp' method='post' style="float:right">
                    <input type='submit' value="Complete the Profile >>" onclick="return setQREs(3);" />
                    <input type='hidden' name='qre'		id='Qre3'/>
                    <input type='hidden' name='qrenm'	id='QreName3'/>
                    <input type='hidden' name='pg'		value="-530" />
                </form>
                <% }%>
            </div>
        </div>

        <br>
    </div>
</div>
