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
<h3><!--- TODO: $$$ ---> Cron Jobs</h3>

<h4><!--- TODO: $$$ ---> Cron Info</h4>

<table class="vlist">
	<cfif StructIsEmpty(stCronConfig)>
		<tr>
			<th>Info:</th>
			<td>No Cron Info avaible.</td>
		</tr>
	<cfelse>
		<tr>
			<th><!--- TODO: $$$ ---> Time Now</th>
			<td>#UDF_DateTimeFormat(now())#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> Last Run</th>
			<td><cfif isDate(stCronConfig.last_dt)>#stCronConfig.last_tasks# Tasks in #stCronConfig.last# seconds @ #UDF_DateTimeFormat(stCronConfig.last_dt)#</cfif></td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> Peak</th>
			<td><cfif isDate(stCronConfig.max_dt)>#stCronConfig.max_tasks# Tasks in #stCronConfig.max# seconds @ #UDF_DateTimeFormat(stCronConfig.max_dt)#</cfif></td>
		</tr>
	</cfif>
	<tr>
		<th><!--- TODO: $$$ ---> Cron URL</th>
		<td>#application.lanshock.oHelper.buildUrl('cron.run&securityhash=#application.applicationname#',true)#</td>
	</tr>
</table>

<h4><!--- TODO: $$$ ---> Tasks</h4>

<table>
	<tr>
		<th class="empty">&nbsp;</th>
		<th><!--- TODO: $$$ ---> Module</th>
		<th><!--- TODO: $$$ ---> Action</th>
		<th><!--- TODO: $$$ ---> Run</th>
		<th><!--- TODO: $$$ ---> Last Run</th>
		<th><!--- TODO: $$$ ---> Time</th>
		<th><!--- TODO: $$$ ---> Runs</th>
		<th><!--- TODO: $$$ ---> Result</th>
	</tr>
	<cfloop query="qCronlist">
		<tr>
			<td class="empty"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&switchtask=#id#')#"><img src="#stImageDir.general#/status_led_<cfif active EQ 0>red<cfelse>green</cfif>.gif" alt="#active#"></a> <a href="#application.lanshock.oHelper.buildUrl('cron.run&cron_id=#id#&securityhash=#application.applicationname#')#" target="_blank"><!--- TODO: $$$ ---> Run</a></td>
			<td>#module#</td>
			<td>#action#</td>
			<td title="Minute Hour Day Month Weekday">#run#</td>
			<td><cfif isDate(lastrun_dt)>#session.oUser.DateTimeFormat(lastrun_dt)#<cfelse><!--- TODO: $$$ ---> NEVER</cfif></td>
			<td>#lastrun_time# seconds</td>
			<td>#executions#</td>
			<td><img src="#stImageDir.general#/status_led_<cfif result EQ 'OK'>green<cfelseif NOT len(result)>orange<cfelse>red</cfif>.gif"></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">