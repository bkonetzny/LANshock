<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "date|DESC">

<cfinvoke component="#application.lanshock.oFactory.load('news_entry','reactorGateway')#" method="getRecords" returnvariable="qNews">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfset iMonth = ''>
<cfset iYear = ''>

<cfsetting enablecfoutputonly="No">