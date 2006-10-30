<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.list_order" default="nick">
<cfparam name="attributes.list_order_type" default="asc">
<cfparam name="attributes.search" default="">
<cfparam name="attributes.startrow" default="1">
<cfparam name="attributes.all" default="false" type="boolean">

<cfscript>
	args1 = StructNew();
	args1.search = attributes.search;
	if(attributes.startrow EQ "ALL"){
		attributes.startrow = 1;
		attributes.all = true;
	}
	args1.startrow = attributes.startrow-1;
	args1.order_type = attributes.list_order_type;
	args1.order_by = attributes.list_order;
	args1.all = attributes.all;
</cfscript>
<cfinvoke component="guests" method="getGuestList" returnvariable="qGuests" argumentcollection="#args1#">

<cfscript>
	pages = int(qGuests.recordcount/50);
	attributes.search = HTMLEditFormat(attributes.search);
</cfscript>

<cfsetting enablecfoutputonly="No">