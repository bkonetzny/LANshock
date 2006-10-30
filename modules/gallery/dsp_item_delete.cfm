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
<div class="headline">#request.content.item_delete#</div>

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

<div class="headline2">#request.content.item_delete#</div>

<table>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.URLToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="gallery_id" value="#attributes.gallery_id#">
	<input type="hidden" name="id" value="#attributes.id#">
	<tr>
		<td><input type="checkbox" name="delete_accepted" id="delete_accepted" value="true"></td>
		<td><label for="delete_accepted">#request.content.item_delete_confirm#</label></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="submit" value="#request.content.form_delete#"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">