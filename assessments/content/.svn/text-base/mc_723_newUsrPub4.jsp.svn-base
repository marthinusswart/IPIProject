<%@ page language="java" import="beans.*" %>

<%
        String msg = "&nbsp;";
        boolean errOccurred = false;
        MarketSegment[] marketSegments = null;
        Career[] careers = null;
        EmploymentStatus[] employmentStatusses = null;
        AutoRegUser newUsr = null;

        if (session.getAttribute("newuser") != null)
        {
            newUsr = (AutoRegUser) session.getAttribute("newuser");
        }
        else
        {
            newUsr = new AutoRegUser();
            newUsr.setFKCustomer("-1");
            newUsr.setUserName(request.getParameter("username"));
            newUsr.setPassword(request.getParameter("password"));
            newUsr.setUserLevel("3");

            newUsr.setFirstName(request.getParameter("firstname"));
            newUsr.setLastName(request.getParameter("lastname"));
            newUsr.setInitial(request.getParameter("initial"));
            newUsr.setTitle(((request.getParameter("title") == null || request.getParameter("title").equals(""))
                             ? null
                             : request.getParameter("title")));
            newUsr.setIDNum(request.getParameter("idnum"));
            newUsr.setCompanyRef(request.getParameter("compref").toUpperCase());

            newUsr.setTelW(request.getParameter("telw"));
            newUsr.setTelH(request.getParameter("telh"));
            newUsr.setTelFax(request.getParameter("telf"));
            newUsr.setTelCell(request.getParameter("telc"));
            newUsr.setEMail(request.getParameter("email"));
            //newUsr.setWebsite(	request.getParameter("web"));

            newUsr.setQualification(Integer.parseInt(request.getParameter("hq")));

            // get user's addresses

            newUsr.getAddrHome().setStreet(request.getParameter("addr1h"));
            newUsr.getAddrHome().setSuburb(request.getParameter("addr2h"));
            newUsr.getAddrHome().setCity(request.getParameter("addr3h"));
            newUsr.getAddrHome().setAreaCode(request.getParameter("arcodeh"));

            newUsr.getAddrPost().setStreet(request.getParameter("addr1p"));
            newUsr.getAddrPost().setSuburb(request.getParameter("addr2p"));
            newUsr.getAddrPost().setCity(request.getParameter("addr3p"));
            newUsr.getAddrPost().setAreaCode(request.getParameter("arcodep"));

            // check if user exists & that ref # is valid
            try
            {
                if (newUsr.exists())
                {
                    session.setAttribute("username", newUsr.getUserName());
%>	<jsp:forward page="/index.jsp?pg=720&err=1" /> <%            }
                else if (!newUsr.hasValidRef())
                {
%>	<jsp:forward page="/index.jsp?pg=720&err=2" /> <%                }
            }
            catch (Exception ex)
            {
                errOccurred = true;
                msg += ex.getMessage();
            }

            AutoRegResume resume = new AutoRegResume();
            newUsr.setResume(resume);
            session.setAttribute("newuser", newUsr);
        }

        try
        {
            marketSegments = MarketSegment.getMarketSegments();
            careers = Career.getCareers();
            employmentStatusses = EmploymentStatus.getEmploymentStatus();
        }
        catch (Exception ex)
        {
            errOccurred = true;
            msg += ex.getMessage();
        }

        if (request.getParameter("refadd") != null)
        {
            if (request.getParameter("refadd").equals("Y"))
            {
                AutoRegResumeReference reference = new AutoRegResumeReference();
                reference.setEmployer(request.getParameter("employer"));
                reference.setEmployerPhone(request.getParameter("phone"));
                reference.setEmploymentPeriod(request.getParameter("period"));
                reference.setRefereeName(request.getParameter("refereename"));
                reference.setContactPermission(request.getParameter("contactpermission"));
                reference.setKeyResponsibility(request.getParameter("keyresponsibility"));
                reference.setSkillsUsed(request.getParameter("skillsused"));
                reference.setComments(request.getParameter("comments"));
                reference.setGrossSalary(request.getParameter("grosssalary"));
                newUsr.getResume().addReference(reference);
            }
        }

        if (request.getParameter("refdel") != null)
        {
            String refNr = request.getParameter("refdel");
            if (!refNr.equals("N"))
            {
                newUsr.getResume().removeReference(Integer.parseInt(refNr) - 1);
            }
        }

%>

<script type='text/javascript' src='script/client/GLib.js'></script>
<script type='text/javascript' src='script/client/CDynamicTable.js'></script>

<script type="text/javascript">
    function setReference()
    {
        try
        {
            var re = /(.)/;
            var taggedRef = refTable.m_aRowData[refTable.m_selectedRows[0]][0];
            var extract = taggedRef.match(re);
            var number = extract[1];
            document.getElementById("refdel").value = number;
        }
        catch (error)
        {
            alert(error.message);
            return false;
        }
        
        return true;
    }

    function setDetails(id)
    {
        try
        {
            document.getElementById("tradeq"+id).value = Trim(document.getElementById("tradeq").value);
            document.getElementById("marketsegment"+id).value = document.getElementById("marketsegment").value.toString();
            document.getElementById("occupation"+id).value = document.getElementById("occupation").value.toString();
            document.getElementById("employment"+id).value = document.getElementById("employment").value.toString();
            document.getElementById("years"+id).value = document.getElementById("years").value.toString();
            document.getElementById("months"+id).value = document.getElementById("months").value.toString();
            document.getElementById("comments"+id).value = Trim(document.getElementById("comments").value);
            document.getElementById("hobbies"+id).value = Trim(document.getElementById("hobbies").value);
            document.getElementById("skillssummary"+id).value = Trim(document.getElementById("skillssummary").value);
            document.getElementById("qualificationdetails"+id).value = Trim(document.getElementById("qualificationdetails").value);
            document.getElementById("salaryrequired"+id).value = Trim(document.getElementById("salaryrequired").value);
            document.getElementById("noticeperiod"+id).value = Trim(document.getElementById("noticeperiod").value);
        }
        catch (error)
        {
            alert(error.message);
            return false;
        }

        return true;
    }
</script>

<h2>New User Registration</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<style>
    .toplink{
        font-size: 8pt;
        font-weight:normal;
    }
    .txt1_{
        width:165px;
    }
    .inputcell{
        width:100%;
    }
    .greyout{
        color:#777;
    }
    .infobox{
        padding: 2px 0 2px 4px;
        width:325px;
        background-color:#DDD;
        border:1px solid #777;
        font-size: 8pt;
        font-style:italic;
    }
    .mandatory{
        font-size:12pt;
        font-weight:normal;
        color:red;
    }
    .cols1{padding: 0 5px 0 5px;}
    .colEmployer{width:175px;}
    .colPeriod{width:150px;}
    .colPhone{width:100px;}
    .alRight{
        text-align:right;
        padding-right:5px;
    }
    #tbl_refTable td{font-size:8pt;}
    .referenceSection{
        border:1px solid black;
        width:500px;
    }
</style>

<% if (!errOccurred)
        {%>
<p>
<div>
    <h3>Step 2: Your Resum&eacute;</h3>
    <h4>(Compulsory for Job Applicants Only)</h4>
    <div class='infobox'>
        <span class='toplink'>[ <a href="#q">more info on registration</a> ]</span><br>
		Fields marked with <span class='mandatory' style='display:inline'>*</span>&nbsp;are mandatory.<br>
		Groups marked with <span class='mandatory' style='display:inline'>+</span>&nbsp;require AT LEAST ONE entry.<br>
    </div>
    <br><br>
    <table width="500px">
        <tr>
            <td width="150px">Skills Qualifications</td>
            <td width="350px">
                <textarea class='inputcell' id='tradeq' name='tradeq'><%
                            if (newUsr.getResume().getTradeQualifications() != null)
                            {
                                out.print(newUsr.getResume().getTradeQualifications());
                            }
                    %></textarea>
            </td>
        </tr>
        <tr>
            <td width="150px">Skills Summary</td>
            <td width="350px">
                <textarea class='inputcell' id='skillssummary' name='skillssummary'><%
                            if (newUsr.getResume().getSkillsSummary() != null)
                            {
                                out.print(newUsr.getResume().getSkillsSummary());
                            }
                    %></textarea>
        </tr>
        <tr>
            <td width="150px">Details of Qualifications</td>
            <td width="350px">
                <textarea class='inputcell' id='qualificationdetails' name='qualificationdetails'><%
                            if (newUsr.getResume().getQualificationDetails() != null)
                            {
                                out.print(newUsr.getResume().getQualificationDetails());
                            }
                    %></textarea>
            </td>
        </tr>
        <tr>
            <td width="150px">Salary Required (Optional)</td>
            <td width="350px">
                <input type="text" class='inputcell' id='salaryrequired' name='salaryrequired' value='<%
                            if (newUsr.getResume().getSalaryRequired() != null)
                            {
                                out.print(newUsr.getResume().getSalaryRequired());
                            }
                       %>'/>
        </tr>
        <tr>
            <td>Market Segment</td>
            <td>
                <select class="inputcell" name="marketsegment" id="marketsegment">
                    <%
                                String selectedItem = "";

                                if (newUsr.getResume().getMarketSegmentFKID() != null)
                                {
                                    selectedItem = newUsr.getResume().getMarketSegmentFKID();
                                }

                                out.println("<option value=\'-1\'>{None}</option>");

                                for (int i = 0; i < marketSegments.length; i++)
                                {
                                    if (marketSegments[i].getPKID().equals(selectedItem))
                                    {
                                        out.println("<option value='" + marketSegments[i].getPKID() + "' SELECTED>"
                                                    + marketSegments[i].getName() + "</option>");
                                    }
                                    else
                                    {
                                        out.println("<option value='" + marketSegments[i].getPKID() + "'>"
                                                    + marketSegments[i].getName() + "</option>");
                                    }
                                }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td>Occupation</td>
            <td>
                <select class="inputcell" name="occupation" id="occupation">
                    <%
                                selectedItem = "";

                                if (newUsr.getResume().getCareerFKID() != null)
                                {
                                    selectedItem = newUsr.getResume().getCareerFKID();
                                }

                                out.println("<option value=\'-1\'>{None}</option>");

                                for (int i = 0; i < careers.length; i++)
                                {
                                    if (careers[i].getPKID().equals(selectedItem))
                                    {
                                        out.println("<option value='" + careers[i].getPKID() + "' SELECTED>"
                                                    + careers[i].getName() + "</option>");
                                    }
                                    else
                                    {
                                        out.println("<option value='" + careers[i].getPKID() + "'>"
                                                    + careers[i].getName() + "</option>");
                                    }
                                }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td>Employment Status</td>
            <td>
                <select class="inputcell" name="employment" id="employment">
                    <%
                                selectedItem = "";

                                if (newUsr.getResume().getEmploymentStatusFKID() != null)
                                {
                                    selectedItem = newUsr.getResume().getEmploymentStatusFKID();
                                }

                                out.println("<option value=\'-1\'>{None}</option>");

                                for (int i = 0; i < employmentStatusses.length; i++)
                                {
                                    if (employmentStatusses[i].getPKID().equals(selectedItem))
                                    {
                                        out.println("<option value='" + employmentStatusses[i].getPKID() + "' SELECTED>"
                                                    + employmentStatusses[i].getName() + "</option>");
                                    }
                                    else
                                    {
                                        out.println("<option value='" + employmentStatusses[i].getPKID() + "'>"
                                                    + employmentStatusses[i].getName() + "</option>");
                                    }
                                }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td>Period of employment</td>
            <td>
                <table width="200px">
                    <tr>
                        <td width="50px">Years</td>
                        <td>
                            <select name='years' id="years">
                                <%
                                            int selectedInt = 0;

                                            if (newUsr.getResume().getCurrentEmploymentYears() != 0)
                                            {
                                                selectedInt = newUsr.getResume().getCurrentEmploymentYears();
                                            }

                                            for (int i = 0; i <= 50; i++)
                                            {
                                                if (i == selectedInt)
                                                {
                                                    out.println("<option value='" + i + "' SELECTED>" + i + "</option>");
                                                }
                                                else
                                                {
                                                    out.println("<option value='" + i + "'>" + i + "</option>");
                                                }
                                            }
                                %>
                            </select>
                        </td>
                        <td width="50px">Months</td>
                        <td>
                            <select name='months' id="months">
                                <%
                                            selectedInt = 0;

                                            if (newUsr.getResume().getCurrentEmploymentMonths() != 0)
                                            {
                                                selectedInt = newUsr.getResume().getCurrentEmploymentMonths();
                                            }

                                            for (int i = 0; i <= 12; i++)
                                            {
                                                if (i == selectedInt)
                                                {
                                                    out.println("<option value='" + i + "' SELECTED>" + i + "</option>");
                                                }
                                                else
                                                {
                                                    out.println("<option value='" + i + "'>" + i + "</option>");
                                                }
                                            }
                                %>
                            </select>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>Notice Period (if Applicable)</td>
            <td><input type="text" class='inputcell' id='noticeperiod' name='noticeperiod' value='<%
                        if (newUsr.getResume().getNoticePeriod() != null)
                        {
                            out.print(newUsr.getResume().getNoticePeriod());
                        }
                       %>'/></td>
        </tr>
    </table>

    <p></p>
    Employment References:

    <table class='referenceSection'>
        <tr>
            <td>
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
                                    ResumeReference[] references = newUsr.getResume().getReferences();
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
            </td>
        </tr>
        <tr>
            <td>
                <div class='btnBar' style="width:250px">
                    <div class='btnBTitle'>Actions</div>
                    <div style="float:left;">
                        <form action='index.jsp' method='post'>
                            <input type='submit' class='btn2' value='Add' onclick='return setDetails(2)'/>
                            <input type="hidden" name="tradeq2" id="tradeq2"/>
                            <input type="hidden" name="marketsegment2" id="marketsegment2"/>
                            <input type="hidden" name="occupation2" id="occupation2"/>
                            <input type="hidden" name="employment2" id="employment2"/>
                            <input type="hidden" name="years2" id="years2"/>
                            <input type="hidden" name="months2" id="months2"/>
                            <input type="hidden" name="comments2" id="comments2"/>
                            <input type="hidden" name="hobbies2" id="hobbies2"/>
                            <input type="hidden" name="skillssummary2" id="skillssummary2"/>
                            <input type="hidden" name="qualificationdetails2" id="qualificationdetails2"/>
                            <input type="hidden" name="salaryrequired2" id="salaryrequired2"/>
                            <input type="hidden" name="noticeperiod2" id="noticeperiod2"/>
                            <input type='hidden' id='pg' name='pg' value="724" />
                        </form>
                    </div>
                    <div style="float:left;">
                        <form action='index.jsp' method='post'>
                            <input type='submit' class='btn2' value='Delete' onclick='return setReference()' />
                            <input type='hidden' name='refdel' id='refdel' value='N'/>
                            <input type='hidden' id='pg' name='pg' value="723" />
                        </form>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <p></p>
    <table width="500px">
        <tr>
            <td width="150px">Comments</td>
            <td width="350px"><textarea class='inputcell' id='comments' name='comments'><%
                        if (newUsr.getResume().getComments() != null)
                        {
                            out.print(newUsr.getResume().getComments());
                        }
                    %></textarea></td>
        </tr>
        <tr>
            <td>Hobbies</td>
            <td><textarea class='inputcell' id='hobbies' name='hobbies'><%
                        if (newUsr.getResume().getHobbies() != null)
                        {
                            out.print(newUsr.getResume().getHobbies());
                        }
                    %></textarea></td>
        </tr>
    </table>
</div>


<hr>
<br>
<div style='text-align:right;'>
    <form action='index.jsp' method='post'>
        <input type='submit' value=" Step 3: Confirm >> " onclick='return setDetails(3)'/>
        <input type='hidden' id='Initial' name='initial'/>
        <input type="hidden" name="tradeq3" id="tradeq3"/>
        <input type="hidden" name="marketsegment3" id="marketsegment3"/>
        <input type="hidden" name="occupation3" id="occupation3"/>
        <input type="hidden" name="employment3" id="employment3"/>
        <input type="hidden" name="years3" id="years3"/>
        <input type="hidden" name="months3" id="months3"/>
        <input type="hidden" name="comments3" id="comments3"/>
        <input type="hidden" name="hobbies3" id="hobbies3"/>
        <input type="hidden" name="skillssummary3" id="skillssummary3"/>
        <input type="hidden" name="qualificationdetails3" id="qualificationdetails3"/>
        <input type="hidden" name="salaryrequired3" id="salaryrequired3"/>
        <input type="hidden" name="noticeperiod3" id="noticeperiod3"/>
        <input type='hidden' id='pg' name='pg' value="721" />
    </form>
</div>
<br>   

<%}%>
<hr>
<a id="q"></a>
<h3>More Info on Registration</h3>
<h4><u>General info & instructions</u></h4>
<p>
    Step #
<ol>
    <li><span class="greyout">Complete the registration form, then click the "Step 2: Resum&eacute;"-button to add your employment details. Make sure you've provided a valid e-mail address.</span></li>
    <li><b>Complete the resum&eacute; form, then click the "Step 3: Confirm"-button to confirm your details. Make sure you've provided a valid e-mail address.</b></li>
    <li><span class="greyout">Click "Finish" to submit you registration.</span></li>
    <li><span class="greyout">Retrieve the confirmation e-mail that will be sent to the e-mail address you've provided.</span></li>
    <li><span class="greyout">Once these steps have been completed, your assessment will be activated and you will be able to login and complete the questionnaire.</span></li></ol>

<a href="#top" class='toplink'>[ top ]</a>

<br><br>
<h4><u>Frequently Asked Questions (FAQ)</u></h4>
<a id="q1"></a>
<h5>1. What is the <i>Assessment Reference#</i>?</h5>
<p>The <i>assessment reference number</i> can be one of two codes:
<ol>
    <li>We and our customers send out adverts in newspapers and through other marketing channels to reach you, the candidate. In this case, the <i>Assessment Reference#</i> is a code that is specified in the ad.
        <br><b><i>If you are responding to an ad</i></b>, provide the code specified therein.</li>
    <li>Our customers that are companies may instruct you, their employee / candidate, to register yourself as part of a organizational assessment. In this case the <i>Assessment Reference#</i> is a code that the company will provide.
        <br><b><i>If you are an employee</i></b>, please provide the reference your employer / organization provided.</li>
</ol>

<p><b>If you are neither responding to an ad, nor registering as an employee, <u>ignore this field</u></b>.</p>
<a href="#top" class='toplink'>[ top ]</a>

<a id="q2"></a>
<h5>2. I have no e-mail address (+more)</h5>
<p>It is important for us to contact you, for example, to inform you of any job-/bursary- matches, or, to sort out any issues with payment. It is also part of the registration process, so - </p>
<p><b>If you do not provide or have a valid e-mail address, you cannot continue!</b></p>
<p>You should already be aware that certain websites provide free online mail accounts. The following is a (non-exhaustive) list of some of them:
<ul>
    <li><a href="http://mail.yahoo.com">Yahoo! mail</a></li>
    <li><a href="http://www.webmail.co.za">WebMail (SA)</a></li>
    <li><a href="http://www.hotmail.com">Hotmail</a></li>
</ul>
<a href="#top" class='toplink'>[ top ]</a>

<a id="q3"></a>
<h5>3. Why do you want my area code?</h5>
<p>After we've found job-/bursary- matches for your profile, we need to organize candidates according to geographical areas. This is also important because once your profile has been selected, you will have to complete a more comprehensive assessment at a designated <b>site in your vicinity</b>, or at our customer's premesis.</p>
<a href="#top" class='toplink'>[ top ]</a>