<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getGallerylist" returnvariable="qGallerylist">
	<cfif session.oUser.checkPermissions('edit-all')>
		<cfinvokeargument name="showVisibleOnly" value="false">
	</cfif>
</cfinvoke>
	
<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getCommentCountStruct" returnvariable="qCommentCount">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">