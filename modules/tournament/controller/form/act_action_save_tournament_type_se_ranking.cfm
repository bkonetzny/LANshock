<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_prevalidation_tournament_type_se_ranking.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_postvalidation_tournament_type_se_ranking.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.tournament_type_se_ranking_id" default="0">
	<cfset otournament_type_se_ranking = application.lanshock.oFactory.load('tournament_type_se_ranking','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset otournament_type_se_ranking.settournamentid(attributes.tournamentid)>
		<cfset otournament_type_se_ranking.setteamid(attributes.teamid)>
		<cfset otournament_type_se_ranking.setpos(attributes.pos)>
	<cfelse>
		
		<cfset otournament_type_se_ranking.setid(attributes.id)>
		<cfset otournament_type_se_ranking.settournamentid(attributes.tournamentid)>
		<cfset otournament_type_se_ranking.setteamid(attributes.teamid)>
		<cfset otournament_type_se_ranking.setpos(attributes.pos)>
	</cfif>
	
	<cfset otournament_type_se_ranking.validate()>
	<cfif otournament_type_se_ranking.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset otournament_type_se_ranking.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_tournament_type_se_ranking.cfm">
		
		<!--- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_type_se_ranking.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = otournament_type_se_ranking._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = otournament_type_se_ranking._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_tournament_type_se_ranking.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
