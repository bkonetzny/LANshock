<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	
	
		

	
		

	
		

	
	
	<cfparam name="attributes.core_security_roles_id" default="0">
	<cfset ocore_security_roles = application.lanshock.oFactory.load('core_security_roles','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocore_security_roles.setname(attributes.name)>
		<cfset ocore_security_roles.setmodule(attributes.module)>
	<cfelse>
		
		<cfset ocore_security_roles.setid(attributes.id)>
		<cfset ocore_security_roles.setname(attributes.name)>
		<cfset ocore_security_roles.setmodule(attributes.module)>
	</cfif>
	
	<cfset ocore_security_roles.validate()>
	<cfif ocore_security_roles.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_security_roles_permissions_reliterator = ocore_security_roles.getcore_security_roles_permissions_reliterator()>
		<cfset ocore_security_roles_permissions_reliterator.deleteAll()>
		<cfif StructKeyExists(attributes,'core_security_roles_permissions_rel')>
			<cfloop list="#attributes.core_security_roles_permissions_rel#" index="idx">
				<cfset ocore_security_roles_permissions_reliterator.add(role_id = ocore_security_roles.getid(), permission_id = idx)>
			</cfloop>
		</cfif>
		<cfset ocore_security_roles_permissions_reliterator.validate()>
		<cfif ocore_security_roles_permissions_reliterator.hasErrors()>
			<cfset bHasErrors = true>
		</cfif>
	</cfif>
	
	<cfif NOT bHasErrors>
		<cfset ocore_security_users_roles_reliterator = ocore_security_roles.getcore_security_users_roles_reliterator()>
		<cfset ocore_security_users_roles_reliterator.deleteAll()>
		<cfif StructKeyExists(attributes,'core_security_users_roles_rel')>
			<cfloop list="#attributes.core_security_users_roles_rel#" index="idx">
				<cfset ocore_security_users_roles_reliterator.add(role_id = ocore_security_roles.getid(), user_id = idx)>
			</cfloop>
		</cfif>
		<cfset ocore_security_users_roles_reliterator.validate()>
		<cfif ocore_security_users_roles_reliterator.hasErrors()>
			<cfset bHasErrors = true>
		</cfif>
	</cfif>
	
	<cfif NOT bHasErrors>
		<cfset ocore_security_roles.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_core_security_roles.cfm">
		
		<cfset aReactorErrors = ocore_security_roles._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocore_security_roles._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_core_security_roles.cfm">
		</cfsavecontent>
	</cfif>
