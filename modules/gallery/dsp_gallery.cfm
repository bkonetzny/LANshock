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
<div class="headline">#request.content.gallery_details#</div>

<div class="headline2">#qGallery.title#</div>

#qGallery.text#<br>

<cfif request.session.userid EQ qGallery.user_id OR request.session.isAdmin>
	<a href="#myself##myfusebox.thiscircuit#.gallery_edit&id=#qGallery.id#&#request.session.UrlToken#" class="link_extended">#request.content.gallery_edit#</a><br>
	<a href="#myself##myfusebox.thiscircuit#.gallery_delete&id=#qGallery.id#&#request.session.UrlToken#" class="link_extended">#request.content.gallery_delete#</a><br>
	<a href="#myself##myfusebox.thiscircuit#.item_edit&gallery_id=#qGallery.id#&#request.session.UrlToken#" class="link_extended">#request.content.item_new#</a><br>
	<a href="#myself##myfusebox.thiscircuit#.item_zip_upload&gallery_id=#qGallery.id#&#request.session.UrlToken#" class="link_extended">#request.content.zip_upload#</a>
	<cfif qItemlist.recordcount>
		<br><a href="#myself##myfusebox.thiscircuit#.gallery_zip&gallery_id=#qGallery.id#&#request.session.UrlToken#" class="link_extended">$$$ Create ZIP</a>
	</cfif>
</cfif>
<cfif (stDefaultModuleConfig.public_download OR request.session.userid EQ qGallery.user_id OR request.session.isAdmin) AND FileExists('#stModuleConfig.files.storage#storage/gallery#qGallery.id#.zip')>
	<br><a href="#UDF_Module('webPath')#galleries/gallery#qGallery.id#.zip" class="link_extended">$$$ Download Gallery ZIP</a>
</cfif>

<table width="100%" cellpadding="5" cellspacing="15">
	<cfset iStartRow = 1>
	<cfset iGridRows = ceiling(qItemlist.recordcount / stModuleConfig.items_per_col)>
	<cfloop from="1" to="#iGridRows#" index="idx">
		<cfset iEndRow = iStartRow+stModuleConfig.items_per_col-1>
		<tr>
			<cfloop query="qItemlist" startrow="#iStartRow#" endrow="#iEndRow#">
				<cfquery dbtype="query" name="qGetComments">
					SELECT postcount
					FROM qCommentCount
					WHERE identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="gallery_item_#id#">
				</cfquery>
				<td align="center" valign="top" style="border: 1px solid gray; border-bottom: 2px solid black; border-right: 2px solid black;">
					<cfif request.session.userid EQ qGallery.user_id OR request.session.isAdmin>
						<a href="#myself##myfusebox.thiscircuit#.item_edit&id=#id#&gallery_id=#qGallery.id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_edit.gif" alt="#request.content.item_edit#"></a>
						<a href="#myself##myfusebox.thiscircuit#.item_delete&id=#id#&gallery_id=#qGallery.id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.item_delete#"></a>
						<br>
					</cfif>
					<a href="#myself##myfusebox.thiscircuit#.item&gallery_id=#qGallery.id#&id=#id#&#request.session.UrlToken#">
						<img src="#UDF_Module('webPath')#galleries/#qGallery.id#/tn/#filename#" title="#title#">
						<br>#title#
					</a>
					<cfif qGetComments.recordcount><br><span class="text_small text_light">#qGetComments.postcount# #request.content._core__comments__comments#</span></cfif>
					&nbsp;
					</td>
			</cfloop>
		</tr>
		<cfset iStartRow = iEndRow+1>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">