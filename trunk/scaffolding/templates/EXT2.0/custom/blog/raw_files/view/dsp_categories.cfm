<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
<h3>#request.content.headline_categories#</h3>

<ul>
<cfloop list="#ArrayToList(StructSort(stCategories,'textnocase','asc','name'))#" index="idx">
	<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&category_id=#idx#')#">#stCategories[idx].name# (#stCategories[idx].entrys#)</a></li>
</cfloop>
</ul>
</cfoutput>

<cfsetting enablecfoutputonly="No">