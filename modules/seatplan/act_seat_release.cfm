<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.roomid" default="">
<cfparam name="attributes.reserve_for_user" default="">
<cfparam name="iUserID" default="#request.session.userid#">

<cfif isNumeric(attributes.reserve_for_user)>
	<cfset UDF_SecurityCheck(area='set_user_seat')>
	<cfset iUserID = attributes.reserve_for_user>
</cfif>

<cfinvoke component="seatplan" method="getSeatByUserID" returnvariable="qCheckUserSeats">
	<cfinvokeargument name="userid" value="#iUserID#">
</cfinvoke>

<cfif qCheckUserSeats.recordcount>
	
	<cfinvoke component="seatplan" method="removeSeatOwner">
		<cfinvokeargument name="seatid" value="#qCheckUserSeats.id#">
	</cfinvoke>

</cfif>

<cfif len(attributes.roomid)>
	<cflocation url="#myself##myfusebox.thiscircuit#.seatplan&roomid=#attributes.roomid#&#request.session.URLToken#" addtoken="false">
<cfelse>
	<cflocation url="#cgi.http_referer#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">