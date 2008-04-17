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
<h3>#request.content.zip_upload#</h3>

<h4>#request.content.zip_upload#</h4>

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" enctype="multipart/form-data">
<input type="hidden" name="form_submitted" value="true"/>
<input type="hidden" name="gallery_id" value="#attributes.gallery_id#"/>
<table>
	<tr>
		<td>#request.content.zip_file#</td>
		<td><input type="file" name="file"/></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="#request.content.form_save#"/></td>
	</tr>
</table>

<cfif session.oUser.checkPermissions('edit-all')>
	<h4>$$$ Uploaded Zip-File</h4>
	
	<table class="list">
		<tr>
			<th>Name</th>
			<th>Size</th>
			<th>Datum</th>
		</tr>
		<cfloop query="qTmpFiles">
			<tr>
				<td><input type="radio" name="existing_file" value="#qTmpFiles.name#"/> #qTmpFiles.name#</td>
				<td align="center">#qTmpFiles.size#</td>
				<td align="center">#session.oUser.DateTimeFormat(qTmpFiles.dateLastModified)#</td>
			</tr>
		</cfloop>
	</table>
</cfif>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">