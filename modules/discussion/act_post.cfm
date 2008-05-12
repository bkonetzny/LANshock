<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="getBoard" returnvariable="qBoard">
	<cfinvokeargument name="id" value="#attributes.board_id#">
</cfinvoke>

<cfset uuidTopic = CreateUUID()>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="getCommentsPanel" returnvariable="stComments">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="identifier" value="topic_#uuidTopic#">
	<cfinvokeargument name="linktosource" value="topic&uuid=#uuidTopic#">
	<cfinvokeargument name="type" value="discussion_board_#attributes.board_id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">