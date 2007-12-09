<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/dsp_categories.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfoutput>
<h3>#request.content.headline_categories#</h3>

<ul>
<cfloop list="#ArrayToList(StructSort(stCategories,'textnocase','asc','name'))#" index="idx">
	<li><a href="#myself##myfusebox.thiscircuit#.main&amp;category_id=#idx#&amp;#request.session.UrlToken#">#stCategories[idx].name# (#stCategories[idx].entrys#)</a></li>
</cfloop>
</ul>
</cfoutput>

<cfsetting enablecfoutputonly="No">