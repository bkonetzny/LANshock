<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_prevalidation_tournament_result.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_postvalidation_tournament_result.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.tournament_result_id" default="0">
	<cfset otournament_result = application.lanshock.oFactory.load('tournament_result','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset otournament_result.setmatchid(attributes.matchid)>
		<cfset otournament_result.setteam1_result(attributes.team1_result)>
		<cfset otournament_result.setteam2_result(attributes.team2_result)>
	<cfelse>
		
		<cfset otournament_result.setid(attributes.id)>
		<cfset otournament_result.setmatchid(attributes.matchid)>
		<cfset otournament_result.setteam1_result(attributes.team1_result)>
		<cfset otournament_result.setteam2_result(attributes.team2_result)>
	</cfif>
	
	<cfset otournament_result.validate()>
	<cfif otournament_result.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset otournament_result.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_tournament_result.cfm">
		
		<!--- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_result.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = otournament_result._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = otournament_result._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_tournament_result.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
