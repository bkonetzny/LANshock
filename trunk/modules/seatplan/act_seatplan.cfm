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

<cfinvoke component="seatplan" method="getRooms" returnvariable="qRooms">

<cfif len(attributes.roomid)>

	<cfscript>
		args = StructNew();
		args.roomid = attributes.roomid;
	</cfscript>
	
	<cfinvoke component="seatplan" method="getRoom" returnvariable="qRoom" argumentcollection="#args#">
	<cfinvoke component="seatplan" method="getElements" returnvariable="qElements" argumentcollection="#args#">
		
	<cfscript>
		aSeats = ArrayNew(2);
	</cfscript>
	
	<cfloop query="qElements">

		<cfscript>
			aSeats[col][row] = StructNew();
			aSeats[col][row].status = status;
			aSeats[col][row].id = id;
			aSeats[col][row].userid = guest;
			if(guest NEQ 0) aSeats[col][row].username = getUsernameByID(guest);
			aSeats[col][row].type = type;
			aSeats[col][row].image = image;
		</cfscript>

	</cfloop>

</cfif>

<cfscript>
	stSeatplanSummary = StructNew();
	stSeatplanSummary.seats = 0;
	stSeatplanSummary.seats_free = 0;
</cfscript>

<cfsetting enablecfoutputonly="No">