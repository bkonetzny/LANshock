<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="gallery" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfinvoke component="gallery" method="getItemlist" returnvariable="qItemlist">
	<cfinvokeargument name="gallery_id" value="#attributes.id#">
</cfinvoke>
	
<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getCommentCountStruct" returnvariable="qCommentCount">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">