<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_profile.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfparam name="attributes.id" default="#session.userid#">

<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getByFields" returnvariable="qUserData">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif NOT qUserData.recordcount>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.user_not_found')#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">