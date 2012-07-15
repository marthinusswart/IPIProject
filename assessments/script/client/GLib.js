<!--

/*********************************************************************************
**
**	GLib v0.5 - General script library
**
**
*********************************************************************************/

	// set_ret()
	//
	//	Synopsis:	'anonymous' compound statement, i.e. {...}, replacement;
	//					it executes a statement(s) [stmt], and returns a value [retVal].
	//	Reasoning:	one cannot do this: (<condition>)?<simple_expr>:{<compound_expr>};
	function compound(stmt, retVal){
		eval(stmt);
		return retVal;
	}

	// enumerateObject()
	//
	//	Synopsis:	rerturn an array of all members of an object (used mainly for testing)
	//
	function getMembers(obj){
		var arrMembers = new Array();
		
		var i=0;
		for(var mem in obj){arrMembers[i]=mem; i++;}
		
		return arrMembers;		
	}
	
	// extractIDs
	//
	//	Synopsis:	looks for occurrences of the substring 'new [ObjectName]' in sourcecode
	//					and returns an array of identifiers to which the instances were asigned.
	function extractIDs(sourcecode, ObjectName){
		// match all var assignments /\w+(\s+)?=(\s+)?new ObjectName/g
		var pattern = new RegExp("\\w+(\\s+)?=(\\s+)?new "+ObjectName, "g");
		var result = sourcecode.match(pattern);
				
		// none.. return
		if(!result) return null;
		
		// strip all else
		for(var i=0; i<result.length; i++) result[i] = result[i].replace(/(\s|=|new DynamicTable)+/,'');
		
		return result;
	}
	
	//	test()
	//
	//	Sysnopsis:	sets the innerHTML of an HTML element with id='test' to str.
	//
	function test(str){
		document.getElementById('test').innerHTML = str;
	}
	
	/* --- v0.4 additions --- */
	
	// emailOK()
	//
	// Synopsis:	does a regular expr check on an email address string
	//
	function emailOK(emailstr){
   	var re = /^[\w-\.]+@[\w-\.]+\.[\w]+$/;
   	
   	return re.test(emailstr);
	}
	
	// isLegalPhoneNumber()
	//
	// Synopsis:	test for legal phone numbers; e.g. +27 12 0000 000 -OR- 555 1234 OR (012)1234567
	//
	function isLegalPhoneNumber(n){
		var re = /^[()\+\d\s]+$/;
		return re.test(n);
	}
	
	// isLegalString()
	//
	// Synopsis:	checks whether a string is in the range [a..z,A..Z,-[,0..9,_]]
	// (ver0.5; '-' is also a legal character.. for double barrel names, e.g. Jean-Luc)
	function isLegalString(s, inclDigits){
		var re = (inclDigits)?/^\w+$|^\w+\-\w+$/:/^[a-zA-Z]+$|^[a-zA-Z]+\-[a-zA-Z]+$/;
		return re.test(s);
	}
	
	/* --- end v0.4 ---*/
	
	/* ----- These (modified) Trim functions are from [http://www.apriori-it.co.uk] */
	
	function Trim(TRIM_VALUE){
		if(TRIM_VALUE.length < 1) return"";
		
		TRIM_VALUE = RTrim(TRIM_VALUE);
		TRIM_VALUE = LTrim(TRIM_VALUE);
		if(TRIM_VALUE=="") return "";
		else return TRIM_VALUE;

	} //End Function

	function RTrim(VALUE){
		var w_space = String.fromCharCode(32);
		var v_length = VALUE.length;
      var strTemp = "";
      
      if(v_length < 0) return"";
      
      var iTemp = v_length -1;
      
      while(iTemp > -1){
	      if(VALUE.charAt(iTemp) == w_space){}
	      else{
   		   strTemp = VALUE.substring(0,iTemp +1);
   		   break;
   	   }
   	   iTemp = iTemp-1;
   	} //End While
   	
      return strTemp;
      
   } //End Function

   function LTrim(VALUE){
      var w_space = String.fromCharCode(32);
      if(v_length < 1) return"";

      var v_length = VALUE.length;
      var strTemp = "";
      
      var iTemp = 0;
      
      while(iTemp < v_length){
         if(VALUE.charAt(iTemp) == w_space){}
         else{
            strTemp = VALUE.substring(iTemp,v_length);
            break;
         }
         iTemp = iTemp + 1;
      } //End While
      return strTemp;
   } //End Function
	
//-->