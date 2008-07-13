<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.account_id" default="">
<cfparam name="attributes.uid" default="">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="getWebmailAccounts" returnvariable="qAccount">
	<cfinvokeargument name="user_id" value="#session.userid#">
	<cfinvokeargument name="id" value="#attributes.account_id#">
</cfinvoke>

<cfif qAccount.recordcount>
	<cfpop action="delete" uid="#attributes.uid#" name="qPop" server="#qAccount.server#" port="#qAccount.port#" username="#qAccount.username#" password="#qAccount.password#" timeout="5">
</cfif>

<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.webmail&action_getheader=#attributes.account_id#')#" addtoken="false">

<cfsetting enablecfoutputonly="No">