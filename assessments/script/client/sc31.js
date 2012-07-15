<!--
	

	function btnStep2_Click(skipOrg, atype){
		var name;
		if(!skipOrg){
			name = document.getElementById("orgName").value = Trim(document.getElementById("orgName").value).substr(0,30);
			document.getElementById("Web").value = Trim(document.getElementById("Web").value).substr(0,50);
		}
		
		var type = (atype)?atype:'';

		document.getElementById("Addr1"+type).value = Trim(document.getElementById("Addr1"+type).value).substr(0,45);
		document.getElementById("Addr2"+type).value = Trim(document.getElementById("Addr2"+type).value).substr(0,45);
		document.getElementById("Addr3"+type).value = Trim(document.getElementById("Addr3"+type).value).substr(0,45);
		document.getElementById("ArCode"+type).value = Trim(document.getElementById("ArCode"+type).value).substr(0,4);
		
		if(!skipOrg) {
			if(name==''){
				alert('Please provide a name');
				return false;
			}
			document.getElementById("Credits").disabled = false;	
		}

		return true;
	}
	
	function btnStep3_Click(){
		// madatory fields
		var usr = document.getElementById("userName").value = Trim(document.getElementById("userName").value).substr(0,20);
		var fnm = document.getElementById("firstName").value = Trim(document.getElementById("firstName").value).substr(0,20);		
		var lnm = document.getElementById("lastName").value = Trim(document.getElementById("lastName").value).substr(0,20);
		
		// other fields
		document.getElementById("Initial").value = Trim(document.getElementById("Initial").value).substr(0,1);
		document.getElementById("IDNum").value = Trim(document.getElementById("IDNum").value);
		document.getElementById("compRef").value = Trim(document.getElementById("compRef").value);

		// at least ONE of these
		var telw = document.getElementById("telW").value = Trim(document.getElementById("telW").value);
		var telh = document.getElementById("telH").value = Trim(document.getElementById("telH").value);
		var telf = document.getElementById("telF").value = Trim(document.getElementById("telF").value);
		var telc = document.getElementById("telC").value = Trim(document.getElementById("telC").value);
		var eml  = document.getElementById("Email").value = Trim(document.getElementById("Email").value);

		var str="";		
		if (usr == '') str+= "- a valid Username\n";
		if (fnm == '') str+= "- a First Name\n";
		if (lnm == '') str+= "- a Last Name\n";
		if (telw=='' && telh=='' && telf=='' && telc=='' && eml=='')
			str+= "- at least one contact number, or an e-mail address\n";
		
		if(str==''){ // no errors
			document.getElementById("Password").disabled = false;
			return true;
		}else{
			alert("Please provide the following:\n\n"+str);
			return false;
		}
	}
	
	// this combines steps 2 & 3 (used by "sc_32#_newUsr#.jsp")
	function btnStep2_3_Click(){
		return btnStep2_Click(true, 'H') && btnStep2_Click(true, 'P') && btnStep3_Click();
	}
//-->