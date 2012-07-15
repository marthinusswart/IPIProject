<!--

function rad1_Click(elem){	

	switch(elem.value){
		// show Org-user
		case '0':
			document.getElementById("option1").style.display = "block";
			document.getElementById("option2").style.display = "none";
			break;
		// show individuals
		case '1':
			document.getElementById("option2").style.display = "block";
			document.getElementById("option1").style.display = "none";
			break;
	}	
}

function btnAll_Click(){
	// select all rows in usrTable
	for(var i=0; i<usrTable.m_aRowData.length; i++){
		if(!usrTable.isSelected(i))
			usrTable.selectRow(i);
	}
	return false;
}


function getSelectedUser(index){
	return usrTable.m_aRowData[usrTable.m_selectedRows[index]][1];
}

function getSelectedDept(){
	return deptidMap[deptTable.m_selectedRows[0]][1];
}

function btnStep2_Click(){

	// Users OR Departments?
	if(document.getElementById("option2").style.display == "block"){	// users !

		// users selected?
		if(!usrTable) return false;
		if(usrTable.m_selectedRows.length == 0){
			alert("Please select one or more Individuals");
			return false;
		}else{
			// add selected users to form
			var hElem;
			var frm	= document.getElementById("mainForm");
			
			for (var i=0; i<usrTable.m_selectedRows.length; i++){
				// create hidden input
				hElem = document.createElement("INPUT");
				hElem.type	= "hidden";
				hElem.name	= "users";
				hElem.value	= getSelectedUser(i);
				// add to main form
				frm.appendChild(hElem);
			}
		}
	}else if(document.getElementById("usrType").value=="2") {	// departments !

		// dept selected?
		if(!deptTable) return false;
		if(deptTable.m_selectedRows.length == 0){
			alert("Please select a Downline");
			return false;
		}else {
		
			// add selected users to form
			var hElem;
			var frm	= document.getElementById("mainForm");
			
			// create hidden input
			hElem = document.createElement("INPUT");
			hElem.type	= "hidden";
			hElem.name	= "dept";
			hElem.value	= getSelectedDept();
			// add to main form
			frm.appendChild(hElem);
		}
	}
	
	return true;
}



//-->