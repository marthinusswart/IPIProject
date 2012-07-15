<!--
/*********************************************************************************
**
** DynamicTable [CLASS]	v0.2c
**
** Synopsis:   a dynamic table draws it's HTML and CSS styles dynamically,
**             e.g. mouseovers, add/remove data-rows, clicks etc.
**
**
** Requires:   GLib.js	(v0.2b)
**
** Author:     Péter Nel (peter@brooklynguesthouses.co.za)
**
**
** LICENCE:	This program is free software; you can redistribute it and/or modify
**				it under the terms of the GNU General Public License as published by
**				the Free Software Foundation; either version 2 of the License, or
**				(at your option) any later version.
**
**
** Disclaimer:	Please notify me if you use it or make changes or have suggestions,
**					for the sake of interest and in the spirit of sharing.
**					Enjoy!
**
** ---
**
** Static data members:
** - instanceCount      // counts the number od instances of DynamicTable
** - hoverCellID        // table Cell id over which mouse is hovering
**
** Instance data members:
** - m_aColData
** - m_aRowData
** - m_tableCSS
** - m_colHCSS
** - m_rowCSS
** - m_mOverCSS
** - m_mDownCSS
** - m_mSelectCSS
** - m_isMultiSelect
**	- m_domID
** - m_instanceID
**	- m_selectedRows
**
** Method List:
** - DynamicTable()
** - draw()
** - setClickHandler()
** - selectRow()
** - deselectRow()
** - deselectAllRows()
** - rowNumFromCellID()
** - isSelected()
** - getRowArr()
** [leave these alone..]
** - mOver()
** - mOut()
** - domID_OK()
** - getClickHandler()
**
*********************************************************************************/


//	DynamicTable() [Constructor]
//
//	Args:		[0]aColData			- array of string column names
//				[1]aRowData			- matrix of row-data [ROW_INDEX][COL_INDEX];
//											* if aRowData is a 1-dimensional array it is seen as one row.
//											* if # row values > # columns the values after aColData.length are ignored.
//											* if # row values < # columns the rest of the row is empty.
//											* if aRowData == '' (default) then an empty row is created.
//			-- the following are optional STYLES, '' indicates default style
//				[2]tableCSS			- CSS styles for entire table
//				[3]colHCSS			- CSS styles for column headers
//				[4]rowCSS			- CSS styles for even rows (starting at 0)
//				[5]altRowCSS		- rowCSS for odd rows
//				[6]mOverCSS			- rowCSS for mouseover event
//				[7]mDownCSS			- rowCSS for mousedown event
//				[8]mSelectCSS		- rowCSS for selected row
//			--
//				[9]isMultiSelect	- whether multiple rows may be selected simultaneously (default false)
//
var DynamicTable = function(){
	// return for prototype() definition
	if (arguments[0]==null) return;

	// instance variables & DEFAULTS
	this.m_aColData	= [0];
	this.m_aRowData	= [[0]];
	this.m_tableCSS	= 'border:1px solid black;border-collapse:collapse; cursor:arrow';
	this.m_colHCSS		= 'background-color:#6B5; border-bottom:1px solid #000';
	this.m_rowCSS		= 'background-color:#fafafa; border:none;';
	this.m_altRowCSS	= 'background-color:#DDD;';
	this.m_mOverCSS	= 'background-color:#BF8;';
	this.m_mDownCSS	= 'background-color:#77C;';
	this.m_mSelectCSS	= 'background-color:#33E; color:white;';
	this.m_isMultiSelect = false;
	
	this.m_domID		= '';										// initially empty, will contain DOM-level identifier of this instance
	this.m_instanceID = ++DynamicTable.instanceCount;	// instance number of this?
	this.m_selectedRows = new Array();						// array of selected row id's

	// CONSTRUCTOR processing (type-check/assign arguments to instance variables)
	var i=0;
	for(var locVar in this){
		if(locVar.substring(0,2)!='m_') continue;
		else if (i==arguments.length || i>9) break;
		else if (arguments[i]=='') { i++; continue; }

		this[locVar] = (arguments[i].constructor == this[locVar].constructor)
								?arguments[i]
								:compound("throw new Error('DynamicTable arg["+i+"] invalid type');", null);
		i++;
	}
	
	// Click event handler
	this.m_fnClickHandler = this._getClickHandler(this.m_isMultiSelect);
	

} // DynamicTable()


//******* |STATIC MEMBERS| *******//

DynamicTable.instanceCount = 0;		// counts the number od instances of DynamicTable
												// TODO: decrement on destruction? / anonymous/discarded objects?
DynamicTable.hoverCellID = '';		// table Cell id over which mouse is hovering


//******* |PROTOTYPE MEMBERS| *******//

// ## shared METHODS ##

// draw()
//
//	Synopsis:	Inject table's HTML at the position draw() is called in host document.
//
DynamicTable.prototype.draw = function(){

	if (!this.__domID_OK())
		throw new Error('Cannot draw anonymous DynamicTable objects. Please assign to a variable. NOTE: do not use empty constructor.');


	// output table-HTML..
	var sHTML = '';
	sHTML += "<table id='tbl_"+this.m_domID+ "' style='" +this.m_tableCSS+ "'>\n";
	
	// ..column headers
	sHTML += 	"<tr>\n";
	for(var c=0; c<this.m_aColData.length; c++)
		sHTML +=		"<td style='" +this.m_colHCSS+ "'>" +this.m_aColData[c]+ "</td>\n";
	sHTML += 	"</tr>\n";
	
	// ..row data
	for(var r=0; r<this.m_aRowData.length; r++){
		sHTML += 	"<tr id='tr_"+this.m_domID+"_"+r+"'>\n";
		for(var c=0; c<this.m_aColData.length; c++){
			sHTML += "<td id='td_"+this.m_domID+"_"+r+"_"+c+"' ";
			sHTML += "class='"+this.m_domID+((r%2==0)?"_row":"_altRow")+ "' ";						// style
			sHTML += "onmouseover='" +this.m_domID+".__mOver(this)' ";									// events
			sHTML += "onmouseout='" +this.m_domID+".__mOut(this)' ";										// ""
			sHTML += "onclick='" +this.m_domID+ ".m_fnClickHandler()' >";								// ""
			sHTML += ((c<this.m_aRowData[r].length)?this.m_aRowData[r][c]:'&nbsp;')+ "</td>\n";	// data
		}
		sHTML += 	"</tr>\n";
	}
	sHTML += "</table>";

	document.writeln(sHTML);

}

// setClickHandler()
//
//	Synopsis:		sets the click-event handler function of this DynamicTable
//
DynamicTable.prototype.setClickHandler = function(func){
	if (!this.__domID_OK())
		throw new Error('Cannot set event-handler to anonymous DynamicTable objects. Please assign to a variable. NOTE: do not use empty constructor.');
	
	if(func.constructor == this.m_fnClickHandler.constructor)
		this.m_fnClickHandler = func;
	else throw new Error(this.m_domID+'.setClickHandler - func not a function');
}

// selectRow()
//
//	Synopsis:		sets the styles of all cells in row <rowNum> to m_mSelectCSS
//
//	Args:				rowNum - 0-based index of row
DynamicTable.prototype.selectRow = function(rowNum){
	if (!this.__domID_OK())
		throw new Error('Cannot select rows of anonymous DynamicTable objects. Please assign to a variable. NOTE: do not use empty constructor.');

	var row = document.getElementById('tr_'+this.m_domID+'_'+rowNum);
	if(row == null)
		throw new Error('DynamicTable.selectRow: rowNum not found');
	
	// do styles & remember this row (if not already selected)..
	if(!this.isSelected(rowNum)){	
		// ..style
		for(var cell=row.firstChild; cell!=null; cell=cell.nextSibling)
			if(cell.tagName=="TD") cell.className = this.m_domID+"_mSelect";
		// ..remember
		this.m_selectedRows.push(rowNum);
	}
	// otherwise deselect
	else this.deselectRow(rowNum);
}

// deselectRow()
//
//	Synopsis:		sets the styles of all cells in row <rowNum> to m_rowCSS | m_altRowCSS
//
//	Args:				rowNum - 0-based index of row
DynamicTable.prototype.deselectRow = function(rowNum){
	var row = document.getElementById('tr_'+this.m_domID+'_'+rowNum);
	rowNum++; rowNum--;

	for(var cell=row.firstChild; cell!=null; cell=cell.nextSibling)
		if(cell.tagName=="TD") cell.className = ((rowNum%2==0)?this.m_domID+"_row":this.m_domID+"_altRow");
	
	// forget this row (find and delete it)
	for(var i=0; i<this.m_selectedRows.length; i++)
		if(this.m_selectedRows[i] == rowNum) this.m_selectedRows.splice(i, 1);
}

// deselecAllRows()
//
//	Synopsis:		sets the styles of all cells in all selected rows to m_rowCSS | m_altRowCSS
//
//	Args:				rowNum - 0-based index of row
DynamicTable.prototype.deselectAllRows = function(){
	if(this.m_selectedRows.length == 0) return;

	// styles
	var row;
	for(var i=0; i < this.m_selectedRows.length; i++){
		// get row
		row = document.getElementById('tr_'+this.m_domID+'_'+this.m_selectedRows[i]);
		// set cells in row
		for(var cell=row.firstChild; cell!=null; cell=cell.nextSibling)
			if(cell.tagName=="TD") cell.className =	((this.m_selectedRows[i]%2==0)
																	?this.m_domID+"_row"
																	:this.m_domID+"_altRow");
	}

	// forget all selected rows
	this.m_selectedRows = new Array();
}

// rowNumFromCellID()
//
//	Synopsis:	..
//
//	Args:			cellID -
//
DynamicTable.prototype.rowNumFromCellID = function(cellID){
	var tmp = cellID.match(/_\d+_/)+"";
	return tmp.match(/\d+/);
}

// isSelected()
//
//	Synopsis:	..
//
//	Args:			rowNum -
//
DynamicTable.prototype.isSelected = function(rowNum){
	rowNum++;rowNum--;
	for(var i=0; i<this.m_selectedRows.length; i++)
		if(this.m_selectedRows[i] == rowNum) return true;

	return false;
}

// getRowArr()
//
// Synopsis:	return an array with the contents of row 'rowNum'
//
DynamicTable.prototype.getRowArr = function(rowNum){
	if(rowNum >= this.m_aRowData.length || rowNum < 0) return null;
	
	return this.m_aRowData[rowNum];
}

// ## helper METHODS - (do not invoke) ##

//// --[EVENT HANDLERS]-- ////

//	mOver() - mouseover
//
//	Synopsis:	sets the styles of all cells in a row to m_mOverCSS
//
//	Notes:		A style rule was created in __domID_OK() with classname
//					in the form "<m_domID>_mOver"
//
DynamicTable.prototype.__mOver = function(elem){
	for(var cell=elem.parentNode.firstChild; cell!=null; cell=cell.nextSibling)
		if(cell.tagName=="TD") cell.className = this.m_domID+"_mOver";

	// record the row number (for selecting, etc.)
	DynamicTable.hoverCellID = elem.id;
}

//	mOut() - mouseout
//
//	Synopsis:	sets the styles of all cells in a row to m_rowCSS | m_altRowCSS
//
DynamicTable.prototype.__mOut = function(elem){
	// get current row number
	var rowNum = this.rowNumFromCellID(DynamicTable.hoverCellID);
	// restore the saved style if this row is NOT selected
	for(var cell=elem.parentNode.firstChild; cell!=null; cell=cell.nextSibling)
		if(cell.tagName=="TD") cell.className =	(!this.isSelected(rowNum))
																?((rowNum%2==0)?this.m_domID+"_row":this.m_domID+"_altRow")
																:this.m_domID+"_mSelect";
	// cancel hover cell
	DynamicTable.hoverCellID = '';
}


//// --[OTHER] --////

// domID_OK()
//
//	Synopsis:	if this instance has no m_domID member set (required for event handling, etc)
//					then it searches:
//						- (for IE): HTML script blocks for this instance's identifier..
//						- (other):  global DOM scope (window object) for the identifier..
//					and assigns it to this.m_domID.
//					** CSS style rules are also created in the document.
//
DynamicTable.prototype.__domID_OK = function(){
	// search the DOM space for this instance's identifier
	if(this.m_domID=='')
		// IE..
		if(document.scripts){
			// locate all instance id's in <script> blocks (parse code)
			var allIDs = new Array();
			var tmpIDs = new Array();
			for(var i=0; i<document.scripts.length; i++){
				tmpIDs = extractIDs(document.scripts[i].text, "DynamicTable");
				if(tmpIDs) allIDs = allIDs.concat(tmpIDs);
			}
			
			// found any?
			if(allIDs.length > 0)
				// locate this instance
				for(var id=0; id<allIDs.length; id++)
					if(window[allIDs[id]] && (window[allIDs[id]].m_instanceID == this.m_instanceID)){
						// found: assign domID & quit!!
						this.m_domID = allIDs[id];
						break;
					}
		}
		// Other..
		else
			for(var globObj in window)
				// check DOM
				if((window[globObj] instanceof DynamicTable) && (window[globObj].m_instanceID == this.m_instanceID)){
					// found: assign domID & quit!!
					window[globObj].m_domID = globObj;
					break;
				}

	// create CSS rules and return..
	if(this.m_domID != ''){
		// ..IE
		if(document.all){
			document.styleSheets[0].addRule("."+this.m_domID+"_row",		this.m_rowCSS);
			document.styleSheets[0].addRule("."+this.m_domID+"_altRow",	this.m_altRowCSS);
			document.styleSheets[0].addRule("."+this.m_domID+"_mOver",	this.m_mOverCSS);
			document.styleSheets[0].addRule("."+this.m_domID+"_mDown",	this.m_mDownCSS);
			document.styleSheets[0].addRule("."+this.m_domID+"_mSelect",this.m_mSelectCSS);
		}
		// ..Other
		else{
			document.styleSheets[0].insertRule("."+this.m_domID+"_row		{"+this.m_rowCSS+"}",		0);
			document.styleSheets[0].insertRule("."+this.m_domID+"_altRow	{"+this.m_altRowCSS+"}",	0);
			document.styleSheets[0].insertRule("."+this.m_domID+"_mOver		{"+this.m_mOverCSS+"}",		0);
			document.styleSheets[0].insertRule("."+this.m_domID+"_mDown		{"+this.m_mDownCSS+"}",		0);
			document.styleSheets[0].insertRule("."+this.m_domID+"_mSelect	{"+this.m_mSelectCSS+"}",	0);
		}
		return true;
	}else return false;
				
}

// getClickHandler()
//
//	Synopsis:	returns a single- or multiselect click handler for this instance.
//
DynamicTable.prototype._getClickHandler = function(isMultiSelect){
	return (isMultiSelect)
					// multiselect clicking
					?function(){
						// just select the next row
						this.selectRow(this.rowNumFromCellID(DynamicTable.hoverCellID));
					}
					// single select clicking
					:function(){
						// deselect any other rows
						this.deselectAllRows();
						// select row we're hovering over
						this.selectRow(this.rowNumFromCellID(DynamicTable.hoverCellID));
					}
}// -->