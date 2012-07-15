<!--
function lnAdd_Click(){

	// get the selected option(s)
	var opts1	= document.getElementById('box1').options;
	var opts2	= document.getElementById('box2').options;
		
	// check if it's not already added.. if not add
	var found;
	for(var i=0; i< opts1.length; i++)
		if(opts1[i].selected){
			// ..check if already added...
			found=false;
			for(var j=0; j<opts2.length; j++)
				if(opts2[j].value == opts1[i].value){
					found=true;	// ... YES: skip it
					break;
				}
			// .. add
			if(!found) opts2[opts2.length] = new Option(opts1[i].text, opts1[i].value);
		}
}

function lnRem_Click(){
	// get the selected option(s)
	var box2		= document.getElementById('box2');
	var opts2	= box2.options;
		
	// remove selected option(s)
	for(var i=0; i< opts2.length; i++)
		if(opts2[i].selected) {
			// remove
			box2.remove(i);
			// check left-shifted element
			i--;
		}
}


function btnStep3_Click(){

	// check requirements..
	var showError=false;
	var msg='NOTICE:\n';
	var qName = document.getElementById('qName').value = Trim(document.getElementById('qName').value).substr(0,30);
	document.getElementById('qDesc').value = Trim(document.getElementById('qDesc').value).substr(0,250);

	var opts2 = document.getElementById('box2').options
	
	if(qName=="") {
		msg+='\t- Please provide a NAME for the Questionaire\n';
		showError=true;
	}
	if(opts2.length==0){
		msg+='\t- At least 1 SUPER-CONSTRUCT is required\n';
		showError=true;
	}
	

	if(showError){
		alert(msg);
		return false;
	}else{
		// weird.. make sure all options are selected... else they dont get posted
		for(var i=0; i< opts2.length; i++) opts2[i].selected=true;
		return true;
	}
}

// -->