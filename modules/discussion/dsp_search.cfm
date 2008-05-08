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
	<h3>#request.content.search_headline#</h3>

	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<input type="text" name="search" value="#attributes.search#">
		<input type="submit" value="#request.content.form_search#">
	</form>
	
	<cfif attributes.form_submitted AND len(attributes.search)>
		<table class="list">
			<tr>
				<th>#request.content.topic#</th>
				<th>#request.content.post_count#</th>
				<th>#request.content.last_post#</th>
			</tr>
			<cfloop query="qTopics">
				<tr>
					<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.topic&id=#qTopics.id#')#">#qTopics.title#</a></td>
					<td align="center">#qTopics.postcount#</td>
					<td><cfif len(qTopics.dt_lastpost)>
							#session.oUser.DateTimeFormat(qTopics.dt_lastpost)#
						<cfelse>
							#session.oUser.DateTimeFormat(qTopics.dt_created)#
						</cfif></td>
				</tr>
			</cfloop>
		</table>
	</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">