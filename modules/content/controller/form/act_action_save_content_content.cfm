<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/content/controller/form/snippets/act_action_save_prevalidation_content_content.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
	<cfif NOT StructKeyExists(attributes,'bactive')>
		<cfset attributes.bactive = 0>
	</cfif>
	
	<!--- snippet 'modules/content/controller/form/snippets/act_action_save_postvalidation_content_content.cfm' --->
	
		<cfinclude template="snippets/act_action_save_postvalidation_content_content.cfm">
	
	<!--- /snippet --->
	<cfparam name="attributes.content_content_id" default="0">
	<cfset ocontent_content = application.lanshock.oFactory.load('content_content','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocontent_content.setcodename(attributes.codename)>
		<cfset ocontent_content.settitle(attributes.title)>
		<cfset ocontent_content.setcontent(attributes.content)>
		<cfset ocontent_content.setuser_id(attributes.user_id)>
		<cfset ocontent_content.setdtcreated(attributes.dtcreated)>
		<cfset ocontent_content.setdtchanged(attributes.dtchanged)>
		<cfset ocontent_content.setbactive(attributes.bactive)>
	<cfelse>
		
		<cfset ocontent_content.setid(attributes.id)>
		<cfset ocontent_content.setcodename(attributes.codename)>
		<cfset ocontent_content.settitle(attributes.title)>
		<cfset ocontent_content.setcontent(attributes.content)>
		<cfset ocontent_content.setuser_id(attributes.user_id)>
		<cfset ocontent_content.setdtcreated(attributes.dtcreated)>
		<cfset ocontent_content.setdtchanged(attributes.dtchanged)>
		<cfset ocontent_content.setbactive(attributes.bactive)>
	</cfif>
	
	<cfset ocontent_content.validate()>
	<cfif ocontent_content.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocontent_content.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_content_content.cfm">
		
		<!--- snippet 'modules/content/controller/form/snippets/act_form_loadrelated_custom_content_content.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = ocontent_content._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocontent_content._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_content_content.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
