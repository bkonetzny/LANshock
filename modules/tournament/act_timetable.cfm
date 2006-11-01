<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="timetable" method="getTimetable" returnvariable="qTimetable">

<cfif qTimetable.recordcount>

	<cfquery dbtype="query" maxrows="1" name="qStartTime">
		SELECT starttime
		FROM qTimetable
		ORDER BY starttime
	</cfquery>
	<cfquery dbtype="query" maxrows="1" name="qEndTime">
		SELECT endtime
		FROM qTimetable
		ORDER BY endtime DESC
	</cfquery>
	
	<cfscript>
		dtCurrentDateTime = CreateDateTime(year(qStartTime.starttime),month(qStartTime.starttime),day(qStartTime.starttime),'00','00','00');
		dtEstimatedEndTime = CreateDateTime(year(qEndTime.endtime),month(qEndTime.endtime),day(qEndTime.endtime),'00','00','00');
		iDays = DateDiff('d',dtCurrentDateTime,dtEstimatedEndTime);
	</cfscript>

</cfif>

<!--- <cfdump var="#qTimetable#">
<cfoutput>#iDays#</cfoutput>
<cfdump var="#qStartTime#">
<cfdump var="#qEndTime#"> --->

<cfsetting enablecfoutputonly="No">