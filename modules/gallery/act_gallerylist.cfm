<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="gallery" method="getGallerylist" returnvariable="qGallerylist">
	<cfif request.session.isAdmin>
		<cfinvokeargument name="showVisibleOnly" value="false">
	</cfif>
</cfinvoke>
	
<cfinvoke component="#request.lanshock.environment.componentpath#core.comments.comments" method="getCommentCountStruct" returnvariable="qCommentCount">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">