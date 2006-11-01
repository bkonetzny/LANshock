<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>




	<cffunction name="getTimetable" access="public" returntype="query" output="false">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTimetable">
			SELECT *
			FROM t2k4_tournaments
			WHERE timetable_color != ''
			ORDER BY name
		</cfquery>
		
		<cfreturn qTimetable>
		
	</cffunction>




</cfcomponent>