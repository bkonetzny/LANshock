<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "name|DESC">
<cfset stFilter.stFields.timetable_color = StructNew()>
<cfset stFilter.stFields.timetable_color.mode = 'isNotEqual'>
<cfset stFilter.stFields.timetable_color.value = ''>

<cfinvoke component="#application.lanshock.oFactory.load('tournament_tournament','reactorGateway')#" method="getRecords" returnvariable="qTimetable">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

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
	
	<cfset dtCurrentDateTime = CreateDateTime(year(qStartTime.starttime),month(qStartTime.starttime),day(qStartTime.starttime),'00','00','00')>
	<cfset dtEstimatedEndTime = CreateDateTime(year(qEndTime.endtime),month(qEndTime.endtime),day(qEndTime.endtime),'00','00','00')>
	<cfset iDays = DateDiff('d',dtCurrentDateTime,dtEstimatedEndTime)>

</cfif>

<cfsetting enablecfoutputonly="No">