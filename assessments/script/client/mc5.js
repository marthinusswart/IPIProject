<!--

function send_Click(){
	var err="";
	var elem;
	
	// test mail..
	elem = document.getElementById("mailFrom");
	var re = /^[\w-\.]+@[\w-\.]+\.[\w]+$/;
	
	if(elem.value=="" || !re.test(elem.value) )
		err+="Please provide a valid E-Mail address.\n";
	
	// test msg
	elem = document.getElementById("msgBox");
	if(elem.value==initMsg)
		err+="Please provide a Message.\n";
	else
		elem.value = elem.value.replace(/[\"]/g,"'").replace(/[<]/g,"(").replace(/[>]/g,")");
	
	elem = document.getElementById("Name");
	elem.value = elem.value.replace(/[\"]/g,"'").replace(/[<]/g,"(").replace(/[>]/g,")");
	
	if(err=="") return true
	else {
		alert(err);
		return false;
	}
}

var initMsg = "[type your message here]";

function msgbox_Focus(){
	var box = document.getElementById("msgBox");
	
	if(box.value==initMsg){
		
		box.value="";
		//document.getElementById("xx").innerHTML=x++;
	}
}

function msgbox_Blur(){
	var box = document.getElementById("msgBox");
	if(box.value=="") {
		box.value=initMsg;
	}
}

// -->
	