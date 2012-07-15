<!-- /* (see "mc72.js") */

	function reset(lvl){
		// note lvl is an arb flag
		switch(lvl){
			case 0:
				document.getElementById("Credits").value = 0;
				break;
			case 1:
				document.getElementById("Credits").value = document.getElementById("origDeptCreds").value;
				document.getElementById("CredsAvailable").value = document.getElementById("origAdminCredits").value;
				break;
		}
	}
	
	function update_Click(){
	
		// Org details:
		// ..mandatory fields
		var org = document.getElementById("orgName").value = Trim(document.getElementById("orgName").value).substr(0,50);
		
		// ..other fields
		document.getElementById("Web").value = Trim(document.getElementById("Web").value).substr(0,50);
		
		// User Details:
	
		// ..madatory fields
		var usr = document.getElementById("userName").value = Trim(document.getElementById("userName").value).substr(0,20);
		var fnm = document.getElementById("firstName").value = Trim(document.getElementById("firstName").value).substr(0,20);		
		var lnm = document.getElementById("lastName").value = Trim(document.getElementById("lastName").value).substr(0,20);
		var eml  = document.getElementById("Email").value = Trim(document.getElementById("Email").value);
		
		// ..other fields
		document.getElementById("Initial").value = Trim(document.getElementById("Initial").value).substr(0,1);
		document.getElementById("IDNum").value = Trim(document.getElementById("IDNum").value);
		document.getElementById("compRef").value = Trim(document.getElementById("compRef").value);
		document.getElementById("telF").value = Trim(document.getElementById("telF").value);
		
		// ..premesis address
		document.getElementById("Addr1").value = Trim(document.getElementById("Addr1").value).substr(0,45);
		document.getElementById("Addr2").value = Trim(document.getElementById("Addr2").value).substr(0,45);
		document.getElementById("Addr3").value = Trim(document.getElementById("Addr3").value).substr(0,45);
		document.getElementById("ArCode").value = Trim(document.getElementById("ArCode").value).substr(0,4);

		// ..at least ONE of these
		var telw = document.getElementById("telW").value = Trim(document.getElementById("telW").value);
		var telh = document.getElementById("telH").value = Trim(document.getElementById("telH").value);
		var telc = document.getElementById("telC").value = Trim(document.getElementById("telC").value);

		var str="";

		if (org == '')	str+= "- an Organization Name\n";
		if (!isLegalString(usr, true))	str+= "- a valid Username (legal characters: 'a..z','A..Z','0..9','_')\n";
		if (!isLegalString(fnm, false))	str+= "- a valid First Name (legal characters: 'a..z','A..Z')\n";
		if (!isLegalString(lnm, false))	str+= "- a valid Last Name (legal characters: 'a..z','A..Z')\n";
		if (!isLegalPhoneNumber(telw) && !isLegalPhoneNumber(telh) && !isLegalPhoneNumber(telc))
			str+= "- at least one telephone number (home/work/cell - legal characters: '+)(', '0..9')\n";
		if (!emailOK(eml))
			str+= "- a valid email address (IMPORTANT)\n";

		if (str==''){ // no errors
			document.getElementById("Credits").disabled = false;
			document.getElementById("userName").disabled = false;
			document.getElementById("Password").disabled = false;
			return true;
		}else{
			alert("In order to manage your account and communicate with you, we need at LEAST the following:\n\n"+str);
			return false;
		}
	}
	

//-->	