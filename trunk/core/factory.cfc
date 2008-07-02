<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>
	
	<cffunction name="load" output="false" returntype="any">
		<cfargument name="sObject" type="string" required="true">
		<cfargument name="sType" type="string" required="false" default="component">
		<cfargument name="bCache" type="boolean" required="false" default="true">
		
		<cfset var oReturn = ''>
		<cfset var sCacheKey = 'factory:#arguments.sType#:#arguments.sObject#'>
		
		<cfif ListFind('reactorDao,reactorRecord',arguments.sType)>
			<cfset arguments.bCache = false>
		</cfif>
		
		<cfif arguments.bCache AND
			StructKeyExists(application.lanshock,'oCache') AND
			application.lanshock.oCache.exists(sCacheKey)>
			<cfset oReturn = application.lanshock.oCache.get(sCacheKey)>
		<cfelse>
			<cfswitch expression="#arguments.sType#">
				<cfcase value="reactorGateway">
					<cfset initFramework('reactor')>
					<cfset oReturn = application.lanshock.oFactory.load('reactor.reactorFactory').createGateway(arguments.sObject)>
				</cfcase>
				<cfcase value="reactorDao">
					<cfset initFramework('reactor')>
					<cfset oReturn = application.lanshock.oFactory.load('reactor.reactorFactory').createDao(arguments.sObject)>
				</cfcase>
				<cfcase value="reactorRecord">
					<cfset initFramework('reactor')>
					<cfset oReturn = application.lanshock.oFactory.load('reactor.reactorFactory').createRecord(arguments.sObject)>
				</cfcase>
				<!--- arguments.sType = 'component' --->
				<cfdefaultcase>
					<cfset oReturn = CreateObject('component',arguments.sObject)>
				</cfdefaultcase>
			</cfswitch>
			<cfif StructKeyExists(application.lanshock,'oCache')>
				<cfset application.lanshock.oCache.set(sCacheKey,oReturn)>
			</cfif>
		</cfif>
		
		<cfreturn oReturn>
	</cffunction>
	
	<cffunction name="initFramework" output="false" returntype="void">
		<cfargument name="sName" type="string" required="true">

		<cfset var oFramework = 0>
		<cfset var sCacheKey = 'factory:component:#arguments.sName#'>
		
		<cfif NOT application.lanshock.oCache.exists(sCacheKey)>

			<cfswitch expression="#arguments.sName#">
				<cfcase value="reactor">
					<cfset oFramework = application.lanshock.oFactory.load('reactor.reactorFactory')>
					<cfset oFramework.init('#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/config/reactor/reactor.xml')>
				</cfcase>
			</cfswitch>
		
		</cfif>
	</cffunction>

</cfcomponent>