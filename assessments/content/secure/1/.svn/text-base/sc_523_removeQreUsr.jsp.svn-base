<%@ page language="java" import="beans.*" %>
<%

        String msg = "&nbsp;";
        boolean errOccurred = false;

        SessionManager sMan = new SessionManager(session);
        int userLevel = sMan.getUserLvl();

        String assessmentId = request.getParameter("qre");
        User[] gaUsers = null;			// array of users for a particular org/dept
        Customer[] gaOrgs = null;			// array of departments for an organization (org-admin)

        try
        {
            // get the users for given assessment
            gaUsers = User.getUsersByAssessmentId(assessmentId, true);

            // get the customers for a given assessment
            gaOrgs = Customer.getDownlinesByAssessmentId(assessmentId);

        }
        catch (Exception e)
        {
            msg = Err.genericMsg(e);
            errOccurred = true;
        }


%>

<style type="text/css">
    .cols1	{ padding: 0 5px 0 5px;}
    .colUser	{ width:150px;}
    .colName	{ width:200px;}

    .alRight { text-align:right; padding-right:5px; }

    #tbl_usrTable td{font-size:8pt;}
    #tbl_deptTable td{font-size:8pt;}


    FORM{DISPLAY: inline;}

</style>

<script type='text/javascript'>
    var usrTable=false;
    var deptTable=false;

    function rad1_Click(elem)
    {

        switch(elem.value)
        {            
            case 'downlines': // show Org-user
                document.getElementById("option1").style.display = "block";
                document.getElementById("option2").style.display = "none";
                break;
            case 'individuals': // Show Individuals
                document.getElementById("option2").style.display = "block";
                document.getElementById("option1").style.display = "none";
                break;
        }
    }

    function getSelectedUser(index)
    {
        var userId = useridMap[usrTable.m_selectedRows[index]][1];
        return userId;
    }

    function getSelectedDept()
    {
        return deptidMap[deptTable.m_selectedRows[0]][1];
    }

    function btnStep2_Click(){
        var radioSelect = document.getElementById("rad1").checked;

        if (radioSelect)
        { // Downlines
            if(!deptTable) return false;
            if(deptTable.m_selectedRows.length == 0)
            {
                alert("Please select a Downline");
                return false;
            }
            else
            {
                // add selected users to form
                var hElem;
                var frm	= document.getElementById("mainForm");

                // create hidden input
                hElem = document.createElement("INPUT");
                hElem.type	= "hidden";
                hElem.name	= "downline";
                hElem.value	= getSelectedDept();
                // add to main form
                frm.appendChild(hElem);
            }
        }
        else
        { // Individuals
            if(!usrTable) return false;
            if(usrTable.m_selectedRows.length == 0)
            {
                alert("Please select one or more Individuals");
                return false;
            }
            else
            {
                // add selected users to form
                var hElem;
                var frm	= document.getElementById("mainForm");

                for (var i=0; i<usrTable.m_selectedRows.length; i++)
                {
                    // create hidden input
                    hElem = document.createElement("INPUT");
                    hElem.type	= "hidden";
                    hElem.name	= "users";
                    hElem.value	= getSelectedUser(i);
                    // add to main form
                    frm.appendChild(hElem);
                }
            }
        }        

        return true;
    }
</script>


<h2>Assessments :: Remove Participants</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div>" + msg + "</div>")%>
<hr>

<b>Remove Questionaire from:-</b><br><br>

<%

        switch (userLevel)
        {

            case 1:
            {	// (1) Administrator: choose Org / Users
%>

<div style="border:1px solid black; background-color:#CCC; width:250px">
    <input name='group1' id="rad1" type='radio' value='downlines' onclick="rad1_Click(this)" checked/> Downlines<br>
    <input name='group1' id="rad2" type='radio' value='individuals' onclick="rad1_Click(this)" /> Individuals
    <input id='usrType' type='hidden' value='1' />
</div>
<hr>
<div id='option1' style="display:block;">
    <div align='left'>
        <b>Choose a Downline:</b><br /><br />

        <%
                        if (gaOrgs != null && gaOrgs.length > 0)
                        {%>

        <script type="text/javascript">

            deptTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colName'>Downline Name</div>"
            ],
            [
            <%
                                        for (int i = 0; i < gaOrgs.length; i++)
                                        {
                                            out.println(
                                                    "["
                                                    + "'" + (i + 1) + ".',"
                                                    + "'" + gaOrgs[i].getName() + "'"
                                                    + "]" + ((i < gaOrgs.length - 1) ? "," : ""));
                                        }
            %>
                ]
            );

                deptTable.draw();



            <%

                                        // output deptid's to client array
                                        out.print("var deptidMap = [");
                                        for (int i = 0; i < gaOrgs.length; i++)
                                        {
                                            out.print("[" + i + "," + gaOrgs[i].getPKID() + "]" + ((i < gaOrgs.length - 1) ? "," : ""));
                                        }
                                        out.print("];");

            %>

        </script>

        <%
                        }
                        else
                            out.println("<b><i style='color:red'>No Downline found.</i></b>");%>

    </div>
</div>
<%
                break;
            }

            case 2:
            {		// (2) Org-admin: choose Dept / Users
%>

<div style="border:1px solid black; background-color:#CCC; width:250px">
    <input name='rad1' type='radio' value='0' onclick="rad1_Click(this)" /> My Downlines<br>
    <input name='rad1' type='radio' value='1' onclick="rad1_Click(this)" checked /> My Candidates
    <input id='usrType' type='hidden' value='2' />
</div>
<hr>
<div id='option1' style="display:none;">
    <i>The Downlines' administrator users will be able to:
        <ul>
            <li>re-assign the questionaire to their downline administrators (requires no credit);
            <li>re-assign the questionaire to their candidates (requires 1 credit per assignment);
        </ul>
    </i>
    <hr>
    <div align='left'>
        <b>Choose a Downline:</b><br /><br />

        <%
                        if (gaOrgs != null && gaOrgs.length > 0)
                        {%>

        <script type="text/javascript">
      
            deptTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colName'>Dept. Name</div>",
                "<div class='cols1'>Code</div>",
                "<div class='cols1'>Credit</div>"
            ],
            [
            <%
                                        for (int i = 0; i < gaOrgs.length; i++)
                                        {
                                            out.println(
                                                    "["
                                                    + "'" + (i + 1) + ".',"
                                                    + "'" + gaOrgs[i].getName() + "',"
                                                    + "'" + gaOrgs[i].getCode() + "',"
                                                    + "'" + gaOrgs[i].getCredits() + "'"
                                                    + "]" + ((i < gaOrgs.length - 1) ? "," : ""));
                                        }
            %>
                ]
            );
      	
                deptTable.draw();
      	
      
      
            <%

                                        // output deptid's to client array
                                        out.print("var deptidMap = [");
                                        for (int i = 0; i < gaOrgs.length; i++)
                                        {
                                            out.print("[" + i + "," + gaOrgs[i].getPKID() + "]" + ((i < gaOrgs.length - 1) ? "," : ""));
                                        }
                                        out.print("];");

            %>
		
        </script>

        <%
                        }
                        else
                            out.println("<b><i style='color:red'>No Downline found.</i></b>");%>

    </div>
</div>
<%
                break;
            }

        }%>

<% if (userLevel == 2)
        {%>
<div id='option2' style="display:block;">
    <%}
     else
     {%>
    <div id='option2' style="display:none;">
        <%}%>
        <div align='left'>
            <b>Choose Individual(s):</b><br /><br />

            <%
                    if (gaUsers != null && gaUsers.length > 0)
                    {%>

            <script type="text/javascript">

                usrTable = new DynamicTable(
                [
                    "<div class='cols1'>#</div>",
                    "<div class='cols1 colUser'>UserName</div>",
                    "<div class='cols1 colName'>Name</div>",
                    "<div class='cols1 colName'>Organization</div>"
                ],
                [
                <%
                                        for (int i = 0; i < gaUsers.length; i++)
                                        {
                                            out.println(
                                                    "["
                                                    + "'" + (i + 1) + ".',"
                                                    + "'" + gaUsers[i].getUserName() + "',"
                                                    + "'"
                                                    + ((gaUsers[i].getTitle() != null && !gaUsers[i].getTitle().equals(""))
                                                       ? gaUsers[i].getTitle() + " "
                                                       : "")
                                                    + gaUsers[i].getFirstName() + " "
                                                    + ((gaUsers[i].getInitial() != null && !gaUsers[i].getInitial().equals(""))
                                                       ? gaUsers[i].getInitial() + " "
                                                       : "")
                                                    + gaUsers[i].getLastName() + "',"
                                                    + "'" + gaUsers[i].getCustName() + "'"
                                                    + "]" + ((i < gaUsers.length - 1) ? "," : ""));
                                        }
                %>
                    ]
                );
	
                    usrTable.m_isMultiSelect = true;
                    usrTable.m_fnClickHandler = usrTable._getClickHandler(usrTable.m_isMultiSelect);
                    usrTable.draw();
                <%
                                            out.print("var useridMap = [");
                                            for (int i = 0; i < gaUsers.length; i++)
                                            {
                                                out.print("[" + i + "," + gaUsers[i].getPKID() + "]" + ((i < gaUsers.length - 1) ? "," : ""));
                                            }
                                            out.print("];");
                %>
            </script>

            <% }
                    else
                        out.println("<b><i style='color:red'>No users found.</i></b>");%>

        </div>
        <br>
        <div class='btnBar' style="width:200px">
            <div class='btnBTitle'>Actions</div>
            <div style="float:left;">
                <input type='submit'	class='btn2' 	value="Select All" onclick="return btnAll_Click();" />
                <input type='submit' class='btn2'	value="Reset"		 onclick="usrTable.deselectAllRows(); return false;" />
            </div>
        </div>

    </div>

    <hr>

    <br>
    <form action="index.jsp" method='post' id='mainForm'>
        <div style='text-align:right;'>
            <input type='submit' onclick="return btnStep2_Click();" value=" Finish " />
        </div>
        <input type='hidden' name='pg' value="-50" />
        <input type='hidden' name='assessmentid' value='<%=assessmentId%>'/>
        <input type='hidden' name='action' value="remove" />
    </form>
    <br>

    <input type="hidden" value="Page=521"/>