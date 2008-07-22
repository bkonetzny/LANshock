<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_prevalidation_tournament_group.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/tournament/controller/form/snippets/act_action_save_postvalidation_tournament_group.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.tournament_group_id" default="0">
	<cfset otournament_group = application.lanshock.oFactory.load('tournament_group','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset otournament_group.setseason_id(attributes.season_id)>
		<cfset otournament_group.setname(attributes.name)>
		<cfset otournament_group.setdescription(attributes.description)>
		<cfset otournament_group.setmaxsignups(attributes.maxsignups)>
	<cfelse>
		
		<cfset otournament_group.setid(attributes.id)>
		<cfset otournament_group.setseason_id(attributes.season_id)>
		<cfset otournament_group.setname(attributes.name)>
		<cfset otournament_group.setdescription(attributes.description)>
		<cfset otournament_group.setmaxsignups(attributes.maxsignups)>
	</cfif>
	
	<cfset otournament_group.validate()>
	<cfif otournament_group.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset otournament_group.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_tournament_group.cfm">
		
		<!--- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_group.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = otournament_group._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = otournament_group._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_tournament_group.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
