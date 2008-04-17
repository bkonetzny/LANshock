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
<h3>#request.content.gallery_list#</h3>

<h4>#request.content.gallery_list#</h4>

<cfif session.oUser.checkPermissions('edit-self,edit-all')>
	<ul class="options">
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery_edit')#">#request.content.gallery_new#</a></li>
	</ul>
</cfif>

<table>
	<cfloop query="qGallerylist">
		<cfquery dbtype="query" name="qGetComments">
			SELECT SUM(postcount) AS comments
			FROM qCommentCount
			WHERE linktosource LIKE '%gallery_id=#id#%'
		</cfquery>
		<tr>
			<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery&id=#qGallerylist.id#')#">#qGallerylist.title#
				<cfif len(qGallerylist.tn)>
					<cfif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallerylist.id#/tn/#qGallerylist.tn#')>
						<br><img src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#galleries/#qGallerylist.id#/tn/#qGallerylist.tn#" title="#qGallerylist.title#"/>
					<cfelseif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallerylist.id#/#stDefaultModuleConfig.tn.max_width#x#stDefaultModuleConfig.tn.max_height#/#qGallerylist.tn#')>
						<br><img src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#galleries/#qGallerylist.id#/#stDefaultModuleConfig.tn.max_width#x#stDefaultModuleConfig.tn.max_height#/#qGallerylist.tn#" title="#qGallerylist.title#"/>
					</cfif>
				</cfif>
				</a>
			</td>
			<td><cfif NOT qGallerylist.visible>#request.content.gallery_invisible#<br/></cfif>
				#qGallerylist.itemcount# #request.content.gallery_itemcount#
				<cfif qGetComments.recordcount><br/>#qGetComments.comments# #request.content.gallery_commentcount#</cfif>
				<br/>#request.content.gallery_date#: #session.oUser.DateTimeFormat(qGallerylist.dt_created)#
				<br/>#request.content.gallery_owner#: <a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qGallerylist.user_id#')#">#application.lanshock.oHelper.getUsernameById(qGallerylist.user_id)#</a>
			</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">