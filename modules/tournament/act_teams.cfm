<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="team" method="getTeams" returnvariable="stTeams">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">