<%@ page language="java" import="beans.*" %>
<%

// TEST_STATUS
final int TS_NOT_STARTED	= 0;
final int TS_IN_PROGRESS	= 1;
final int TS_COMPLETED	   = 2;
final int TS_CANCELED		= 3;


SessionManager sMan	= new SessionManager(session);

LiveTest lt	 = sMan.getLiveTest();
QandA [] qns = null;						// the questions to display

boolean	is1stVisit = false;
String	msg = "";

// test_status
int status = Integer.parseInt(lt.getAssmt().getFkTstStatus());

try{

   switch(status){
   	case TS_NOT_STARTED:
   		lt.start();
   		
   		// get the next set of questions
			qns = lt.getNext();
   		
   		break;

   	case TS_IN_PROGRESS:
	   	// if this is a post-back ("NEXT >>").. 
      	is1stVisit = request.getParameter("tt") == null;
      	if(!is1stVisit){	// .. store the previous answers
      		lt.processAnswers(request.getParameterMap());
      	}

   		// get the next set of questions
			qns = lt.getNext();
			
			// end of test/part?
			if(qns == null){

				if(lt.getSplitSet() == lt.getNSplits()+1){		// end of test : COMPLETED

   				lt.end(true);
   				status = TS_COMPLETED;
   				msg =
						"<div class='success'>You've reached the end of this questionnaire. Your answers will be processed and the results sent to the relevant parties <i>in due course</i><br><br>"+
						"<b><i>Thank You</i> for using our service.</b></div>";
				}else{													// end of split : IN_PROGRESS
					lt.end(false);
					msg =
						"<div class='success'>You've reached the end of this part of the test. "+
						"<i><u>Please return</u></i> after a cooldown period of <u><b><i>at least "+lt.getCoolDownTime()+" minutes</i></b></u>, "+
						"to continue with the next part.<br><br>"+
						"<b>THANK YOU!</b></div>";
				}
			}

   		break;
   		
   	case TS_COMPLETED:
   		msg = "<div class='err'>This assessment has been COMPLETED previously...</div>";
   		break;
   		
   	case TS_CANCELED:
	   	msg = "<div class='err'>This assessment has been CANCELED...</div>";
   		break;
   }


}catch(Exception e){
	Err.printDBErr(e.getMessage(), out, true, true);
}

%>

<style>
.field{
	border:			1px solid black;
	background-color:#ccc;
	padding:2px 4px 2px 4px;
	font-weight: bold;
	font-size: 8pt;
}.fld2{
	background-color:#aea;
}
.value{
	border:			1px solid black;
	background-color:#fff;
	padding:2px 4px 2px 4px;
	font-style:italic;
	font-size: 8pt;
}.val2{
	border-bottom:		1px solid #555;
	border-right:		1px solid #555;
	border-left:		1px solid #555;
	font-style:normal;
	font-size: 9pt;
}.val3{
	background-color:	#EDD;
}

HR {	padding: 0 0 0 0; margin: 3px 0 4px 0;}
</style>

<script type='text/javascript'>
var tSec=<%=(!is1stVisit)?request.getParameter("tt"):"0"%>;
</script>

<script type='text/javascript' src='script/client/sc53.js'></script>

<h2>Test :: Answer the Questions</h2>

<hr>
<form id='frm' action="index.jsp" method='post'>
   <table style='border-collapse:collapse;'>
   	<tr>
   		<td class='field' colspan="4">Entire Test</td>
   		<td>&nbsp;</td>
   		<td class='field' colspan="4">This Set</td>
   	</tr>
   	<tr>
   		<td class='field'>Assessment Name:</td>
   		<td class='value'><%=lt.getQre().getName()%></td>
   		<td class='field'>Questions Remaining:</td>
   		<td class='value'><%=lt.getTotQRemaining()%></td>
   		<td>&nbsp;</td>
   		<td class='field'>Q's Remaining:</td>
   		<td class='value'><%=lt.getQRemaining()%></td>		
   		<td class='field'>Part:</td>
   		<td class='value'><%=lt.getSplitSet()%> of <%=(lt.getNSplits()+1)%></td>
   	</tr>
   	<tr>
   		<td class='field'>Status:</td>
   		<td class='value'><%=lt.getAssmt().getTstStatusDesc()%></td>
   		<td class='field'>Questions Completed:</td>
   		<td class='value'><%=lt.getTotQCompleted()%></td>
   		<td>&nbsp;</td>
   		<td class='field'>Q's Completed:</td>
   		<td class='value'><%=lt.getQCompleted()%></td>
   		<td></td>
   		<td></td>
   	</tr>
   	<tr>
   		<td></td>
   		<td></td>
   		<td class='field'>Total Questions:</td>
   		<td class='value'><%=lt.getQre().getTestLength()%></td>
   		<td>&nbsp;</td>
   		<td class='field'>Set Total:</td>
   		<td class='value'><%=lt.getSplitLen()%></td>
   		<td></td>
   		<td></td>
   	</tr>
   </table>
   
	<table style='border-collapse:collapse; margin:4px 0 0 0;'>
		<tr>
			<td class='field' colspan="7">Answer Reference</td>
		</tr>
		<tr>
			<td class='value val3'>1: Never</td>
			<td class='value val3'>2: Rarely</td>
			<td class='value val3'>3: Sometimes</td>
			<td class='value val3'>4: Half the time</td>
			<td class='value val3'>5: Often</td>
			<td class='value val3'>6: Mostly</td>
			<td class='value val3'>7: Always</td>
		</tr>
		<tr>
			<td><img src="images/spacer.gif" width='125' height='0'></td>
			<td><img src="images/spacer.gif" width='125' height='0'></td>
			<td><img src="images/spacer.gif" width='126' height='0'></td>
			<td><img src="images/spacer.gif" width='125' height='0'></td>
			<td><img src="images/spacer.gif" width='126' height='0'></td>
			<td><img src="images/spacer.gif" width='126' height='0'></td>
			<td><img src="images/spacer.gif" width='126' height='0'></td>
		</tr>
	</table>	   
   <hr>
   
<%	if(qns != null){
%>
   <table style='border-collapse:collapse;'>
   	<tr>
   		<td class='field fld2'>#</td>
   		<td class='field fld2'>Question</td>
   		<td class='field fld2' colspan="7">Answer <i style="font-weight:normal">(1:never - 7:always)</i></td>
   	</tr>
   	<tr>
   		<td class='field fld2' colspan="2"><i style="font-weight:normal;">(Answer the questions, then click "<b>NEXT >></b>")</i></td>
   		<td class='field fld2'>1</td>
   		<td class='field fld2'>2</td>
   		<td class='field fld2'>3</td>
   		<td class='field fld2'>4</td>
   		<td class='field fld2'>5</td>
		<td class='field fld2'>6</td>
		<td class='field fld2'>7</td>
   	</tr>
<%
   	if(qns.length>0){

   	int id;
   	for(int i=0; i< qns.length; i++){

   		if(qns[i] == null){ // no more for this set
   			break;
   		}
   		id = qns[i].getPKID();
%>
   	<tr>
   		<td class='value val2'>
   			<%=(i+1)+"."%>
   			<input type='hidden' id='D_<%=id%>' name='d_<%=id%>' value="-1" />
   			<input type='hidden' id='D_<%=id%>_T' name='t_<%=id%>' value="0" />
   		</td>
   		<td class='value val2'><%=qns[i].getWording()%></td>
   		<td class='value val2'><input type='radio' id='a_<%=id%>_1' name='a_<%=id%>' value="1" onclick="doDbt('D_<%=id%>')" /></td>
   		<td class='value val2'><input type='radio' id='a_<%=id%>_2' name='a_<%=id%>' value="2" onclick="doDbt('D_<%=id%>')" /></td>
   		<td class='value val2'><input type='radio' id='a_<%=id%>_3' name='a_<%=id%>' value="3" onclick="doDbt('D_<%=id%>')" /></td>
   		<td class='value val2'><input type='radio' id='a_<%=id%>_4' name='a_<%=id%>' value="4" onclick="doDbt('D_<%=id%>')" /></td>
   		<td class='value val2'><input type='radio' id='a_<%=id%>_5' name='a_<%=id%>' value="5" onclick="doDbt('D_<%=id%>')" /></td>
		<td class='value val2'><input type='radio' id='a_<%=id%>_6' name='a_<%=id%>' value="6" onclick="doDbt('D_<%=id%>')" /></td>
		<td class='value val2'><input type='radio' id='a_<%=id%>_7' name='a_<%=id%>' value="7" onclick="doDbt('D_<%=id%>')" /></td>
   	</tr>
<%		}

   	}
%>
   	<tr>
   		<td><img src="images/spacer.gif" width='20' height='0'></td>
   		<td><img src="images/spacer.gif" width='450' height='0'></td>
   		<td><img src="images/spacer.gif" width='30' height='0'></td>
   		<td><img src="images/spacer.gif" width='30' height='0'></td>
   		<td><img src="images/spacer.gif" width='30' height='0'></td>
   		<td><img src="images/spacer.gif" width='30' height='0'></td>
   		<td><img src="images/spacer.gif" width='30' height='0'></td>
		<td><img src="images/spacer.gif" width='30' height='0'></td>
		<td><img src="images/spacer.gif" width='30' height='0'></td>
   	</tr>
   </table>
<%	}else{
		out.println(msg);
	}
%>
   <hr>
<%
	switch(status){
		case TS_NOT_STARTED:
		case TS_IN_PROGRESS:{
			if(qns !=null){
%>
	<div style='text-align:right;'>
		<input type='submit' onclick='return btnNext_Click();' value=" Next >> " />
	</div>
	
	<input type='hidden' name='pg' value="-532" />
	<input type='hidden' name='tt' id='TT' />
<%
			}else{
%>
	<div style='text-align:right;'>
		<input type='submit' value=" Back to Assessments " />
	</div>
	
	<input type='hidden' name='pg' value="-50" />
<%
			}
			break;
		}
		
		case TS_COMPLETED:
		case TS_CANCELED: {
%>
	<div style='text-align:right;'>
		<input type='submit' value=" Back to Assessments " />
	</div>
	
	<input type='hidden' name='pg' value="-50" />
<%
			break;		
		}
	}
%>
</form>