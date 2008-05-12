<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	
	
		

	
		

	
		

	
	
	<cfparam name="attributes.news_entry_category_id" default="0">
	<cfset onews_entry_category = application.lanshock.oFactory.load('news_entry_category','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset onews_entry_category.setid(attributes.id)>
		<cfset onews_entry_category.setentry_id(attributes.entry_id)>
	<cfelse>
		
		<cfset onews_entry_category.setid(attributes.id)>
		<cfset onews_entry_category.setentry_id(attributes.entry_id)>
		<cfset onews_entry_category.setcategory_id(attributes.category_id)>
	</cfif>
	
	<cfset onews_entry_category.validate()>
	<cfif onews_entry_category.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset onews_entry_category.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_news_entry_category.cfm">
		
		<cfset aReactorErrors = onews_entry_category._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = onews_entry_category._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_news_entry_category.cfm">
		</cfsavecontent>
	</cfif>
