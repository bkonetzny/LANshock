<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.id" default="">

<cfinvoke component="messenger" method="getWebmailAccounts" returnvariable="qAccount">
	<cfinvokeargument name="user_id" value="#request.session.userid#">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif qAccount.recordcount>
	<cfscript>
		oObAccount = objectBreeze.objectCreate("core_mail_webmail");
		oObAccount.read(attributes.id);
		oObAccount.delete();
	</cfscript>
</cfif>

<cflocation url="#myself##myfusebox.thiscircuit#.webmail&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">