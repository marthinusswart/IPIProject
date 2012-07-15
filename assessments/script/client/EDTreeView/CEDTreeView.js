// -------------------------------------------------------
// Name:    Easy DHTML Treeview (aka CEDTreeView)         
// Author:  P.S. Nel (fourdots@gmail.com)	_______________
//          * Modified version of                        *
//	         * D.D. de Kerf                               *
//	         *  (dddekerf@dds.nl || D.deKerf@bodegro.com) *
//          *  Version: 0.2          Date: 13-6-2001     *
// Version: 0.1  Date: 19-10-2005                         
// -------------------------------------------------------

var imgPath			= "images/EDTreeView/";
var imgPLUS			= "plus.gif";
var imgMINUS		= "minus.gif";
//var imgLEAF			= "leaf.gif";

var disableToggle	= false;
var selectedNodeVal=null;

function Toggle(node){

	if (disableToggle) {
		disableToggle=false;
		return;
	}
	
	// browser hack: find sibling with correct classname
	var siblingIterator = node.nextSibling; 	
	do{
		
		if( siblingIterator.className == 'subtreeHIDE'){ // show
			
			// Change any image
			for(var i=0; i< node.childNodes.length; i++)
				if (node.childNodes.item(i).nodeName == "IMG"){
					node.childNodes.item(i).src = imgPath+"minus.gif";
					break;
				}

			// Expand the branch if it isn't visible
			siblingIterator.className = "subtreeSHOW";
				
			break;
		
		}else if( siblingIterator.className == 'subtreeSHOW') { // hide
		
			// Change any image
			for(var i=0; i< node.childNodes.length; i++)
				if (node.childNodes.item(i).nodeName == "IMG"){
					node.childNodes.item(i).src = imgPath+"plus.gif";
					break;
				}
			
			// Collapse the branch if it IS visible
			siblingIterator.className = "subtreeHIDE";
			
			break;
		}
		
		if(siblingIterator.nextSibling == null) continue;
		else siblingIterator = siblingIterator.nextSibling;
		
	}while(true);

}

// _getNodes()
//
//	Synopsis:	returns an array of DIV & IMG elements in the tree; returned DIVs must the given classname
function _getNodes(className){
	var retVal	= new Array();	// return array
	var retIndex=0;
	
	var rootNode	= document.getElementById("treeview");	
	var nodes, i;
	
	// get the div nodes
	nodes = rootNode.getElementsByTagName("DIV");
	for(i=0; i<=nodes.length; i++) {
		if(nodes[i]!=null && nodes[i].tagName=="DIV" && nodes[i].className==className)
			retVal[retIndex++] = nodes[i];
	}

	// get the img nodes
	nodes = rootNode.getElementsByTagName("IMG");
	for(i=0; i<=nodes.length; i++) {
		if(nodes[i]!=null && nodes[i].tagName=="IMG") //alert(nodes[i].src+": "+nodes[i].src.indexOf(imgPLUS));
			if(nodes[i].src.indexOf(imgPLUS)>-1 || nodes[i].src.indexOf(imgMINUS)>-1) retVal[retIndex++] = nodes[i];
	}
	
		
	return retVal;
}

// collapseTree()
//
//	Synopsis:	changes the classnames of all DIV nodes (in the element with id='treeview')
//					with classname 'subtreeSHOW' to 'subtreeHIDE'
function collapseTree(){
	var nodes = _getNodes("subtreeSHOW");
	
	for(var i=0; i<nodes.length; i++) {
		switch(nodes[i].tagName){
			case "DIV":	nodes[i].className="subtreeHIDE"; break;
			case "IMG":	nodes[i].src=imgPath+imgPLUS; break;
		}
	}
	
	return false;
}

// expandTree()
//
//	Synopsis:	changes the classnames of all DIV nodes (in the element with id='treeview')
//					with classname 'subtreeHIDE' to 'subtreeSHOW'
function expandTree(){
	var nodes = _getNodes("subtreeHIDE");
	

	for(var i=0; i<nodes.length; i++) {
		switch(nodes[i].tagName){
			case "DIV":	nodes[i].className="subtreeSHOW"; break;
			case "IMG":	nodes[i].src=imgPath+imgMINUS; break;
		}
	}
	
	return false;
}
