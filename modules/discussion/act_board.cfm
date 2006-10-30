<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="discussion" method="getGroups" returnvariable="qGroups"></cfinvoke>

<cfinvoke component="discussion" method="getBoard" returnvariable="qBoard">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfinvoke component="#request.lanshock.environment.componentpath#core.comments.comments" method="getTopics" returnvariable="qTopics">
	<cfinvokeargument name="type" value="discussion_board_#attributes.id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">