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
	
	<h4>$$$ Recent Actions</h4>
	<table class="list">
		<tr>
			<th>#request.content.log_file#</th>
			<th>$$$ Message</th>
			<th>$$$ User</th>
		</tr>
		<cfloop query="qCoreLogs">
			<tr>
				<td><cfswitch expression="#qCoreLogs.level#">
						<cfcase value="error">
							<img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/delete.png" alt="#qCoreLogs.level#" title="#qCoreLogs.level#" />
						</cfcase>
						<cfcase value="warn">
							<img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/error.png" alt="#qCoreLogs.level#" title="#qCoreLogs.level#" />
						</cfcase>
						<cfcase value="info">
							<img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/information.png" alt="#qCoreLogs.level#" title="#qCoreLogs.level#" />
						</cfcase>
						<cfcase value="debug">
							<img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/con.png" alt="#qCoreLogs.level#" title="#qCoreLogs.level#" />
						</cfcase>
					</cfswitch> <a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&logfile=#qCoreLogs.logname#.log')#" target="_blank">#qCoreLogs.logname#</a>
					<br/>#session.oUser.DateTimeFormat(qCoreLogs.timestamp)#
				</td>
				<td>#qCoreLogs.data#</td>
				<td><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qCoreLogs.userid#')#">#qCoreLogs.name#</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">