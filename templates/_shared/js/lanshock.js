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
		sessionUrlToken:"",
		sWebPath:""
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
	},
	Formatters:{}
}

LANshock.Formatters.formatBoolean = function(value){
	if(value) return '<img src="'+LANshock.getVar('sWebPath')+'templates/_shared/images/famfamfam/icons/bullet_green.png" alt=""/>';
	else return '<img src="'+LANshock.getVar('sWebPath')+'templates/_shared/images/famfamfam/icons/bullet_red.png" alt=""/>';
};

LANshock.Formatters.cfTimeStamp = function(value){
	if(value){
		var aMatches = value.match("([0-9]{4,4})-([0-9]{2,2})-([0-9]{2,2}) ([0-9]{2,2}):([0-9]{2,2}):([0-9]{2,2})"); 
		var dtDateTime = new Date();
		dtDateTime.setYear(aMatches[1]);
		dtDateTime.setMonth(aMatches[2]-1);
		dtDateTime.setDate(aMatches[3]);
		dtDateTime.setHours(aMatches[4]);
		dtDateTime.setMinutes(aMatches[5]);
		dtDateTime.setSeconds(aMatches[6]);
		return Ext.util.Format.date(dtDateTime,"d.m.y, h:m");
	} 
	else return '-';
};