package beans;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;

import javax.servlet.jsp.JspWriter;

/*
 * Created on 13-Jun-2005
 *
 * 
 */

/**
 * @author psnel
 *
 * 
 */
public class Err {
	// static array of err..
	private static String[] gsMsgList= {
			"You must be logged in to view this page.",
			"The page you've requested is unavailable.",
			"The login details you provided was incorrect. Please try again.",
			"Your maximum number of failed consecutive logins have been exceeded. Please return later.",
			"The operation could not be completed. The following error was reported: "};
	
	// indexes into message array
	public static int E_LOGIN_NEEDED		= 0; 
	public static int E_PAGE_NOT_FOUND		= 1;
	public static int E_LOGIN_FAILED		= 2;
	public static int E_MAX_FAILED_LOGINS	= 3;
	public static int E_GENERIC			= 4;

	
	public static void printDBErr(String msg, Writer out, boolean isWriteErr){
		printDBErr(msg, out, isWriteErr, false);
	}
	
	public static void printDBErr(String msg, Writer out, boolean isWriteErr, boolean calledFromJSP){
		String html_msg =
			"There was a problem "+((isWriteErr)?"writing to":"reading from")+" the database. " +
			"The following error was given: " + msg;
		print(html_msg, out, calledFromJSP);
	}
	
	public static String genericMsg(Exception e){
	    return gsMsgList[E_GENERIC]+e.getMessage();
	}
	
	/**
	 * Prints a error message 'msg', within a html DIV tag with class='err'.
	 * 
	 * @param msg the error message.
	 * @param out the Writer to which the error string will be written. 
	 */
	public static void print(String msg, Writer out){
		print(msg, out, false);
	}

	
	/**
	 * Prints a error message 'msg', within a html DIV tag with class='err'.
	 * 
	 * @param msg the error message.
	 * @param out the Writer to which the error string will be written.
	 * @param calledFromJSP determines whether Writer is cast to a java.io.PrintWriter or javax.servlet.jsp.JspWriter
	 */
	public static void print(String msg, Writer out, boolean calledFromJSP){
		String output = "<div class='err'>"+msg+"</div>";
		if(!calledFromJSP){ // servlet output
			((PrintWriter)out).println(output);
		}else{
			try{			// jsp output
				((JspWriter)out).println(output);
			}catch(IOException iox){}
		}
	}

	
	/**
	 * Prints a error message specified by <code>errCode</code>, within a html DIV tag with class='err'.
	 * 
	 * @param errCode one of the static constant error-codes of this class.
	 * @param out the PrintWriter to which the error string will be written. 
	 */
	public static void print(int errCode, PrintWriter out){
		print(gsMsgList[errCode], out);
	}

	/**
	 * Retrieves a specified String error message. 
	 * 
	 * @param errCode one of the static constant error-codes of this class.
	 * @return the String error message mapped to errCode.
	 */
	public static String getMsg(int errCode){
		return gsMsgList[errCode]; }
	
	
}
