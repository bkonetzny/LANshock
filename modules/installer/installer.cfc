<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/admin.cfc $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfcomponent>

	<cffunction name="getDatasources" output="false" returntype="string">
		<cfset var oFactory = 0>
		<cfset var lDatasources = ''>
		
		<cftry>
			<cfobject type="java" action="create" name="oFactory" class="coldfusion.server.ServiceFactory">
			<cfset lDatasources = StructKeyList(oFactory.getDataSourceService().getDatasources())>
			<cfcatch></cfcatch>
		</cftry>
		
		<cfreturn LCase(lDatasources)>
	</cffunction>

	<cffunction name="checkDbConnection" output="false" returntype="struct">
		<cfargument name="sDatasource" type="string" required="false" default="">
		
		<cfset var stReturn = StructNew()>
		<cfset var qCheckConnection = 0>
		
		<cfset stReturn.bStatus = true>
		<cfset stReturn.message = ''>
		
		<cfif len(arguments.sDatasource)>
			<cftry>
				<cfquery datasource="#arguments.sDatasource#" name="qCheckConnection">
					SELECT id
					FROM user
				</cfquery>
				<cfcatch>
					<cfset stReturn.bStatus = false>
					<cfset stReturn.message = cfcatch.message>
				</cfcatch>
			</cftry>
		<cfelse>
			<cfset stReturn.bStatus = false>
			<cfset stReturn.message = 'No datasource selected'>
		</cfif>
		
		<cfreturn stReturn>
	</cffunction>

	<cffunction name="checkUserAccounts" output="false" returntype="struct">
		
		<cfset var stReturn = StructNew()>
		<cfset var qCheckAccounts = 0>
		<cfset var stRuntimeConfig = application.lanshock.oRuntime.getRuntimeConfig()>
		
		<cfset stReturn.bStatus = false>
		
		<cftry>
			<cfquery datasource="#stRuntimeConfig.lanshock.datasource#" name="qCheckAccounts">
				SELECT u.id
				FROM user u
				INNER JOIN core_security_users_roles_rel urrel ON u.id = urrel.user_ID
			</cfquery>
			<cfif qCheckAccounts.recordcount>
				<cfset stReturn.bStatus = true>
			</cfif>
			<cfcatch>
				<cfset stReturn.bStatus = false>
				<cfset stReturn.cfcatch = cfcatch>
			</cfcatch>
		</cftry>
		
		<cfreturn stReturn>

	</cffunction>

</cfcomponent>