<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/blog/raw_files/view/dsp_archive.cfm $
$LastChangedDate: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 205 $
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
					<td>#session.oUser.DateTimeFormat(date)#</td>
					<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#id#')#">#title#</a></td>
				</tr>
	</cfloop></table>
</cfoutput>

<cfsetting enablecfoutputonly="No">