<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/act_webmail.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.action_getheaders" default="false">
<cfparam name="attributes.action_getheader" default="">

<cfinvoke component="messenger" method="getWebmailAccounts" returnvariable="qAccounts">
	<cfinvokeargument name="user_id" value="#session.userid#">
</cfinvoke>

<cfset stResults = StructNew()>

<cfif attributes.action_getheaders OR len(attributes.action_getheader)>

	<cfloop query="qAccounts">
		<cfif isactive AND (NOT len(attributes.action_getheader) OR attributes.action_getheader EQ id)>
			<cfset stResults[id] = StructNew()>
			
			<cftry>
				<cfpop action="getHeaderOnly" name="qPop" server="#server#" port="#port#" username="#username#" password="#password#" timeout="5">
				<cfset stResults[id] = qPop>
				<cfcatch><cfset stResults[id] = cfcatch></cfcatch>
			</cftry>
		</cfif>
	</cfloop>

</cfif>

<cfsetting enablecfoutputonly="No">