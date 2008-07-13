<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->
<cfif NOT LsIsDate(attributes.dtcreated)>
	<cfset attributes.dtcreated = now()>
</cfif>
<cfset attributes.dtchanged = now()>
<cfset attributes.user_id = session.oUser.getDataValue('userid')>