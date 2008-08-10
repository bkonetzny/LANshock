<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_player">
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
<h3>#request.content.__globalmodule__navigation__tournament_player_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_player_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_player_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_8416F8E1F2494216A50759A2069508D7" value="#otournament_player.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_8416F8E1F2494216A50759A2069508D7">#request.content.tournament_player_rowtype_label_id#</label>
		#Trim(otournament_player.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A5D4DD4FA7264FE9AC0D34CFF3B7DE48">#request.content.tournament_player_rowtype_label_status#</label>
		<input type="text" class="textInput" name="status" id="formrow_A5D4DD4FA7264FE9AC0D34CFF3B7DE48" value="#Trim(otournament_player.getstatus())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_team = otournament_player.gettournament_team().getid()>
	<div class="ctrlHolder">
		<label for="formrow_37E13A33DD8D469DB0795C179A55F3DB">tournament_team</label>
		<select class="selectInput" name="teamid" id="formrow_37E13A33DD8D469DB0795C179A55F3DB">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.tournament_team.qData">
				<option value="#stRelated.stManyToOne.tournament_team.qData.optionvalue#"<cfif sReltournament_team EQ stRelated.stManyToOne.tournament_team.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.tournament_team.qData.optionname#</option>
			</cfloop>
		</select>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sReluser = otournament_player.getuser().getid()>
	<div class="ctrlHolder">
		<label for="formrow_FFC84020586244D5B7FBC91ECCA2F941">user</label>
		<select class="selectInput" name="userid" id="formrow_FFC84020586244D5B7FBC91ECCA2F941">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.user.qData">
				<option value="#stRelated.stManyToOne.user.qData.optionvalue#"<cfif sReluser EQ stRelated.stManyToOne.user.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.user.qData.optionname#</option>
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
