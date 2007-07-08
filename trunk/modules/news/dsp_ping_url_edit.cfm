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
<div class="headline"><!--- TODO: $$$ ---> Ping URL bearbeiten</div>
	
<cfif ArrayLen(aError)>
	<div class="errorBox">
		#request.content.error#
		<ul>
			<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
			<li>#aError[idxError]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<div class="headline2"><!--- TODO: $$$ ---> Ping URL bearbeiten</div>

<table class="vlist">
	<cfif attributes.ping_id NEQ 0>
		<tr>
			<td colspan="2"><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Neue URL hinzuf�gen</a></td>
		</tr>
	</cfif>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="ping_id" value="#attributes.ping_id#">
	<tr>
		<th><!--- TODO: $$$ ---> Name</th>
		<td><input type="text" name="name" maxlength="255" value="#attributes.name#"></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> URL</th>
		<td><input type="text" name="url" maxlength="255" value="#attributes.url#"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="center"><input type="Submit" value="#request.content.form_save#"></td>
	</tr>
	</form>
</table>

<div class="headline2"><!--- TODO: $$$ ---> Verf&uuml;gbare Ping URLs</div>

<table class="list">
	<tr>
		<th>Name</th>
		<th>URL</th>
	</tr>
	<cfloop query="qPingUrls">
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&ping_id=#qPingUrls.id#&#request.session.UrlToken#">#qPingUrls.name#</a></td>
			<td>#qPingUrls.url#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">