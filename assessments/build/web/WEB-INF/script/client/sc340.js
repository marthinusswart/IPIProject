<!--

function getSelectedAdPKID(){
	return adTableMap[adTable.m_selectedRows[0]][1];
}

function selectOK(){
		if(adTable.m_selectedRows.length > 0){
			return true;
		}else{
			alert("Please select an Advert.");
			return false;
		}
}


function setAd(val){
	val=(val)?val:'';
	if(selectOK()){
		document.getElementById("Ad"+val).value = getSelectedAdPKID();
		
		return true;
		
	}else return false;
}
	
-->