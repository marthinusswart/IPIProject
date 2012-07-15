<% out.println("<!-"); %> 

function radDoctype_Click(boxID){
	// set option-box dimensions
	document.getElementById('opt_box').style.height = '115px';
	
	// hide other option-elements
	switch(boxID){
		case 'scr'	:
			document.getElementById('action_xls').style.display =
			document.getElementById('action_pdf').style.display =
			document.getElementById('note_xls').style.display =
			document.getElementById('note_pdf').style.display =
			'none';
			
			document.getElementById('btnGet').disabled = false;
			
			break;
			
		case 'xls'	:
			document.getElementById('action_scr').style.display =
			document.getElementById('action_pdf').style.display =
			document.getElementById('note_scr').style.display =
			document.getElementById('note_pdf').style.display =
			'none';
			
			document.getElementById('btnGet').disabled = true;
			
			break;
			
		case 'pdf'	:
			document.getElementById('action_scr').style.display =
			document.getElementById('action_xls').style.display =
			document.getElementById('note_scr').style.display =
			document.getElementById('note_xls').style.display =
			'none';
			
			document.getElementById('btnGet').disabled = true;
			
			// reset option-box dimensions
			document.getElementById('opt_box').style.height = '242px';
			
			break;
	}
	
	// show given option-elements
	document.getElementById('action_'+boxID).style.display	= 'block';
	document.getElementById('note_'+boxID).style.display		= 'inline';
	
}



function getSelectedRepID(){
	return orgTableMap[orgTable.m_selectedRows[0]][1];
}

function getSelectedOrgName(){
	return orgTable.m_aRowData[orgTable.m_selectedRows[0]][1];
}

function getSelectedOrgCred(){
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
		
		return true;
		
	}else return false;
}

function btnGet_Click(){
	alert("Please select a Report");
	
	return false;
}

<% out.println("// [ the abyss ] "); %>