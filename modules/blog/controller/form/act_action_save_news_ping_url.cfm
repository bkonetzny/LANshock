<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/blog/controller/form/snippets/act_action_save_prevalidation_news_ping_url.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
	<!--- snippet 'modules/blog/controller/form/snippets/act_action_save_postvalidation_news_ping_url.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.news_ping_url_id" default="0">
	<cfset onews_ping_url = application.lanshock.oFactory.load('news_ping_url','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset onews_ping_url.setname(attributes.name)>
		<cfset onews_ping_url.seturl(attributes.url)>
	<cfelse>
		
		<cfset onews_ping_url.setid(attributes.id)>
		<cfset onews_ping_url.setname(attributes.name)>
		<cfset onews_ping_url.seturl(attributes.url)>
	</cfif>
	
	<cfset onews_ping_url.validate()>
	<cfif onews_ping_url.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset onews_ping_url.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#')#" addtoken="false">
		<!--- <cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false"> --->
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_news_ping_url.cfm">
		
		<!--- snippet 'modules/blog/controller/form/snippets/act_form_loadrelated_custom_news_ping_url.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = onews_ping_url._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = onews_ping_url._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_news_ping_url.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
