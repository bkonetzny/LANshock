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
<cfparam name="aError" default="#ArrayNew(1)#">

<cfif NOT isNumeric(qUserMemberData.team_id)>
	<cflocation url="#myself##myfusebox.thiscircuit#.list&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfif qUserMemberData.status NEQ 'leader'>
	<cflocation url="#myself##myfusebox.thiscircuit#.details&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfinvoke component="team" method="getTeamMembers" returnvariable="qTeamMembers">
	<cfinvokeargument name="id" value="#qUserMemberData.team_id#">
</cfinvoke>

<cfif attributes.form_submitted>
	
	<cfloop collection="#attributes#" item="idx">
		<cfif listFirst(idx,'_') EQ 'status'>
			<cfinvoke component="team" method="setTeamMember">
				<cfinvokeargument name="team_id" value="#qUserMemberData.team_id#">
				<cfinvokeargument name="user_id" value="#listLast(idx,'_')#">
				<cfinvokeargument name="status" value="#attributes[idx]#">
				<cfinvokeargument name="rights" value="">
			</cfinvoke>
		</cfif>
	</cfloop>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.details&#request.session.UrlToken#" addtoken="false">

</cfif>

<cfsetting enablecfoutputonly="No">