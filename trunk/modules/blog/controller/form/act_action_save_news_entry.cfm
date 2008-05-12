<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	
	
		

	
		

	
		

	
		

	
		

	
		

	
	
	<cfparam name="attributes.news_entry_id" default="0">
	<cfset onews_entry = application.lanshock.oFactory.load('news_entry','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset onews_entry.setauthor(attributes.author)>
		<cfset onews_entry.settitle(attributes.title)>
		<cfset onews_entry.settext(attributes.text)>
		<cfset onews_entry.setdate(attributes.date)>
		<cfset onews_entry.setmp3url(attributes.mp3url)>
	<cfelse>
		
		<cfset onews_entry.setid(attributes.id)>
		<cfset onews_entry.setauthor(attributes.author)>
		<cfset onews_entry.settitle(attributes.title)>
		<cfset onews_entry.settext(attributes.text)>
		<cfset onews_entry.setdate(attributes.date)>
		<cfset onews_entry.setmp3url(attributes.mp3url)>
	</cfif>
	
	<cfset onews_entry.validate()>
	<cfif onews_entry.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset onews_entry_categoryiterator = onews_entry.getnews_entry_categoryiterator()>
		<cfset onews_entry_categoryiterator.deleteAll()>
		<cfif StructKeyExists(attributes,'news_entry_category')>
			<cfloop list="#attributes.news_entry_category#" index="idx">
				<cfset onews_entry_categoryiterator.add(entry_id = onews_entry.getid(), category_id = idx)>
			</cfloop>
		</cfif>
		<cfset onews_entry_categoryiterator.validate()>
		<cfif onews_entry_categoryiterator.hasErrors()>
			<cfset bHasErrors = true>
		</cfif>
	</cfif>
	
	<cfif NOT bHasErrors>
		<cfset onews_entry.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_news_entry.cfm">
		
		<cfset aReactorErrors = onews_entry._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = onews_entry._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_news_entry.cfm">
		</cfsavecontent>
	</cfif>
