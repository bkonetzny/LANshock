<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/act_details_edit.cfm $
$LastChangedDate: 2006-10-23 00:42:15 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 52 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfset attributes.id = qUserMemberData.team_id>

<cfif isNumeric(attributes.id) AND qUserMemberData.status NEQ 'leader'>
	<cflocation url="#myself##myfusebox.thiscircuit#.details&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfif NOT isNumeric(attributes.id)>
	<cfset attributes.id = 0>
</cfif>

<cfif attributes.id NEQ 0>
	<cfinvoke component="team" method="getTeam" returnvariable="qTeam">
		<cfinvokeargument name="id" value="#attributes.id#">
	</cfinvoke>
	
	<cfloop query="qTeam">
		<cfparam name="attributes.name" default="#name#">
		<cfparam name="attributes.tag" default="#tag#">
		<cfparam name="attributes.homepage" default="#homepage#">
		<cfparam name="attributes.description" default="#description#">
	</cfloop>
<cfelse>
	<cfparam name="attributes.name" default="">
	<cfparam name="attributes.tag" default="">
	<cfparam name="attributes.homepage" default="http://">
	<cfparam name="attributes.description" default="">
</cfif>

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT len(attributes.name)) ArrayAppend(aError, request.content.error_teamname);
		if(NOT len(attributes.tag)) ArrayAppend(aError, request.content.error_teamtag);
	</cfscript>

	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="team" method="setTeam" returnvariable="rTeamID">
			<cfinvokeargument name="id" value="#attributes.id#">
			<cfinvokeargument name="name" value="#attributes.name#">
			<cfinvokeargument name="tag" value="#attributes.tag#">
			<cfinvokeargument name="homepage" value="#attributes.homepage#">
			<cfinvokeargument name="description" value="#attributes.description#">
		</cfinvoke>
		
		<cfif attributes.id EQ 0>

			<cfinvoke component="team" method="setTeamMember">
				<cfinvokeargument name="team_id" value="#rTeamID#">
				<cfinvokeargument name="user_id" value="#request.session.userid#">
				<cfinvokeargument name="status" value="leader">
				<cfinvokeargument name="rights" value="">
			</cfinvoke>
		
		</cfif>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.details&#request.session.UrlToken#" addtoken="false">
	
	</cfif>
</cfif>

<cfsetting enablecfoutputonly="No">