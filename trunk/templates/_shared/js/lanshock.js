/*
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
*/

LANshock = {
	properties:{
		self:"",
		myself:"",
		sessionUrlToken:""
	},
	getVars:function(){
		return LANshock.properties;
	},
	getVar:function(key){
		return this.properties[key];
	},
	setVar:function(key,value){
		this.properties[key] = value;
	},
	openWindow:function(sUrl,sName,iWidth,iHeight){
		if(typeof(iWidth) == 'undefined') iWidth = 800;
		if(typeof(iHeight) == 'undefined') iHeight = 600;
		window.open(sUrl,sName,"width="+iWidth+",height="+iHeight+",locationbar=0,menubar=0,resizable=0,scrollbars=1,status=0");
	},
	userSendMessage:function(iUserID){
		var sUrl = this.getVar('myself')+'mail.message_dialog/user_id='+iUserID+'/'+this.getVar('sessionUrlToken');
		this.openWindow(sUrl,"NewMessage",300,300);
	}
}