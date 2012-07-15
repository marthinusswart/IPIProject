<!--

		function getSelectedQPKID(){
			return qTableMap[qTable.m_selectedRows[0]][1];
		}
		
		function selectOK(){
				if(qTable.m_selectedRows.length > 0){
					return true;
				}else{
					alert("Please select a Question.");
					return false;
				}
		}

		
		function setQs(val){
			val=(val)?val:'';
			if(selectOK())
			{
				document.getElementById("qid"+val).value = getSelectedQPKID();
				return true;
				
			}else return false;
		}
//-->