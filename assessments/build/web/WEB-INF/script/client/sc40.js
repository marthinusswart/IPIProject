<!--

		function getSelectedUsrUserName(){
			var re = />(.+)</;
			var taggedUsr = usrTable.m_aRowData[usrTable.m_selectedRows[0]][1];
			var extract = taggedUsr.match(re);
			
			return extract[1];
		}
/*
		function getSelectedUsrNames(){
			return usrTable.m_aRowData[usrTable.m_selectedRows[0]][2];
		}
*/
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
				document.getElementById("Usr"+((val)?val:'')).value = getSelectedUsrUserName();
				
				return true;
				
			}else return false;
		}
//-->	