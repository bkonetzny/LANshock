<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/blog/raw_files/view/custom/dsp_categories.cfm $
$LastChangedDate: 2008-05-12 14:45:39 +0200 (Mo, 12 Mai 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 295 $
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

<cfsetting enablecfoutputonly="No">