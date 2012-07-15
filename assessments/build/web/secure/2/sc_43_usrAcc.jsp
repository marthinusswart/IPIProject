<%@ page language="java" import="beans.*" %>

<style>
    H4{ margin: 0;}
    .sectionBlok	{
        width:950px;
        border: 1px solid #ddd;
        padding: 4px 6px 2px 4px;
    }.sbTitle1{
        border: 1px solid #ddd;
        margin-top:20px;
        width:150px;
        padding: 5px 0 5px 5px;
        background-color: #eee;
    }

    .tbl		{ border-collapse:collapse;padding:0;}

    .infobox{
        padding: 2px 0 2px 4px;
        width:338px;
        background-color:#DDD;
        border:1px solid #777;
        font-size: 8pt;
        font-style:italic;
        margin-bottom:4px;
    }

    .btnPW1	{ width:140px; margin-left:3px }
    .btnPW2	{ width:115px; margin-left:3px }

    .field	{ border: 1px solid #000; background-color: #bbb; padding: 3px 0 3px 3px; vertical-align:middle; }
    .field2	{ border: 1px solid #000; background-color: #ddd; padding: 3px 0 3px 3px; vertical-align:middle; }
    .value	{ border: 1px solid #000; padding: 2px 2px 3px 3px; }
    .alR		{ text-align:right; padding-right:15px; }
    .smVal	{ width:56px; }
    .smVal2_1{ width:65px; }
    .smVal2_2{ width:65px; }
    .smVal2_3{ width:65px; }
    .smVal2_4{ width:65px; }
    .smVal2_5{ width:65px; }
    .smVal2_6{ width:65px; }
    .smVal2_7{ width:65px; }
    .smnote	{ font-size:8pt; font-style:italic; }
    .txt_1	{width:153px;}

    .cols1	{ padding: 0 5px 0 3px;}
    .colName	{ width:185px;}
    .colDesc	{ width:233px;}
    .colStat	{ width:53px;}

    .multiline { width:100%;height:75px;}

    #tbl_assmtTable td{font-size:8pt;}
    #tbl_refTable td{font-size:8pt;}

    .colEmployer{width:200px;}
    .colPeriod{width:200px;}
    .colPhone{width:150px;}
    .alRight{text-align:right;padding-right:5px;}

</style>

<%

        String msg = "&nbsp;";
        String currentOperation = "";
        boolean errOccurred = false;

        DBProxy db = null;

        // user variables..
        User usr = null;
        Address addrH = null;
        Address addrP = null;
        Assignment[] assmts = null;

        try
        {
            // first vist?
            if (request.getParameter("password") == null)
            {	// YES: load from db
                // ..init user
                currentOperation = "Loading user";
                usr = new User();
                String username = request.getParameter("user");
                if ((username != null) && (!username.equals("")))
                {
                    usr.setUserName(username);
                    usr.load(true);
                }
                else
                {
                    throw new Exception("Username is null or empty");
                }

                // ..init addresses
                currentOperation = "Loading address";
                addrH = new Address();
                addrP = new Address();
                addrH.setFkUserID(usr.getPKID());
                addrP.setFkUserID(usr.getPKID());
                addrH.setFkAddrType("1");
                addrP.setFkAddrType("3");

                db = new DBProxy();
                try
                {
                    addrH.load(db);
                    addrP.load(db);

                    // .. Load Assignments !
                    assmts = User.getAssmts(db, usr.getPKID());
                }
                catch (Exception e)
                {
                    throw e;
                }
                finally
                {
                    db.close();
                }

                // save in session
                (new SessionManager(session)).setUserAcc(new Object[]
                        {
                            usr
                        });

            }
            else
            {														// NO: post-back update (load from session+request)

                // ..init from session (fields aren't available for update)
                Object[] usrAcc = (new SessionManager(session)).getUserAcc();
                usr = (User) usrAcc[0];
                addrH = new Address();//(Address) usrAcc[1];
                addrP = new Address();//(Address) usrAcc[2];
                addrH.setFkUserID(usr.getPKID());
                addrP.setFkUserID(usr.getPKID());
                addrH.setFkAddrType("1");
                addrP.setFkAddrType("3");

                // ..load updates
                usr.setPassword(request.getParameter("password"));
                usr.setFirstName(request.getParameter("fname"));
                usr.setInitial(request.getParameter("initial"));
                usr.setLastName(request.getParameter("lname"));
                usr.setTitle(request.getParameter("title"));
                usr.setEMail(request.getParameter("email"));
                usr.setTelH(request.getParameter("telh"));
                usr.setTelW(request.getParameter("telw"));
                usr.setTelFax(request.getParameter("telf"));
                usr.setTelCell(request.getParameter("telc"));
                usr.setIDNum(request.getParameter("idnum"));

                addrH.setStreet(request.getParameter("addr1h"));
                addrH.setSuburb(request.getParameter("addr2h"));
                addrH.setCity(request.getParameter("addr3h"));
                addrH.setAreaCode(request.getParameter("arcodeh"));

                addrP.setStreet(request.getParameter("addr1p"));
                addrP.setSuburb(request.getParameter("addr2p"));
                addrP.setCity(request.getParameter("addr3p"));
                addrP.setAreaCode(request.getParameter("arcodep"));


                // UPDATE
                try
                {
                    usr.updateWithAddresses(new Address[]
                            {
                                addrH, addrP
                            });
                }
                catch (Exception e)
                {
                    throw new Exception("update failed; " + e.getMessage());
                }
                msg = "Update Successful";


                // .. Load Assignments !
                db = new DBProxy();
                try
                {
                    assmts = User.getAssmts(db, usr.getPKID());
                }
                catch (Exception e)
                {
                    throw e;
                }
                finally
                {
                    db.close();
                }

            }

        }
        catch (Exception e)
        {
            msg = Err.genericMsg(e) + ". [" + currentOperation + "]";
            errOccurred = true;
        }

%>


<script type='text/javascript' src="script/client/pwGen.js"></script>
<script type='text/javascript' src="script/client/mc72.0.2.js"></script>

<h2>Individuals :: User Account Details</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<div class='sbTitle1'>
    <h4>User Details</h4>
</div>

<%if (!errOccurred)
        {%>

<div class='sectionBlok'>
    <div class='infobox'>
        Fields marked <div class='err' style='display:inline'>*</div>&nbsp;are mandatory.<br>
        Groups marked <div class='success' style='display:inline'>+</div>&nbsp;require AT LEAST ONE entry.<br>
    </div>
    <form action='index.jsp' method='post'>
        <table class='tbl' cellpadding="0" cellspacing="0">
            <tr>
                <td class='field'>Username:</td>
                <td class='value'><input class='txt1' type='text' id='userName' name='username' value='<%=usr.getUserName()%>' disabled /></td>
            </tr>
            <tr>
                <td class='field'>Password:</td>
                <td class='value'>
                    <input id='Password' class='txt1' type='text' name='password' value='<%=usr.getPassword()%>' disabled />
                    <button class='btnPW1' onclick="setPW(document.getElementById('Password')); return false;">generate password</button>
                    <button class='btnPW2' onclick="document.getElementById('Password').value = '<%=usr.getPassword()%>'; return false;" >reset password</button>
                </td>
            </tr>
            <tr>
                <td class='field'>Company Reference #:</td>
                <td class='value'>
                    <input class='txt1' name='companyref' id='companyref' type='text' value='<%=usr.getCompanyRef()%>' disabled/>
                </td>
            </tr>
            <tr>
                <td class='field'>Title:</td>
                <td class='value'>
                    <select name='title'>
                        <%=((usr.getTitle() != null && !usr.getTitle().equals(""))
                              ? "<option value='" + usr.getTitle() + "'>" + usr.getTitle()
                              : "<option value=''>{none}")%>
                        <option value=""		>{none}
                        <option value="Mr."	>Mr.
                        <option value="Me."	>Me.
                        <option value="Mrs."	>Mrs.
                        <option value="Miss"	>Miss
                        <option value="Dr."	>Dr.
                        <option value="Prof.">Prof.
                        <option value="Ds."	>Ds.
                    </select>
                </td>
            </tr>
            <tr>
                <td class='field'>First Name:</td>
                <td class='value'>
                    <input class='txt1' name='fname' id='firstName' type='text' value='<%=usr.getFirstName()%>' />
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td class='field'>Initial:</td>
                <td class='value'><input class='txt3' name='initial' id='Initial' type='text' value='<%=((usr.getInitial() != null) ? usr.getInitial() : "")%>' /></td>
            </tr>
            <tr>
                <td class='field'>Last Name:</td>
                <td class='value'>
                    <input class='txt1' name='lname' id='lastName' type='text' value='<%=usr.getLastName()%>' />
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td class='field'>Highest Qualification:</td>
                <td class='value'>
                    <input class='txt1' name='lname' id='highestq' type='text' value='<%=usr.getHighestQualification()%>' disabled/>
                </td>
            </tr>
            <tr>
                <td class='field'>ID Number:</td>
                <td class='value'><input class='txt1' name='idnum' id='IDNum' type='text' value='<%=((usr.getIDNum() != null) ? usr.getIDNum() : "")%>' /></td>
            </tr>
            <tr>
                <td class='field'>Tel (Cell):</td>
                <td class='value'>
                    <input class='txt1' name='telc' id='telC' type='text' value='<%=((usr.getTelCell() != null) ? usr.getTelCell() : "")%>' />
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td class='field'>Tel (H):</td>
                <td class='value'>
                    <input class='txt1' name='telh' id='telH' type='text' value='<%=((usr.getTelH() != null) ? usr.getTelH() : "")%>' />
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td class='field'>Tel (W):</td>
                <td class='value'>
                    <input class='txt1' name='telw' id='telW' type='text' value='<%=((usr.getTelW() != null) ? usr.getTelW() : "")%>' />
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td class='field'>Tel (Fax):</td>
                <td class='value'><input class='txt1' name='telf' id='telF' type='text' value='<%=((usr.getTelFax() != null) ? usr.getTelFax() : "")%>' /></td>
            </tr>
            <tr>
                <td class='field'>E-Mail:</td>
                <td class='value'>
                    <input class='txt1' name='email' id='Email' type='text' value='<%=((usr.getEMail() != null) ? usr.getEMail() : "")%>' />
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td><img src="images/spacer.gif" width="140" height="1"></td>
                <td><img src="images/spacer.gif" width="475" height="1"></td>
            </tr>
        </table>
        <table class='tbl' cellpadding="0" cellspacing="0">
            <tr>
                <td class='field' colspan="2">Home Address</td>
                <td></td>
                <td class='field' colspan="2">Postal Address</td>
            </tr>
            <tr>
                <td class='field2'>Street:</td>
                <td class='value'><input id="Addr1H" name="addr1h" type='text' class='txt_1' value='<%=((addrH.getStreet() != null) ? addrH.getStreet() : "")%>' /></td>
                <td></td>
                <td class='field2'>P.O. Box:</td>
                <td class='value'><input id="Addr1P" name="addr1p" type='text' class='txt_1' value='<%=((addrP.getStreet() != null) ? addrP.getStreet() : "")%>' /></td>
            </tr>
            <tr>
                <td class='field2'>Suburb:</td>
                <td class='value'><input id="Addr2H" name="addr2h" type='text' class='txt_1' value='<%=((addrH.getSuburb() != null) ? addrH.getSuburb() : "")%>' /></td>
                <td></td>
                <td class='field2'>Suburb:</td>
                <td class='value'><input id="Addr2P" name="addr2p" type='text' class='txt_1' value='<%=((addrP.getSuburb() != null) ? addrP.getSuburb() : "")%>' /></td>
            </tr>
            <tr>
                <td class='field2'>City:</td>
                <td class='value'><input id="Addr3H" name="addr3h" type='text' class='txt_1' value='<%=((addrH.getCity() != null) ? addrH.getCity() : "")%>' /></td>
                <td></td>
                <td class='field2'>City:</td>
                <td class='value'><input id="Addr3P" name="addr3p" type='text' class='txt_1' value='<%=((addrP.getCity() != null) ? addrP.getCity() : "")%>' /></td>
            </tr>
            <tr>
                <td class='field2'>Area Code:</td>
                <td class='value'>
                    <input id="ArCodeH" name="arcodeh" type='text' class='txt3' value='<%=((addrH.getAreaCode() != null) ? addrH.getAreaCode() : "")%>' />
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
                <td></td>
                <td class='field2'>Area Code:</td>
                <td class='value'>
                    <input id="ArCodeP" name="arcodep" type='text' class='txt3' value='<%=((addrP.getAreaCode() != null) ? addrP.getAreaCode() : "")%>' />
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td colspan="5">
                    <hr>
                    <br>
                    <div style='text-align:right;'>
                        <input type='submit' value=" Update " onclick="return btnStep2_Click();" />
                    </div>
                    <input type='hidden' name='pg' value="-43" />
                </td>
            </tr>
            <tr>
                <td><img src="images/spacer.gif" width="140" height="1"></td>
                <td><img src="images/spacer.gif" width="160" height="1"></td>
                <td><img src="images/spacer.gif" width="15" height="1"></td>
                <td><img src="images/spacer.gif" width="140" height="1"></td>
                <td><img src="images/spacer.gif" width="160" height="1"></td>
            </tr>

        </table>

        <!-- unused (script compatibility) -->
        <input type='hidden' id='compRef' />

    </form>
</div>

<% if (usr.getResumeFKID() != null)
            {%>

<div class='sbTitle1'>
    <h4>Resum&eacute;</h4>
</div>
<div class='sectionBlok'>
    <table class='tbl' cellpadding="0" cellspacing="0">
        <tr>
            <td class='field' width="200px">Trade Qualifications</td>
            <td class='value' width="400px"><textarea class="multiline" disabled><%=usr.getResume().getTradeQualifications()%></textarea></td>
        </tr>
        <tr>
            <td class='field'>Market Segment</td>
            <td class='value'><%=usr.getResume().getMarketSegmentName()%></td>
        </tr>
        <tr>
            <td class='field'>Occupation</td>
            <td class='value'><%=usr.getResume().getCareerName()%></td>
        </tr>
        <tr>
            <td class='field'>Employment Status</td>
            <td class='value'><%=usr.getResume().getEmploymentStatus()%></td>
        </tr>
        <tr>
            <td class='field'>Period of Employment</td>
            <td class='value'><%=usr.getResume().getCurrentEmploymentYears()%> year(s) and <%=usr.getResume().getCurrentEmploymentMonths()%> month(s)</td>
        </tr>
        <tr>
            <td class='field'>Hobbies</td>
            <td class='value'><textarea class="multiline" disabled><%=usr.getResume().getHobbies()%></textarea></td>
        </tr>
        <tr>
            <td class='field'>Comments</td>
            <td class='value'><textarea class="multiline" disabled><%=usr.getResume().getComments()%></textarea></td>
        </tr>
    </table>

    <p></p>
    Employment References
    <div>
        <script type="text/javascript">

            var refTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colEmployer'>Employer</div>",
                "<div class='cols1 colPeriod'>Period</div>",
                "<div class='cols1 colPhone'>Phone</div>"
            ],
            [
            <%
                            ResumeReference[] references = usr.getResume().getReferences();
                            if ((references != null) && (references.length > 0))
                            {
                                for (int i = 0; i < references.length - 1; i++)
                                {
                                    out.print("[");
                                    out.print("'" + (i + 1) + ".',");
                                    out.print("'" + references[i].getEmployer() + "',");
                                    out.print("'" + references[i].getEmploymentPeriod() + "',");
                                    out.print("'" + references[i].getEmployerPhone() + "'");
                                    out.println("],");
                                }

                                out.print("[");
                                out.print("'" + (references.length) + ".',");
                                out.print("'" + references[references.length - 1].getEmployer() + "',");
                                out.print("'" + references[references.length - 1].getEmploymentPeriod() + "',");
                                out.print("'" + references[references.length - 1].getEmployerPhone() + "'");
                                out.println("]");
                            }
                            else
                            {
                                out.println("['', '', '', '']");
                            }
            %>

                ]);

                refTable.draw();

        </script>
    </div>
</div>
<%}%>
<%}%>
<div class='sbTitle1'>
    <h4>Assignments</h4>
</div>
<%if (!errOccurred)
        {%>
<div class='sectionBlok'>
    <table class='tbl' cellpadding="0" cellspacing="0">
        <tr>
            <td class='field'>Total Assigned</td>
            <td class='value'><%=((assmts != null) ? assmts.length + "" : "0")%></td>
            <td colspan="3"></td>
        </tr>
        <tr>
            <td class='field' colspan="2">Type Summary</td>
            <td></td>
            <td class='field' colspan="2">Status Summary</td>
        </tr>
        <tr>
            <td colspan="2" class='value' style="padding:0; margin:0">
                <table class='tbl' cellspacing="0" cellpadding="0">
                    <tr>
                        <td class='field2' style="border-top:0; border-left:0;">Value Assessment</td>
                        <td class='field2' style="border-top:0">Full Assessment</td>
                        <td class='field2' style="border-top:0">Job Profile</td>
                        <td class='field2' style="border-top:0">Organization Screening Inventory</td>
                        <td class='field2' style="border-top:0">Personal Profile</td>
                        <td class='field2' style="border-top:0">Highschool Assessment</td>
                        <td class='field2' style="border-top:0;border-right:0">Career Planning Inventory</td>
                    </tr>
                    <tr>
                        <td class='value alR' style="border-left:0">
                            <div class='smVal2_1'><%=usr.getAssmtCount(User.QT_VA)%></div></td>
                        <td class='value alR'>
                            <div class='smVal2_2'><%=usr.getAssmtCount(User.QT_FA)%></div></td>
                        <td class='value alR'>
                            <div class='smVal2_3'><%=usr.getAssmtCount(User.QT_JP)%></div></td>
                        <td class='value alR'>
                            <div class='smVal2_4'><%=usr.getAssmtCount(User.QT_SI)%></div></td>
                        <td class='value alR'>
                            <div class='smVal2_5'><%=usr.getAssmtCount(User.QT_PP)%></div></td>
                        <td class='value alR'>
                            <div class='smVal2_6'><%=usr.getAssmtCount(User.QT_HA)%></div></td>
                        <td class='value alR'>
                            <div class='smVal2_7'><%=usr.getAssmtCount(User.QT_CP)%></div></td>
                    </tr>
                </table>
            </td>
            <td></td>
            <td colspan="2" class='value' style="padding:0; margin:0">
                <table class='tbl' cellspacing="0" cellpadding="0">
                    <tr>
                        <td class='field2' style="border-top:0; border-left:0;">Not Started</td>
                        <td class='field2' style="border-top:0">In Progress</td>
                        <td class='field2' style="border-top:0">Completed</td>
                        <td class='field2' style="border-top:0; border-right:0"><i>Canceled</i></td>
                    </tr>
                    <tr>
                        <td class='value alR' style="border-left:0">
                            <div class='smVal'><%=usr.getAssmtCount(User.AS_NS)%></div></td>
                        <td class='value alR'>
                            <div class='smVal'><%=usr.getAssmtCount(User.AS_IP)%></div></td>
                        <td class='value alR'>
                            <div class='smVal'><%=usr.getAssmtCount(User.AS_CP)%></div></td>
                        <td class='value alR' style="border-right:0">
                            <div class='smVal'>-</div></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="5"></td>
        </tr>
        <tr>
            <td class='field' colspan="5">Assigned Questionaires</td>
        </tr>
        <tr>
            <td class='value' colspan="5">
                <%
                            if (assmts != null && assmts.length > 0)
                            {%>
                <div style="width:610px">
                    <script type="text/javascript">
         
                        var assmtTable = new DynamicTable(
                        [
                            "<div class='cols1'>#</div>",
                            "<div class='cols1 colName'>Questionaire Name</div>",
                            "<div class='cols1 colDesc'>Description</div>",
                            "<div class='cols1 '>Type</div>",
                            "<div class='cols1 '>Total Q's</div>",
                            "<div class='cols1 colStat'>Status</div>"
                        ],
                        [
                        <%
                                                            for (int i = 0; i < assmts.length; i++)
                                                            {
                                                                out.println(
                                                                        "["
                                                                        + "'" + (i + 1) + ".',"
                                                                        + "'" + assmts[i].getQre().getName() + "',"
                                                                        + "'" + assmts[i].getQre().getDesc() + "',"
                                                                        + "'" + assmts[i].getQre().getType().getCode() + "',"
                                                                        + "'" + assmts[i].getQre().getTestLength() + "',"
                                                                        + "'" + assmts[i].getTstStatusDesc() + "']"
                                                                        + ((i == assmts.length - 1) ? "" : ","));
                                                            }

                        %>
                            ]
                        );
         
                            assmtTable.draw();
         	
                    </script>
                </div>
                <%			}
                                                else
                                                {%>
                <b><i>No Questionaires Assigned</i></b>
                <%			}%>

            </td>
        </tr>
        <tr>
            <td><img src="images/spacer.gif" width="140" height="1"></td>
            <td><img src="images/spacer.gif" width="160" height="1"></td>
            <td><img src="images/spacer.gif" width="15" height="1"></td>
            <td><img src="images/spacer.gif" width="140" height="1"></td>
            <td><img src="images/spacer.gif" width="160" height="1"></td>
        </tr>
    </table>
</div>
<%}%>
<hr>
