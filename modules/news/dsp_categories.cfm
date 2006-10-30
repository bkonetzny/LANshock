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
<div class="headline">#request.content.headline_categories#</div>

<cfloop list="#ArrayToList(StructSort(stCategories,'textnocase','asc','name'))#" index="idx">
	<a href="#myself##myfusebox.thiscircuit#.main&category_id=#idx#&#request.session.UrlToken#">#stCategories[idx].name# (#stCategories[idx].entrys#)</a><br>
</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="No">