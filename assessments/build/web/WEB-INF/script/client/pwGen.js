<!--

	// generatePw()
	//
	// returns a random string of characters from a set alphabet
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
	
	
	//	setPW()
	//
	//	generates 6 or 7 -letter alpanumeric password and sets it to elem.value
	function setPW(elem){
		// 1 or 2 ? : true or false
		var HeadsORTails	= (Math.floor(Math.random()*3)==1)?false:true;
		elem.value			= generatePw((HeadsORTails)?6:7);
	}

	
	// setStr()
	//
	// sets the value attribute of the given element, 'elem', to a random string of length 'len'
	function setStr(elem, len){
		elem.value = generatePw(len);
	}
	
-->