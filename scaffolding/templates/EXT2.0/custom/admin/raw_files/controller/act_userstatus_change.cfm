<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_userstatus_change.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.userid" default="0">
<cfparam name="attributes.locked" default="">

<cfinvoke component="#application.lanshock.environment.componentpath#core.user.user" method="getUser" returnvariable="qUserData">	
	<cfinvokeargument name="id" value="#attributes.userid#">
</cfinvoke>

<cfif qUserData.recordcount>
	
	<cfif isNumeric(attributes.locked) AND qUserData.locked NEQ attributes.locked>
	
		<cfinvoke component="#request.lanshock.environment.componentpath#core.user.user" method="updateHistory">
			<cfinvokeargument name="userid" value="#attributes.userid#">
			<cfinvokeargument name="status" value="status_lock_#attributes.locked#">
		</cfinvoke>

		<cfinvoke component="#application.lanshock.environment.componentpath#core.user.user" method="updateStatus">	
			<cfinvokeargument name="id" value="#attributes.userid#">
			<cfinvokeargument name="locked" value="#attributes.locked#">
		</cfinvoke>
	
	</cfif>

</cfif>

<cflocation url="#cgi.http_referer#" addtoken="false">

<cfsetting enablecfoutputonly="No">