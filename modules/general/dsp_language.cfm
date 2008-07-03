<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<cfset iListLen = ceiling(ListLen(StructKeyList(stLocales)) / 2)>
<cfset lTheList = ListSort(StructKeyList(stLocales),'textnocase')>

<cfoutput>
<h3>#request.content.language_headline#</h3>

<p>#request.content.language_txt#</p>

<table>
	<cfloop from="1" to="#iListLen#" index="idx">
		<tr>
			<cfset sListItem = ListGetAt(lTheList,idx)>
			<td align="center"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/#LCase(ListLast(sListItem,'_'))#.png" alt="#sListItem#"></td>
			<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.session_language&language=#sListItem#')#"><cfif session.lang EQ sListItem><strong>#stLocales[sListItem]#</strong><cfelse>#stLocales[sListItem]#</cfif></a></td>
			<td align="right"><span class="text_light">( #sListItem# )</span></td>
			<td>&nbsp;&nbsp;&nbsp;</td>
			<cftry>
			<cfset sListItem = ListGetAt(lTheList,idx+iListLen)>
			<td align="center"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/#LCase(ListLast(sListItem,'_'))#.png" alt="#sListItem#"></td>
			<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.session_language&language=#sListItem#')#"><cfif session.lang EQ sListItem><strong>#stLocales[sListItem]#</strong><cfelse>#stLocales[sListItem]#</cfif></a></td>
			<td align="right"><span class="text_light">( #sListItem# )</span></td>
			<cfcatch><td colspan="2">&nbsp;</td></cfcatch>
			</cftry>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">