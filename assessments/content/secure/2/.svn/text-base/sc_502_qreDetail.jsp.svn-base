<%@ page language="java" import="beans.extensions.*,beans.SessionManager,beans.Questionaire,beans.User,beans.QreType,beans.Err" %>

<%

        SessionManager sMan = new SessionManager(session);

        String msg = "&nbsp;";
        boolean errOccurred = false;
        boolean is1stVisit = (request.getParameter("qname") == null);
        int userLvl = sMan.getUserLvl();
        boolean canUpdate = userLvl == 1;

        Questionaire qre = (is1stVisit) ? new Questionaire(request.getParameter("qre")) : sMan.getQre();
        String qreId = request.getParameter("qre");
        String action = request.getParameter("action");

        User[] gaUsers = null;

        try
        {
            if (action != null)
            {
                if (action.equals("removesuperconstruct"))
                {
                    // We will now remove the selected super construct from the questionnaire
                    String scId = request.getParameter("sc");
                    Questionaire.removeSuperConstruct(scId, qreId);
                }
                else if (action.equals("addsuperconstruct"))
                {
                    // We will now remove the selected super construct from the questionnaire
                    String scId = request.getParameter("sc");
                    Questionaire.addSuperConstruct(scId, qreId);
                }
                else if (action.equals("excludeconstruct"))
                {
                    String constructId = request.getParameter("c");
                    Construct.excludeConstruct(qreId, constructId);
                }
                else if (action.equals("includeconstruct"))
                {
                    String constructId = request.getParameter("c");
                    Construct.includeConstruct(qreId, constructId);
                }
            }

            // first visit?
            if (is1stVisit)
            {			// YES: load
                qre.loadFromDB((userLvl == 1) ? null : sMan.getCustID(true), true);
                sMan.setQre(qre);

            }
            else if (canUpdate)
            {						// NO: post-back update

                qre.setName(request.getParameter("qname"));
                qre.setDesc(request.getParameter("qdesc"));
                qre.setWording(request.getParameter("radWording"));
                // type
                int type = Integer.parseInt(request.getParameter("type"));
                switch (type)
                {
                    case 0:
                        qre.setType(new QreType(0, "??", "??"));
                        break;
                    case 1:
                        qre.setType(new QreType(1, "VA", "Values Profile Assessment"));
                        break;
                    case 2:
                        qre.setType(new QreType(2, "FA", "Full Assessment"));
                        break;
                    case 3:
                        qre.setType(new QreType(3, "JP", "Job Definition Profile"));
                        break;
                    case 4:
                        qre.setType(new QreType(4, "SI", "Organization Screening Inventory"));
                        break;
                    case 5:
                        qre.setType(new QreType(5, "PP", "Personal Profile"));
                        break;
                    case 6:
                        qre.setType(new QreType(6, "HA", "Highschool Assessment"));
                        break;
                    case 7:
                        qre.setType(new QreType(7, "CP", "Career Planning Inventory"));
                        break;
                }

                qre.update();
                msg = "Questionaire updated successfully";
            }
            else
            {
                errOccurred = true;
                msg = "Unknown operation";
            }

            gaUsers = qre.getUsers();

        }
        catch (Exception e)
        {
            msg = Err.genericMsg(e);
            errOccurred = true;
        }


%>

<style>
    H4{ margin: 0;}
    .sectionBlok	{
        width:700px;
        border: 1px solid #ddd;
        padding: 4px 2px 2px 4px;
    }.sbTitle1{
        border: 1px solid #ddd;
        margin-top:20px;
        width:150px;
        padding: 5px 0 5px 5px;
        background-color: #eee;
    }

    .tbl		{ border-collapse:collapse;padding:0;}

    .field	{ border: 1px solid #000; background-color: #bbb; padding: 3px 0 3px 3px; vertical-align:middle; }
    .field2	{ border: 1px solid #000; background-color: #ddd; padding: 3px 0 3px 3px; vertical-align:middle; }
    .value	{ border: 1px solid #000; padding: 2px 0 3px 3px; }
    .alR	{ text-align:right; padding-right:15px; }
    .smVal	{ width:56px; }
    .smnote	{ font-size:8pt; font-style:italic; }

    .cols1	{ padding: 0 5px 0 5px;}
    .cellUserPw{ font-family:"Courier New", Courier, monospace;}
    .colUser	{ width:130px;}
    .colName	{ width:155px;}
    .colOrg	{ width:190px;}
    .colStat	{ width:70px;}
    .txt4 {width:99%;}

    #tbl_usrTable td{font-size:8pt;}

    /* ieHX */
    * html .colUser	{ width:140px;}
    * html .colName	{ width:170px;}
    * html .colOrg		{ width:205px;}
    * html .colStat	{ width:70px;}
    .btn3{width:150px;font-size:8pt;}

</style>

<h2>Assessments :: Questionaire Detail</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<% if (!errOccurred)
        {%>

<div class='sbTitle1'>
    <h4>Assessment Details</h4>
</div>
<div class='sectionBlok'>
    <form action='index.jsp' method='post'>
        <table class='tbl' cellpadding="0" cellspacing="0">
            <tr>
                <td class='field'>Assessment Name:</td>
                <td class='value'><input id='qName' class='txt4' type='text' name='qname' value='<%=qre.getName()%>'<%=((canUpdate) ? "" : " disabled")%> /></td>
            </tr>
            <tr>
                <td class='field'>Description:</td>
                <td class='value'><input id='qDesc' class='txt4' type='text' name='qdesc' value='<%=qre.getDesc()%>'<%=((canUpdate) ? "" : " disabled")%> /></td>
            </tr>
            <tr>
                <td class='field'>Type:</td>
                <td class='value'>
                    <select id='Type' name='type' class='txt4'<%=((canUpdate) ? "" : " disabled")%> >
                        <%
                             out.println("<option value='" + qre.getType().getPKID() + "'>" + qre.getType().getCode() + ": " + qre.getType().getName());
                             if (canUpdate)
                             {%>
                        <option value="1">VA: Values Profile Assessment
                        <option value="2">FA: Full Assessment
                        <option value="3">JP: Job Definition Profile
                        <option value="4">SI: Organization Screening Inventory
                        <option value="5">PP: Personal Profile
                        <option value="6">HA: Highschool Assessment
                        <option value="7">CP: Career Planning Inventory
                            <% }%>
                    </select>
                </td>
            </tr>
            <tr>
                <td class='field'>Wording Set:</td>
                <td class='value'>
                    <%
                         int w = Integer.parseInt(qre.getWording());
                         out.println("<input type='radio' name='radWording' value='0'" + ((w == 0) ? "checked" : "") + ((canUpdate) ? "" : " disabled") + "> 1. Wording Set 1 (individual)<br>");
                         out.println("<input type='radio' name='radWording' value='1'" + ((w == 1) ? "checked" : "") + ((canUpdate) ? "" : " disabled") + "> 2. Wording Set 2 (organizational)");
                    %>
                </td>
            </tr>

            <%		if (canUpdate)
                 {%>
            <tr>
                <td colspan="2">
                    <hr>
                    <br>
                    <div style='text-align:right;'>
                        <input type='submit' value=" Update " onclick="if(document.getElementById('qName').value!=''){ return true;}else{alert('Please provide a Questionaire name');return false;}" />
                    </div>

                    <input type='hidden' name='pg' value="-502" />
                </td>
            </tr>
            <%		}%>

            <tr>
                <td><img src="images/spacer.gif" width="140" height="1"></td>
                <td><img src="images/spacer.gif" width="475" height="1"></td>
            </tr>
        </table>
    </form>
</div>

<div class='sbTitle1'>
    <h4><%=((userLvl == 1) ? "Constructs" : "Questions")%></h4>
</div>
<div class='sectionBlok'>
    <table class='tbl' cellpadding="0" cellspacing="0">
        <tr>
            <td class='field'>Total Questions:</td>
            <td class='value' style="text-align:right; padding-right:10px"><%=qre.getTestLength()%></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <%
             if (userLvl == 1)
             {%>

        <tr>
            <td class='field' colspan="2">Super Constructs</td>
            <td></td>
            <td class='field' colspan="2">Excluded Constructs</td>
        </tr>
        <tr>
            <td class='value' colspan="2">
                <%
                                    String[][] matrix = qre.getSCs();
                                    if (matrix != null && matrix.length > 0)
                                    {
                                        for (int i = 0; i < matrix.length; i++)
                                        {
                                            out.println(matrix[i][1] + ".) " + matrix[i][2] + "<br>");
                                        }
                                    }
                %>
            </td>
            <td></td>
            <td class='value' colspan="2">
                <%
                                    matrix = qre.getOptCs();
                                    if (matrix != null && matrix.length > 0)
                                    {
                                        for (int i = 0; i < matrix.length; i++)
                                        {
                                            out.println(matrix[i][0] + ".) " + matrix[i][1] + "<br>");
                                        }
                                    }
                %>
            </td>
        </tr>
        <% }%>
        <tr>
            <td><img src="images/spacer.gif" width="140" height="1" alt=""></td>
            <td><img src="images/spacer.gif" width="160" height="1" alt=""></td>
            <td><img src="images/spacer.gif" width="15" height="1" alt=""></td>
            <td><img src="images/spacer.gif" width="140" height="1" alt=""></td>
            <td><img src="images/spacer.gif" width="160" height="1" alt=""></td>
        </tr>
    </table>
    <div>
        <table class='tbl' cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <form action='index.jsp' method='post'>
                        <input type='submit' class='btn3' value="Remove Super Construct" />
                        <input type='hidden' name='qreId' value='<%=qreId%>'/>
                        <input type='hidden' name='pg' value="-610"/>
                    </form>
                </td>
                <td>
                    <form action='index.jsp' method='post'>
                        <input type='submit' class='btn3' value="Add Super Construct" />
                        <input type='hidden' name='qreId' value='<%=qreId%>'/>
                        <input type='hidden' name='pg' value="-611"/>
                    </form>
                </td>

                <td><img src="images/spacer.gif" width="15" height="1" alt=""></td>

                <td>
                    <form action='index.jsp' method='post'>
                        <input type='submit' class='btn3' value="Exclude Construct" />
                        <input type='hidden' name='qreId' value='<%=qreId%>'/>
                        <input type='hidden' name='pg' value="-612"/>
                    </form>
                </td>
                <td>
                    <form action='index.jsp' method='post'>
                        <input type='submit' class='btn3' value="Include Construct" />
                        <input type='hidden' name='qreId' value='<%=qreId%>'/>
                        <input type='hidden' name='pg' value="-613"/>
                    </form>
                </td>
            </tr>
        </table>

    </div>
</div>

<div class='sbTitle1'>
    <h4>Assignments</h4>
</div>
<div class='sectionBlok'>
    <table class='tbl' cellpadding="0" cellspacing="0">
        <tr>
            <td class='field'># Participants Assigned:</td>
            <td class='value alR'><%=qre.getAssCount()%></td>
            <td></td>
            <td class='field' colspan="2">Status Counts</td>
        </tr>
        <tr>
            <td colspan="3"></td>
            <td colspan="2" class='value' style="padding:0; margin:0">
                <table class='tbl' cellspacing="0" cellpadding="0">
                    <tr>
                        <td class='field2' style="border-top:0; border-left:0;">Not Started</td>
                        <td class='field2' style="border-top:0">In Progress</td>
                        <td class='field2' style="border-top:0">Completed</td>
                        <td class='field2' style="border-top:0; border-right:0">Canceled</td>
                    </tr>
                    <tr>
                        <td class='value alR' style="border-left:0"><div class='smVal'><%=qre.getStatCount(0)%></div></td>
                        <td class='value alR'><div class='smVal'><%=qre.getStatCount(1)%></div></td>
                        <td class='value alR'><div class='smVal'><%=qre.getStatCount(2)%></div></td>
                        <td class='value alR' style="border-right:0"><div class='smVal'><%=qre.getStatCount(3)%></div></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="5"></td>
        </tr>
        <tr>
            <td class='field' colspan="5">Participants</td>
        </tr>
        <tr>
            <td class='value' colspan="5">

                <script type="text/javascript">
         
                    var usrTable = new DynamicTable(
                    [
                        "<div class='cols1'>#</div>",
                        "<div class='cols1 colUser'>UserName</div>",
                        "<div class='cols1 colName'>Name</div>",
                        "<div class='cols1 colOrg'>Organization</div>",
                        "<div class='cols1 colStat'>Status</div>"
                    ],
                    [
                    <%
                         // note: website reuse hack (test_status)
                         int i;
                         if (gaUsers != null && gaUsers.length > 0)
                         {
                             for (i = 0; i < gaUsers.length; i++)
                             {
                                 if (gaUsers[i] == null)
                                 {
                                     break;
                                 }
                                 out.println(
                                         "["
                                         + "'" + (i + 1) + ".',"
                                         + "'<div class=\"cellUserPw\">" + gaUsers[i].getUserName() + "</div>',"
                                         + "'" + gaUsers[i].getFullName() + "',"
                                         + "'" + gaUsers[i].getCustName() + "',"
                                         + "'" + Questionaire.getStatString(gaUsers[i].getWebsite()) + "'"
                                         + "]" + ((i < gaUsers.length - 1) ? "," : ""));
                             }
                         }
                         else
                         {
                             out.println("['', '', '', '', '']");
                         }

                    %>
                        ]
                    );
         
                        usrTable.draw();
         	
                </script>

            </td>
        </tr>
        <tr>
            <td><img src="images/spacer.gif" width="140" height="1" alt=""></td>
            <td><img src="images/spacer.gif" width="160" height="1" alt=""></td>
            <td><img src="images/spacer.gif" width="15" height="1" alt=""></td>
            <td><img src="images/spacer.gif" width="140" height="1" alt=""></td>
            <td><img src="images/spacer.gif" width="160" height="1" alt=""></td>
        </tr>
    </table>
</div>
<%}%>
<hr>
