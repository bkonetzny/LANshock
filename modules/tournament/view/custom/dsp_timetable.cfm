<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
<h3>#request.content.timetable_headline#</h3>

<cfif qTimetable.recordcount>
<div style="width:100%;overflow:scroll;">
	<table cellpadding="3" cellspacing="0" align="center">
		<tr>
			<td colspan="2">&nbsp;</td>
			<cfloop query="qTimetable">
				<td align="center">
					<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#qTimetable.id#')#">
					<cfif len(qTimetable.image)><img src="#application.lanshock.oHelper.UDF_Module('webPath')#images/icons/#qTimetable.image#"><br/></cfif>
					#qTimetable.name#</a>
					</td>
			</cfloop>
		</tr>
		<cfloop from="0" to="#iDays#" index="idx">
			<cfloop from="0" to="23" index="idxHours">
				<tr>
					<cfif idxHours EQ 0>
						<cfset dtThisDate = DateAdd('d',idx,qStartTime.starttime)>
						<td rowspan="24" valign="top"><strong>#DayOfWeekAsString(DayOfWeek(dtThisDate))#</strong><br>
							#DateFormat(dtThisDate,'DD.MM.YYYY')#</td>
					</cfif>
					<td style="border-top: 1px solid black;">#NumberFormat(idxHours,'00')#:00</td>
					<cfloop query="qTimetable">
						<cfset bMark = false>
						<cfif DateCompare(dtCurrentDateTime,starttime) EQ 1 AND DateCompare(endtime,dtCurrentDateTime) EQ 1>
							<cfset bMark = true>
						</cfif>
						<td align="center" title="#NumberFormat(idxHours,'00')#:00 - #name#" style="border-top: 1px solid black; border-left: 1px solid black;"<cfif bMark> bgcolor="#timetable_color#"</cfif>><cfif bMark>x</cfif>&nbsp;</td>
					</cfloop>
				</tr>
				<cfset dtCurrentDateTime = DateAdd('h',1,dtCurrentDateTime)>
			</cfloop>
		</cfloop>
	</table>
</div>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">