var oEditor = window.parent.InnerDialogLoaded() ;
var FCK		= oEditor.FCK ;

// Set the language direction.
window.document.dir = oEditor.FCKLang.Dir ;

// Set the Skin CSS.
document.write( '<link href="' + oEditor.FCKConfig.SkinPath + 'fck_dialog.css" type="text/css" rel="stylesheet">' ) ;

var sAgent = navigator.userAgent.toLowerCase() ;

var is_ie = (sAgent.indexOf("msie") != -1); // FCKBrowserInfo.IsIE
var is_gecko = !is_ie; // FCKBrowserInfo.IsGecko

var oMedia = null;
var is_new_flvplayer = true;

function window_onload()
{
	// Translate the dialog box texts.
	oEditor.FCKLanguageManager.TranslatePage(document) ;

	// Load the selected element information (if any).
	LoadSelection() ;

	// Show/Hide the "Browse Server" button.
	GetE('tdBrowse').style.display = oEditor.FCKConfig.FlashBrowser ? '' : 'none' ;

	// Activate the "OK" button.
	window.parent.SetOkButton( true ) ;
}


function getSelectedMovie(){
	var oSel = null;
	oMedia = new Media();
	oSel = FCK.Selection.GetParentElement();
	// If in "Get the Flash Player" a href, do it again
	if (oSel.id != null && !oSel.id.match(/^player[0-9]*$/)) {
		oSel = oSel.parentNode;
	}
	if (oSel.id != null && oSel.id.match(/^player[0-9]*$/)) {
		for (var i = 0; i < oSel.childNodes.length; i++) {
			if (oSel.childNodes.item(i).nodeName=="DIV") {
				var oC=oSel.childNodes.item(i).innerHTML.split(' ');
				for (var o = 0; o < oC.length ; o++) {
					var tmp=oC[o].split('=');
					oMedia.setAttribute(tmp[0],tmp[1]);
				}
				is_new_flvplayer = false;
			}
		}
	}
	return oMedia;
}

function updatePlaylistOption () {
	if (GetE('selDispPlaylist').value == "right" || GetE('selDispPlaylist').value == "below") {
		GetE('chkPLThumbs').disabled=false;
		GetE('chkPLThumbs').checked=true;
		GetE('txtPLDim').disabled=false;
		GetE('txtPLDim').style.background='#ffffff';
		GetE('spanDimText').style.display='none';
		if (GetE('selDispPlaylist').value == "right") {
			GetE('spanDimWText').style.display='';
			GetE('spanDimHText').style.display='none';
		} else if (GetE('selDispPlaylist').value == "below") {
			GetE('spanDimWText').style.display='none';
			GetE('spanDimHText').style.display='';
		}
	} else {
		GetE('chkPLThumbs').disabled=true;
		GetE('chkPLThumbs').checked=false;
		GetE('txtPLDim').value = "";
		GetE('txtPLDim').disabled=true;
		GetE('txtPLDim').style.background='transparent';
		GetE('spanDimText').style.display='';
		GetE('spanDimWText').style.display='none';
		GetE('spanDimHText').style.display='none';
	}
}


function LoadSelection()
{
	oMedia = new Media();
	oMedia = getSelectedMovie();

	GetE('rbFileType').value	= oMedia.fileType;
	GetE('txtURL').value    	= oMedia.url;
	GetE('txtPlaylist').value   = oMedia.purl;
	GetE('txtImgURL').value    	= oMedia.iurl;
	GetE('txtWMURL').value    	= oMedia.wmurl;
	GetE('txtWidth').value		= oMedia.width;
	GetE('txtHeight').value		= oMedia.height;
	GetE('chkLoop').checked		= oMedia.loop;
	GetE('chkAutoplay').checked	= oMedia.play;
	GetE('chkDownload').checked 	= oMedia.downloadable;
	GetE('chkFullscreen').checked	= oMedia.fullscreen;
	GetE('txtBgColor').value	= oMedia.bgcolor;
	GetE('txtToolbarColor').value	= oMedia.toolcolor;
	GetE('txtToolbarTxtColor').value	= oMedia.tooltcolor;
	GetE('txtToolbarTxtRColor').value	= oMedia.tooltrcolor;
	GetE('chkShowNavigation').checked	= oMedia.displayNavigation;
	GetE('chkShowDigits').checked	= oMedia.displayDigits;
	GetE('selAlign').value		= oMedia.align;
	GetE('selDispPlaylist').value = oMedia.dispPlaylist;
	GetE('txtRURL').value = oMedia.rurl;
	GetE('txtPLDim').value = oMedia.playlistDim;
	GetE('chkPLThumbs').checked = oMedia.playlistThumbs;

	//updatePreview();
}

//#### The OK button was hit.
function Ok()
{
	var rbFileTypeVal = "single";
	if (GetE('rbFileType').checked == false) {
		rbFileTypeVal = "list";
	}

	if ( rbFileTypeVal == "single") {
		if ( GetE('txtURL').value.length == 0 )
		{
			GetE('txtURL').focus() ;	

			alert( oEditor.FCKLang.DlgFLVPlayerAlertUrl ) ;
			return false ;
		}
	}

	if (rbFileTypeVal == "list") {
		if ( GetE('txtPlaylist').value.length == 0 )
		{
			GetE('txtPlaylist').focus() ;	

			alert( oEditor.FCKLang.DlgFLVPlayerAlertPlaylist ) ;
			return false ;
		}
	}


	if ( GetE('txtWidth').value.length == 0 )
	{
		GetE('txtWidth').focus() ;	

		alert( oEditor.FCKLang.DlgFLVPlayerAlertWidth ) ;
		return false ;
	}

	if ( GetE('txtHeight').value.length == 0 )
	{
		GetE('txtHeight').focus() ;	

		alert( oEditor.FCKLang.DlgFLVPlayerAlertHeight ) ;
		return false ;
	}


	var e = (oMedia || new Media()) ;

	updateMovie(e) ;

	// Replace or insert?
	if (!is_new_flvplayer) {
		// Find parent..
	        oSel = FCK.Selection.GetParentElement();
		while (oSel != null && !oSel.id.match(/^player[0-9]*-parent$/)) {
			oSel=oSel.parentNode;
		}
		// Found - So replace
		if (oSel != null) {
			oSel.parentNode.removeChild(oSel);
			FCK.InsertHtml(e.getInnerHTML());
		}
	} else {
		FCK.InsertHtml(e.getInnerHTML());
	}

	return true ;
}


function updateMovie(e){
	e.fileType = GetE('rbFileType').value;
	e.url = GetE('txtURL').value;
	e.purl = GetE('txtPlaylist').value;
	e.iurl = GetE('txtImgURL').value;
	e.wmurl = GetE('txtWMURL').value;
	e.bgcolor = GetE('txtBgColor').value;
	e.toolcolor = GetE('txtToolbarColor').value;
	e.tooltcolor = GetE('txtToolbarTxtColor').value;
	e.tooltrcolor = GetE('txtToolbarTxtRColor').value;
	e.width = (isNaN(GetE('txtWidth').value)) ? 0 : parseInt(GetE('txtWidth').value);
	e.height = (isNaN(GetE('txtHeight').value)) ? 0 : parseInt(GetE('txtHeight').value);
	e.loop = (GetE('chkLoop').checked) ? 'true' : 'false';
	e.play = (GetE('chkAutoplay').checked) ? 'true' : 'false';
	e.downloadable = (GetE('chkDownload').checked) ? 'true' : 'false';
	e.fullscreen = (GetE('chkFullscreen').checked) ? 'true' : 'false';
	e.displayNavigation = (GetE('chkShowNavigation').checked) ? 'true' : 'false';
	e.displayDigits = (GetE('chkShowDigits').checked) ? 'true' : 'false';
	e.align =	GetE('selAlign').value;
	e.dispPlaylist =	GetE('selDispPlaylist').value;
	e.rurl = GetE('txtRURL').value;
	e.playlistDim = GetE('txtPLDim').value;
	e.playlistThumbs = (GetE('chkPLThumbs').checked) ? 'true' : 'false';
}


function BrowseServer()
{
	OpenServerBrowser(
		'flv',
		oEditor.FCKConfig.MediaBrowserURL,
		oEditor.FCKConfig.MediaBrowserWindowWidth,
		oEditor.FCKConfig.MediaBrowserWindowHeight ) ;
}


function LnkBrowseServer()
{
	OpenServerBrowser(
		'link',
		oEditor.FCKConfig.LinkBrowserURL,
		oEditor.FCKConfig.LinkBrowserWindowWidth,
		oEditor.FCKConfig.LinkBrowserWindowHeight ) ;
}

function Lnk2BrowseServer()
{
	OpenServerBrowser(
		'link2',
		oEditor.FCKConfig.LinkBrowserURL,
		oEditor.FCKConfig.LinkBrowserWindowWidth,
		oEditor.FCKConfig.LinkBrowserWindowHeight ) ;
}

function img1BrowseServer()
{
	OpenServerBrowser(
		'img1',
		oEditor.FCKConfig.ImageBrowserURL,
		oEditor.FCKConfig.ImageBrowserWindowWidth,
		oEditor.FCKConfig.ImageBrowserWindowHeight ) ;
}

function img2BrowseServer()
{
	OpenServerBrowser(
		'img2',
		oEditor.FCKConfig.ImageBrowserURL,
		oEditor.FCKConfig.ImageBrowserWindowWidth,
		oEditor.FCKConfig.ImageBrowserWindowHeight ) ;
}


function OpenServerBrowser( type, url, width, height )
{
	sActualBrowser = type ;
	OpenFileBrowser( url, width, height ) ;
}

var sActualBrowser ;


function SetUrl( url ) {
	if ( sActualBrowser == 'flv' ) {
		document.getElementById('txtURL').value = url ;
		GetE('txtHeight').value = GetE('txtWidth').value = '' ;
	} else if ( sActualBrowser == 'link' ) {
		document.getElementById('txtPlaylist').value = url ;
	} else if ( sActualBrowser == 'link2' ) {
		document.getElementById('txtRURL').value = url ;
	} else if ( sActualBrowser == 'img1' ) {
		document.getElementById('txtImgURL').value = url ;
	} else if ( sActualBrowser == 'img2' ) {
		document.getElementById('txtWMURL').value = url ;
	}
}

var Media = function (o){
	this.fileType = '';
	this.url = '';
	this.purl = '';
	this.iurl = '';
	this.wmurl = '';
	this.width = '';
	this.height = '';
	this.loop = '';
	this.play = '';
	this.downloadable = '';
	this.fullscreen = true;
	this.bgcolor = '';
	this.toolcolor = '';
	this.tooltcolor = '';
	this.tooltrcolor = '';
	this.displayNavigation = true;
	this.displayDigits = true;
	this.align = '';
	this.dispPlaylist = '';
	this.rurl = '';
	this.playlistDim = '';
	this.playlistThumbs = '';

	if (o) 
		this.setObjectElement(o);
};

Media.prototype.setObjectElement = function (e){
	if (!e) return ;
	this.width = GetAttribute( e, 'width', this.width );
	this.height = GetAttribute( e, 'height', this.height );
};

Media.prototype.setAttribute = function(attr, val) {
	if (val=="true") {
		this[attr]=true;
	} else if (val=="false") {
		this[attr]=false;
	} else {
		this[attr]=val;
	}
};

Media.prototype.getInnerHTML = function (objectId){
	var randomnumber = Math.floor(Math.random()*1000001);
	var thisWidth = this.width;
	var thisHeight = this.height;

	var thisMediaType = "single";
	if (GetE('rbFileType').checked == false) {
		thisMediaType = "mpl";
	}

	// Align
	var cssalign='';
	var cssfloat='';
	if (this.align=="center") {
		cssalign='margin-left: auto;margin-right: auto;';
	} else if (this.align=="right") {
		cssfloat='float: right;';
	} else if (this.align=="left") {
		cssfloat='float: left;';
	}

	var s = "";
	s+= '<div id="player' + randomnumber + '-parent" style="text-align: center; height: ' + thisHeight + 'px; ' + cssfloat + '">\n';
	s+= '<div style="border-style: none; height: ' + thisHeight + 'px; width: ' + thisWidth + 'px; overflow: hidden; background-color: rgb(220, 220, 220); background-image: url(' + oEditor.FCKConfig.PluginsPath + 'flvPlayer/flvPlayer.gif); background-repeat:no-repeat; background-position:center;' + cssalign + '">';
	s+= '<div id="player' + randomnumber + '">';
	s+= '<a href="http://www.adobe.com/go/getflashplayer">Get the Flash Player</a> to see this player.';
	// Moved after info - Added width,height,overflow for MSIE7
	s+= '<div id="player' + randomnumber + '-config" style="display: none;visibility: hidden;width: 0px;height:0px;overflow: hidden;">';
	// Save settings
	for (var i in this) {
		if (!i || !this[i]) continue;
	        if (!i.match(/(set|get)/)) {
        	        s+=i+"="+this[i]+" ";
        	}
	}
	s+= '</div>';
	s+= '</div>';
	s+= '<script type="text/javascript">\n';
	s+= '	var oSwfVariables = {};\n';
	s+= '	var oSwfParams = {};\n';
	s+= '	var oSwfAttributes = {};\n';
	s+= '	oSwfVariables.width = "' + thisWidth + '";\n';
	s+= '	oSwfVariables.height = "' + thisHeight + '";\n';
	s+= '	oSwfVariables.autostart = "' + this.play + '";\n';

	if (thisMediaType == 'mpl') {
		s+= '	oSwfVariables.file = "' + this.purl + '";\n';
		s+= '	oSwfVariables.autoscroll = "true";\n';
		s+= '	oSwfParams.allowscriptaccess = "always";\n';

		var dispWidth = thisWidth
		var dispHeight = thisHeight
		var dispThumbs = false

		if (this.dispPlaylist != "none") {
			if (this.dispPlaylist == "right") {

				if (this.playlistDim.length > 0) {
					dispWidth = thisWidth - this.playlistDim
					if (this.playlistDim < 100) {
						dispThumbs = false
					} else {
						dispThumbs = true
					}
				} else {
					if (thisWidth >= 550) {
						dispWidth = thisWidth - 200
						dispThumbs = true
					} else if (thisWidth >= 450) {
						dispWidth = thisWidth - 100
						dispThumbs = false
					} else if (thisWidth >= 350) {
						dispWidth = thisWidth - 50
						dispThumbs = false
					}
				}

				s+= '	oSwfVariables.displaywidth = "' + dispWidth + '";\n';
			} else if (this.dispPlaylist == "below") {
				dispThumbs = true
				
				if (this.playlistDim.length > 0) {
					dispHeight = thisWidth - this.playlistDim
				} else {
					if (thisHeight >= 550) {
						dispHeight = thisWidth - 200
					} else if (thisHeight >= 450) {
						dispHeight = thisHeight - 150
					} else if (thisHeight >= 350) {
						dispHeight = thisHeight - 100
					}
				}

				s+= '	oSwfVariables.displayheight = "' + dispHeight + '";\n';
			}

			if (this.playlistThumbs == "false") {
				dispThumbs = false;
			}
				
			s+= '	oSwfVariables.thumbsinplaylist = "' + dispThumbs + '";\n';
		}

		s+= '	oSwfVariables.shuffle = "false";\n';
		if (this.loop == true) {
			s+= '	oSwfVariables.repeat = "list";\n';
		} else {
			s+= '	oSwfVariables.repeat = "' + this.loop + '";\n';
		}
	} else {
		s+= '	oSwfVariables.file = "' + this.url + '";\n';
		s+= '	oSwfVariables.repeat = "' + this.loop + '";\n';
		s+= '	oSwfVariables.image = "' + this.iurl + '";\n';
	}

	s+= '	oSwfVariables.showdownload = "' + this.downloadable + '";\n';
	s+= '	oSwfVariables.link = "' + this.url + '";\n';
	s+= '	oSwfParams.allowfullscreen = "' + this.fullscreen + '";\n';
	s+= '	oSwfVariables.showdigits = "' + this.displayDigits + '";\n';
	s+= '	oSwfVariables.shownavigation = "' + this.displayNavigation + '";\n';

	// SET THE COLOR OF THE TOOLBAR
	var colorChoice1 = this.toolcolor
	if (colorChoice1.length > 0) {
		colorChoice1 = colorChoice1.replace("#","0x")
		s+= '	oSwfVariables.backcolor = "' + colorChoice1 + '";\n';
	}
	// SET THE COLOR OF THE TOOLBARS TEXT AND BUTTONS
	var colorChoice2 = this.tooltcolor
	if (colorChoice2.length > 0) {
		colorChoice2 = colorChoice2.replace("#","0x")
		s+= '	oSwfVariables.frontcolor = "' + colorChoice2 + '";\n';
	}
	//SET COLOR OF ROLLOVER TEXT AND BUTTONS
	var colorChoice3 = this.tooltrcolor
	if (colorChoice3.length > 0) {
		colorChoice3 = colorChoice3.replace("#","0x")
		s+= '	oSwfVariables.lightcolor = "' + colorChoice3 + '";\n';
	}
	//SET COLOR OF BACKGROUND
	var colorChoice4 = this.bgcolor
	if (colorChoice4.length > 0) {
		colorChoice4 = colorChoice4.replace("#","0x")
		s+= '	oSwfVariables.screencolor = "' + colorChoice4 + '";\n';
	}

	s+= '	oSwfVariables.logo = "' + this.wmurl + '";\n';
	if (this.rurl.length > 0) {
		s+= '	oSwfVariables.recommendations = "' + this.rurl + '";\n';
	}

	s+= '	swfobject.embedSWF("' + oEditor.FCKConfig.PluginsPath + 'flvPlayer/mediaplayer.swf","player' + randomnumber + '","' + thisWidth + '","' + thisHeight + '","10","expressInstall.swf", oSwfVariables, oSwfParams, oSwfAttributes);\n';
	s+= '</script>\n';
	s+= '</div>\n';
	s+= '</div>\n';

	return s;
};

function SelectColor1()
{
	oEditor.FCKDialog.OpenDialog( 'FCKDialog_Color', oEditor.FCKLang.DlgColorTitle, 'dialog/fck_colorselector.html', 400, 330, SelectBackColor, window ) ;
}

function SelectColor2()
{
	oEditor.FCKDialog.OpenDialog( 'FCKDialog_Color', oEditor.FCKLang.DlgColorTitle, 'dialog/fck_colorselector.html', 400, 330, SelectToolColor, window ) ;
}

function SelectColor3()
{
	oEditor.FCKDialog.OpenDialog( 'FCKDialog_Color', oEditor.FCKLang.DlgColorTitle, 'dialog/fck_colorselector.html', 400, 330, SelectToolTextColor, window ) ;
}

function SelectColor4()
{
	oEditor.FCKDialog.OpenDialog( 'FCKDialog_Color', oEditor.FCKLang.DlgColorTitle, 'dialog/fck_colorselector.html', 400, 330, SelectToolTextRColor, window ) ;
}

function SelectBackColor( color )
{
	if ( color && color.length > 0 ) {
		GetE('txtBgColor').value = color ;
		//updatePreview()
	}
}

function SelectToolColor( color )
{
	if ( color && color.length > 0 ) {
		GetE('txtToolbarColor').value = color ;
		//updatePreview()
	}
}

function SelectToolTextColor( color )
{
	if ( color && color.length > 0 ) {
		GetE('txtToolbarTxtColor').value = color ;
		//updatePreview()
	}
}

function SelectToolTextRColor( color )
{
	if ( color && color.length > 0 ) {
		GetE('txtToolbarTxtRColor').value = color ;
		//updatePreview()
	}
}