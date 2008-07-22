<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_prevalidation_tournament_tournament.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_postvalidation_tournament_tournament.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.tournament_tournament_id" default="0">
	<cfset otournament_tournament = application.lanshock.oFactory.load('tournament_tournament','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset otournament_tournament.setname(attributes.name)>
		<cfset otournament_tournament.settype(attributes.type)>
		<cfset otournament_tournament.setexport_league(attributes.export_league)>
		<cfset otournament_tournament.setexport_league_data(attributes.export_league_data)>
		<cfset otournament_tournament.setstatus(attributes.status)>
		<cfset otournament_tournament.setgroupid(attributes.groupid)>
		<cfset otournament_tournament.setmaxteams(attributes.maxteams)>
		<cfset otournament_tournament.setteamsize(attributes.teamsize)>
		<cfset otournament_tournament.setteamsubstitute(attributes.teamsubstitute)>
		<cfset otournament_tournament.setrulefile(attributes.rulefile)>
		<cfset otournament_tournament.setimage(attributes.image)>
		<cfset otournament_tournament.setcoins(attributes.coins)>
		<cfset otournament_tournament.setstarttime(attributes.starttime)>
		<cfset otournament_tournament.setendtime(attributes.endtime)>
		<cfset otournament_tournament.setpausetime(attributes.pausetime)>
		<cfset otournament_tournament.setmatchtime(attributes.matchtime)>
		<cfset otournament_tournament.setmatchcount(attributes.matchcount)>
		<cfset otournament_tournament.settimetable_color(attributes.timetable_color)>
		<cfset otournament_tournament.setladminids(attributes.ladminids)>
		<cfset otournament_tournament.setinfotext(attributes.infotext)>
	<cfelse>
		
		<cfset otournament_tournament.setid(attributes.id)>
		<cfset otournament_tournament.setname(attributes.name)>
		<cfset otournament_tournament.settype(attributes.type)>
		<cfset otournament_tournament.setexport_league(attributes.export_league)>
		<cfset otournament_tournament.setexport_league_data(attributes.export_league_data)>
		<cfset otournament_tournament.setstatus(attributes.status)>
		<cfset otournament_tournament.setgroupid(attributes.groupid)>
		<cfset otournament_tournament.setmaxteams(attributes.maxteams)>
		<cfset otournament_tournament.setteamsize(attributes.teamsize)>
		<cfset otournament_tournament.setteamsubstitute(attributes.teamsubstitute)>
		<cfset otournament_tournament.setrulefile(attributes.rulefile)>
		<cfset otournament_tournament.setimage(attributes.image)>
		<cfset otournament_tournament.setcoins(attributes.coins)>
		<cfset otournament_tournament.setstarttime(attributes.starttime)>
		<cfset otournament_tournament.setendtime(attributes.endtime)>
		<cfset otournament_tournament.setpausetime(attributes.pausetime)>
		<cfset otournament_tournament.setmatchtime(attributes.matchtime)>
		<cfset otournament_tournament.setmatchcount(attributes.matchcount)>
		<cfset otournament_tournament.settimetable_color(attributes.timetable_color)>
		<cfset otournament_tournament.setladminids(attributes.ladminids)>
		<cfset otournament_tournament.setinfotext(attributes.infotext)>
	</cfif>
	
	<cfset otournament_tournament.validate()>
	<cfif otournament_tournament.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset otournament_tournament.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_tournament_tournament.cfm">
		
		<!--- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_tournament.cfm' --->
		
			<cfinclude template="snippets/act_form_loadrelated_custom_tournament_tournament.cfm">
		
		<!--- /snippet --->
		<cfset aReactorErrors = otournament_tournament._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = otournament_tournament._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_tournament_tournament.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
