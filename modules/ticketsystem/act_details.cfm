<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="tickets" method="getTicket" returnvariable="qTicketdetails">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfinvoke component="#application.lanshock.environment.componentpath#core.admin.admin" method="getAdmins" returnvariable="qAdmins"/>

<cfsetting enablecfoutputonly="No">