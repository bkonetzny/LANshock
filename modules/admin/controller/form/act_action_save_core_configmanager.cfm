<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/admin/controller/form/snippets/act_action_save_prevalidation_core_configmanager.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/admin/controller/form/snippets/act_action_save_postvalidation_core_configmanager.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.core_configmanager_id" default="0">
	<cfset ocore_configmanager = application.lanshock.oFactory.load('core_configmanager','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocore_configmanager.setversion(attributes.version)>
		<cfset ocore_configmanager.setdata(attributes.data)>
		<cfset ocore_configmanager.setdtlastchanged(attributes.dtlastchanged)>
	<cfelse>
		
		<cfset ocore_configmanager.setmodule(attributes.module)>
		<cfset ocore_configmanager.setversion(attributes.version)>
		<cfset ocore_configmanager.setdata(attributes.data)>
		<cfset ocore_configmanager.setdtlastchanged(attributes.dtlastchanged)>
	</cfif>
	
	<cfset ocore_configmanager.validate()>
	<cfif ocore_configmanager.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_configmanager.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_core_configmanager.cfm">
		
		<!--- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_configmanager.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = ocore_configmanager._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocore_configmanager._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_core_configmanager.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
