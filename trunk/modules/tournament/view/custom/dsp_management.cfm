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
<h3>#request.content.management_headline#</h3>

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
<input type="hidden" name="form_submitted" value="true">

<h4>#request.content.management_settings_signup_restrictions#</h4>
<table>
	<tr>
		<td><input type="checkbox" name="group_maxsignups" id="group_maxsignups" value="true"<cfif stModuleConfig.groupmaxsignups> checked</cfif>></td>
		<td><label for="group_maxsignups">#request.content.management_settings_groupmaxsignups#</label></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="coin_system" id="coin_system" value="true"<cfif stModuleConfig.coinsystem> checked</cfif>></td>
		<td><label for="coin_system">#request.content.management_settings_coinsystem#</label></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="text" name="coinsystem_usercoins" size="2" maxlength="3" value="#stModuleConfig.coinsystem_usercoins#"> #request.content.management_settings_coinsystem_usercoins#</td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>

<h4>#request.content.management_rules_headline#</h4>

<p>#sStorageRules#</p>

<table>
	<tr>
		<th>#request.content.management_rules_file#</th>
		<th>#request.content.management_rules_lastchange#</th>
	</tr>
	<cfloop query="qRules">
		<cfif qRules.type NEQ "dir">
			<tr>
				<td><a href="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#rules/#qRules.name#" target="_blank">#qRules.name#</a></td>
				<td>#session.oUser.DateTimeFormat(qRules.datelastmodified)#</td>
			</tr>
		</cfif>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">