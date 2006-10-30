<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getTicketlist" access="remote" returntype="query" output="false">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTicketlist">
			SELECT id, title, user, editor, dtcreated, status, badmin
			FROM ticketsystem
			ORDER BY dtcreated DESC
		</cfquery>
		
		<cfreturn qTicketlist>
		
	</cffunction>

	<cffunction name="getTicket" access="remote" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="true">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTicket">
			SELECT id, title, problem, answer, user, editor, dtcreated, dtfinished, status, badmin
			FROM ticketsystem
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qTicket>
		
	</cffunction>

	<cffunction name="getMyTickets" access="remote" returntype="query" output="false">
		<cfargument name="userid" type="numeric" required="true">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qMyTickets">
			SELECT id, title, problem, answer, user, editor, dtcreated, dtfinished, status
			FROM ticketsystem
			WHERE editor = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND status = 2
			ORDER BY dtcreated DESC
		</cfquery>
		
		<cfreturn qMyTickets>
		
	</cffunction>

	<cffunction name="getOpenTickets" access="remote" returntype="query" output="false">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qOpenTickets">
			SELECT id, title, problem, answer, user, editor, dtcreated, dtfinished, status
			FROM ticketsystem
			WHERE status = 0
			ORDER BY dtcreated DESC
		</cfquery>
		
		<cfreturn qOpenTickets>
		
	</cffunction>

	<cffunction name="createTicket" access="remote" returntype="boolean" output="false">
		<cfargument name="title" type="string" required="true">
		<cfargument name="problem" type="string" required="true">
		<cfargument name="userid" type="numeric" required="true">

	
		<cfquery datasource="#request.lanshock.environment.datasource#">
			INSERT INTO ticketsystem
			SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
				problem = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.problem#">,
				user = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">,
				dtcreated = #now()#
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="acceptTicket" access="remote" returntype="boolean" output="false">
		<cfargument name="userid" type="numeric" required="true">
		<cfargument name="ticketid" type="numeric" required="true">
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			UPDATE ticketsystem
			SET editor = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">,
				status = 2
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ticketid#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="finishTicket" access="remote" returntype="boolean" output="false">
		<cfargument name="userid" type="numeric" required="true">
		<cfargument name="ticketid" type="numeric" required="true">
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			UPDATE ticketsystem
			SET dtfinished = #now()#,
				status = 1
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ticketid#">
			AND editor = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND status = 2
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="updateTicket" access="remote" returntype="boolean" output="false">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="editor" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="problem" type="string" required="true">
		<cfargument name="answer" type="string" required="true">
		<cfargument name="badmin" type="boolean" required="true">
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			UPDATE ticketsystem
			SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
				problem = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.problem#">,
				answer = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.answer#">,
				editor = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.editor#">,
				badmin = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.badmin#">
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			AND status = 2
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="deleteTicket" access="remote" returntype="boolean" output="false">
		<cfargument name="ticketid" type="numeric" required="true">
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE
			FROM ticketsystem
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ticketid#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

</cfcomponent>