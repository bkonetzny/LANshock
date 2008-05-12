<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/blog/raw_files/controller/act_archive.cfm $
$LastChangedDate: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 205 $
--->

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "date|DESC">

<cfinvoke component="#application.lanshock.oFactory.load('news_entry','reactorGateway')#" method="getRecords" returnvariable="qNews">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfset iMonth = ''>
<cfset iYear = ''>

<cfsetting enablecfoutputonly="No">