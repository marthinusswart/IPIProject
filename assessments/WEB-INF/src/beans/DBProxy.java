package beans;

import java.sql.*;
import java.util.*;
import java.io.*;
import java.net.*;
import javax.servlet.ServletContext;

/**
 * Manages Database-related tasks: connections, queries, etc.
 *
 *  @author psnel
 * 
 *	TODO - implement this class as a (request-scoped) Singleton -- 
 */
public class DBProxy
{

    private String gsDBDriver = "org.postgresql.Driver";
    private String gsDbUrl = "jdbc:postgresql:fnctlint_ipi";
    private String gsUser = "fnctlint_ipiweb";
    private String gsPasswd = "1P1w3b";
    private Connection gConn;

//public static String err=null;
    public DBProxy()
    {
        open();
    }

    public DBProxy(String driver, String dbURL, String user, String passwd)
    {
        gsDBDriver = driver;
        gsDbUrl = dbURL;
        gsUser = user;
        gsPasswd = passwd;

        // load the driver and establish connection
        open();
    }

    /* (non-Javadoc)
     * @see java.lang.Object#finalize()
     */
    protected void finalize() throws Throwable
    {
        close();
    }

    /**
     * Execute a query that <i>don't</i> return anything
     * @param sql SQL statement to run
     * @return number of rows affected
     */
    public int executeNonQuery(String sql) throws Exception
    {
        int retVal = 0;
        try
        {
            Statement statement = gConn.createStatement();

            // Perform the query
            retVal = statement.executeUpdate(sql);
            statement.close();
        }
        catch (SQLException e)
        {
            throw new Exception(e.getMessage());
        }

        return retVal;
    }

    /**
     * Execute a query that returns results.
     * @param sql SQL query to run
     * @return a ResultSet with the rows that satisfied the query.
     */
    public ResultSet executeQuery(String sql) throws Exception
    {
        ResultSet retVal = null;
        try
        {
            Statement statement = gConn.createStatement();

            // Perform the query
            retVal = statement.executeQuery(sql);
        }
        catch (SQLException e)
        {
            throw new Exception(e.getMessage());
        }

        return retVal;
    }

    public static String legalizeString(String str)
    {
        if (str == null)
        {
            return null;
        }

        // replace all illegal chars
        return str.replaceAll("\"", "´´").replaceAll("'", "´").replaceAll(">", ")").replaceAll("<", "(").trim();
    }

    private void open()
    {
        try
        {
            // load the jdbc driver
            Class.forName(gsDBDriver);

            // create the connection object
            gConn = DriverManager.getConnection(gsDbUrl, gsUser, gsPasswd);
        }
        catch (ClassNotFoundException ex)
        {
            ex.printStackTrace();
//err=ex.getMessage();
        }
        catch (SQLException e)
        {
            System.err.println("SQLException in DBProxy.open(): " + e.getMessage());
//err=e.getMessage();
        }
    }

    /**
     * Release the connection maintained by this proxy
     */
    public void close()
    {
        try
        {
            gConn.close();
        }
        catch (SQLException e)
        {
            System.err.println("SQLException in DBProxy.close(): " + e.getMessage());
        }
    }
}
