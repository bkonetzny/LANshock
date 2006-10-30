<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.category_id" default="">
<cfparam name="attributes.user_id" default="">

<cfif NOT isNumeric(attributes.category_id)>
	<cfset attributes.category_id = ''>
</cfif>

<cfif NOT isNumeric(attributes.user_id)>
	<cfset attributes.user_id = ''>
</cfif>

<cfinvoke component="news" method="getNews" returnvariable="qNews">
	<cfif NOT len(attributes.category_id)>
		<cfinvokeargument name="records" value="10">
	</cfif>
	<cfif len(attributes.user_id)>
		<cfinvokeargument name="user_id" value="#attributes.user_id#">
	</cfif>
	<cfif len(attributes.category_id)>
		<cfinvokeargument name="category_id" value="#attributes.category_id#">
	</cfif>
</cfinvoke>

<cfsetting enablecfoutputonly="No">