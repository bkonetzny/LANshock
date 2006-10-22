<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->
 
<cfparam name="attributes.list_order" default="name">
<cfparam name="attributes.list_order_type" default="asc">
<cfparam name="attributes.startkey" default="?">
<cfparam name="attributes.search" default="">
<cfparam name="attributes.search_in" default="id,name,firstname,lastname,email">
<cfparam name="attributes.filter" default="">

<cfinvoke component="user" method="getUsers" returnvariable="qUsers">
	<cfinvokeargument name="search" value="#attributes.search#">
	<cfinvokeargument name="search_in" value="#attributes.search_in#">
	<cfinvokeargument name="list_order" value="#attributes.list_order#">
	<cfinvokeargument name="list_order_type" value="#attributes.list_order_type#">
	<cfinvokeargument name="startkey" value="#attributes.startkey#">
	<cfinvokeargument name="filter" value="#attributes.filter#">
</cfinvoke>

<cfset iUserCountSearch = qUsers.recordcount>

<cfinvoke component="user" method="getUserCount" returnvariable="iUserCountGlobal">
</cfinvoke>

<cfif len(attributes.search)>
	<cfset attributes.startkey = ''>
</cfif>

<cfsetting enablecfoutputonly="No">