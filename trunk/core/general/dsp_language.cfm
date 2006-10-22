<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	iListLen = ceiling(ListLen(StructKeyList(stLocales)) / 2);
	lTheList = ListSort(StructKeyList(stLocales),'textnocase');
</cfscript>

<cfoutput>
<div class="headline">#request.content.language_headline#</div>

<div align="center">&nbsp;<br>&nbsp;<br>#request.content.language_txt#<br>&nbsp;<br>&nbsp;</div>

<table cellpadding="3" align="center">
	<cfloop from="1" to="#iListLen#" index="idx">
		<tr>
			<cfset sListItem = ListGetAt(lTheList,idx)>
			<td align="center"><img src="#UDF_Module('webPath')#flags/#LCase(ListLast(sListItem,'_'))#.gif" alt="#sListItem#"></td>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&newlang=#sListItem#&#request.session.urltoken#"><cfif request.session.lang EQ sListItem><strong>#stLocales[sListItem]#</strong><cfelse>#stLocales[sListItem]#</cfif></a></td>
			<td align="right"><span class="text_light">( #sListItem# )</span></td>
			<td>&nbsp;&nbsp;&nbsp;</td>
			<cftry>
			<cfset sListItem = ListGetAt(lTheList,idx+iListLen)>
			<td align="center"><img src="#UDF_Module('webPath')#flags/#LCase(ListLast(sListItem,'_'))#.gif" alt="#sListItem#"></td>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&newlang=#sListItem#&#request.session.urltoken#"><cfif request.session.lang EQ sListItem><strong>#stLocales[sListItem]#</strong><cfelse>#stLocales[sListItem]#</cfif></a></td>
			<td align="right"><span class="text_light">( #sListItem# )</span></td>
			<cfcatch><td colspan="2">&nbsp;</td></cfcatch>
			</cftry>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">