<!--

// Global vars
var gSMenu;								// Current Submenu being displayed

var gMMBG_over		= '#CF9';		// Main menu hover background color
var gMMFG_over		= '#0A0A0A';	// Main menu hover text color
var gTmpMMBG;							// temporary storage for Main menu CSS bgcolor
var gTmpMMFG;							// temporary storage for Main menu CSS color
var gSmiBG_over	= '#386E31';	// Submenu item hover background color
var gSmiFG_over	= '#FFF';		// Submenu item hover text color
var gTmpSmiBG;							// temporary storage for Submenu item CSS bgcolor
var gTmpSmiFG;							// temporary storage for Submenu item CSS color

var gSMenuDelay2On;					// pop ON timer (setTimeout identifier)
var gSMenuDelay2Off;					// pop OFF timer (setTimeout identifier)
var gMOutFlag=false;					// mouseout flag (used to intercept timers
//		when moving between main- & submenus)

//var gDoNav							// whether or not to navigate (submit form).. [see mmenu_Click()]


function menuInitialize(embedded)
{
    if (embedded)
    {
        gMMBG_over = '#C0C0C0';
        gMMFG_over = '#000000';
        gSmiBG_over = '#A0A0A0';
    }
}
	
/* #### --| EVENT HANDLERS |-- #### */

// mmenu_MOver()
//
// Synopsis:	Does main-menu hover style, and activates a submenu popout timer
function mmenu_MOver(elem){
    // MENU: mouse-over style..
    // ..save current
    gTmpMMBG = elem.style.backgroundColor;
    gTmpMMFG = elem.style.color;
    // ..flip
    elem.style.backgroundColor = gMMBG_over;
    elem.style.color = gMMFG_over;
    //elem.style.fontWeight = 'bold';

    // SUBMENU: show (timer)
    var submenu = elem.childNodes[1];
    if(submenu){
        // cancel old menus & timers
        window.clearTimeout(gSMenuDelay2On);
        window.clearTimeout(gSMenuDelay2Off);
        if(gSMenu && (gSMenu != submenu)) gSMenu.style.visibility = 'hidden';
        gSMenu = submenu;
        // intercept pending hides (ignore mouseout when moving to submenu)
        gMOutFlag = false;
        // call new one
        gSMenuDelay2On = window.setTimeout("_sMenuShow()", 300);
    }
}

// mmenu_MOut()
//
// Sysnopsis:	Does main-menu mouseout style, and hides (via 1ms timer) submenus
function mmenu_MOut(elem){
    // MENU: out-style..
    // ..restore saved colors
    elem.style.backgroundColor = gTmpMMBG;
    elem.style.color = gTmpMMFG;
    //elem.style.fontWeight = 'normal';

    // SUBMENU: hide (timer)
    var submenu = elem.childNodes[1];
    if(submenu){
        // intercept pending show's (don't show if mouseout before timer invokes show())
        gMOutFlag = true;
        gSMenuDelay2Off = window.setTimeout("_sMenuHide()", 1);
    }
}

// mmenu_Click()
//
// Synopsis:	Navigates via form-submission
var gDoNav = true;
function mmenu_Click(elem, pg){
    if(gDoNav){
        document.getElementById('menuPg').value = pg;
        document.forms['menuNav'].submit();
        // stop click event bubbling..
        gDoNav = false;
    }
}

// smenuItem_MOver()
//
//
function smenuItem_MOver(elem){
    // Save current
    gTmpSmiBG = elem.style.backgroundColor;
    gTmpSmiFG = elem.style.color;
    // flip
    elem.style.backgroundColor = gSmiBG_over;
    elem.style.color = gSmiFG_over;
//elem.style.fontWeight = 'bold';
}

// smenuItem_MOut()
//
//
function smenuItem_MOut(elem){
    // resore saved colors
    elem.style.backgroundColor = gTmpSmiBG;
    elem.style.color = gTmpSmiFG;
//elem.style.fontWeight = 'normal';
}



/* #### --| TIMER FUNCTIONS (do not call) |-- #### */
function _sMenuShow(){
    if(!gMOutFlag) gSMenu.style.visibility = 'visible';
}

function _sMenuHide(){
    if(gMOutFlag && gSMenu) gSMenu.style.visibility = 'hidden';
}

function setLoggedInUser(username, elementid)
{
    var message = "Logged in as: " + username;
    var element = document.getElementById(elementid);    
    element.innerHTML = message;
}


	/* #### --|  |-- #### */
-->