<!--

		function getSelectedUsrUserName(){
			var re = />(.+)</;
			var taggedUsr = usrTable.m_aRowData[usrTable.m_selectedRows[0]][1];
			var extract = taggedUsr.match(re);
			
			return extract[1];
		}
		
		function getSelectedUsrRef(){
			var re = /"cellCRef">(.+)<\/div/;
			var taggedRef = usrTable.m_aRowData[usrTable.m_selectedRows[0]][4];
			var extract = taggedRef.match(re);
			
			return extract[1];
		}

		function selectOK(){
				if(usrTable.m_selectedRows.length > 0){
					return true;
				}else{
					alert("Please select an Individual.");
					return false;
				}
		}

		
		function setUser(val){
			if(selectOK()){
				document.getElementById("Usr"+val).value = getSelectedUsrUserName();
				if(val==2) document.getElementById("Ref").value = getSelectedUsrRef();
				
				return true;
				
			}else return false;
		}
		
		function activate_Click(){
			var customerList = document.getElementById("Cust");
			if (customerList != null)
			{
				if( document.getElementById("Cust").selectedIndex < 0)
					document.getElementById("Cust").selectedIndex = 0;
			}
				
			if( document.getElementById("Qre").selectedIndex < 0)
				document.getElementById("Qre").selectedIndex = 0;
			
			return true;
		}
//-->	