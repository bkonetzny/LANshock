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
<div class="headline">#request.content.zip_upload#</div>

<div class="headline2">#request.content.zip_upload#</div>

<table>
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" enctype="multipart/form-data">
	<input type="hidden" name="form_submitted" value="true"/>
	<input type="hidden" name="gallery_id" value="#attributes.gallery_id#"/>
	<tr>
		<td>#request.content.zip_file#</td>
		<td><input type="file" name="file"/></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="#request.content.form_save#"/></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">