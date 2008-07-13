<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/blog/controller/form/snippets/act_action_save_prevalidation_news_trackback.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
	<!--- snippet 'modules/blog/controller/form/snippets/act_action_save_postvalidation_news_trackback.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.news_trackback_id" default="0">
	<cfset onews_trackback = application.lanshock.oFactory.load('news_trackback','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset onews_trackback.setentry_id(attributes.entry_id)>
		<cfset onews_trackback.setblog_name(attributes.blog_name)>
		<cfset onews_trackback.settitle(attributes.title)>
		<cfset onews_trackback.settext(attributes.text)>
		<cfset onews_trackback.setdate(attributes.date)>
		<cfset onews_trackback.seturl(attributes.url)>
	<cfelse>
		
		<cfset onews_trackback.setid(attributes.id)>
		<cfset onews_trackback.setentry_id(attributes.entry_id)>
		<cfset onews_trackback.setblog_name(attributes.blog_name)>
		<cfset onews_trackback.settitle(attributes.title)>
		<cfset onews_trackback.settext(attributes.text)>
		<cfset onews_trackback.setdate(attributes.date)>
		<cfset onews_trackback.seturl(attributes.url)>
	</cfif>
	
	<cfset onews_trackback.validate()>
	<cfif onews_trackback.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset onews_trackback.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_news_trackback.cfm">
		
		<!--- snippet 'modules/blog/controller/form/snippets/act_form_loadrelated_custom_news_trackback.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = onews_trackback._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = onews_trackback._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_news_trackback.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
