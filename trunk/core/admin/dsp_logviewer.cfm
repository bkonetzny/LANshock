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
	<div class="headline">#request.content.logviewer_headline#</div>
	<br><br>
	#request.content.logviewer_description#
	<div class="headline2">#request.content.logfiles#</div>
	<table class="list">
		<tr>
			<th>#request.content.log_file#</th>
			<th>#request.content.log_size#</th>
			<th>#request.content.log_date#</th>
			<th class="empty">&nbsp;</th>
		</tr>
		<cfloop query="qLogs">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&logfile=#name#&#request.session.urltoken#" target="_blank">#name#</a></td>
				<td align="right">#size#</td>
				<td>#UDF_DateTimeFormat(datelastmodified)#</td>
				<td class="empty"><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&deletefile=#name#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></a></td>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">