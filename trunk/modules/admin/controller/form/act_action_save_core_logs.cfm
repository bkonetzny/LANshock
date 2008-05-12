<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	
	
		

	
		

	
		

	
		

	
		
	
	
	
	<cfparam name="attributes.core_logs_id" default="0">
	<cfset ocore_logs = application.lanshock.oFactory.load('core_logs','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ocore_logs.setid(attributes.id)>
		<cfset ocore_logs.setlogname(attributes.logname)>
		<cfset ocore_logs.setlevel(attributes.level)>
		<cfset ocore_logs.setdata(attributes.data)>
	<cfelse>
		
		<cfset ocore_logs.setid(attributes.id)>
		<cfset ocore_logs.setlogname(attributes.logname)>
		<cfset ocore_logs.setlevel(attributes.level)>
		<cfset ocore_logs.setdata(attributes.data)>
		<cfset ocore_logs.settimestamp(attributes.timestamp)>
	</cfif>
	
	<cfset ocore_logs.validate()>
	<cfif ocore_logs.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_logs.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_core_logs.cfm">
		
		<cfset aReactorErrors = ocore_logs._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ocore_logs._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_core_logs.cfm">
		</cfsavecontent>
	</cfif>
