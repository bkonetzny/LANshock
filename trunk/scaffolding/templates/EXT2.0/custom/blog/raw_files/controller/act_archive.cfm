<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/act_archive.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "date|DESC">

<cfinvoke component="#application.lanshock.oFactory.load('news_entry','reactorGateway')#" method="getRecords" returnvariable="qNews">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfset iMonth = ''>
<cfset iYear = ''>

<cfsetting enablecfoutputonly="No">