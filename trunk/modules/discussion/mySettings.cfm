<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	stModuleConfig = StructNew();
	stModuleConfig.types = StructNew();
	stModuleConfig.types.gallery = StructNew();
	stModuleConfig.types.gallery.image = "image.png";
	stModuleConfig.types.blog = StructNew();
	stModuleConfig.types.blog.image = "newspaper.png";
</cfscript>

<cfset lTypesShow = ''>
<cfset lTypesHide = ''>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="getGroups" returnvariable="qGroups">

<cfloop query="qGroups">
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="getBoards" returnvariable="qBoards">
		<cfinvokeargument name="group_id" value="#qGroups.id#">
	</cfinvoke>
	
	<cfloop query="qBoards">
		<cfif NOT len(qGroups.permission)
				OR (len(qGroups.permission) AND session.oUser.checkPermissions(ListLast(qGroups.permission,'.'),ListFirst(qGroups.permission,'.')))>
			<cfset lTypesShow = ListAppend(lTypesShow,"discussion_board_#qBoards.id#")>
		<cfelse>
			<cfset lTypesHide = ListAppend(lTypesHide,"discussion_board_#qBoards.id#")>
		</cfif>
	</cfloop>
</cfloop>

<cfsetting enablecfoutputonly="No">