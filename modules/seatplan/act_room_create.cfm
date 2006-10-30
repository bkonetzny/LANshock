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

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT len(attributes.name)) ArrayAppend(aError, "NO VALID NAME GIVEN");
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
		
		<cfinvoke component="seatplan" method="setRoom" returnvariable="RoomID">
			<cfinvokeargument name="name" value="#attributes.name#">
			<cfinvokeargument name="labels_x" value="A,B,C,D,E,F,G,H,I,J">
			<cfinvokeargument name="labels_y" value="1,2,3,4,5,6,7,8,9,10">
		</cfinvoke>
			
		<cfscript>
			args = StructNew();
			args.roomid = RoomID;
			args.start = 0;
			args.number = 10;
		</cfscript>
		
		<cfinvoke component="seatplan" method="addCol" argumentcollection="#args#">
			
		<cfscript>
			args = StructNew();
			args.roomid = RoomID;
			args.start = 0;
			args.number = 10;
		</cfscript>
		
		<cfinvoke component="seatplan" method="addRow" argumentcollection="#args#">
		
		<cflocation url="#myself##myfusebox.thiscircuit#.room_structure_edit&roomid=#RoomID#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">