<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/admin/controller/form/snippets/act_action_save_prevalidation_core_navigation.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/admin/controller/form/snippets/act_action_save_postvalidation_core_navigation.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.core_navigation_id" default="0">
	<cfset ocore_navigation = application.lanshock.oFactory.load('core_navigation','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocore_navigation.setmodule(attributes.module)>
		<cfset ocore_navigation.setlevel(attributes.level)>
		<cfset ocore_navigation.setsortorder(attributes.sortorder)>
		<cfset ocore_navigation.setpermissions(attributes.permissions)>
	<cfelse>
		
		<cfset ocore_navigation.setmodule(attributes.module)>
		<cfset ocore_navigation.setaction(attributes.action)>
		<cfset ocore_navigation.setlevel(attributes.level)>
		<cfset ocore_navigation.setsortorder(attributes.sortorder)>
		<cfset ocore_navigation.setpermissions(attributes.permissions)>
	</cfif>
	
	<cfset ocore_navigation.validate()>
	<cfif ocore_navigation.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_navigation.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_core_navigation.cfm">
		
		<!--- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_navigation.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = ocore_navigation._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocore_navigation._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_core_navigation.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
