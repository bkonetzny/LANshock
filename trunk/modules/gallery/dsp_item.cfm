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
<a name="gallery_image"><div class="headline">#request.content.item_details#</div>

<div align="center">
	<cfif isNumeric(iPrevItemID)>
		<a href="#myself##myfusebox.thiscircuit#.item&gallery_id=#qGallery.id#&id=#iPrevItemID#&#request.session.UrlToken###gallery_image">#request.content.item_nav_prev#</a>
	<cfelse>
		#request.content.item_nav_prev#
	</cfif>
	 | <a href="#myself##myfusebox.thiscircuit#.gallery&id=#qGallery.id#&#request.session.UrlToken#">#qGallery.title#</a> | 
	<cfif isNumeric(iNextItemID)>
		<a href="#myself##myfusebox.thiscircuit#.item&gallery_id=#qGallery.id#&id=#iNextItemID#&#request.session.UrlToken###gallery_image">#request.content.item_nav_next#</a>
	<cfelse>
		#request.content.item_nav_next#
	</cfif>
</div>

<div class="headline2">#qItem.title#</div> <span class="text_small text_light">#LSDateFormat(qItem.dt_created)#</span>

<div align="center">
	<img src="#UDF_Module('webPath')#galleries/#qGallery.id#/#qItem.filename#">
</div>

<div class="headline2">#request.content.description#</div>

#ConvertText(qItem.text)#

<cfif isWDDX(qItem.metadata)>
	<cfwddx action="wddx2cfml" input="#qItem.metadata#" output="aMetadata">
	<div class="headline2">$$$ EXIF-Data</div>
	
	<div class="expandable">
		<div>
			<ul>
				<cfloop from="1" to="#ArrayLen(aMetadata)#" index="idx">
					<li>#aMetadata[idx]#</li>
				</cfloop>
			</ul>
		</div>
	</div>
</cfif>

#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">