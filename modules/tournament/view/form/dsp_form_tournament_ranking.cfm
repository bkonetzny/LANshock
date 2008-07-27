<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_ranking">
<!--- This parameter specifies if we are to use Search Safe URLs or not --->
<cfparam name="request.searchSafe" default="false">
</cfsilent>
<cfoutput>
<script type="text/javascript">
<!--
	function validate(){
		$('##btnSave').attr('disabled','disabled');
		return true;
	};
//-->
</script>
<h3>#request.content.__globalmodule__navigation__tournament_ranking_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_ranking_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_ranking_grid_global_edit#</h4>
</cfif>
<cfif isDefined("aTranslatedErrors") AND ArrayLen(aTranslatedErrors)>
	<div class="errorBox">
		<h3>#request.content.error#</h3>
		<ul>
			<cfloop index="i" from="1" to="#arrayLen(aTranslatedErrors)#">
				<li>#aTranslatedErrors[i]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>
<!--- Start of the form --->
<form id="frmAddEdit" action="#application.lanshock.oHelper.buildUrl('#xfa.save#')#" method="post" class="uniForm" onsubmit="javascript: return validate();">
	<div class="hidden">
		<!---<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
		<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
		<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />--->
	</div>
	
	

	
		
		
		
		
		
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
		
				
		
	
	
		
		
		
		
		
			
				
				
				
				
				
						
					
				
				
			
				
				
				
				
				
						
					
				
				
			
		
				
		
	
	
	
				
	
	
	
	
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aTable</legend>
		
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="id" id="formrow_230815DA698D4079B88C8A67975CEEAB" value="#otournament_ranking.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_230815DA698D4079B88C8A67975CEEAB">#request.content.tournament_ranking_rowtype_label_id#</label>
		#Trim(otournament_ranking.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_53495F2D0E3C4974B02A8B7B20045EFA"><em>*</em> #request.content.tournament_ranking_rowtype_label_pos#</label>
		<input type="text" class="textInput" name="pos" id="formrow_53495F2D0E3C4974B02A8B7B20045EFA" value="#Trim(otournament_ranking.getpos())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_ADEDB32EF1CF4A879BCFC74281357BC7"><em>*</em> #request.content.tournament_ranking_rowtype_label_stats_win#</label>
		<input type="text" class="textInput" name="stats_win" id="formrow_ADEDB32EF1CF4A879BCFC74281357BC7" value="#Trim(otournament_ranking.getstats_win())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E90A3B4ED9024DD1AB550CC8AF47E3BA"><em>*</em> #request.content.tournament_ranking_rowtype_label_stats_lose#</label>
		<input type="text" class="textInput" name="stats_lose" id="formrow_E90A3B4ED9024DD1AB550CC8AF47E3BA" value="#Trim(otournament_ranking.getstats_lose())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_51299A691164443A856FAE94EC739151"><em>*</em> #request.content.tournament_ranking_rowtype_label_points_win#</label>
		<input type="text" class="textInput" name="points_win" id="formrow_51299A691164443A856FAE94EC739151" value="#Trim(otournament_ranking.getpoints_win())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A981B2E3E8A24A80B70959E11FBF7B0A"><em>*</em> #request.content.tournament_ranking_rowtype_label_points_lose#</label>
		<input type="text" class="textInput" name="points_lose" id="formrow_A981B2E3E8A24A80B70959E11FBF7B0A" value="#Trim(otournament_ranking.getpoints_lose())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_tournament = otournament_ranking.gettournament_tournament().getid()>
	<div class="ctrlHolder">
		<label for="formrow_D772D63762D1432F98FECA5AB38794F2">tournament_tournament</label>
		<select class="selectInput" name="tournamentid" id="formrow_D772D63762D1432F98FECA5AB38794F2">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.tournament_tournament.qData">
				<option value="#stRelated.stManyToOne.tournament_tournament.qData.optionvalue#"<cfif sReltournament_tournament EQ stRelated.stManyToOne.tournament_tournament.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.tournament_tournament.qData.optionname#</option>
			</cfloop>
		</select>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sReltournament_team = otournament_ranking.gettournament_team().getid()>
	<div class="ctrlHolder">
		<label for="formrow_6043198B49B34F54B3AD2AFBCFF646CD">tournament_team</label>
		<select class="selectInput" name="teamid" id="formrow_6043198B49B34F54B3AD2AFBCFF646CD">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.tournament_team.qData">
				<option value="#stRelated.stManyToOne.tournament_team.qData.optionvalue#"<cfif sReltournament_team EQ stRelated.stManyToOne.tournament_team.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.tournament_team.qData.optionname#</option>
			</cfloop>
		</select>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
