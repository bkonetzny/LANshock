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
<div class="headline"><!--- TODO: $$$ ---> System Check</div>

<div align="center">
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.URLToken#" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<input type="submit" value="<!--- TODO: $$$ ---> Run System Check">
	</form>
</div>

<cfif attributes.form_submitted>
<table class="list">
	<tr>
		<th><!--- TODO: $$$ ---> Module</th>
		<th><!--- TODO: $$$ ---> Type</th>
		<th><!--- TODO: $$$ ---> Subtype</th>
		<th><!--- TODO: $$$ ---> Message</th>
		<th><!--- TODO: $$$ ---> Status</th>
	</tr>
	<cfloop collection="#stEvents#" item="idx">
		<tr>
			<td>#stEvents[idx].module#</td>
			<td>#stEvents[idx].type#</td>
			<td>#stEvents[idx].subtype#</td>
			<td>#stEvents[idx].message#<br>
				<span class="text_small text_light">#stEvents[idx].details#</span></td>
			<td align="center"><img src="#stImageDir.general#/status_led_<cfif stEvents[idx].status>green<cfelse>red</cfif>.gif" alt="#stEvents[idx].status#"></td>
		</tr>
	</cfloop>
</table>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">