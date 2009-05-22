<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stLocales = application.lanshock.oFactory.load('lanshock.core._utils.i18n.i18nUtil').getLocalesStruct()>

<cfset stUserOnline = application.lanshock.oSessionmanager.getSessions()>
<cfset aStructOrder = StructSort(stUserOnline,'textnocase','DESC','session.dtSessionLastCall')>

<cfsetting enablecfoutputonly="false">