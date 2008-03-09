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
	<h3>#request.content.logviewer_headline#</h3>
	<p>#request.content.logviewer_description#</p>
	
	<h4>#request.content.logfiles#</h4>
	<table class="list">
		<tr>
			<th>#request.content.log_file#</th>
			<th>#request.content.log_size#</th>
			<th>#request.content.log_date#</th>
		</tr>
		<cfloop query="qLogs">
			<tr>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&logfile=#qLogs.name#')#" target="_blank">#qLogs.name#</a></td>
				<td align="right">#byteConvert(qLogs.size,'MB')#</td>
				<td>#session.oUser.DateTimeFormat(qLogs.datelastmodified)#</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">