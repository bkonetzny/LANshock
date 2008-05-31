<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/act_webmail_account_delete.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfparam name="attributes.id" default="">

<cfinvoke component="messenger" method="getWebmailAccounts" returnvariable="qAccount">
	<cfinvokeargument name="user_id" value="#session.userid#">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif qAccount.recordcount>
	<cfscript>
		oObAccount = objectBreeze.objectCreate("core_mail_webmail");
		oObAccount.read(attributes.id);
		oObAccount.delete();
	</cfscript>
</cfif>

<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.webmail')#" addtoken="false">

<cfsetting enablecfoutputonly="No">