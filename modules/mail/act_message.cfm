<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/act_message.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfparam name="attributes.id" default="">
<cfparam name="attributes.mailtype" default="0">

<cfinvoke component="messenger" method="getMessage" returnvariable="qMessage">
	<cfinvokeargument name="user_id" value="#session.userid#">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">