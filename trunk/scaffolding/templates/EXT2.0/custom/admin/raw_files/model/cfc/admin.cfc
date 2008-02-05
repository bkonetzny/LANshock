<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/admin.cfc $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfcomponent>

	<cffunction name="getAdmins" access="public" returntype="query" output="false">
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qAdmins">
			SELECT u.id, u.name, a.security, a.id AS admin_id
			FROM admin a, user u
			WHERE u.id = a.user
			ORDER BY u.name
		</cfquery>
		
		<cfset refresh = 0>
		
		<cfloop query="qAdmins">
			<cfscript>
				if(NOT isWDDX(security)){
					updateRights(id);
					refresh = 1;
				}
			</cfscript>
		</cfloop>
		
		<cfif refresh>
			<cfreturn getAdmins()>
		<cfelse>
			<cfreturn qAdmins>
		</cfif>

	</cffunction>

	<cffunction name="getAdminRights" access="public" returntype="struct" output="false">
		<cfargument name="userid" required="true" type="numeric">
		
		<cfset updateRights(arguments.userid)>
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qAdmin">
			SELECT security, lastchange_userid, lastchange_dt
			FROM admin
			WHERE user = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
		</cfquery>
	
		<cfwddx action="wddx2cfml" input="#qAdmin.security#" output="stSecurityRights">
	
		<cfscript>
			stSecurity = StructNew();
			stSecurity.rights = stSecurityRights;
			stSecurity.lastchange_userid = qAdmin.lastchange_userid;
			stSecurity.lastchange_dt = qAdmin.lastchange_dt;
		</cfscript>
	
		<cfreturn stSecurity>

	</cffunction>

	<cffunction name="setAdminRights" access="public" returntype="boolean" output="false">
		<cfargument name="userid" required="true" type="numeric">
		<cfargument name="security" required="true" type="struct">
		<cfargument name="lastchange_by" required="true" type="numeric">
		
		<cfwddx action="cfml2wddx" input="#arguments.security#" output="wddxSecurity">

		<cfquery datasource="#application.lanshock.environment.datasource#">
			UPDATE admin
			SET security = '#wddxSecurity#',
				lastchange_userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.lastchange_by#">,
				lastchange_dt = #now()#
			WHERE user = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
		</cfquery>
		
		<cfset updateRights(arguments.userid)>
	
		<cfreturn true>

	</cffunction>

	<cffunction name="setAdminSessionRights" access="public" returntype="boolean" output="false">
		<cfargument name="userid" required="true" type="numeric">
		
		<cfscript>
			rights = getAdminRights(arguments.userid);
			session.rights = rights.rights;
		</cfscript>
	
		<cfreturn true>

	</cffunction>

	<cffunction name="updateRights" access="public" returntype="boolean" output="false">
		<cfargument name="userid" type="numeric" required="false" default="0">
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qAdminsForUpdate">
			SELECT id, security
			FROM admin
			<cfif arguments.userid NEQ 0>WHERE user = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"></cfif>
		</cfquery>
		
		<cflock scope="APPLICATION" type="READONLY" timeout="10">
			<cfset stModule = duplicate(application.module)>
		</cflock>
		
		<cfscript>
			stGlobalRights = StructNew();
		</cfscript>
		
		<cfloop collection="#stModule#" item="item">
		
			<cfscript>
				if(StructKeyExists(stModule[item],'securityareas') AND StructCount(stModule[item].securityareas)){
					stGlobalRights[item] = StructNew();
					stGlobalRights[item].areas = StructNew();
					lModuleList = StructKeyList(stModule[item].securityareas);
					iListLen = ListLen(StructKeyList(stModule[item].securityareas));
					for(i = 1 ; i LTE iListLen ; i = i + 1){
						stGlobalRights[item].areas[ListGetAt(lModuleList,i)] = 'false';
					}
				}
			</cfscript>
		
		</cfloop>
		
		<cfloop query="qAdminsForUpdate">
		
			<cfif isWDDX(security)>
				<cfwddx action="wddx2cfml" input="#security#" output="stUserRights">
			<cfelse>
				<cfset stUserRights = StructNew()>
			</cfif>
			
			<cfset stUserRightsNew = StructNew()>
		
			<cfloop collection="#stGlobalRights#" item="item">
			
				<cfscript>
					stUserRightsNew[item] = StructNew();
					stUserRightsNew[item].areas = StructNew();
				</cfscript>
			
				<cfloop collection="#stGlobalRights[item].areas#" item="item2">
				
					<cfscript>
						if(StructKeyExists(stUserRights, item) AND StructKeyExists(stUserRights[item].areas, item2))
							stUserRightsNew[item].areas[item2] = stUserRights[item].areas[item2];
						else if(item EQ '#request.lanshock.settings.modulePrefix.core#admin' AND item2 EQ 'setrights') stUserRightsNew[item].areas[item2] = true;
						else stUserRightsNew[item].areas[item2] = false;
					</cfscript>
				
				</cfloop>
			
			</cfloop>
			
			<cfwddx action="cfml2wddx" input="#stUserRightsNew#" output="wddxSecurity">
			
			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE admin
				SET security = '#wddxSecurity#'
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
			</cfquery>
		
		</cfloop>
	
		<cfreturn true>

	</cffunction>

	<cffunction name="byteConvert" access="public" returntype="string" output="false">
		<cfargument name="num" type="numeric" required="true">
		<cfargument name="unit" type="string" required="false" default="">
		
		<!--- 
			* Pass in a value in bytes, and this function converts it to a human-readable format of bytes, KB, MB, or GB.
			* Updated from Nat Papovich's version.
			* 01/2002 - Optional Units added by Sierra Bufe (sierra@brighterfusion.com)
			* 
			* @param size 	 Size to convert. 
			* @param unit 	 Unit to return results in.  Valid options are bytes,KB,MB,GB. 
			* @return Returns a string. 
			* @author Paul Mone (sierra@brighterfusion.compaul@ninthlink.com) 
			* @version 2.1, January 7, 2002 		
		 --->
		<cfset var iResult = 0>
		<cfset var sUnit = "">
		<cfset var iModifier = "">
			
		<cfset var stSize = StructNew()>
		<cfset stSize.bytes = 1>
		<cfset stSize.kb = 1024>
		<cfset stSize.mb = 1048576>
		<cfset stSize.gb = 1073741824>

		<cfif ListFindNoCase("bytes,KB,MB,GB",arguments.unit)>
			<!--- Check to see if unit was passed in, and if it is valid --->
			<cfset sUnit = arguments.unit>
		<cfelse>
			<!--- If not, set unit depending on the size of num --->
			<cfif arguments.num LT stSize.kb>
				<cfset sUnit = "bytes">
			<cfelseif arguments.num LT stSize.mb>
				<cfset sUnit = "KB">
			<cfelseif arguments.num LT stSize.gb>
				<cfset sUnit = "MB">
			<cfelse>
				<cfset sUnit = "GB">
			</cfif>
		</cfif>
		
		<cfif sUnit EQ "bytes">
			<cfset iModifier = stSize.bytes>
		<cfelseif sUnit EQ "KB">
			<cfset iModifier = stSize.kb>
		<cfelseif sUnit EQ "MB">
			<cfset iModifier = stSize.mb>
		<cfelse>
			<cfset iModifier = stSize.gb>
		</cfif>
			
		<!--- Find the result by dividing num by the number represented by the unit --->
		<cfset iResult = arguments.num / iModifier>
			
		<!--- Format the result --->
		<cfif iResult LT 10>
			<cfset iResult = NumberFormat(Round(iResult * 100) / 100,"0.00")>
		<cfelseif iResult LT 100>
			<cfset iResult = NumberFormat(Round(iResult * 10) / 10,"90.0")>
		<cfelse>
			<cfset iResult = Round(iResult)>
		</cfif>

		<!--- Concatenate result and unit together for the return value --->
		<cfreturn iResult & " " & sUnit>
	</cffunction>

</cfcomponent>