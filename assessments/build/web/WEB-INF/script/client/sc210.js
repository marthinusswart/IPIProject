<!-- /* (see "mc72.js") */

	function generatePw(numLetters){
		var pwAlphabet = [
		'a','b','c','d','e','f','g','h','j','k','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
		'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z',
		'2','3','4','5','6','7','8','9', '@', '$', '&', '?', '+', '%'
		];
		
		var pw="";
		
		for(var i=0; i<numLetters; i++){
			pw += pwAlphabet[Math.floor(Math.random()*pwAlphabet.length)];
		}
		
		return pw;
	}
	
	//	setPW
	//
	//	generates 6 or 7 -letter alpanumeric password and sets it to elem.value
	function setPW(elem){
		// 1 or 2 ? : true or false
		var HeadsORTails	= (Math.floor(Math.random()*3)==1)?false:true;
		elem.value			= generatePw((HeadsORTails)?6:7);
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
			document.getElementById("Password").disabled = false;
			return true;
		}else{
			alert("In order to manage your account and communicate with you, we need at LEAST the following:\n\n"+str);
			return false;
		}
	}
	

//-->	