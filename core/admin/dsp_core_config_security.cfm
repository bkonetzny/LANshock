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
<div class="headline"><!--- TODO: $$$ ---> System Security</div>

<!--- TODO: $$$ ---> If you don't have a good reason, NEVER disable any security settings!

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
		<th><!--- TODO: $$$ ---> Cron HashKey</th>
		<td>#attributes.cron_hashkey#</td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Generate New Cron HashKey</th>
		<td><input type="text" name="cron_hashkey" value=""></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Prevent Session Hijacking</th>
		<td><input type="radio" name="check_sessionhijack" id="check_sessionhijack1" value="true"<cfif attributes.check_sessionhijack> checked</cfif>> <label for="check_sessionhijack1"><!--- TODO: $$$ ---> Enabled</label><br>
			<input type="radio" name="check_sessionhijack" id="check_sessionhijack0" value="false"<cfif NOT attributes.check_sessionhijack> checked</cfif>> <label for="check_sessionhijack0"><!--- TODO: $$$ ---> Disabled</label></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Check for User -> Module Rights</th>
		<td><input type="radio" name="check_useraccess_module" id="check_useraccess_module1" value="true"<cfif attributes.check_useraccess_module> checked</cfif>> <label for="check_useraccess_module1"><!--- TODO: $$$ ---> Enabled</label><br>
			<input type="radio" name="check_useraccess_module" id="check_useraccess_module0" value="false"<cfif NOT attributes.check_useraccess_module> checked</cfif>> <label for="check_useraccess_module0"><!--- TODO: $$$ ---> Disabled</label></td>
	</tr>
</table>
<input type="submit" value="#request.content.form_save#">
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">