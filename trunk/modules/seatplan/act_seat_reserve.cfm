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

<cfif NOT qCheckUserSeats.recordcount>
	
	<cfinvoke component="seatplan" method="setSeatOwner">
		<cfinvokeargument name="seatid" value="#attributes.id#">
		<cfinvokeargument name="user" value="#iUserID#">
	</cfinvoke>

</cfif>

<cflocation url="#myself##myfusebox.thiscircuit#.seatplan&roomid=#attributes.roomid#&#request.session.URLToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">