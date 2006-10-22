<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.id" default="">
<cfparam name="attributes.mailtype" default="0">

<cfinvoke component="messenger" method="getMessage" returnvariable="qMessage">
	<cfinvokeargument name="user_id" value="#request.session.userid#">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">