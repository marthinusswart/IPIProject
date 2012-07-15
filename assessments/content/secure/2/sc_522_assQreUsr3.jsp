<%@ page language="java" import="beans.*" %>
<%@ page language="java" import="java.sql.*" %>

<%

        SessionManager sMan = new SessionManager(session);
        String[] users = request.getParameterValues("users");
        Questionaire qAss = sMan.getQre();
        Assignment ass;
        Customer dept = null;

        String msg = "The participants were assigned successfully.";
        boolean errOccurred = false;

        int userLevel = sMan.getUserLvl();

        try
        {

            // are you a (1)Customer or (2)Admin?
            if (userLevel == 2)
            {	// (1) customer

                Customer cust = new Customer(sMan.getCustID(true), null, 0);
                cust.loadFromDB(false);

                // Dept-assignment OR User-assignment? ..

                String deptID = request.getParameter("dept");

                if (deptID != null)
                {	// ..Dept-assignment:
                    // create & load dept-cust
                    dept = new Customer(deptID);

                    DBProxy db = new DBProxy();

                    try
                    {

                        dept.loadFromDB(true, db);		// < -- NOTE: heavy load (extended user details, address, etc.)

                        // new assignment
                        ass = new Assignment(dept.getUser().getPKID(), qAss.getPKID(), "0");

                        // store
                        ass.commit(db);

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
                else
                {					// ..User-assignment:

                    // enough credit?
                    if (cust.getCredits() >= users.length)
                    {	// .. YES: assign & subtract credit

                        // assign all users
                        for (int i = 0; i < users.length; i++)
                        {
                            // new assignment ('not started')
                            ass = new Assignment(null, qAss.getPKID(), "0");
                            ass.setUserName(users[i]);

                            // store
                            ass.commit();
                        }

                        // subtract credit
                        cust.setCredits(cust.getCredits() - users.length);
                        cust.update(); // -->> db

                    }
                    else
                    {								// .. NO: error message
                        msg = "Not enough credit.";
                        errOccurred = true;
                    }
                }
            }
            else if (userLevel == 1)
            {					// (2) Admin

                // null(users) means assign to Org-level user
                if (users == null)
                {

                    // get the user-pkid
                    String custID = (String) session.getAttribute("assCustID");
                    String userID = null;

                    DBProxy db = new DBProxy();

                    // there should be only 1 level-2 user/customer
                    ResultSet res = db.executeQuery(
                            "SELECT pkid, username FROM Users "
                            + "WHERE fkCustID=" + custID + " AND fkLevel=2");

                    if (res.next())
                    {
                        userID = res.getString("pkid");
                        users = new String[]
                                {
                                    res.getString("username")
                                };
                    }

                    // assign to org
                    ass = new Assignment(userID, qAss.getPKID(), "0");
                    ass.commit();

                }
                else
                {
                    // get the user-pkid
                    String custID = (String) session.getAttribute("assCustID");
                    Customer cust = new Customer(custID);
                    cust.loadFromDB(false);

                    // enough credit?
                    if (cust.getCredits() >= users.length)
                    {	// .. YES: assign & subtract credit

                        // assign all users
                        for (int i = 0; i < users.length; i++)
                        {
                            // new assignment ('not started')
                            ass = new Assignment(null, qAss.getPKID(), "0");
                            ass.setUserName(users[i]);

                            // store
                            ass.commit();
                        }

                        // subtract credit
                        cust.setCredits(cust.getCredits() - users.length);
                        cust.update(); // -->> db

                    }
                    else
                    {								// .. NO: error message
                        msg = "Not enough credit.";
                        errOccurred = true;
                    }
                }
            }
        }
        catch (Exception e)
        {
            msg = e.getMessage();
            errOccurred = true;
        }

%>

<h2>Assessments :: Assign Participants (result)</h2>
<hr>
<%=((errOccurred)
                              ? "<div class='err'>The participants were NOT assigned due to the following error: " + msg + "</div>"
                              : "<div class='success'>" + msg + "</div>")%>
<hr>
<%

        out.println("Questionaire: '<i>" + qAss.getName() + "</i>'<br><br>");
        out.println("Participants:<br><ul>");
        if (users != null)
        {
            for (int i = 0; i < users.length; i++)
            {
                out.println("<li>" + users[i] + "<br>");
            }
        }
        else if (dept != null)
        {
            out.println("<li>" + dept.getName() + " [user: " + dept.getUser().getUserName() + "]");
        }
        out.println("</ul>");

        session.removeAttribute("assCustID");
        session.removeAttribute("qre1");
%>

<input type="hidden" value="Page=522"/>