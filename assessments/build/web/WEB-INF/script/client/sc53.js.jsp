<% out.println("<!--"); %>

//------ timer

window.setInterval("doTime()", 1);
var tMark=tSec;
function doTime(){
	++tSec;
//document.getElementById("b1").value++;
}

//--------

function doDbt(id){
	// dbt
	document.getElementById(id).value ++;
	
	// set
	var intvl = document.getElementById(id+"_T").value++; intvl --;
	intvl += tSec - tMark;

	document.getElementById(id+"_T").value = intvl;
	// mark
	tMark = tSec;
//document.getElementById("b2").value = id+" = "+intvl;
}


function btnNext_Click(){

	// check if all questions were answered
	var msg='';
	var frm = document.getElementById("frm");
	var len = frm.elements.length;
	var currQID;	// prefix of current question being checked

	var i=0;
	for(var q=0; q < len; q++){
		if(frm.elements[q].tagName == "INPUT" && frm.elements[q].name.substr(0, 2) == "a_"){
			if(currQID != frm.elements[q].name) {
				currQID = frm.elements[q].name;
				// check if any of the 5 are checked
				if(	!document.getElementById(currQID+"_1").checked &&
						!document.getElementById(currQID+"_2").checked &&
						!document.getElementById(currQID+"_3").checked &&
						!document.getElementById(currQID+"_4").checked &&
						!document.getElementById(currQID+"_5").checked){
					
					msg='Please answer ALL questions';
					break;
				}
			}
			else continue;
			
		}
	}

	if(msg!=''){
		alert(msg);
		return false;
	}else {
		// save the time and continue
		document.getElementById("TT").value = tSec;
		return true;
	}
}
<% out.println("// :-) -->"); %>