<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/admin/controller/form/snippets/act_action_save_prevalidation_core_security_roles_permissions_rel.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
	<!--- snippet 'modules/admin/controller/form/snippets/act_action_save_postvalidation_core_security_roles_permissions_rel.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.core_security_roles_permissions_rel_id" default="0">
	<cfset ocore_security_roles_permissions_rel = application.lanshock.oFactory.load('core_security_roles_permissions_rel','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocore_security_roles_permissions_rel.setrole_id(attributes.role_id)>
		<cfset ocore_security_roles_permissions_rel.setpermission_id(attributes.permission_id)>
	<cfelse>
		
		<cfset ocore_security_roles_permissions_rel.setid(attributes.id)>
		<cfset ocore_security_roles_permissions_rel.setrole_id(attributes.role_id)>
		<cfset ocore_security_roles_permissions_rel.setpermission_id(attributes.permission_id)>
	</cfif>
	
	<cfset ocore_security_roles_permissions_rel.validate()>
	<cfif ocore_security_roles_permissions_rel.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_security_roles_permissions_rel.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_core_security_roles_permissions_rel.cfm">
		
		<!--- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_security_roles_permissions_rel.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = ocore_security_roles_permissions_rel._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocore_security_roles_permissions_rel._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_core_security_roles_permissions_rel.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
