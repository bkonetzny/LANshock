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
<h3>#request.content.gallery_details#</h3>

<h4>#qGallery.title#</h4>

<p>#qGallery.text#</p>

<cfif session.oUser.checkPermissions('edit-all') OR (session.oUser.checkPermissions('edit-self') AND session.userid EQ qGallery.user_id)>
	<ul class="options">
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery_edit&id=#qGallery.id#')#">#request.content.gallery_edit#</a></li>
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery_delete&id=#qGallery.id#')#">#request.content.gallery_delete#</a></li>
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.item_edit&gallery_id=#qGallery.id#')#">#request.content.item_new#</a></li>
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.item_zip_upload&gallery_id=#qGallery.id#')#">#request.content.zip_upload#</a></li>
	</ul>
</cfif>

<cfset iStartRow = 1>
<cfset iGridRows = ceiling(qItemlist.recordcount / stModuleConfig.items_per_col)>
<cfloop from="1" to="#iGridRows#" index="idx">
	<cfset iEndRow = iStartRow+stModuleConfig.items_per_col-1>
	<cfloop query="qItemlist" startrow="#iStartRow#" endrow="#iEndRow#">
		<cfquery dbtype="query" name="qGetComments">
			SELECT postcount
			FROM qCommentCount
			WHERE identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="gallery_item_#id#">
		</cfquery>
		<div style="float: left; width: #stModuleConfig.tn.max_width#px; margin: 3px; padding: 3px; border: 1px solid gray; border-bottom: 2px solid black; border-right: 2px solid black;">
			<cfif session.userid EQ qGallery.user_id OR session.isAdmin>
				<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.item_edit&id=#qItemlist.id#&gallery_id=#qGallery.id#')#"><img src="#stImageDir.general#/btn_edit.gif" alt="#request.content.item_edit#"></a>
				<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.item_delete&id=#qItemlist.id#&gallery_id=#qGallery.id#')#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.item_delete#"></a>
			</cfif>
			<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.item&id=#qItemlist.id#&gallery_id=#qGallery.id#')#">
				<cfif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/tn/#filename#')>
					<img src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#galleries/#qGallery.id#/tn/#filename#" title="#title#">
				<cfelseif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/#stDefaultModuleConfig.tn.max_width#x#stDefaultModuleConfig.tn.max_height#/#filename#')>
					<img src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#galleries/#qGallery.id#/#stDefaultModuleConfig.tn.max_width#x#stDefaultModuleConfig.tn.max_height#/#filename#" title="#title#">
				</cfif>
				<br/>#title#
			</a>
			<cfif qGetComments.recordcount>
				<span class="text_small text_light">#qGetComments.postcount# #request.content._core__comments__comments#</span>
			</cfif>
		</div>
	</cfloop>
	<cfset iStartRow = iEndRow+1>
	<div class="clearer"></div>
</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="No">