<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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