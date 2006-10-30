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
<div class="headline">#request.content.item_edit#</div>

<div class="headline2">#request.content.item_edit#</div>

<cfif len(attributes.filename)>
	<div align="center">
		<img src="#UDF_Module('webPath')#galleries/#qGallery.id#/tn/#attributes.filename#">
	</div>
</cfif>

<table>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.URLToken#" method="post" enctype="multipart/form-data">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="gallery_id" value="#attributes.gallery_id#">
	<input type="hidden" name="id" value="#attributes.id#">
	<tr>
		<td>#request.content.item_name#</td>
		<td><input type="text" name="title" value="#attributes.title#"></td>
	</tr>
	<tr>
		<td>#request.content.description#</td>
		<td><textarea name="text">#attributes.text#</textarea></td>
	</tr>
	<tr>
		<td>#request.content.item_file#</td>
		<td><input type="file" name="file"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="#request.content.form_save#"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">