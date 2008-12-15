<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "name|ASC">

<cfinvoke component="#application.lanshock.oFactory.load('news_category','reactorGateway')#" method="getRecords" returnvariable="qCategories">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfoutput>
<h3>#request.content.headline_categories#</h3>

<ul>
<cfloop query="qCategories">
	<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&category_id=#qCategories.id#')#">#qCategories.name#</a></li>
</cfloop>
</ul>
</cfoutput>

<cfsetting enablecfoutputonly="false">