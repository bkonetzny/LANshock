<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	
	
		

	
		
	
	
		

	
		

	
	
	<cfparam name="attributes.core_modules_id" default="0">
	<cfset ocore_modules = application.lanshock.oFactory.load('core_modules','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocore_modules.setversion(attributes.version)>
		<cfset ocore_modules.setdate(attributes.date)>
		<cfset ocore_modules.setname(attributes.name)>
	<cfelse>
		
		<cfset ocore_modules.setversion(attributes.version)>
		<cfset ocore_modules.setdate(attributes.date)>
		<cfset ocore_modules.setname(attributes.name)>
		<cfset ocore_modules.setfolder(attributes.folder)>
	</cfif>
	
	<cfset ocore_modules.validate()>
	<cfif ocore_modules.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_modules.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_core_modules.cfm">
		
		<cfset aReactorErrors = ocore_modules._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocore_modules._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_core_modules.cfm">
		</cfsavecontent>
	</cfif>
