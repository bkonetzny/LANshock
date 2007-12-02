<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/dsp_details_edit.cfm $
$LastChangedDate: 2006-10-23 00:42:15 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 52 $
--->

<cfoutput>
<div class="headline">#request.content.edit_team#</div>

<cfif attributes.id NEQ 0>
	<a href="#myself##myfusebox.thiscircuit#.details&#request.session.UrlToken#" class="link_extended">#request.content.back_to_teamdetails#</a>
</cfif>

<div class="headline2">#request.content.teaminfo#</div>
	
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

<table cellspacing="5">
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<tr>
			<td align="right">#request.content.teamname#</td>
			<td><input type="text" name="name" value="#attributes.name#" maxlength="255"></td>
		</tr>
		<tr>
			<td align="right">#request.content.tag#</td>
			<td><input type="text" name="tag" value="#attributes.tag#" maxlength="255"></td>
		</tr>
		<tr>
			<td align="right">#request.content.homepage#</td>
			<td><input type="text" name="homepage" value="#attributes.homepage#" maxlength="255"></td>
		</tr>
		<tr>
			<td align="right">#request.content.description#</td>
			<td><textarea name="description" rows="10" cols="40">#attributes.description#</textarea></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" value="#request.content.form_save#"></td>
		</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">