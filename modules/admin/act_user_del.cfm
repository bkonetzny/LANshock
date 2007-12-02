<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_user_del.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted" default="false">

<cfif attributes.form_submitted>

	<!--- get all user data --->
	<cfquery datasource="#application.lanshock.environment.datasource#" name="qGetUserData">
		SELECT *
		FROM user
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.user_id#">		
	</cfquery>
	
	<!--- backup user data --->
	<cfwddx action="cfml2wddx" input="#qGetUserData#" output="wddxUserData">
	
	<cfquery datasource="#application.lanshock.environment.datasource#">
		INSERT INTO user_deleted (old_id, name, email, firstname, lastname, dt_deleted, full_data)
		VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#qGetUserData.id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#qGetUserData.name#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#qGetUserData.email#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#qGetUserData.firstname#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#qGetUserData.lastname#">,
				#now()#,
				'#wddxUserData#')
	</cfquery>
	
	<!--- delete user --->
	<cfquery datasource="#application.lanshock.environment.datasource#">
		DELETE
		FROM user
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.user_id#">		
	</cfquery>
	
	<!--- release seats --->
	<cftry>
		<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatByUserID" returnvariable="qCheckUserSeats">
			<cfinvokeargument name="userid" value="#attributes.user_id#">
		</cfinvoke>
		
		<cfif qCheckUserSeats.recordcount>
			
			
			<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="removeSeatOwner">
				<cfinvokeargument name="seatid" value="#qCheckUserSeats.id#">
			</cfinvoke>
		
		</cfif>
		<cfcatch><!--- do nothing ---></cfcatch>
	</cftry>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.userlist&#request.session.URLToken#" addtoken="false">

</cfif>

<cfsetting enablecfoutputonly="No">