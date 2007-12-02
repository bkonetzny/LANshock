<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/act_panel_buddylist.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfinvoke component="messenger" method="getBuddylist" returnvariable="qBuddylist">
	<cfinvokeargument name="user_id" value="#request.session.userid#">
</cfinvoke>

<cfinvoke component="messenger" method="getNewMessagesBuddyIDs" returnvariable="qNewMessagesBuddyIDs">
	<cfinvokeargument name="user_id" value="#request.session.userid#">
</cfinvoke>

<cfset lBuddy_NotInList = ''>
<cfloop list="#ValueList(qNewMessagesBuddyIDs.user_id_from)#" index="idx">
	<cfif NOT ListFind(ValueList(qBuddylist.id),idx)>
		<cfset lBuddy_NotInList = ListAppend(lBuddy_NotInList,idx)>
	</cfif>
</cfloop>

<cfsetting enablecfoutputonly="No">