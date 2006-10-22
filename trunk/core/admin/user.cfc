<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getUsers" access="public" returntype="query" output="false">
		<cfargument name="luserids" type="string" required="false" default="">
		<cfargument name="search" type="string" required="false" default="">
		<cfargument name="search_in" type="string" required="false" default="id,name,firstname,lastname,email">
		<cfargument name="list_order" type="string" required="false" default="name">
		<cfargument name="list_order_type" type="string" required="false" default="asc">
		<cfargument name="startkey" type="string" required="false" default="all">
		<cfargument name="filter" type="string" required="false" default="">
		
		<cfscript>
			if(NOT listFind('asc,desc',arguments.list_order_type)) arguments.list_order_type = 'asc';
			if(NOT listFind('id,name,firstname,lastname,email,notice',arguments.search_in)) arguments.search_in = 'id,name,firstname,lastname';
			bDoWhere = true;
		</cfscript>
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qUsers">
			SELECT u.*, a.id AS admin
			FROM user u
			LEFT OUTER JOIN admin a ON u.id = a.user
			<cfif len(arguments.luserids)>
				<cfset bDoWhere = false>
				WHERE u.id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.luserids#" list="yes">)
			</cfif>
			<cfif len(arguments.search) AND len(arguments.search_in)>
				<cfset bDoWhere = false>
				WHERE (<cfloop list="#arguments.search_in#" index="idx">
							u.#idx# like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="255" value="%#HtmlEditFormat(arguments.search)#%">
							<cfif idx NEQ listLast(arguments.search_in)> OR </cfif>
						</cfloop>)
			</cfif>
			<cfif len(arguments.filter)>
				<cfloop list="#arguments.filter#" index="idx">
					<cfif bDoWhere>WHERE<cfelse>OR</cfif> #ListFirst(idx,'_')# = <cfqueryparam cfsqltype="cf_sql_integer" value="#ListLast(idx,'_')#">
					<cfset bDoWhere = false>
				</cfloop>
			</cfif>
			<cfif bDoWhere AND arguments.startkey NEQ 'all'>
				<cfif arguments.startkey EQ '?'>
					WHERE left(u.name,1) REGEXP '[^[:alnum:]]'
				<cfelseif arguments.startkey EQ '0-9'>
					WHERE left(u.name,1) REGEXP '[[:digit:]]'
				<cfelse>
					WHERE left(u.name,1) = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="255" value="#arguments.startkey#">
				</cfif>
			</cfif>
			ORDER BY #arguments.list_order# #arguments.list_order_type#
		</cfquery>

		<cfreturn qUsers>

	</cffunction>

	<cffunction name="getUserCountSearch" access="public" returntype="numeric" output="false">
		<cfargument name="search" type="string" required="false" default="">
		<cfargument name="search_in" type="string" required="false" default="">
		<cfargument name="filter" type="string" required="false" default="">
		
		<cfset bDoWhere = true>
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qUserCountSearch">
			SELECT COUNT(id) As cnt
			FROM user
			<cfif len(arguments.search) AND len(arguments.search_in)>
				<cfset bDoWhere = false>
				WHERE (<cfloop list="#arguments.search_in#" index="idx">
							#idx# like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="255" value="%#HtmlEditFormat(arguments.search)#%">
							<cfif idx NEQ listLast(arguments.search_in)> OR </cfif>
						</cfloop>)
			</cfif>
			<cfif len(arguments.filter)>
				<cfloop list="#arguments.filter#" index="idx">
					<cfif bDoWhere>WHERE<cfelse>OR</cfif> #ListFirst(idx,'_')# = <cfqueryparam cfsqltype="cf_sql_integer" value="#ListLast(idx,'_')#">
					<cfset bDoWhere = false>
				</cfloop>
			</cfif>
		</cfquery>
	
		<cfreturn qUserCountSearch.cnt>

	</cffunction>

	<cffunction name="getUserCount" access="public" returntype="numeric" output="false">
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qUserCount">
			SELECT COUNT(id) AS cnt
			FROM user
		</cfquery>
	
		<cfreturn qUserCount.cnt>

	</cffunction>

</cfcomponent>