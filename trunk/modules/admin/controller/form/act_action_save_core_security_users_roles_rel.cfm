<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	
	
		

	
		

	
	
	<cfparam name="attributes.core_security_users_roles_rel_id" default="0">
	<cfset ocore_security_users_roles_rel = application.lanshock.oFactory.load('core_security_users_roles_rel','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocore_security_users_roles_rel.setrole_id(attributes.role_id)>
	<cfelse>
		
		<cfset ocore_security_users_roles_rel.setrole_id(attributes.role_id)>
		<cfset ocore_security_users_roles_rel.setuser_id(attributes.user_id)>
	</cfif>
	
	<cfset ocore_security_users_roles_rel.validate()>
	<cfif ocore_security_users_roles_rel.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_security_users_roles_rel.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_core_security_users_roles_rel.cfm">
		
		<cfset aReactorErrors = ocore_security_users_roles_rel._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocore_security_users_roles_rel._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_core_security_users_roles_rel.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
