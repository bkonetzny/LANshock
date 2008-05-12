<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.boardid" default="0">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="generateRSS" returnvariable="sRSS">
	<cfinvokeargument name="boardid" value="#attributes.boardid#">
	<cfinvokeargument name="myfusebox" value="#myfusebox#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">