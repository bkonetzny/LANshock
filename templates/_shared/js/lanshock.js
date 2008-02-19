/*
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
*/

LANshock={
	properties:{
		self:"",
		myself:"",
		sessionUrlToken:""
	},
	getVars:function(){
		return LANshock.properties;
	},
	getVar:function(key){
		return LANshock.properties[key];
	},
	setVar:function(key,value){
		LANshock.properties[key] = value;
	}
}

function clipboardSet(text){
	window.clipboardData.setData('Text',text);
}

function clipboardGet(){
	return window.clipboardData.getData('Text');
}

function validateCommentsForm(uuidFormName,sErrorMessage){
	var oElmTitle = document.getElementById(uuidFormName+'title');
	var oElmText = document.getElementById('text');
	var oEditor = FCKeditorAPI.GetInstance('text');
	oEditor.UpdateLinkedField();
	if(oElmTitle.value == '' || oElmText.value == '' ){
		alert(sErrorMessage);
		return false;
	}
	else return true;
}

function Panel(){
	var myself = LANshock.getVar('myself');
	var sessionUrlToken = LANshock.getVar('sessionUrlToken');
	window.open(myself+'c_general.panel&'+sessionUrlToken,
				"Panel",
				"height=500,width=220,left=20,top=20,locationbar=0,menubar=0,resizable=1,scrollbars=1,status=0"
	);
}

function SendMsg(iUserID){
	var myself = LANshock.getVar('myself');
	var sessionUrlToken = LANshock.getVar('sessionUrlToken');
	window.open(myself+'c_mail.message_dialog&user_id='+iUserID+'&'+sessionUrlToken,
				"NewMessage",
				"height=300,width=300,left=340,top=20,locationbar=0,menubar=0,resizable=0,scrollbars=1,status=0"
	);
}

function showLANshockCode(){
	var myself = LANshock.getVar('myself');
	var sessionUrlToken = LANshock.getVar('sessionUrlToken');
	window.open(myself+'c_general.lanshock_code_popup&'+sessionUrlToken,
				"LANshockCode",
				"height=450,width=600,left=20,top=20,locationbar=0,menubar=0,resizable=1,scrollbars=1,status=0"
	);
}