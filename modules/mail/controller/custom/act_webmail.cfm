<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.action_getheaders" default="false">
<cfparam name="attributes.action_getheader" default="">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="getWebmailAccounts" returnvariable="qAccounts">
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