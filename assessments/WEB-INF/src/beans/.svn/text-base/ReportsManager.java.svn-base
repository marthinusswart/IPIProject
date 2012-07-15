/* ReportsManager.java
 * 
 * Created on 27-Jul-2005
 */
package beans;

import java.sql.ResultSet;
import java.util.Date;
import java.util.Vector;
import org.apache.log4j.Logger;
import org.apache.log4j.Priority;

/**
 * This class acts as a factory for Reports. It retrieves report data from the database and
 * constructs Reports, or arrays of reports, bases on the context. E.g. if only a listing of
 * available reports is required, superficial reports are created; if detailed reports are
 * required, Reports are constructed with the required fields. 
 * 
 * @author psnel
 *
 */
public class ReportsManager
{

    private static int reportCount = 0;
    private static long startTime;
    private static long endTime;

    /**
     * @return Returns the reportCount.
     */
    public static int getReportCount()
    {
        return reportCount;
    }

    public static Report[] getReportsByUser(String username) throws Exception
    {
        Report[] retVal = null;

        return retVal;

    }

    public static Customer getCustomerByReportId(String reportId)
    {
        Customer result = null;

        String sql = "SELECT c.pkid "
                     + "FROM customer c, users u, _assignment a "
                     + "WHERE a.pkid=" + reportId + " "
                     + "AND u.pkid = a.fkuser "
                     + "AND c.pkid = u.fkcustid";

        DBProxy db = new DBProxy();
        ResultSet res = null;

        try
        {
            res = db.executeQuery(sql);

            if (res.next())
            {
                String customerId = res.getString("pkid");
                result = new Customer();
                result.setPKID(customerId);
                result.loadFromDB(false, db);
            }
        }
        catch (Exception ex)
        {
            Logger.getLogger("ReportsManager").error("Failed to load the customer", ex);
        }
        finally
        {
            try
            {
                res.close();
                db.close();
            }
            catch (Exception ex)
            {
                // Nothing
            }

        }

        return result;
    }

    /**
     * @param custpkid pkid of cutomer for whom reports must be retrived, or null
     * @return array of reports for customer, or all reports id custpkid = null 
     * @throws Exception on db error
     */
    public static Report[] getReportsByCustomer(String custpkid) throws Exception
    {
        Report[] retVal = null;

        DBProxy db = new DBProxy();
        ResultSet res;
        String SQL;

        try
        {
            // count reports
            SQL = "SELECT " + ((custpkid != null)
                               ? " countCustReports(" + custpkid + ") "
                               : " countReports() ")
                  + "AS cnt";
            res = db.executeQuery(SQL);

            if (res.next())
            {
                retVal = new Report[reportCount = res.getInt("cnt")];
            }

            // get reports
            SQL = "SELECT * FROM " + ((custpkid != null) ? "getReportsByCustID(" + custpkid + ")" : "getReports()");
            res = db.executeQuery(SQL);


            int i = 0;
            Assignment aTmp;
            String uName;		// user's full name string

            while (res.next())
            {
                // init Report()
                aTmp = new Assignment(
                        res.getString("assmtID"),
                        res.getString("usrID"),
                        res.getString("qreID"), "");
                uName = User.fullName(res.getString("title"), res.getString("fname"),
                                      res.getString("initial"), res.getString("lname"));

                retVal[i++] = new Report(
                        aTmp, res.getString("submittime"),
                        res.getString("qname"), uName, res.getString("custName"));
            }

        }
        catch (Exception e)
        {
            throw new Exception("Failed to load the reports by customer: " + e.getMessage());
        }
        finally
        {
            db.close();
        }


        return retVal;
    }

    public static Report[] createMatrix(String reportIds) throws Exception
    {
        Vector vecReports = new Vector();
        String[] reports = reportIds.split(",");
        Logger logger = Logger.getLogger("ReportsManager");

        for (int i = 0; i < reports.length; i++)
        {
            logger.debug("Adding report to matrix structure");
            vecReports.add(createReport(Integer.parseInt(reports[i])));
        }

        Report[] reportArray = new Report[vecReports.size()];

        // we can compare any report with any report
        for (int i = 0; i < reportArray.length; i++)
        {
            reportArray[i] = (Report) vecReports.get(i);            
        }

        return reportArray;
    }

    public static Report createReport(int assmtid) throws Exception
    {
        Report retVal = null;
        DBProxy db = new DBProxy();
        ResultSet res;

        try
        {
            // get report info
            res = db.executeQuery("SELECT * FROM getReportByAssmtID(" + assmtid + ")");
            if (res.next())
            {
                // construct the Report
                Assignment aTmp = new Assignment(
                        res.getString("assmtID"),
                        res.getString("usrID"),
                        res.getString("qreID"), "");

                Questionaire qre = new Questionaire(res.getString("qreID"));
                qre.loadFromDB(null, false);
                aTmp.setQre(qre);

                String uName = User.fullName(res.getString("title"), res.getString("fname"),
                                             res.getString("initial"), res.getString("lname"));

                retVal = new Report(
                        aTmp, res.getString("submittime"),
                        res.getString("qname"), uName, res.getString("custName"));

            }

            // Get answer-list for report..
            QandA[] repAnswerList = null;

            // .. count answers
            res = db.executeQuery("SELECT countRepAnswers(" + assmtid + ")");
            if (res.next())
            {
                repAnswerList = new QandA[res.getInt(1)];
            }

            // .. get anwers
            res = db.executeQuery("SELECT * FROM getRepAnswersByAssmtID(" + assmtid + ")");
            int i = 0;
            while (res.next())
            {
                repAnswerList[i++] = new QandA(
                        res.getInt("constID"), res.getInt("answer"), res.getInt("timetaken"),
                        res.getInt("ndoubted"), res.getBoolean("isinverted"));
            }

            retVal.setQnaAnswerList(repAnswerList);


        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            db.close();
        }

        return retVal;
    }

    private String generateOnScreenMatrix(Report[] reports, int matrixType, int reportType) throws Exception
    {
        DBProxy db = new DBProxy();
        StringBuffer html = new StringBuffer();
        ReportCategory[] reportCategories = ReportCategory.getReportCategories();
        Logger logger = Logger.getLogger("ReportsManager");

        try
        {
            logger.debug("Adding the style");
            addStyle(html, reports.length);
            logger.debug("Adding the header");
            addMatrixHeader(html, reports[0]);
            logger.debug("Adding the the key");
            addReportKey(html);

            logger.debug("Report cat count " + reportCategories.length);

            for (int i = 0; i < reports.length; i++)
            {
                startTime = System.currentTimeMillis();
                reports[i].loadConstructs(db);
                logger.debug("report constructs " + reports[0].getConstructs().length);
                endTime = System.currentTimeMillis();
            }

            ReportCategory.syncConstructs(reports[0].getConstructs(), reportCategories);

            logger.debug("Report cat count " + reportCategories.length);
            logger.debug("Going to add the gategories");
            addReportCategories(html, reportCategories, reports, matrixType, reportType);
        }
        finally
        {
            db.close();
        }

        return html.toString();
    }

    private String generateOnScreenReport(Report report) throws Exception
    {
        DBProxy db = new DBProxy();
        StringBuffer html = new StringBuffer();
        ReportCategory[] reportCategories = ReportCategory.getReportCategories();

        try
        {
            startTime = System.currentTimeMillis();
            report.loadConstructs(db);
            ReportCategory.syncConstructs(report.getConstructs(), reportCategories);
            endTime = System.currentTimeMillis();

            addStyle(html, 1);
            addReportHeader(html, report);
            addReportKey(html);
            addReportCategories(html, reportCategories);

            long totalTime = endTime - startTime;
            //html.append("Report generation: ("+ totalTime + ") ms\n");
        }
        finally
        {
            db.close();
        }

        return html.toString();
    }

    public static String displayOnScreen(Report[] reports, int matrixType, int reportType) throws Exception
    {

        String HTML = null;					// return html

        try
        {

            ReportsManager reportManager = new ReportsManager();
            try
            {
                HTML = reportManager.generateOnScreenMatrix(reports, matrixType, reportType);
            }
            catch (Exception ex)
            {
                HTML = "Failed to generate the report: " + ex.getMessage() + " Ex: " + ex.toString();
            }

        }
        catch (Exception e)
        {
            throw e;
        }

        return HTML;
    }

    public static String displayOnScreen(Report report, int scrType) throws Exception
    {

        String HTML = null;					// return html

        try
        {
            switch (scrType)
            {
                case 0:
                    ReportsManager reportManager = new ReportsManager();
                    try
                    {
                        HTML = reportManager.generateOnScreenReport(report);
                    }
                    catch (Exception ex)
                    {
                        HTML = "Failed to generate the report: " + ex.getMessage() + " Ex: " + ex.toString();
                    }
                    break;

                case 1: // graphs
                    HTML = "The 'Display Graph' feature in not available";
                    break;

                case 2: // full (graphs + narratives)
                    HTML = "The 'Full Report' feature in not available";
                    break;

            }
        }
        catch (Exception e)
        {
            throw e;
        }

        return HTML;
    }

    private static String styleString(Construct construct, int total)
    {
        String retVal = null;
        if (construct.isNeutral())
        {
            retVal = "neutral";
        }
        else if (construct.isPositive())
        {
            if (total < 30)
            {
                retVal = "danger";
            }
            else if (total >= 30 && total < 50)
            {
                retVal = "urgent";
            }
            else if (total >= 50 && total < 73)
            {
                retVal = "attention";
            }
            else if (total >= 73 && total < 79)
            {
                retVal = "warning";
            }
            else if (total >= 95)
            {
                retVal = "exceptional";
            }
            else
            {
                retVal = "recommend";
            }
        }
        else
        {// negative construct
            if (total <= 5)
            {
                retVal = "exceptional";
            }
            else if (total < 22)
            {
                retVal = "recommend";
            }
            else if (total >= 22 && total < 28)
            {
                retVal = "warning";
            }
            else if (total >= 28 && total < 50)
            {
                retVal = "attention";
            }
            else if (total >= 50 && total < 70)
            {
                retVal = "urgent";
            }
            else
            {
                retVal = "danger";
            }
        }
        return retVal;
    }

    private void addStyle(StringBuffer html, int reportCount)
    {
        html.append("<style type='text/css'>\n");
        html.append(".tbl1{border-collapse:collapse;}\n");
        //html.append(".tbl1{border-style:solid;}\n");
        html.append(".field{\n");
        html.append("	border:	1px solid black;\n");
        html.append("	background-color:#ccc;\n");
        html.append("	padding:2px 4px 2px 4px;\n");
        html.append("	font-weight: bold;\n");
        html.append("	font-size: 8pt;\n");
        html.append("}\n");
        html.append(".value{\n");
        html.append("	border:	1px solid black;\n");
        html.append("	background-color:#fff;\n");
        html.append("	padding:2px 4px 2px 4px;\n");
        html.append("	font-style:italic;\n");
        html.append("	font-size: 8pt;\n");
        html.append("}\n");
        html.append(".col{background-color:#E3DCDE; color:#FFF; font-weight:bold ; border:1px solid #111; padding:0 3px 0 3px;}\n");
        html.append(".col2{background-color:#E3DCDE;font-weight:bold ; border:1px solid #111; padding:0 3px 0 3px;text-align:center;}\n");
        html.append(".total{font-weight:bold;border:1px solid #111; padding:0 3px 0 3px;}\n");
        html.append(".tableHeader{vertical-align:middle;text-align:center;width:200px;height:50px;}");
        html.append(".rowOdd{background-color:#DDD;}\n");
        html.append(".number{text-align:center; font-weight:bold;}\n");
        html.append(".neutral{color: #77A;}\n");
        html.append(".recommend{color:green;}\n");
        html.append(".warning{color:blue;}\n");
        html.append(".attention{color:orange;}\n");
        html.append(".urgent{color:red;}\n");
        html.append(".danger{color:purple}");
        html.append(".negative{color:red;}\n");
        html.append(".positive{color:green;}\n");
        html.append(".exceptional{color:black;}\n");
        html.append(".construct{font-size:12;}\n");
        html.append(".centered{text-align:center;}\n");
        html.append(".imageCol{width:450px;}\n");
        html.append(".constructCol{width:300px;}\n");
        //html.append(".constructColMatrix{width:" + ((reportCount * 100) + 300) + "px;}\n");
        html.append(".constructColMatrix{width:800px;}\n");
        html.append(".constructColMatrixSections{width:300px;}\n");
        html.append(".constructColMatrixResultsOuter{width:500px;}\n");
        html.append(".constructColMatrixResultsOuterPrintable{width:" + ((reportCount * 100) + 300) + "px;}\n");
        html.append(".constructColMatrixResults{width:" + ((reportCount * 100) + 300) + "px;}\n");
        html.append(".dottedborder{border-style:dotted;}\n");
        html.append(".solidborder{border:1px solid black;}\n");
        html.append(".categorytable{width:750px;}\n");
        html.append(".totalcol{width:100px;}\n");
        //html.append(".categorytableMatrix{width:" + ((reportCount * 100) + 800) + "px;}\n");
        html.append(".categorytableMatrix{width:900px;}\n");
        html.append(".title{border: 1px solid black;margin-top:20px;width:300px;padding: 5px 0 5px 5px;background-color: #ccc;font-weight:bold;}\n");
        html.append(".scrollableDiv{overflow:auto;}\n");
        html.append("</style>\n\n");
    }

    private void addReportHeader(StringBuffer html, Report report)
    {
        html.append("<table>\n");
        html.append("<tr>\n");
        html.append("<td>\n");
        html.append("<b>Construct totals</b><br><br>\n");
        html.append("<table class='tbl1'>\n");
        html.append("	<tr>\n");
        html.append("		<td class='field'>Assessment:</td>\n");
        html.append("		<td class='value'>" + report.getQreName() + "</td>\n");
        html.append("		<td class='field'>Time Submitted (local):</td>\n");
        html.append("		<td class='value'>" + report.getAssmtTime() + "</td>\n");
        html.append("	</tr>\n");
        html.append("	<tr>\n");
        html.append("		<td class='field'>Person:</td>\n");
        html.append("		<td class='value'>" + report.getUserFullName() + "</td>\n");
        html.append("		<td class='field'>Organization:</td>\n");
        html.append("		<td class='value'>" + report.getCustomerName() + "</td>\n");
        html.append("	</tr>\n");
        html.append("	</table>\n");
        html.append("</td>\n");

        Customer customer = getCustomerByReportId(report.getReportId());
        if (customer == null)
        {
            html.append("			<td style='vertical-align:middle;width:300px;text-align:right;'><img border='0' src='images/ipilogo.jpg' height='100px'></td>\n");
        }
        else
        {
            if (customer.getLogo() != null && !(customer.getLogo().equals("")))
            {
                html.append("			<td style='vertical-align:middle;width:300px;text-align:right;'><img border='0' src='images/" + customer.getLogo() + "' height='100px'></td>\n");
            }
            else
            {
                html.append("			<td style='vertical-align:middle;width:300px;text-align:right;'><img border='0' src='images/ipilogo.jpg' height='100px'></td>\n");
            }
        }

        html.append("</tr>\n");
        html.append("</table>\n");
        html.append("</table><br>\n");
    }

    private void addMatrixHeader(StringBuffer html, Report report) throws Exception
    {
        Logger logger = Logger.getLogger("ReportsManager");
        if (report == null)
               logger.debug("Adding matrix header [null]");

        html.append("<table>\n");       
        html.append("<tr>\n");
        html.append("<td>\n");
        html.append("<b>Construct totals</b><br><br>\n");
        html.append("<table class='tbl1'>\n");
        html.append("	<tr>\n");
        html.append("		<td class='field'>Assessment:</td>\n");
        html.append("		<td class='value'>" + report.getQreName() + "</td>\n");      
        html.append("		<td class='field'>Time Submitted (local):</td>\n");
        html.append("		<td class='value'>" + report.getAssmtTime() + "</td>\n");
        html.append("	</tr>\n");
        html.append("	</table>\n");
        html.append("</td>\n");

        logger.debug("Get the customer");
        Customer customer = getCustomerByReportId(report.getReportId());
        if (customer == null)
        {
            html.append("			<td style='vertical-align:middle;width:600px;text-align:right;'><img border='0' src='images/ipilogo.jpg' height='100px'></td>\n");
        }
        else
        {
            if (customer.getLogo() != null && !(customer.getLogo().equals("")))
            {
                html.append("			<td style='vertical-align:middle;width:600px;text-align:right;'><img border='0' src='images/" + customer.getLogo() + "' height='100px'></td>\n");
            }
            else
            {
                html.append("			<td style='vertical-align:middle;width:600px;text-align:right;'><img border='0' src='images/ipilogo.jpg' height='100px'></td>\n");
            }
        }

        html.append("</tr>\n");
        html.append("</table>\n");
        html.append("</table><br>\n");
    }

    private void addReportCategories(StringBuffer html, ReportCategory[] reportCategories,
                                     Report[] reports, int matrixType, int reportType)
    {
        Logger logger = Logger.getLogger("ReportsManager");
        for (int i = 0; i < reportCategories.length; i++)
        {
            if (reportCategories[i].getRelevantConstructs().length > 0)
            {
                logger.debug("add report category");
                // Always add to a new page except on first
                addReportCategoryTable(html, reportCategories[i], reports, matrixType, reportType);
            }
        }
    }

    private void addReportCategories(StringBuffer html, ReportCategory[] reportCategories)
    {
        for (int i = 0; i < reportCategories.length; i++)
        {
            if (reportCategories[i].getRelevantConstructs().length > 0)
            {
                // Always add to a new page except on first
                addReportCategoryTable(html, reportCategories[i]);
            }
        }

    }

    private void addReportCategoryTable(StringBuffer html, ReportCategory reportCategory,
                                        Report[] reports, int matrixType, int reportType)
    {
        Logger logger = Logger.getLogger("ReportsManager");

        html.append("<p></p>");

        html.append("<div style='page-break-inside:avoid'>");

        logger.debug("Adding titles");
        addCategoryTitle(html, reportCategory);

        html.append("<table class='solidborder categorytableMatrix'>\n");

        html.append("<tr>");
        html.append("<td class='constructColMatrix'>\n");

        addCategoryConstructsTable(html, reportCategory, reports, matrixType, reportType);

        html.append("</td>\n");

        html.append("<td class='imageCol'>\n");

        if ((reportCategory.getImage() != null) && (!(reports[0].getAssignment().getQre().getType().getCode().equals("JP"))))
        {
            addCategoryDefinitions(html, reportCategory);
        }

        html.append("</td>\n");

        html.append("</tr>\n");
        html.append("</table>\n");
        html.append("</div>");
    }

    private void addReportCategoryTable(StringBuffer html, ReportCategory reportCategory)
    {
        html.append("<p></p>");

        html.append("<div style='page-break-inside:avoid'>");

        addCategoryTitle(html, reportCategory);

        html.append("<table class='solidborder categorytable'>\n");

        html.append("<tr>");
        html.append("<td class='constructCol'>\n");

        addCategoryConstructsTable(html, reportCategory);

        html.append("</td>\n");

        html.append("<td class='imageCol'>\n");

        if (reportCategory.getImage() != null)
        {
            addCategoryDefinitions(html, reportCategory);
        }

        html.append("</td>\n");

        html.append("</tr>\n");
        html.append("</table>\n");
        html.append("</div>");
    }

    private void addConstructs(StringBuffer html, Construct[] constructs)
    {
        int total = 0;

        for (int i = 0; i < constructs.length; i++)
        {
            String rowClass = "class='construct";

            if (!constructs[i].isPositive() && !constructs[i].isNeutral())
            {
                rowClass += " negative";
            }

            if (i % 2 != 0)
            {
                rowClass += " rowOdd";
            }

            rowClass += "'";

            total = constructs[i].computeTotal();
            html.append("	<tr>\n");
            html.append("		<td " + rowClass + ">" + constructs[i].getPKID() + ".)</td>\n");
            html.append("		<td " + rowClass + ">" + constructs[i].getName() + "</td>\n");
            html.append("		<td class='number " + styleString(constructs[i], total) + ((i % 2 != 0) ? " rowOdd'" : "'"));
            html.append(">" + total + "</td>\n");
            html.append("	</tr>\n");
        }
    }

    private void addConstructs(StringBuffer html, Construct[] constructs, Report reports[])
    {
        int total = 0;

        for (int i = 0; i < constructs.length; i++)
        {
            String rowClass = "class='construct";

            if (!constructs[i].isPositive() && !constructs[i].isNeutral())
            {
                rowClass += " negative";
            }

            if (i % 2 != 0)
            {
                rowClass += " rowOdd";
            }

            rowClass += "'";

            html.append("	<tr>\n");
            html.append("		<td " + rowClass + ">" + constructs[i].getPKID() + ".)</td>\n");
            html.append("		<td " + rowClass + ">" + constructs[i].getName() + "</td>\n");
            html.append("	</tr>\n");
        }
    }

    private void addConstructTotals(StringBuffer html, Construct[] constructs, Report reports[])
    {
        int total = 0;

        for (int i = 0; i < constructs.length; i++)
        {

            html.append("	<tr>\n");

            for (int j = 0; j < reports.length; j++)
            {
                Construct reportConstruct = reports[j].getConstructById(constructs[i].getPKID());
                if (reportConstruct != null)
                {
                    total = reportConstruct.computeTotal();
                    html.append("		<td class='construct number " + styleString(constructs[i], total) + ((i % 2 != 0) ? " rowOdd'" : "'"));
                    html.append(">" + total + "</td>\n");
                }
            }

            html.append("	</tr>\n");

        }
    }

    private void addReportKey(StringBuffer html)
    {
        html.append("<div class='positive'>* Positive functioning constructs</div>\n");
        html.append("<div class='negative'># Negative functioning constructs</div>\n");
    }

    private void addCategoryConstructsTable(StringBuffer html, ReportCategory reportCategory,
                                            Report[] reports, int matrixType, int reportType)
    {
        html.append("<table class='tbl1'>\n");
        html.append("<tr>\n");
        html.append("<td>\n");

        html.append("<table class='tbl1 constructColMatrixSections'>\n");
        html.append("	<tr>\n");
        html.append("		<td class='col2 " + (reportCategory.isPositive() ? "positive" : "negative")
                    + "' style='vertical-align:middle;width:25px'>" + (reportCategory.isPositive() ? "*" : "#") + "</td>\n");
        html.append("		<td class='col2 " + (reportCategory.isPositive() ? "positive" : "negative")
                    + " tableHeader'>" + reportCategory.getName() + "</td>\n");
        html.append("	<tr>\n");

        addConstructs(html, reportCategory.getRelevantConstructs(), reports);

        html.append("</table>\n");
        html.append("</td>\n");

        html.append("<td>\n");

        if (reportType == 0)
        {
            html.append("<div class='scrollableDiv'>\n");
            html.append("<div class='constructColMatrixResultsOuter'>\n");
            html.append("<table class='tbl1 constructColMatrixResults'>\n");
        }
        else
        {
            html.append("<div>\n");
            html.append("<div class='constructColMatrixResultsOuterPrintable'>\n");
            html.append("<table class='tbl1 constructColMatrixResults'>\n");
        }

        html.append("<tr>\n");

        int counter = 1;
        for (int i = 0; i < reports.length; i++)
        {
            String name = null;

            if (reports[0].getAssignment().getQre().getType().getCode().equals("JP")
                && (i == 0))
            {
                name = "Job Definition";
            }
            else
            {
                name = "Candidate " + (counter);

                if (matrixType == 1)
                {
                    name = reports[i].getUserFullName();
                }

                counter++;
            }

            html.append("		<td class='total tableHeader'>" + name + "</td>\n");


        }

        html.append("	</tr>\n");

        addConstructTotals(html, reportCategory.getRelevantConstructs(), reports);

        html.append("</table>\n");
        html.append("</div>\n");

        html.append("</div>\n");


        html.append("</td>\n");
        html.append("</tr>\n");
        html.append("</table>\n");




    }

    private void addCategoryConstructsTable(StringBuffer html, ReportCategory reportCategory)
    {
        html.append("<table class='tbl1'>\n");

        html.append("	<tr>\n");
        html.append("		<td class='col2 " + (reportCategory.isPositive() ? "positive" : "negative")
                    + "' width='25px'>" + (reportCategory.isPositive() ? "*" : "#") + "</td>\n");
        html.append("		<td class='col2 " + (reportCategory.isPositive() ? "positive" : "negative")
                    + "' width='250px'>" + reportCategory.getName() + "</td>\n");
        html.append("		<td class='total' width='40px'>Total</td>\n");
        html.append("	</tr>");

        addConstructs(html, reportCategory.getRelevantConstructs());
        html.append("</table>\n");
    }

    private void addCategoryDefinitions(StringBuffer html, ReportCategory reportCategory)
    {
        String image = "<img src='images/" + reportCategory.getImage() + "' alt=''>";
        html.append("<p class='centered'>");
        html.append(image);
        html.append("</p>\n");
    }

    private void addCategoryTitle(StringBuffer html, ReportCategory reportCategory)
    {
        html.append("<div class='title'>" + reportCategory.getName() + "</div>");
    }
}
