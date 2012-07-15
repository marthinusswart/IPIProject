<%@ page language="java" import="beans.*" %>

<%
        String msg = "&nbsp;";
        String position = "";
        boolean errOccurred = false;

        try
        {
            AutoRegUser newUser = (AutoRegUser) session.getAttribute("newuser");

            Resume resume = newUser.getResume();
            resume.setTradeQualifications(request.getParameter("tradeq2"));
            position = "marketsegment";
            resume.setMarketSegmentFKID(request.getParameter("marketsegment2"));
            position = "occupation";
            resume.setCareerFKID(request.getParameter("occupation2"));
            position = "employment";
            resume.setEmploymentStatusFKID(request.getParameter("employment2"));
            position = "years";
            String value = request.getParameter("years2");

            if (value != null)
            {
                resume.setCurrentEmploymentYears(Integer.parseInt(value));
            }

            value = request.getParameter("months2");
            if (value != null)
            {
                resume.setCurrentEmploymentMonths(Integer.parseInt(value));
            }

            resume.setComments(request.getParameter("comments2"));
            resume.setHobbies(request.getParameter("hobbies2"));
            resume.setSkillsSummary(request.getParameter("skillssummary2"));
            resume.setQualificationDetails(request.getParameter("qualificationdetails2"));
            resume.setSalaryRequired(request.getParameter("salaryrequired2"));
            resume.setNoticePeriod(request.getParameter("noticeperiod2"));
        }
        catch (Exception ex)
        {
            msg = ex.getMessage() + " pos: " + position + ". Exception: " + ex.toString();
            errOccurred = true;
        }
%>

<script type="text/javascript" src="script/client/GLib.js"></script>
<script type="text/javascript">
    function verifyReference()
    {
        // madatory fields
        var employer = document.getElementById("employer").value = Trim(document.getElementById("employer").value);
        var period = document.getElementById("period").value = Trim(document.getElementById("period").value);
        var phone = document.getElementById("phone").value = Trim(document.getElementById("phone").value);

        var str = "";

        if (employer == '') str+= "- a valid Employer Name\n";
        if (period == '') str+= "- a valid Employment Period\n";
        if (!isLegalPhoneNumber(phone, true)) str+= "- a valid Phone Number\n";    

        if (str=='')
        { // no errors
            document.getElementById("refadd").value = "Y";
            return true;
        }else
        {
            alert("Please provide the following fields :\n\n"+str);
            return false;
        }
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
    .colEmployer{width:250px;}
    .colPeriod{width:200px;}
    .colPhone{width:200px;}
    .alRight{
        text-align:right;
        padding-right:5px;
    }
    #tbl_refTable td{font-size:8pt;}
    .referenceSection{border:1px solid black;}
</style>

<form action='index.jsp' method='post'>
    <p>
    <div>
        <h3>Add Employer Reference</h3>

        <table width="500px">            
            <tr>
                <td width="200px">Employer</td>
                <td><input class="inputcell" type="text" id="employer" name="employer"></td>
            </tr>
            <tr>
                <td>Period of employment</td>
                <td><input class="inputcell" type="text" id="period" name="period"></td>
            </tr>
            <tr>
                <td>Referee's Name</td>
                <td><input class="inputcell" type="text" id="refereename" name="refereename"></td>
            </tr>
            <tr>
                <td>Referee's Phone Number</td>
                <td><input class="inputcell" type="text" id="phone" name="phone"></td>
            </tr>
            <tr>
                <td>Permission to contact referee?</td>
                <td>
                    <table>
                        <tr>
                            <td>No<input type="radio" id="contactpermission" name="contactpermission" value="no" checked></td>
                            <td>Yes<input type="radio" id="contactpermission" name="contactpermission" value="yes"></td>
                        </tr>
                    </table>
                <td>
            </tr>
            <tr>
                <td>Key Responsibility</td>
                <td><input class="inputcell" type="text" id="keyresponsibility" name="keyresponsibility"></td>
            </tr>
            <tr>
                <td>Skills Used</td>
                <td><input class="inputcell" type="text" id="skillsused" name="skillsused"></td>
            </tr>
            <tr>
                <td>Comments (Optional)</td>
                <td><input class="inputcell" type="text" id="comments" name="comments"></td>
            </tr>
            <tr>
                <td>Gross Salary Received</td>
                <td><input class="inputcell" type="text" id="grosssalary" name="grosssalary"></td>
            </tr>
            <tr>
                <td>
                    <div>
                        <input type='submit' class='btn2' value="OK" onclick="return verifyReference();"/>
                        <input type='submit' class='btn2' value="Cancel" />
                        <input type='hidden' name='refadd' id='refadd' value="N"/>
                        <input type='hidden' name='pg' value="723" />
                    </div>
                </td>
            </tr>
        </table>        
    </div>
    <hr>    
</form>

