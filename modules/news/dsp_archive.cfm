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
<div class="headline">#request.content.archive_headline#</div>

<table class="list">
	<cfloop query="qNews">
		<cfif iYear NEQ year(date) OR iMonth NEQ month(date)>
			<cfscript>
				iMonth = month(date);
				iYear = year(date);
				dtCurrentDate = LsParseDateTime('#iYear#-#iMonth#-01 00:00:00');
			</cfscript>
			<tr>
				<th class="empty" colspan="2"><div class="headline2">#LsDateFormat(dtCurrentDate,'YYYY MMMM')#</div></th>
			</tr>
		</cfif>
		<tr>
			<td align="center"><span class="text_small">#UDF_DateTimeFormat(date)#</span></td>
			<td width="80%"><a href="#myself##myfusebox.thiscircuit#.news_details&news_id=#id#&#request.session.UrlToken#">#title#</a></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">