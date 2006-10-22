<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stUserOnline = request.application.sessions.stSessions>
<cfset aStructOrder = StructSort(stUserOnline,'textnocase','DESC','session.timestamp')>

<cfsetting enablecfoutputonly="No">