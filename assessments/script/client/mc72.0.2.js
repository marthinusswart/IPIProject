<!--
/*mc_<720>*/
/*sc_<43>*/
	
function btnStep2_Click(){

    // madatory fields
    var usr = document.getElementById("userName").value = Trim(document.getElementById("userName").value).substr(0,20);
    var fnm = document.getElementById("firstName").value = Trim(document.getElementById("firstName").value).substr(0,20);
    var lnm = document.getElementById("lastName").value = Trim(document.getElementById("lastName").value).substr(0,20);
    var eml  = document.getElementById("Email").value = Trim(document.getElementById("Email").value);
		
    // other fields
    document.getElementById("Initial").value = Trim(document.getElementById("firstName").value).substr(0,1);
    document.getElementById("IDNum").value = Trim(document.getElementById("IDNum").value);
    document.getElementById("compRef").value = Trim(document.getElementById("compRef").value);
	
		
    // street address
    document.getElementById("Addr1H").value = Trim(document.getElementById("Addr1H").value).substr(0,45);
    document.getElementById("Addr2H").value = Trim(document.getElementById("Addr2H").value).substr(0,45);
    document.getElementById("Addr3H").value = Trim(document.getElementById("Addr3H").value).substr(0,45);
		
    // postal address
    document.getElementById("Addr1P").value = Trim(document.getElementById("Addr1P").value).substr(0,45);
    document.getElementById("Addr2P").value = Trim(document.getElementById("Addr2P").value).substr(0,45);
    document.getElementById("Addr3P").value = Trim(document.getElementById("Addr3P").value).substr(0,45);

    // at least ONE of these
    var telw = Trim(document.getElementById("telW").value);
    var telh = Trim(document.getElementById("telH").value);
    var telc = Trim(document.getElementById("telC").value);
    var	telf = Trim(document.getElementById("telF").value);

    var acH = document.getElementById("ArCodeH").value = Trim(document.getElementById("ArCodeH").value).substr(0,12);
    var acP = document.getElementById("ArCodeP").value = Trim(document.getElementById("ArCodeP").value).substr(0,12);


    var str="";
		
    var ignoreUser = document.getElementById("userName").disabled;
    if (!ignoreUser && !isLegalString(usr, true))	str+= "- a valid Username (legal characters: 'a..z','A..Z','0..9','_','-')\n";
    if (!isLegalString(fnm, false))	str+= "- a valid First Name (legal characters: 'a..z','A..Z','-')\n";
    if (!isLegalString(lnm, false))	str+= "- a valid Last Name (legal characters: 'a..z','A..Z','-')\n";
    if (!isLegalPhoneNumber(telw) && !isLegalPhoneNumber(telh) && !isLegalPhoneNumber(telc))
        str+= "- at least one telephone number (home/work/cell - legal characters: '+)(', '0..9')\n";
    if (!emailOK(eml))
        str+= "- a valid email address (IMPORTANT)\n";
    if ((acH=='' && acP=='') || (isNaN(acH) || isNaN(acP)))
        str+= "- a valid area code (for geographical grouping)";

    if (str=='')
    { // no errors
        document.getElementById("telW").value = concatTelNo("work");
        document.getElementById("telH").value = concatTelNo("home");
        document.getElementById("telF").value = concatTelNo("fax");
        document.getElementById("telC").value = concatTelNo("cell");

        if(ignoreUser) document.getElementById("userName").disabled = false;
        document.getElementById("Password").disabled = false;
        return true;
    }
    else
    {
        alert("Please provide the following fields :\n\n"+str);
        return false;
    }
}

function concatTelNo(telType)
{

    var telNo = "";
    var areaCode ="";

    if (telType == "work")
    {
        telNo = Trim(document.getElementById("telW").value);   
        areaCode = Trim(document.getElementById("telWa").value);
        if (areaCode.indexOf("0") === 0)
        {
            areaCode = areaCode.substring(1,areaCode.length);
        }
        telNo += areaCode;
        telNo += Trim(document.getElementById("telWn").value);   
    }
    else if (telType == "home")
    {
        telNo = Trim(document.getElementById("telH").value) ;
        areaCode = Trim(document.getElementById("telHa").value);
        if (areaCode.indexOf("0") === 0)
        {
            areaCode = areaCode.substring(1,areaCode.length);
        }
        telNo += areaCode;

        telNo += Trim(document.getElementById("telHn").value)
    }
    else if (telType == "fax")
    {
        telNo = Trim(document.getElementById("telF").value)
        areaCode = Trim(document.getElementById("telFa").value);
        if (areaCode.indexOf("0") === 0)
        {
            areaCode = areaCode.substring(1,areaCode.length);
        }
        telNo += areaCode;
        telNo += Trim(document.getElementById("telFn").value)
    }
    else if (telType == "cell")
    {
        telNo = Trim(document.getElementById("telC").value)
        areaCode = Trim(document.getElementById("telCa").value);
        if (areaCode.indexOf("0") === 0)
        {
            areaCode = areaCode.substring(1,areaCode.length);
        }
        telNo += areaCode;
        telNo += Trim(document.getElementById("telCn").value)
    }
 
    return telNo;
}
	

//-->	