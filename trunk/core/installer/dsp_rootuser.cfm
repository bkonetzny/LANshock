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
	<cfif attributes.rootaccount_saved>
		<div class="text_important">#request.content.root_account_created#</div>
	</cfif>
	
	<div>#request.content.root_notice#</div>
	
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<table>
		<tr>
			<th>#request.content.root_email#</th>
			<td><input type="Text" name="root_email"></td>
		</tr>
		<tr>
			<th>#request.content.root_password#</th>
			<td><input type="Text" name="root_password"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="Submit" value="#request.content.form_save#"></td>
		</tr>
	</table>
	</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">