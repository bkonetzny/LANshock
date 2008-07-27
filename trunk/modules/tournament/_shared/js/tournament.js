LANshock.Modules.oTournament = {
	sRelocate: ''
};

LANshock.Modules.oTournament.changeTournamentStatus = function(title,message,icon,relocate){
	LANshock.Modules.oTournament.sRelocate = relocate;
	Ext.Msg.show({
		title: title,
		msg: message,
		buttons: Ext.Msg.YESNO,
		fn: LANshock.Modules.oTournament.changeTournamentStatusRelocate,
		icon: Ext.MessageBox[icon]
	});
	//Ext.MessageBox.confirm(title,message,LANshock.Modules.oTournament.changeTournamentStatusRelocate);
}

LANshock.Modules.oTournament.changeTournamentStatusRelocate = function(btn){
	if (btn == 'yes') {
		window.location.href = LANshock.Modules.oTournament.sRelocate;
	}
}