<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	<!--- snippet 'modules/blog/controller/form/snippets/act_action_save_prevalidation_news_category.cfm' --->
	
	<!--- /snippet --->
	
		

	
		

	
	<!--- snippet 'modules/blog/controller/form/snippets/act_action_save_postvalidation_news_category.cfm' --->
	
	<!--- /snippet --->
	<cfparam name="attributes.news_category_id" default="0">
	<cfset onews_category = application.lanshock.oFactory.load('news_category','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset onews_category.setname(attributes.name)>
	<cfelse>
		
		<cfset onews_category.setid(attributes.id)>
		<cfset onews_category.setname(attributes.name)>
	</cfif>
	
	<cfset onews_category.validate()>
	<cfif onews_category.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset onews_entry_categoryiterator = onews_category.getnews_entry_categoryiterator()>
		<cfset onews_entry_categoryiterator.deleteAll()>
		<cfif StructKeyExists(attributes,'news_entry_category')>
			<cfloop list="#attributes.news_entry_category#" index="idx">
				<cfset onews_entry_categoryiterator.add(category_id = onews_category.getid(), entry_id = idx)>
			</cfloop>
		</cfif>
		<cfset onews_entry_categoryiterator.validate()>
		<cfif onews_entry_categoryiterator.hasErrors()>
			<cfset bHasErrors = true>
		</cfif>
	</cfif>
	
	<cfif NOT bHasErrors>
		<cfset onews_category.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_news_category.cfm">
		
		<!--- snippet 'modules/blog/controller/form/snippets/act_form_loadrelated_custom_news_category.cfm' --->
		
		<!--- /snippet --->
		<cfset aReactorErrors = onews_category._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = onews_category._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_news_category.cfm">
		</cfsavecontent>
		<cfoutput>#request.page.pageContent#</cfoutput>
	</cfif>
