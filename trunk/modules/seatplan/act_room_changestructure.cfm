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

<cfif len(attributes.roomid)>

	<cfswitch expression="#attributes.subaction#">
	
		<cfcase value="addCol">
		
			<cfif isNumeric(attributes.number)>
			
				<cfscript>
					args = StructNew();
					args.roomid = attributes.roomid;
					args.start = attributes.start;
					args.number = attributes.number;
				</cfscript>
				
				<cfinvoke component="seatplan" method="addCol" argumentcollection="#args#">
			
			</cfif>	
		
		</cfcase>
	
		<cfcase value="addRow">
		
			<cfif isNumeric(attributes.number)>
			
				<cfscript>
					args = StructNew();
					args.roomid = attributes.roomid;
					args.start = attributes.start;
					args.number = attributes.number;
				</cfscript>
				
				<cfinvoke component="seatplan" method="addRow" argumentcollection="#args#">
			
			</cfif>	
		
		</cfcase>
	
		<cfcase value="deleteCol">
		
			<cfif len(attributes.colIDX)>
			
				<cfscript>
					args = StructNew();
					args.roomid = attributes.roomid;
					args.cols = attributes.colIDX;
				</cfscript>
				
				<cfinvoke component="seatplan" method="deleteCol" argumentcollection="#args#">
			
			</cfif>	
		
		</cfcase>
	
		<cfcase value="deleteRow">
		
			<cfif len(attributes.rowIDX)>
			
				<cfscript>
					args = StructNew();
					args.roomid = attributes.roomid;
					args.rows = attributes.rowIDX;
				</cfscript>
				
				<cfinvoke component="seatplan" method="deleteRow" argumentcollection="#args#">
			
			</cfif>	
		
		</cfcase>
	
	</cfswitch>

</cfif>

<cflocation url="#self#?fuseaction=#UDF_Module()#.room_structure_edit&roomid=#attributes.roomid#&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">