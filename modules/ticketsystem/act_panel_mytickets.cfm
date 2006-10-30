<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="tickets" method="getMyTickets" returnvariable="qMyTickets">
	<cfinvokeargument name="userid" value="#request.session.userid#">
</cfinvoke>

<cfinvoke component="tickets" method="getOpenTickets" returnvariable="qOpenTickets">
</cfinvoke>

<cfsetting enablecfoutputonly="No">