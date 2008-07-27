<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_prevalidation_tournament_ranking.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_postvalidation_tournament_ranking.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.tournament_ranking_id" default="0">
	<cfset otournament_ranking = application.lanshock.oFactory.load('tournament_ranking','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset otournament_ranking.settournamentid(attributes.tournamentid)>
		<cfset otournament_ranking.setteamid(attributes.teamid)>
		<cfset otournament_ranking.setpos(attributes.pos)>
		<cfset otournament_ranking.setstats_win(attributes.stats_win)>
		<cfset otournament_ranking.setstats_lose(attributes.stats_lose)>
		<cfset otournament_ranking.setpoints_win(attributes.points_win)>
		<cfset otournament_ranking.setpoints_lose(attributes.points_lose)>
	<cfelse>
		
		<cfset otournament_ranking.setid(attributes.id)>
		<cfset otournament_ranking.settournamentid(attributes.tournamentid)>
		<cfset otournament_ranking.setteamid(attributes.teamid)>
		<cfset otournament_ranking.setpos(attributes.pos)>
		<cfset otournament_ranking.setstats_win(attributes.stats_win)>
		<cfset otournament_ranking.setstats_lose(attributes.stats_lose)>
		<cfset otournament_ranking.setpoints_win(attributes.points_win)>
		<cfset otournament_ranking.setpoints_lose(attributes.points_lose)>
	</cfif>
	
	<cfset otournament_ranking.validate()>
	<cfif otournament_ranking.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset otournament_ranking.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_tournament_ranking.cfm">
		
		<!--- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_ranking.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = otournament_ranking._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = otournament_ranking._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_tournament_ranking.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
