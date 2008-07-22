<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_prevalidation_tournament_season.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_postvalidation_tournament_season.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.tournament_season_id" default="0">
	<cfset otournament_season = application.lanshock.oFactory.load('tournament_season','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset otournament_season.setname(attributes.name)>
		<cfset otournament_season.setdescription(attributes.description)>
		<cfset otournament_season.setevent_id(attributes.event_id)>
		<cfset otournament_season.setplayer_coins(attributes.player_coins)>
		<cfset otournament_season.setdt_start(attributes.dt_start)>
		<cfset otournament_season.setdt_end(attributes.dt_end)>
	<cfelse>
		
		<cfset otournament_season.setid(attributes.id)>
		<cfset otournament_season.setname(attributes.name)>
		<cfset otournament_season.setdescription(attributes.description)>
		<cfset otournament_season.setevent_id(attributes.event_id)>
		<cfset otournament_season.setplayer_coins(attributes.player_coins)>
		<cfset otournament_season.setdt_start(attributes.dt_start)>
		<cfset otournament_season.setdt_end(attributes.dt_end)>
	</cfif>
	
	<cfset otournament_season.validate()>
	<cfif otournament_season.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset otournament_season.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_tournament_season.cfm">
		
		<!--- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_season.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = otournament_season._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = otournament_season._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_tournament_season.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
