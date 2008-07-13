<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/admin/controller/form/snippets/act_action_save_prevalidation_core_cron.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
	<cfif NOT StructKeyExists(attributes,'active')>
		<cfset attributes.active = 0>
	</cfif>
	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/admin/controller/form/snippets/act_action_save_postvalidation_core_cron.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.core_cron_id" default="0">
	<cfset ocore_cron = application.lanshock.oFactory.load('core_cron','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocore_cron.setactive(attributes.active)>
		<cfset ocore_cron.setrun(attributes.run)>
		<cfset ocore_cron.setmodule(attributes.module)>
		<cfset ocore_cron.setaction(attributes.action)>
		<cfset ocore_cron.setexecutions(attributes.executions)>
		<cfset ocore_cron.setlastrun_dt(attributes.lastrun_dt)>
		<cfset ocore_cron.setlastrun_time(attributes.lastrun_time)>
		<cfset ocore_cron.setresult(attributes.result)>
	<cfelse>
		
		<cfset ocore_cron.setid(attributes.id)>
		<cfset ocore_cron.setactive(attributes.active)>
		<cfset ocore_cron.setrun(attributes.run)>
		<cfset ocore_cron.setmodule(attributes.module)>
		<cfset ocore_cron.setaction(attributes.action)>
		<cfset ocore_cron.setexecutions(attributes.executions)>
		<cfset ocore_cron.setlastrun_dt(attributes.lastrun_dt)>
		<cfset ocore_cron.setlastrun_time(attributes.lastrun_time)>
		<cfset ocore_cron.setresult(attributes.result)>
	</cfif>
	
	<cfset ocore_cron.validate()>
	<cfif ocore_cron.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_cron.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_core_cron.cfm">
		
		<!--- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_cron.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = ocore_cron._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocore_cron._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_core_cron.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
