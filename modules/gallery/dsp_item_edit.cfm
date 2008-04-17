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
<h3>#request.content.item_edit#</h3>

<h4>#request.content.item_edit#</h4>

<table>
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" enctype="multipart/form-data">
	<input type="hidden" name="form_submitted" value="true"/>
	<input type="hidden" name="gallery_id" value="#attributes.gallery_id#"/>
	<input type="hidden" name="id" value="#attributes.id#"/>
	<cfif len(attributes.filename)>
		<tr>
			<td></td>
			<td><cfif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/tn/#attributes.filename#')>
					<br><img src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#galleries/#qGallery.id#/tn/#attributes.filename#" title="#attributes.filename#"/>
				<cfelseif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/#stDefaultModuleConfig.tn.max_width#x#stDefaultModuleConfig.tn.max_height#/#attributes.filename#')>
					<br><img src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#galleries/#qGallery.id#/#stDefaultModuleConfig.tn.max_width#x#stDefaultModuleConfig.tn.max_height#/#attributes.filename#" title="#attributes.filename#"/>
				</cfif></td>
		</tr>
	</cfif>
	<tr>
		<td>#request.content.item_name#</td>
		<td><input type="text" name="title" value="#attributes.title#"/></td>
	</tr>
	<tr>
		<td>#request.content.description#</td>
		<td><textarea name="text">#attributes.text#</textarea></td>
	</tr>
	<tr>
		<td>#request.content.item_file#</td>
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