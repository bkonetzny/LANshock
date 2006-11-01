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
<div class="headline">#request.content.timetable_headline#</div>

<cfif qTimetable.recordcount>
<table cellpadding="3" cellspacing="0" align="center">
	<tr>
		<td colspan="2">&nbsp;</td>
		<cfloop query="qTimetable">
			<cfif len(timetable_color)>
			<td align="center">
				<a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">
				<cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif><br>
				#name#</a><br>
				<img src="#stImageDir.general#/spacer.gif" width="100" height="1">
				</td>
			</cfif>
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
					<td title="#NumberFormat(idxHours,'00')#:00 - #name#" style="border-top: 1px solid black; border-left: 1px solid black;"<cfif DateCompare(dtCurrentDateTime,starttime) EQ 1 AND DateCompare(endtime,dtCurrentDateTime) EQ 1> bgcolor="#timetable_color#"</cfif>>&nbsp;</td>
				</cfloop>
			</tr>
			<cfset dtCurrentDateTime = DateAdd('h',1,dtCurrentDateTime)>
		</cfloop>
	</cfloop>
</table>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">