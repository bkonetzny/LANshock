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
<base target="_blank">
<table>
	<tr>
		<td><em>#qNews.recordcount# #request.content.news_headline#</em></td>
	</tr>
	<cfloop query="qNews">
		<cfif NOT isDefined('dtDate') OR DateCompare(date,dtDate) EQ -1>
			<tr>
				<td>&nbsp;<br><span class="text_small">#LSDateFormat(date)#</span></td>
			</tr>
		</cfif>
		<cfset dtDate = date>
		<tr>
			<td><span class="text_small">#LSTimeFormat(date)#</span> <a href="#myself##myfusebox.thiscircuit#.news_comments&news_id=#id#&#request.session.urltoken#">#title#</a></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">