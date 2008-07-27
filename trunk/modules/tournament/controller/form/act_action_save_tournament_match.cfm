<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_prevalidation_tournament_match.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_postvalidation_tournament_match.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.tournament_match_id" default="0">
	<cfset otournament_match = application.lanshock.oFactory.load('tournament_match','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset otournament_match.settournamentid(attributes.tournamentid)>
		<cfset otournament_match.setstatus(attributes.status)>
		<cfset otournament_match.setrow(attributes.row)>
		<cfset otournament_match.setcol(attributes.col)>
		<cfset otournament_match.setteam1(attributes.team1)>
		<cfset otournament_match.setteam2(attributes.team2)>
		<cfset otournament_match.setwinner(attributes.winner)>
		<cfset otournament_match.setsubmittedby_userid(attributes.submittedby_userid)>
		<cfset otournament_match.setsubmittedby_teamid(attributes.submittedby_teamid)>
		<cfset otournament_match.setsubmittedby_dt(attributes.submittedby_dt)>
		<cfset otournament_match.setcheckedby_userid(attributes.checkedby_userid)>
		<cfset otournament_match.setcheckedby_teamid(attributes.checkedby_teamid)>
		<cfset otournament_match.setcheckedby_dt(attributes.checkedby_dt)>
		<cfset otournament_match.setcheckedby_admin(attributes.checkedby_admin)>
		<cfset otournament_match.setcheckedby_admin_dt(attributes.checkedby_admin_dt)>
	<cfelse>
		
		<cfset otournament_match.setid(attributes.id)>
		<cfset otournament_match.settournamentid(attributes.tournamentid)>
		<cfset otournament_match.setstatus(attributes.status)>
		<cfset otournament_match.setrow(attributes.row)>
		<cfset otournament_match.setcol(attributes.col)>
		<cfset otournament_match.setteam1(attributes.team1)>
		<cfset otournament_match.setteam2(attributes.team2)>
		<cfset otournament_match.setwinner(attributes.winner)>
		<cfset otournament_match.setsubmittedby_userid(attributes.submittedby_userid)>
		<cfset otournament_match.setsubmittedby_teamid(attributes.submittedby_teamid)>
		<cfset otournament_match.setsubmittedby_dt(attributes.submittedby_dt)>
		<cfset otournament_match.setcheckedby_userid(attributes.checkedby_userid)>
		<cfset otournament_match.setcheckedby_teamid(attributes.checkedby_teamid)>
		<cfset otournament_match.setcheckedby_dt(attributes.checkedby_dt)>
		<cfset otournament_match.setcheckedby_admin(attributes.checkedby_admin)>
		<cfset otournament_match.setcheckedby_admin_dt(attributes.checkedby_admin_dt)>
	</cfif>
	
	<cfset otournament_match.validate()>
	<cfif otournament_match.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset otournament_match.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_tournament_match.cfm">
		
		<!--- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_match.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = otournament_match._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = otournament_match._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_tournament_match.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
