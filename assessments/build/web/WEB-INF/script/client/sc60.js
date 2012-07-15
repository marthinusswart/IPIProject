<!--

		function getSelectedSCPKID(){
			return scTableMap[scTable.m_selectedRows[0]][1];
		}
		
		function getSelectedSCName(){
			return scTable.m_aRowData[scTable.m_selectedRows[0]][1];
		}
		
		function selectOK(){
				if(scTable.m_selectedRows.length > 0){
					return true;
				}else{
					alert("Please select a Super Construct.");
					return false;
				}
		}

		
		function setSCs(val){
			val=(val)?val:'';
			if(selectOK())
			{
				document.getElementById("sc"+val).value = getSelectedSCPKID();
				document.getElementById("scname"+val).value	= getSelectedSCName();				
				return true;
				
			}else return false;
		}
//-->