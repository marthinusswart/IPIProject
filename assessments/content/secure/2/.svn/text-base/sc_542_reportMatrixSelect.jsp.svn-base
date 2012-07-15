<%@ page language="java" import="beans.*" %>

<%
        Report[] grReports = null;

        // ..error messages
        String msg = "&nbsp;";
        boolean errOccurred = false;


        // get the reports
        try
        {
            // details of current logged in user
            SessionManager sMan = new SessionManager(session);

            int usrLvl = sMan.getUserLvl();
            String custID = null;
            if (usrLvl == 2)
            {
                custID = sMan.getCustID(true);
            }

            grReports = ReportsManager.getReportsByCustomer(custID);
        }
        catch (Exception e)
        {
            msg += "error: " + e.getMessage();
            errOccurred = true;
            Err.printDBErr(e.getMessage(), out, false, true);
        }

        //out.println("count:"+grReports.length);
%>

<h2>Assessments :: Reports</h2>
<hr>
<%=((errOccurred) ? "<div class='err'>" + msg + "</div>" : "<div class='success'>" + msg + "</div>")%>
<hr>

<style>
    .cols1	{ padding: 0 5px 0 5px;}
    .colUser	{ width:180px;}
    .colAssmt{ width:180px;}
    .colOrg	{ width:180px;}
    .colTime	{ width:180px;}

    .alRight { text-align:right; padding-right:5px; }

    #tbl_repTable td{font-size:8pt;}


    FORM{DISPLAY: inline;}

    #act_box{
        float:left;
        margin-left:30px;
    }

    #opt_box{
        height:115px;
        width: 400px;
    }#opt_box UL{
        margin:0 0 10px 0;
        padding:0;
    }

    LI{
        font-size:9pt;
        list-style:none;
        margin:0 0 0 0;
        padding:0 0 0 0;
    }LI.disabled{
        color: #666;
    }


    #action_scr{}
    #action_xls{	display: none;}
    #action_pdf{	display: none;}
    #note_scr{}
    #note_xls{display: none;}
    #note_pdf{display: none;}

    div.optTitle{
        background-color: #DDD;
        border: 1px solid #777;
        font-size: 8pt;
        padding: 0 2px 0 2px;
        margin: 0 3px 0 3px;
    }div.subOptTitle{
        background-color: #DFD;
        color: #363;
        border: 1px solid #797;
    }

    .spaceHack{				height:240px;}

    /* IE */
    * html .spaceHack{	height:190px;width:100px;}

    * html LI{list-style-image:none;}

    * html #act_box{width:300px;}

</style>
<script type='text/javascript' src='script/client/sc54.js'></script>

<script type="text/javascript">
    function getSelectedReports()
    {
        var reportIds = "";
        var reports = document.getElementsByName("report");
        var count = 0;

  
        for (i = 0; i < reports.length; i++)
        {
            if (reports[i].checked)
            {
                if (count == 0)
                {
                    reportIds += repTableMap[i][1];
                    count ++;
                }
                else
                {
                    reportIds += "," + repTableMap[i][1];
                }
            }
        }

        // get the control report        
        var controlReports = document.getElementsByName("controlreport");
    
        if (controlReports != null)
        {         
            for (i = 0; i < controlReports.length; i++)
            {
                if (controlReports[i].checked)
                {
                    reportIds = repTableMap[i][1] +  "," + reportIds;
                }
            }
        }
        
        return reportIds;
    }

    function getMatrixType()
    {
        var matrixRadios = document.getElementsByName("matrixtype");
        var matrixType = 0;
        if (matrixRadios[1].checked)
        {
            matrixType = 1;
        }
        return matrixType;
    }

    function getReportType()
    {
        var reportRadios = document.getElementsByName("doctype");
        var reportType = 0;
        if (reportRadios[1].checked)
        {
            reportType = 1;
        }
        return reportType;
    }

    function showMatrix()
    {
        var reports = getSelectedReports();

        if (reports.length == 0)
        {
            alert ("Please select reports for the matrix")
            return false;
        }
        else
        {
            var matrixType = getMatrixType();
            var reportType = getReportType();
            var reportWindow = window.open("index.jsp?pg=-543&reportIds="+reports+"&matrixtype="+matrixType+"&reporttype="+reportType);
            return false;
        }
    }
</script>

<b>The following Reports are available (* indicates the control report):</b><br /><br />

<script type="text/javascript">

    var repTable = new DynamicTable(
    [
        "<div class='cols1'>#</div>",
        "<div class='cols1'>*</div>",
        "<div class='cols1'></div>",
        "<div class='cols1 colUser'>Person</div>",
        "<div class='cols1 colAssmt'>Assessment</div>",
        "<div class='cols1 colOrg'>Organization</div>",
        "<div class='cols1 colTime'>Submitted (Local Time)</div>"
    ],
    [
    <%
            int i;
            if (grReports != null && grReports.length > 0)
            {
                for (i = 0; i < grReports.length - 1; i++)
                {
                    out.println(
                            "["
                            + "'" + (i + 1) + ".',"
                            + "'" + "<input type=\"radio\" name=\"controlreport\" value=\"controlreport" + (i + 1) + "\">',"
                            + "'" + "<input type=\"checkbox\" name=\"report\" value=\"report" + (i + 1) + "\">',"
                            + "'" + grReports[i].getUserFullName() + "',"
                            + "'" + grReports[i].getQreName() + "',"
                            + "'" + grReports[i].getCustomerName() + "',"
                            + "'" + grReports[i].getAssmtTime() + "'"
                            + "],");
                }
                out.println(
                        "["
                        + "'" + (grReports.length) + ".',"
                        + "'" + "<input type=\"radio\" name=\"controlreport\" value=\"controlreport" + (i + 1) + "\">',"
                        + "'" + "<input type=\"checkbox\" name=\"report\" value=\"report" + (i + 1) + "\">',"
                        + "'" + grReports[grReports.length - 1].getUserFullName() + "',"
                        + "'" + grReports[grReports.length - 1].getQreName() + "',"
                        + "'" + grReports[grReports.length - 1].getCustomerName() + "',"
                        + "'" + grReports[grReports.length - 1].getAssmtTime() + "'"
                        + "]");
            }
            else
            {
                out.println("['', '', '', '', '', '', '']");
            }

    %>
        ]
    );

        repTable.draw();

    <%
            // output report (assmt id's) in script array
            if ((grReports != null) && (grReports.length > 0))
            {
                out.print("var repTableMap = [");
                for (i = 0; i < grReports.length - 1; i++)
                {
                    out.print("[" + (i) + "," + grReports[i].getAssignment().getPKID() + "],");
                }
                out.print("[" + (grReports.length - 1) + "," + grReports[grReports.length - 1].getAssignment().getPKID() + "]");
                out.print("];");
            }
    %>

</script>

<hr>
<form action='index.jsp' method='post'>
    <div id='opt_box' class='btnBar'  style="float:left">
        <div class='btnBTitle'>Display Options</div>
        <table style="border-collapse:collapse; width:100%">
            <tr>
                <td>
                    <div class='optTitle'>Report Type</div>
                    <ul>
                        <li><input type='radio' name='doctype' value="0" onclick="radDoctype_Click('scr')" checked /><b>Display on Screen</b></li>
                        <li><input type='radio' name='doctype' value="1" onclick="radDoctype_Click('prn')" /><b>Printable Format</b></li>
                        <li><input type='radio' name='doctype' value="2" onclick="radDoctype_Click('xls')" disabled /><b>Spreadsheet (.xls)</b></li>
                    </ul>
                </td>
                <td style="border-left:1px solid #AAA;">
                    <div id="action_scr">
                        <div class='optTitle subOptTitle'>Show in Browser:</div>
                        <ul>
                            <li><input type='radio' name='matrixtype' value="0" checked />Anonymous Candidates</li>
                            <li><input type='radio' name='matrixtype' value="1" />Full Candidate Names</li>
                        </ul>
                    </div>
                    <div id="action_xls">
                        <div class='optTitle subOptTitle'>Download only</div>
                        <ul>
                            <li class='disabled' style="padding-top:3px">&nbsp;&nbsp;&nbsp;<i>- Compressed spreadsheet (.zip)</i></li>
                        </ul>
                    </div>
                    <div id="action_pdf">
                        <div class='optTitle subOptTitle'>Compression</div>
                        <ul>
                            <li class='disabled'><input type='radio' name='streamtype' checked disabled />Compressed (download .zip)</li>
                            <li class='disabled'><input type='radio' name='streamtype' disabled />Uncompressed (view in browser)</li>
                        </ul>
                        <div class='optTitle subOptTitle'>Color Setting</div>
                        <ul>
                            <li class='disabled'><input type='radio' name='colortype' checked disabled />Color + White Backgrounds</li>
                            <li class='disabled'><input type='radio' name='colortype' disabled />Color + Image Backgrounds</li>
                            <li class='disabled'><input type='radio' name='colortype' disabled />Black & White</li>
                        </ul>
                        <div class='optTitle subOptTitle'>Page Setup</div>
                        <ul>
                            <li class='disabled'><input type='radio' name='pagetype' checked disabled />Normal Continuous Pages</li>
                            <li class='disabled'><input type='radio' name='pagetype' disabled />Pages Arranged for Printing</li>
                        </ul>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <div id='act_box' class='btnBar'>
        <div class='btnBTitle'>Actions
            <i id='note_scr'>(Report: On Screen)</i>
            <i id='note_xls'>(Report: Spreadsheet)</i>
            <i id='note_pdf'>(Report: PDF)</i></div>
        <div style="float:left;">
            <input id='btnGet' type='submit' class='btn1'	value="Get Matrix" onclick="return showMatrix();" />
            <input type='hidden' name='repids'	id='RepIDs' />
            <input type='hidden' name='pg'		value="-543" />
        </div>
    </div>

</form>
<div class='spaceHack'>&nbsp;</div>