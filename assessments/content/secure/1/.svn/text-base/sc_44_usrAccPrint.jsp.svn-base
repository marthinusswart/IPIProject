<%@ page language="java" import="beans.*" %>

<style type="text/css">
    H4{ margin: 0;}
    .sectionBlok	{
        width:630px;
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

    .pageBreak{page-break-before:always;}

    .colEmployer{width:200px;}
    .colPeriod{width:200px;}
    .colPhone{width:150px;}
    .colLarge{width:75px;}
    .colMedium{width:70px;}
    .colSmall{width:50px;}
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

        try
        {

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
        catch (Exception e)
        {
            msg = Err.genericMsg(e) + ". [" + currentOperation + "]";
            errOccurred = true;
        }

%>


<h2>Individuals :: User Account Details</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<div>
    <div class='sbTitle1'>
        <h4>User Details</h4>
    </div>

    <%if (!errOccurred)
            {%>

    <div class='sectionBlok'>

        <table class='tbl' cellpadding="0" cellspacing="0">
            <tr>
                <td class='field'>Username:</td>
                <td class='value'><input class='txt1' type='text' id='userName' name='username' value='<%=usr.getUserName()%>' disabled /></td>
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
                    <input class='txt1' name='title' id='title' type='text' value='<%=usr.getTitle()%>' disabled/>
                </td>
            </tr>
            <tr>
                <td class='field'>First Name:</td>
                <td class='value'>
                    <input class='txt1' name='fname' id='firstName' type='text' value='<%=usr.getFirstName()%>' disabled/>
                    &nbsp;<div class='err' style='display:inline'>*</div></td>
            </tr>
            <tr>
                <td class='field'>Initial:</td>
                <td class='value'><input class='txt3' name='initial' id='Initial' type='text' value='<%=((usr.getInitial() != null) ? usr.getInitial() : "")%>' disabled/></td>
            </tr>
            <tr>
                <td class='field'>Last Name:</td>
                <td class='value'>
                    <input class='txt1' name='lname' id='lastName' type='text' value='<%=usr.getLastName()%>' disabled/>
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
                <td class='value'><input class='txt1' name='idnum' id='IDNum' type='text' value='<%=((usr.getIDNum() != null) ? usr.getIDNum() : "")%>' disabled/></td>
            </tr>
            <tr>
                <td class='field'>Tel (Cell):</td>
                <td class='value'>
                    <input class='txt1' name='telc' id='telC' type='text' value='<%=((usr.getTelCell() != null) ? usr.getTelCell() : "")%>' disabled/>
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td class='field'>Tel (H):</td>
                <td class='value'>
                    <input class='txt1' name='telh' id='telH' type='text' value='<%=((usr.getTelH() != null) ? usr.getTelH() : "")%>' disabled/>
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td class='field'>Tel (W):</td>
                <td class='value'>
                    <input class='txt1' name='telw' id='telW' type='text' value='<%=((usr.getTelW() != null) ? usr.getTelW() : "")%>' disabled/>
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
            </tr>
            <tr>
                <td class='field'>Tel (Fax):</td>
                <td class='value'><input class='txt1' name='telf' id='telF' type='text' value='<%=((usr.getTelFax() != null) ? usr.getTelFax() : "")%>' disabled/></td>
            </tr>
            <tr>
                <td class='field'>E-Mail:</td>
                <td class='value'>
                    <input class='txt1' name='email' id='Email' type='text' value='<%=((usr.getEMail() != null) ? usr.getEMail() : "")%>' disabled/>
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
                <td class='value'><input id="Addr1H" name="addr1h" type='text' class='txt_1' value='<%=((addrH.getStreet() != null) ? addrH.getStreet() : "")%>' disabled/></td>
                <td></td>
                <td class='field2'>P.O. Box:</td>
                <td class='value'><input id="Addr1P" name="addr1p" type='text' class='txt_1' value='<%=((addrP.getStreet() != null) ? addrP.getStreet() : "")%>' disabled/></td>
            </tr>
            <tr>
                <td class='field2'>Suburb:</td>
                <td class='value'><input id="Addr2H" name="addr2h" type='text' class='txt_1' value='<%=((addrH.getSuburb() != null) ? addrH.getSuburb() : "")%>' disabled/></td>
                <td></td>
                <td class='field2'>Suburb:</td>
                <td class='value'><input id="Addr2P" name="addr2p" type='text' class='txt_1' value='<%=((addrP.getSuburb() != null) ? addrP.getSuburb() : "")%>' disabled/></td>
            </tr>
            <tr>
                <td class='field2'>City:</td>
                <td class='value'><input id="Addr3H" name="addr3h" type='text' class='txt_1' value='<%=((addrH.getCity() != null) ? addrH.getCity() : "")%>' disabled/></td>
                <td></td>
                <td class='field2'>City:</td>
                <td class='value'><input id="Addr3P" name="addr3p" type='text' class='txt_1' value='<%=((addrP.getCity() != null) ? addrP.getCity() : "")%>' disabled/></td>
            </tr>
            <tr>
                <td class='field2'>Area Code:</td>
                <td class='value'>
                    <input id="ArCodeH" name="arcodeh" type='text' class='txt3' value='<%=((addrH.getAreaCode() != null) ? addrH.getAreaCode() : "")%>' disabled/>
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
                <td></td>
                <td class='field2'>Area Code:</td>
                <td class='value'>
                    <input id="ArCodeP" name="arcodep" type='text' class='txt3' value='<%=((addrP.getAreaCode() != null) ? addrP.getAreaCode() : "")%>' disabled/>
                    &nbsp;<div class='success' style='display:inline'>+</div></td>
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


    </div>

</div>
<% if (usr.getResumeFKID() != null)
                {%>
<p></p>
<div class="pageBreak">
    <div class='sbTitle1'>
        <h4>Resum&eacute;</h4>
    </div>
    <div class='sectionBlok'>
        <table class='tbl' cellpadding="0" cellspacing="0">
            <tr>
                <td class='field' width="200px">Skills Qualifications</td>
                <td class='value' width="400px"><textarea class="multiline" disabled><%=usr.getResume().getTradeQualifications()%></textarea></td>
            </tr>
            <tr>
                <td class='field' width="200px">Skills Summary</td>
                <td class='value' width="400px"><textarea class="multiline" disabled><%=usr.getResume().getSkillsSummary()%></textarea></td>
            </tr>
            <tr>
                <td class='field' width="200px">Details of Qualifications</td>
                <td class='value' width="400px"><textarea class="multiline" disabled><%=usr.getResume().getQualificationDetails()%></textarea></td>
            </tr>
            <tr>
                <td class='field' width="200px">Salary Required (Optional)</td>
                <td class='value'><%=usr.getResume().getSalaryRequired()%></td>
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
                <td class='field' width="200px">Notice Period (if Applicable)</td>
                <td class='value' width="400px"><textarea class="multiline" disabled><%=usr.getResume().getNoticePeriod()%></textarea></td>
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
    </div>
</div>
<p></p>
<div class="pageBreak">
    <div class='sbTitle1'>
        <h4>Employment References</h4>
    </div>

    <div>
        <script type="text/javascript">

            var refTable = new DynamicTable(
            [
                "<div class='cols1'>#</div>",
                "<div class='cols1 colLarge'>Employer</div>",
                "<div class='cols1 colMedium'>Period</div>",
                "<div class='cols1 colMedium'>Referee Name</div>",
                "<div class='cols1 colMedium'>Referee Phone Number</div>",
                "<div class='cols1 colSmall'>Permission to Contact</div>",
                "<div class='cols1 colLarge'>Key Responsibility</div>",
                "<div class='cols1 colLarge'>Skills Used</div>",
                "<div class='cols1 colMedium'>Gross Salary</div>"
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
                                        out.print("'" + references[i].getRefereeName() + "',");
                                        out.print("'" + references[i].getEmployerPhone() + "',");
                                        out.print("'" + references[i].getContactPermission() + "',");
                                        out.print("'" + references[i].getKeyResponsibility() + "',");
                                        out.print("'" + references[i].getSkillsUsed() + "',");
                                        out.print("'" + references[i].getGrossSalary() + "'");
                                        out.println("],");
                                    }

                                    out.print("[");
                                    out.print("'" + (references.length) + ".',");
                                    out.print("'" + references[references.length - 1].getEmployer() + "',");
                                    out.print("'" + references[references.length - 1].getEmploymentPeriod() + "',");
                                    out.print("'" + references[references.length - 1].getRefereeName() + "',");
                                    out.print("'" + references[references.length - 1].getEmployerPhone() + "',");
                                    out.print("'" + references[references.length - 1].getContactPermission() + "',");
                                    out.print("'" + references[references.length - 1].getKeyResponsibility() + "',");
                                    out.print("'" + references[references.length - 1].getSkillsUsed() + "',");
                                    out.print("'" + references[references.length - 1].getGrossSalary() + "'");
                                    out.println("]");
                                }
                                else
                                {
                                    out.println("['', '', '', '', '', '', '', '', '']");
                                }
            %>

                ]);

                refTable.draw();

        </script>
    </div>
</div>

<%}%>
<%}%>

<a href="index.jsp?pg=-40">[Back]</a>
<hr>
