LANshock.Modules.oTournament.oTypeSE = {
	bMarkersTeam: false,
	bMarkersMatchStatus: false
};

LANshock.Modules.oTournament.oTypeSE.showMatchStatus = function(){
	if(!LANshock.Modules.oTournament.oTypeSE.bMarkersMatchStatus){
		$('div.match_status_open').addClass('match_status_open_marker');
		$('div.match_status_submitted').addClass('match_status_submitted_marker');
		$('div.match_status_checked').addClass('match_status_checked_marker');
		LANshock.Modules.oTournament.oTypeSE.bMarkersMatchStatus = true;
	}
	else {
		$('div.match_status_open').removeClass('match_status_open_marker');
		$('div.match_status_submitted').removeClass('match_status_submitted_marker');
		$('div.match_status_checked').removeClass('match_status_checked_marker');
		LANshock.Modules.oTournament.oTypeSE.bMarkersMatchStatus = false;
	}
}

LANshock.Modules.oTournament.oTypeSE.markTeam = function(id){
	if(!LANshock.Modules.oTournament.oTypeSE.bMarkersTeam){
		$('span.team_'+id).addClass('team_marker');
		$('div.team_'+id+'_box').addClass('team_marker_box');
		LANshock.Modules.oTournament.oTypeSE.bMarkersTeam = true;
	}
	else {
		$('span.team_'+id).removeClass('team_marker');
		$('div.team_'+id+'_box').removeClass('team_marker_box');
		LANshock.Modules.oTournament.oTypeSE.bMarkersTeam = false;
	}
}

LANshock.Modules.oTournament.oTypeSE.checkResultsForm = function(){
	var iErrors = 0;
	$('input[@id^=round]').each(function(i){
		var regex = /(^\d+$)/;
		var value = jQuery.trim($('#'+this.id).val());
		if(regex.test(value) && value >= 0){
			// do nothing
		}
		else{
			alert(value);
			iErrors = iErrors+1;
		}
	});
	
	if(iErrors == 0) return true;
	else return false;
}