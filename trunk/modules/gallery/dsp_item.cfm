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
<h3><a name="gallery_image"></a>#request.content.item_details#</h3>

<div align="center">
	<cfif isNumeric(iPrevItemID)>
		<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.item&gallery_id=#qGallery.id#&id=#iPrevItemID#')###gallery_image">#request.content.item_nav_prev#</a>
	<cfelse>
		#request.content.item_nav_prev#
	</cfif>
	 | <a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery&id=#qGallery.id#')#">#qGallery.title#</a> | 
	<cfif isNumeric(iNextItemID)>
		<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.item&gallery_id=#qGallery.id#&id=#iNextItemID#')###gallery_image">#request.content.item_nav_next#</a>
	<cfelse>
		#request.content.item_nav_next#
	</cfif>
</div>

<h4>#qItem.title#</h4> <span class="text_small text_light">#LSDateFormat(qItem.dt_created)#</span>

<div align="center">
	<cfif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/#qItem.filename#')>
		<img src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#galleries/#qGallery.id#/#qItem.filename#">
	<cfelseif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/#stDefaultModuleConfig.item.max_width#x#stDefaultModuleConfig.item.max_height#/#qItem.filename#')>
		<img src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#galleries/#qGallery.id#/#stDefaultModuleConfig.item.max_width#x#stDefaultModuleConfig.item.max_height#/#qItem.filename#">
	</cfif>
</div>

<cfif len(qItem.text)>
	<h4>#request.content.description#</h4>
	
	#ConvertText(qItem.text)#
</cfif>

<cfif isWDDX(qItem.metadata)>
	<cfwddx action="wddx2cfml" input="#qItem.metadata#" output="oMetadata">
	<h4 onclick="$('##exif').toggle();">$$$ EXIF-Data</h4>
	
	<div id="exif" style="display: none;">
		<div>
			<ul>
				<cfif isArray(oMetadata)>
					<cfloop from="1" to="#ArrayLen(oMetadata)#" index="idx">
						<li>#oMetadata[idx]#</li>
					</cfloop>
				<cfelseif isQuery(oMetadata)>
					<cfloop query="oMetadata">
						<li>#oMetadata.dirname#/#oMetadata.tagname#: #oMetadata.tagvalue#</li>
					</cfloop>
				</cfif>
			</ul>
		</div>
	</div>
</cfif>

#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">