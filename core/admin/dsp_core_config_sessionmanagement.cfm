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
<div class="headline"><!--- TODO: $$$ ---> Session Management</div>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th>#request.content.sessionmanagement#</th>
		<td><input type="radio" name="type" id="type_urltoken" value="urltoken"<cfif attributes.type EQ 'urltoken'> checked</cfif>> <label for="type_urltoken"><!--- TODO: $$$ ---> UrlToken</label><br>
			<input type="radio" name="type" id="type_cookie" value="cookie"<cfif attributes.type EQ 'cookie'> checked</cfif>> <label for="type_cookie"><!--- TODO: $$$ ---> Cookie</label><br>
			<input type="radio" name="type" id="type_force_cookie" value="force_cookie"<cfif attributes.type EQ 'force_cookie'> checked</cfif>> <label for="type_force_cookie"><!--- TODO: $$$ ---> Force Cookie</label></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Timeout</th>
		<td><input type="text" name="timeout" value="#attributes.timeout#" maxlength="6" size="6"> <!--- TODO: $$$ ---> seconds</td>
	</tr>
</table>
<input type="submit" value="#request.content.form_save#">
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">