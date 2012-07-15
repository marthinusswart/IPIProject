<!--

		function getSelectedOrgPKID(){
			return orgTableMap[orgTable.m_selectedRows[0]][1];
		}
		
		function getSelectedOrgName(){
			return orgTable.m_aRowData[orgTable.m_selectedRows[0]][1];
		}
		
		function getSelectedOrgCred(){
			var re = />(.+)</;
			var taggedCred = orgTable.m_aRowData[orgTable.m_selectedRows[0]][3];
			var extract = taggedCred.match(re);
			
			return extract[1];
		}
		
		function getSelectedOrgCode(){
			return orgTable.m_aRowData[orgTable.m_selectedRows[0]][2];
		}
		
		function selectOK(){
				if(orgTable.m_selectedRows.length > 0){
					return true;
				}else{
					alert("Please select an Organization.");
					return false;
				}
		}

		
		function setOrgs(val){
			val=(val)?val:'';
			if(selectOK()){
				document.getElementById("Org"+val).value = getSelectedOrgPKID();
				document.getElementById("OrgName"+val).value	= getSelectedOrgName();
				document.getElementById("OrgCred"+val).value	= getSelectedOrgCred();
				if (val==6) document.getElementById("OrgCode"+val).value	= getSelectedOrgCode()
				return true;
				
			}else return false;
		}
//-->		