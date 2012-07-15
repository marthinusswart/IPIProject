import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.DBProxy;

/**
 * @author psnel
 *
 * Clears tables of the IPI DB, then parses input files, loading data into the db
 * on-the-fly. 
 */
public class IPIDataLoader  extends HttpServlet {
	
	private String sAppPath;
	
	private BufferedReader fIn;			// file reader
	private PrintWriter out; 			// browser output
	private DBProxy db;					// database
	private Vector vErr;				// errors messages 
	
	
	/* (non-Javadoc)
	 * @see javax.servlet.GenericServlet#init()
	 */
	public void init() throws ServletException {
		sAppPath = getServletContext().getRealPath("/");
	}
	
	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
		
		resp.setContentType("text/html");
		out = resp.getWriter();
		db = new DBProxy();
		vErr = new Vector();
		
		// clear the DB
		clearDB();
		
		// process files
		importFiles();
		
		// errors?
		if(!vErr.isEmpty()){
			out.println("<div style='color:red'><u><b>There were Errors while importing the data...</b></u><br><br><ul>");
			Enumeration e = vErr.elements();
			
			while(e.hasMoreElements()){
				out.println("<li>"+(String)e.nextElement());
			}
			out.println("</ul></div>");
			
		}
		
		db.close();
	}
	
	private void clearDB(){
		String[] sTables = {
				"Super_Construct",
				"Construct",
				"Wording"
		};
		
		String SQL = "DELETE FROM ";
		
		try{
			for(int i=0; i< sTables.length; i++){
				db.executeNonQuery(SQL+sTables[i]);
			}
		}catch(Exception e){
			vErr.add(e.getMessage());
		}
	}
	
	private void importFiles(){
		String[] sCSVFiles	= {
				"data/IPIQ_3org.csv",
				"data/IPIQ_1q.csv",
				"data/IPIQ_2alt.csv"};
		
		String SQL;
		String sLine;		// a line of text
		String[] sVals;		// tokenized sLine
		int iLine;			// current line number within file being processed
		
		// questions (1,2)
		int iConstruct=-1;	// current construct
		int iQuestion=0;	// current question
		int iCOrder=0;		// question order within construct
		//int iRange=5;		// 
		String sWording;	// current wording
		//ResultSet res;		// resultset for queries
		
		for(int fIndex=0;fIndex<sCSVFiles.length; fIndex++){
			if(!vErr.isEmpty()) break;
			
			out.println("<br><div style='color:blue; font-weight:bold'>Processing file: "+sCSVFiles[fIndex]+"</div><br><br>");
			
			try{
				fIn = new BufferedReader(new FileReader(sAppPath+sCSVFiles[fIndex]));
			}catch(FileNotFoundException fnfx){out.println(fnfx.getMessage()+" : "+sCSVFiles[fIndex]);}
			
			iLine=1;
			
			try{			
				switch(fIndex){
				
				case 0: // 3org
					boolean isOptional = false;
					boolean isPositive = false;
					boolean isNeutral	= false;
					
					// skip 2 lines
					fIn.readLine();fIn.readLine();
					iLine+=2;
					// read rest
					try{
						while((sLine = fIn.readLine()) != null){
							out.println("ln "+(iLine++)+": "+sLine+"<br>");
							sVals = null;
							sVals = sLine.split(",");
							
							// only process valid lines
							if(sVals.length>0 && !sVals[0].equals("")){
								// Super-Construct OR Construct?
								switch(sVals[0].charAt(0)){
								// Super-Construct
								case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
								case 'G':case 'H':case 'I':case 'J':case 'K':case 'L':
									// add to [Super_Construct] table
									SQL =	
										"INSERT INTO Super_Construct (code, name) " +
										"VALUES ('"+sVals[0].charAt(0)+"', '"+sVals[1]+"')";
									db.executeNonQuery(SQL);
									break;
									// Construct
								case '0':case '1':case '2':case '3':case '4':
								case '5':case '6':case '7':case '8':case '9':
									// is this Construct optional? ('Y'?)
									isOptional =  (	!sVals[3].equals("") ||
													!sVals[7].equals("") ||
													(sVals.length>=12 && !sVals[11].equals("")));
									// is this Construct positive or negative?
									isPositive = (	sVals[2].equals("+"));
									// is this Construct neutral (neither + or -)
									isNeutral  = (	sVals[2].equals(""));
									
									// add to [Construct] table
									SQL = 
										"INSERT INTO Construct (pkid, fkSC, name, isOptional, isPositive, isNeutral) " +
										"VALUES (" +
										sVals[0]+", currval('super_construct_pkid_seq'), " +
										"'"+sVals[1]+"', "+isOptional+", "+isPositive+", "+isNeutral+")";
									db.executeNonQuery(SQL);
									//System.out.println(SQL);
									break;
								}
							}
						}
					}catch(Exception e) {vErr.add(e.getMessage());};
					
					if(vErr.isEmpty())
						out.println("<div style='color:#5c5; font-weight:bold'>SUCCESS</div>");
					
					break;
					
				case 1: // 1q
					// skip 2 lines
					fIn.readLine();fIn.readLine();
					iLine+=2;
					// read rest
					try{
						while((sLine = fIn.readLine()) != null){
							out.println("ln "+(iLine++)+": "+sLine+"<br>");
							sVals = null;
							sVals = sLine.split(",");
							
							// only process valid lines
							if(sVals.length>2 && !sVals[1].equals("")){
								// is this a Construct header?
								if(!sVals[0].equals("")){	// YES:
									iConstruct = Integer.parseInt(sVals[0]);
									iCOrder = 0;
								}else{						// NO: [Question] + [Wording] 
									// insert [Question]..
									
									// .. get iRange from end (wording may have commas)
									//iRange = Integer.parseInt(sVals[sVals.length-5]) + Integer.parseInt(sVals[sVals.length-4]);
									
									SQL =
										"INSERT INTO Question (pkid, fkC, cOrder, isInverted) " +
										"VALUES ("+(++iQuestion)+", "+iConstruct+", "+(++iCOrder)+", "+sVals[5].equals("#")+")";
									
									db.executeNonQuery(SQL);
									
									// format & insert [Wording]..
									sWording=sVals[6].trim();
									// .. comma-split sentences
									if(sVals.length == 13) 
										sWording += ", "+sVals[7].trim();
									// .. full-stops
									if(!sWording.contains(".")) sWording += "."; 
									// .. remove quotes & double-spaces
									sWording = sWording.replaceAll("\"", "").replaceAll("'", "&acute;").replaceAll("  ", " ");
									
									SQL =
										"INSERT INTO Wording (fkQn, wording) " +
										"VALUES ("+iQuestion+", '"+sWording+"')";
									
									db.executeNonQuery(SQL);
								}
							}
						}
					}catch(Exception e){ vErr.add(e.getMessage()); }
					
					
					if(vErr.isEmpty())
						out.println("<div style='color:#5c5; font-weight:bold'>SUCCESS</div>");
					
					break;
					
				case 2: // 2alt
					// skip 3 lines
					fIn.readLine();fIn.readLine();fIn.readLine();
					iLine+=3;
					
					// read rest
					try{
						while((sLine = fIn.readLine()) != null){
							out.println("ln "+(iLine++)+": "+sLine+"<br>");
							sVals = null;
							sVals = sLine.split(",");
							
							// only process valid lines
							if(sVals.length>2 && !sVals[1].equals("")){
								// is this a Construct header?
								if(!sVals[0].equals("")){	// YES:
									iConstruct = Integer.parseInt(sVals[0]);
									iCOrder = 0;
								}else{						// NO: [Wording]								
									// format & insert [Wording]..
									sWording=sVals[5].trim();
									// .. comma-split sentences
									if(sVals.length == 7) 
										sWording += ", "+sVals[6].trim();
									// .. full-stops
									if(!sWording.contains(".")) sWording += "."; 
									// .. remove quotes & double-spaces									
									sWording = sWording.replaceAll("\"", "").replaceAll("'", "&acute;").replaceAll("  ", " ");
									
									SQL = 
										"INSERT INTO Wording (fkQn, alt, wording) " +
										"VALUES (" +
										"(SELECT pkid FROM Question WHERE fkC="+iConstruct+" AND cOrder="+(++iCOrder)+")," +
										"1, '"+sWording+"')";
									
									db.executeNonQuery(SQL);
									
								}
							}
						}
					}catch(Exception e){ vErr.add(e.getMessage()); }
					
					
					if(vErr.isEmpty())
						out.println("<div style='color:#5c5; font-weight:bold'>SUCCESS</div>");
				}
				
				fIn.close();
			}catch(IOException iox){iox.printStackTrace();}
			
		}
	}
}
