<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent hint="LANshock Config Manager">

	<cfinclude template="_utils/udf/_structmerge.cfm">

	<cffunction name="createConfig" output="false" returntype="struct">
		<cfargument name="data" type="struct" required="true">
		<cfargument name="module" type="string" required="false" default="#myfusebox.thiscircuit#">
		<cfargument name="version" type="string" required="false" default="">
		
		<cfset var qConfig = ''>
		<cfset var stData = StructNew()>
		<cfset var stConfig = StructNew()>
		<cfset var stReturn = arguments.data>

		<cfif application.lanshock.config.complete>
		
			<cftry>
	
				<cfparam name="application.lanshock.core.configmanager" default="#StructNew()#">

				<cfif NOT StructKeyExists(application.lanshock.core.configmanager,arguments.module)>

					<cfquery datasource="#application.lanshock.environment.datasource#" name="qConfig">
						SELECT module, version, data, dtlastchanged
						FROM core_configmanager
						WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
						<cfif len(arguments.version)>AND version = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.version#"></cfif>
					</cfquery>
			
					<cfif qConfig.recordcount AND isWDDX(qConfig.data)>
						<cfwddx action="wddx2cfml" input="#qConfig.data#" output="stData">
			
						<cfscript>
							stConfig.module = qConfig.module;
							stConfig.version = qConfig.version;
							stConfig.data = stData;
							stConfig.dtlastchanged = qConfig.dtlastchanged;
							
							application.lanshock.core.configmanager[arguments.module] = stConfig;
							stReturn = stData;
						</cfscript>
					</cfif>
					
					<cfparam name="application.lanshock.core.configmanager[arguments.module]" default="#StructNew()#">
					<cfparam name="application.lanshock.core.configmanager[arguments.module].version" default="">
					<cfparam name="application.lanshock.core.configmanager[arguments.module].data" default="#StructNew()#">
					<cfparam name="application.lanshock.core.configmanager[arguments.module].dtlastchanged" default="#now()#">
		
					<cfset stReturn = StructMerge(stReturn,application.lanshock.core.configmanager[arguments.module].data,true)>
					
					<cfif arguments.version NEQ qConfig.version>

						<cfinvoke method="setConfig">
							<cfinvokeargument name="module" value="#arguments.module#">
							<cfinvokeargument name="data" value="#stReturn#">
							<cfinvokeargument name="version" value="#arguments.version#">
						</cfinvoke>
						
					</cfif>
				<cfelse>
					<cfset stReturn = StructMerge(stReturn,application.lanshock.core.configmanager[arguments.module].data,true)>
										
					<cfif arguments.version NEQ application.lanshock.core.configmanager[arguments.module].version>

						<cfinvoke method="setConfig">
							<cfinvokeargument name="module" value="#arguments.module#">
							<cfinvokeargument name="data" value="#stReturn#">
							<cfinvokeargument name="version" value="#arguments.version#">
						</cfinvoke>
						
					</cfif>
				</cfif>
				
				<cfcatch><cfrethrow><cfdump var="#cfcatch#"><cfabort><!--- do nothing ---></cfcatch>

			</cftry>

		</cfif>

		<cfreturn stReturn>
		
	</cffunction>

	<cffunction name="getConfig" output="false" returntype="struct">
		<cfargument name="module" type="string" required="true">
		<cfargument name="version" type="string" required="false" default="">
		
		<cfset var stData = StructNew()>
		<cfset var stConfig = StructNew()>

		<cfif application.lanshock.config.complete>
		
			<cftry>
	
				<cfparam name="application.lanshock.core.configmanager" default="#StructNew()#">

				<cfif StructKeyExists(application.lanshock.core.configmanager,arguments.module)>
					<cfparam name="application.lanshock.core.configmanager[arguments.module].version" default="">
					<cfif NOT len(arguments.version) OR application.lanshock.core.configmanager[arguments.module].version EQ arguments.version>
						<cfset stData = application.lanshock.core.configmanager[arguments.module].data>
					</cfif>
				<cfelse>
					<cfquery datasource="#application.lanshock.environment.datasource#" name="qConfig">
						SELECT module, version, data, dtlastchanged
						FROM core_configmanager
						WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
						<cfif len(arguments.version)>AND version = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.version#"></cfif>
					</cfquery>
			
					<cfif qConfig.recordcount AND isWDDX(qConfig.data)>
						<cfwddx action="wddx2cfml" input="#qConfig.data#" output="stData">
			
						<cfscript>
							stConfig.module = qConfig.module;
							stConfig.version = qConfig.version;
							stConfig.data = stData;
							stConfig.dtlastchanged = qConfig.dtlastchanged;
							
							application.lanshock.core.configmanager[arguments.module] = stConfig;
						</cfscript>
					</cfif>
				</cfif>
			
				<cfcatch><cfreturn StructNew()></cfcatch>
			</cftry>
			
			<cfreturn stData>
		<cfelse>
			<cfreturn StructNew()>
		</cfif>
		
	</cffunction>

	<cffunction name="setConfig" output="false" returntype="boolean">
		<cfargument name="module" type="string" required="true">
		<cfargument name="version" type="string" required="false" default="">
		<cfargument name="data" type="struct" required="true">
		
		<cfset var stLocal = StructNew()>
		
		<cftry>
			
			<cfparam name="application.lanshock.core.configmanager[arguments.module]" default="#StructNew()#">
			<cfparam name="application.lanshock.core.configmanager[arguments.module].version" default="">
			
			<cfscript>
				initDbEntry(arguments.module);
				
				stLocal.stConfig = arguments;
				stLocal.stConfig.dtlastchanged = now();
				
				if(NOT isSimpleValue(application.lanshock.core.configmanager[arguments.module].version)) application.lanshock.core.configmanager[arguments.module].version = '';
				
				if(NOT len(arguments.version) AND len(application.lanshock.core.configmanager[arguments.module].version)) stLocal.stConfig.version = application.lanshock.core.configmanager[arguments.module].version;
				
				application.lanshock.core.configmanager[arguments.module] = stLocal.stConfig;
			</cfscript>
			
			<cfwddx action="cfml2wddx" input="#arguments.data#" output="stLocal.wddxData">
	
			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE core_configmanager
				SET dtlastchanged = #stLocal.stConfig.dtlastchanged#,
					data = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#stLocal.wddxData#">,
					version = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stLocal.stConfig.version#">
				WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stLocal.stConfig.module#">
			</cfquery>

			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
		
		<cfreturn true>
		
	</cffunction>
	
	<cffunction name="clearConfig" output="false" returntype="boolean">
		<cfargument name="lmodules" type="string" required="true">
		
		<cfset var stLocal = StructNew()>
		<cfset stLocal.idx = ''>
		
		<cfloop list="#lmodules#" index="stLocal.idx">		

			<cftry>
				
				<cfset StructDelete(application.lanshock.core.configmanager,stLocal.idx)>
	
				<cfquery datasource="#application.lanshock.environment.datasource#">
					DELETE FROM core_configmanager
					WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stLocal.idx#">
				</cfquery>
	
				<cfcatch><cfrethrow><!--- do nothing ---></cfcatch>
			</cftry>
		
		</cfloop>
		
		<cfreturn true>
		
	</cffunction>
	
	<cffunction name="initDbEntry" output="false" returntype="boolean">
		<cfargument name="module" type="string" required="true">
		
		<cfset var stLocal = StructNew()>

		<cfquery datasource="#application.lanshock.environment.datasource#" name="stLocal.qCheckDB">
			SELECT module FROM core_configmanager
			WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
		</cfquery>
		
		<cfif NOT stLocal.qCheckDB.recordcount>
	
			<cfquery datasource="#application.lanshock.environment.datasource#">
				INSERT INTO core_configmanager (module, version, data, dtlastchanged)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="">,
						#now()#)
			</cfquery>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>

</cfcomponent>