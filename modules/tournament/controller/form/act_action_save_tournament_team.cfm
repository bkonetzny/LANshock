<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_prevalidation_tournament_team.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_postvalidation_tournament_team.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.tournament_team_id" default="0">
	<cfset otournament_team = application.lanshock.oFactory.load('tournament_team','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset otournament_team.setname(attributes.name)>
		<cfset otournament_team.settournamentid(attributes.tournamentid)>
		<cfset otournament_team.setleaderid(attributes.leaderid)>
		<cfset otournament_team.setautoacceptids(attributes.autoacceptids)>
		<cfset otournament_team.setleagueid(attributes.leagueid)>
	<cfelse>
		
		<cfset otournament_team.setid(attributes.id)>
		<cfset otournament_team.setname(attributes.name)>
		<cfset otournament_team.settournamentid(attributes.tournamentid)>
		<cfset otournament_team.setleaderid(attributes.leaderid)>
		<cfset otournament_team.setautoacceptids(attributes.autoacceptids)>
		<cfset otournament_team.setleagueid(attributes.leagueid)>
	</cfif>
	
	<cfset otournament_team.validate()>
	<cfif otournament_team.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset otournament_team.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_tournament_team.cfm">
		
		<!--- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_team.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = otournament_team._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = otournament_team._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_tournament_team.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
