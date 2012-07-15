<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="beans.QreType" %>

<jsp:useBean id="db" class="beans.DBProxy" scope="page" />
<jsp:useBean id="newQre" class="beans.Questionaire" scope="session" />

<%
        // Is [Step 1] assesmment-name unique?
        String qName = db.legalizeString(request.getParameter("qname"));
        String SQL =
               "SELECT pkid "
               + "FROM Questionaire "
               + "WHERE name='" + qName + "'";

        ResultSet res = db.executeQuery(SQL);

        String[] sOptConstruct;											// optional Construct: (fksc, pkid, name)-tripair
        java.util.Vector vOptCs = new java.util.Vector(5, 5);	// list of optConstruct's

        if (!res.next())
        {		// YES: continue..

            // .. 1. find any optional constructs in db (add to sOptCs-vector : output on pg->>)...

            // ... break-up "pkid:code:name"s of added super-constructs
            String[] tmpOpts = request.getParameterValues("selSC");	// array of "pkid:code:name"
            String[][] SCs = new String[tmpOpts.length][3];
            String[] SCids = new String[tmpOpts.length];

            for (int i = 0; i < tmpOpts.length; i++)
            {
                SCs[i] = tmpOpts[i].split(":");
                SCids[i] = SCs[i][0];
            }

            // ... get from db
            SQL =
            "SELECT pkid, fkSC, name, isOptional "
            + "FROM Construct "
            + "WHERE fkSC IN (";
            for (int i = 0; i < SCids.length - 1; i++)
            {
                SQL += SCids[i] + ',';
            }
            SQL += SCids[SCids.length - 1] + ") ORDER BY pkid";

            ResultSet res2 = db.executeQuery(SQL);

            // ... add optional constructs to vector
            while (res2.next())
            {
                if (res2.getBoolean("isOptional"))
                {
                    sOptConstruct = new String[3];
                    sOptConstruct[0] = res2.getString("fkSC");
                    sOptConstruct[1] = res2.getString("pkid");
                    sOptConstruct[2] = res2.getString("name");
                    vOptCs.addElement(sOptConstruct);
                }
            }


            // .. 2. find any alternative wordings (output on page->>)
            // TODO -	implement this.. for now we'll simply output 2 sets (0 & 1),
            // 			and assign it to the Qre we're creating - when we output the
            //				questions during a test, we check for alternative wordings.

            // .. 3. put everything so-far into the session (more, further down)
            newQre.setName(qName);
            newQre.setDesc(request.getParameter("qdesc"));
            newQre.setSCs(SCs);
            // type
            int type = Integer.parseInt(request.getParameter("type"));
            switch (type)
            {
                case 1:
                    newQre.setType(new QreType(1, "VA", "Values Profile Assessment"));
                    break;
                case 2:
                    newQre.setType(new QreType(2, "FA", "Full Assessment"));
                    break;
                case 3:
                    newQre.setType(new QreType(3, "JP", "Job Definition Profile"));
                    break;
                case 4:
                    newQre.setType(new QreType(4, "SI", "Organization Screening Inventory"));
                    break;
                case 5:
                    newQre.setType(new QreType(5, "PP", "Personal Profile"));
                    break;
                case 6:
                    newQre.setType(new QreType(6, "HA", "Highschool Assessment"));
                    break;
                case 7:
                    newQre.setType(new QreType(7, "CP", "Career Planning Inventory"));
                    break;
            }

        }
        else
        {					// NO: redirect back to [step 1 & 2]

%><jsp:forward page="/index.jsp?pg=-510&err=1&qname=<%=qName%>" /><%

                }

%>

<h2>Assessments :: New Questionaire (cont.)</h2>
<hr>
<div>&nbsp;</div>
<hr>

<script type='text/javascript' src='script/client/sc51.js'></script>

<form action='index.jsp' method='post'>
    <p>
        <b>Step 3: Remove optional Constructs</b><br><br>

        <%
                // output the optional constructs (if any was found)

                if (!vOptCs.isEmpty())
                {
                    java.util.Enumeration e = vOptCs.elements();	// for iterating the vector
                    String[] sSC;			// array[pkid, code, name] for Super-Construct
                    String[] sOptC;		// array[fkSC, pkid, name] for optional construct
                    String[] pkid;			// pkid of an SC
                    String sCurrSC = "";	// current Super-Construct under which we are printing opt. constructs


                    out.println("<table>");
                    while (e.hasMoreElements())
                    {
                        sOptC = (String[]) e.nextElement();
                        // new group of optionals under new Super-Construct?
                        sSC = newQre.getSC(sOptC[0]);
                        if (!sCurrSC.equals(sSC[0]))
                        { // YES: print SC header
                            out.println("	<tr>");
                            out.println("		<td><b>" + sSC[1] + ". " + sSC[2] + "</b></td>");
                            out.println("	</tr>");
                            sCurrSC = sSC[0];
                        }
                        // checkbox values = "fSC:pkid:name"
                        out.println("	<tr>");
                        out.println("		<td><input type='checkbox' name='optC' value='" + sOptC[0] + ":" + sOptC[1] + ":" + sOptC[2] + "' />" + sOptC[1] + ". " + sOptC[2] + "</td>");
                        out.println("	</tr>");
                    }
                    out.println("</table>");
                }
                else
                {
                    out.println("N/A<br>");
                }

        %>

    </p>
    <hr>
    <p>
        <b>Step 4: Choose from available Wording-sets</b><br>
        <i>(note: if there are no alternative wording sets available for a Construct, the default set (1) will be used)</i><br><br>
    <table>
        <tr>
            <td><input type='radio' name='radWording' value='0' checked /></td>
            <td>1. Wording Set 1 (individual) </td>
        </tr>
        <tr>
            <td><input type='radio' name='radWording' value='1' /></td>
            <td>2. Wording Set 2 (organizational) </td>
        </tr>
    </table>
</p>

<hr>
<br>
<div style='text-align:right;'>
    <input type='submit' value=" Step 5 >> " />
</div>

<input type='hidden' name='pg' value="-512" />
</form>

<% db.close();%>