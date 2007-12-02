<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_language.cfm $
$LastChangedDate: 2007-07-08 13:01:39 +0200 (So, 08 Jul 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 96 $
--->

<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<cfscript>
	iListLen = ceiling(ListLen(StructKeyList(stLocales)) / 2);
	lTheList = ListSort(StructKeyList(stLocales),'textnocase');
</cfscript>

<cfoutput>
<h3>#request.content.language_headline#</h3>

<p>#request.content.language_txt#</p>

<table>
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