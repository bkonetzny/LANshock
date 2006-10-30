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

<cfif isNumeric(attributes.roomid)>
			
	<cfscript>
		args = StructNew();
		args.roomid = attributes.roomid;
	</cfscript>
	
	<cfinvoke component="seatplan" method="deleteRoom" argumentcollection="#args#">
			
</cfif>

<cflocation url="#self#?fuseaction=#UDF_Module()#.roomlist&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">