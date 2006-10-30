<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getGuestList" access="remote" returntype="query" output="false">
		<cfargument name="search" type="string" default="" required="No">
		<cfargument name="startrow" type="numeric" default="0" required="No">
		<cfargument name="order_by" type="string" default="u.name" required="No">
		<cfargument name="order_type" type="string" default="ASC" required="No">
		<cfargument name="all" type="boolean" default="false" required="No">
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qGuests">
			SELECT s.row, s.col, u.id AS user_id, u.name AS nick, u.firstname, u.lastname, sb.name AS ort, sb.id AS roomid, sb.labels_x, sb.labels_y, s.id AS seat_id, t.id AS clan_id, t.name AS clan
			FROM user u
			LEFT OUTER JOIN seatplan_location_elements s ON u.id = s.guest AND s.status = 2
			LEFT OUTER JOIN seatplan_location_data sb ON s.block = sb.id
			LEFT OUTER JOIN core_team_user tu ON tu.user_id = u.id
			LEFT OUTER JOIN core_team t ON t.id = tu.team_id
			<cfif len(arguments.search)>
				WHERE (u.name LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#arguments.search#%" maxlength="255">
						OR u.firstname LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#arguments.search#%" maxlength="255">
						OR u.lastname LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#arguments.search#%" maxlength="255">)
			</cfif>
			GROUP BY u.id
			ORDER BY #arguments.order_by# #arguments.order_type#
		</cfquery>
	
		<cfreturn qGuests>

	</cffunction>

	<cffunction name="getGuestCount" access="remote" returntype="numeric" output="false">
		<cfargument name="search" type="string" default="" required="No">
		
		<cfif len(arguments.search)>
			<cfquery datasource="#application.lanshock.environment.datasource#" name="qGuestCount">
				SELECT COUNT(id) AS menge
				FROM user
				WHERE (name LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#arguments.search#%" maxlength="255">
					 OR clan LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#arguments.search#%" maxlength="255">)
			</cfquery>
		<cfelse>
			<cfquery datasource="#application.lanshock.environment.datasource#" name="qGuestCount" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
				SELECT COUNT(id) AS menge
				FROM user
			</cfquery>
		</cfif>
		
		<cfreturn qGuestCount.menge>

	</cffunction>

</cfcomponent>