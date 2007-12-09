<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/dsp_archive.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfoutput>
<h3>#request.content.archive_headline#</h3>
	<cfloop query="qNews">
		<cfif iYear NEQ year(date) OR iMonth NEQ month(date)>
			<cfscript>
				iMonth = month(date);
				iYear = year(date);
				dtCurrentDate = LsParseDateTime('#iYear#-#iMonth#-01 00:00:00');
			</cfscript>
			<cfif qNews.currentrow NEQ 1></table></cfif>
			<h4>#LsDateFormat(dtCurrentDate,'YYYY MMMM')#</h4>
			<table>
		</cfif>
				<tr>
					<td>#UDF_DateTimeFormat(date)#</td>
					<td><a href="#myself##myfusebox.thiscircuit#.news_details&news_id=#id#&#request.session.UrlToken#">#title#</a></td>
				</tr>
	</cfloop></table>
</cfoutput>

<cfsetting enablecfoutputonly="No">