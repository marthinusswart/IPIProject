<!--

		function getSelectedQPKID(){
			return qTableMap[qTable.m_selectedRows[0]][1];
		}
		
		function getSelectedQName(){
			return qTable.m_aRowData[qTable.m_selectedRows[0]][1];
		}
		
		function selectOK(){
				if(qTable.m_selectedRows.length > 0){
					return true;
				}else{
					alert("Please select a Questionaire.");
					return false;
				}
		}

		
		function setQREs(val){
			val=(val)?val:'';
			if(selectOK()){
				document.getElementById("Qre"+val).value = getSelectedQPKID();
				document.getElementById("QreName"+val).value	= getSelectedQName();
				
				return true;
				
			}else return false;
		}
//-->