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
<cfparam name="attributes.form_submit" default="false">
<cfparam name="attributes.form_submitted2" default="false">

<cfinvoke component="seatplan" method="getRooms" returnvariable="qRooms">

<cfinvoke component="seatplan" method="getElementImages" returnvariable="stElements">
	<cfinvokeargument name="file" value="#UDF_Module('absPath')#elements.xml">
</cfinvoke>

<cfif attributes.form_submit>

	<cfloop collection="#attributes#" item="idx">
		<cfif left(idx,13) EQ "element_type_">
			
			<cfset iRow = ListGetAt(idx,3,"_")>
			<cfset iCol = ListGetAt(idx,4,"_")>
			
			<cfinvoke component="seatplan" method="changeElement">
				<cfinvokeargument name="roomid" value="#attributes.roomid#">
				<cfinvokeargument name="row" value="#iRow#">
				<cfinvokeargument name="col" value="#iCol#">
				<cfinvokeargument name="type" value="#attributes[idx]#">
				<cfinvokeargument name="image" value="#attributes['element_' & iRow & '_' & iCol]#">
			</cfinvoke>
			
		</cfif>
	</cfloop>

</cfif>

<cfif attributes.form_submitted2>

	<cfscript>
		// do this 2 times (1. ',,,,' = ', ,, ,' 2. ', ,, ,' = ', , , ,')
		attributes.labels_x = ReplaceNoCase(attributes.labels_x,',,',', ,','ALL');
		attributes.labels_x = ReplaceNoCase(attributes.labels_x,',,',', ,','ALL');
		// do this 2 times (1. ',,,,' = ', ,, ,' 2. ', ,, ,' = ', , , ,')
		attributes.labels_y = ReplaceNoCase(attributes.labels_y,',,',', ,','ALL');
		attributes.labels_y = ReplaceNoCase(attributes.labels_y,',,',', ,','ALL');
	</cfscript>
		
	<cfinvoke component="seatplan" method="setRoom" returnvariable="RoomID">
		<cfinvokeargument name="id" value="#attributes.roomid#">
		<cfinvokeargument name="name" value="#attributes.name#">
		<cfinvokeargument name="labels_x" value="#attributes.labels_x#">
		<cfinvokeargument name="labels_y" value="#attributes.labels_y#">
	</cfinvoke>

</cfif>

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
			aSeats[col][row].image = image;
			aSeats[col][row].type = type;
		</cfscript>
	</cfloop>

</cfif>

<cfsetting enablecfoutputonly="No">