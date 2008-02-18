<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent hint="LANshock Config Manager">

	<cffunction name="createConfig" output="false" returntype="struct">
		<cfargument name="data" type="struct" required="true">
		<cfargument name="module" type="string" required="true">
		<cfargument name="version" type="string" required="false" default="">
		
		<cfset var stReturn = StructNew()>
		<cfset var sCacheKey = 'config:#arguments.module#'>

		<cftry>
			<cfset stReturn = getConfig(arguments.module,arguments.version)>
			<cfif getConfigVersion(arguments.module) NEQ arguments.version
				OR NOT application.lanshock.oCache.exists(sCacheKey)>
				<cfset setConfig(arguments.module,arguments.version,arguments.data)>
				<cfset stReturn = getConfig(arguments.module,arguments.version)>
			</cfif>
			<cfcatch>
				<cfset stReturn = arguments.data>
			</cfcatch>
		</cftry>
	
		<cfreturn stReturn>
		
	</cffunction>

	<cffunction name="getConfigVersion" output="false" returntype="string">
		<cfargument name="module" type="string" required="true">
		
		<cfset var oConfig = 0>

		<cfset oConfig = application.lanshock.oFactory.load('core_configmanager','reactorRecord')>
		<cfset oConfig.setModule(arguments.module)>
		<cfset oConfig.load()>
			
		<cfreturn oConfig.getVersion()>
		
	</cffunction>

	<cffunction name="getConfig" output="false" returntype="struct">
		<cfargument name="module" type="string" required="true">
		<cfargument name="version" type="string" required="false" default="">
		
		<cfset var oConfig = 0>
		<cfset var stReturn = StructNew()>
		<cfset var sCacheKey = 'config:#arguments.module#'>

		<cfif application.lanshock.oCache.exists(sCacheKey)>
			<cfset stReturn = application.lanshock.oCache.get(sCacheKey)>
		<cfelse>
			<cfset oConfig = application.lanshock.oFactory.load('core_configmanager','reactorRecord')>
			<cfset oConfig.setModule(arguments.module)>
			<cfset oConfig.load()>

			<cfwddx action="wddx2cfml" input="#oConfig.getData()#" output="stReturn">
			
			<cfset application.lanshock.oCache.set(sCacheKey,stReturn)>
		</cfif>
			
		<cfreturn stReturn>
		
	</cffunction>

	<cffunction name="setConfig" output="false" returntype="boolean">
		<cfargument name="module" type="string" required="true">
		<cfargument name="version" type="string" required="false" default="">
		<cfargument name="data" type="struct" required="true">
		
		<cfset var oConfig = 0>
		<cfset var sCacheKey = 'config:#arguments.module#'>
		<cfset var wddxData = ''>
		
		<cfset application.lanshock.oCache.set(sCacheKey,arguments.data)>
		
		<cfwddx action="cfml2wddx" input="#arguments.data#" output="wddxData">

		<cfset oConfig = application.lanshock.oFactory.load('core_configmanager','reactorRecord')>
		<cfset oConfig.setModule(arguments.module)>
		<cfset oConfig.load()>
		<cfif len(arguments.version)>
			<cfset oConfig.setVersion(arguments.version)>
		</cfif>
		<cfset oConfig.setData(wddxData)>
		<cfset oConfig.setDtLastChanged(now())>
		<cfset oConfig.save()>
		
		<cfreturn true>
		
	</cffunction>
	
	<cffunction name="clearConfig" output="false" returntype="boolean">
		<cfargument name="lModules" type="string" required="true">
		
		<cfset var idxModule = ''>
		<cfset var sCacheKey = ''>
		
		<cfloop list="#arguments.lModules#" index="idxModule">		

			<cfset application.lanshock.oCache.drop('config:#idxModule#')>
			
			<cfset oConfig = application.lanshock.oFactory.load('core_configmanager','reactorRecord')>
			<cfset oConfig.setModule(arguments.module)>
			<cfset oConfig.delete()>
		
		</cfloop>
		
		<cfreturn true>
		
	</cffunction>

</cfcomponent>