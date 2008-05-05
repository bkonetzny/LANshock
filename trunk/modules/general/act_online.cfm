<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/act_online.cfm $
$LastChangedDate: 2007-07-08 13:01:39 +0200 (So, 08 Jul 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 96 $
--->

<cfset stLocales = application.lanshock.oFactory.load('lanshock.core._utils.i18n.i18nUtil').getLocalesStruct()>

<cfset stUserOnline = application.lanshock.oSessionmanager.getSessions()>
<cfset aStructOrder = StructSort(stUserOnline,'textnocase','DESC','session.dtsessioncreated')>

<cfsetting enablecfoutputonly="No">