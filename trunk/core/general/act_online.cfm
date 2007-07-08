<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<cfset stUserOnline = request.application.sessions.stSessions>
<cfset aStructOrder = StructSort(stUserOnline,'textnocase','DESC','session.timestamp')>

<cfsetting enablecfoutputonly="No">