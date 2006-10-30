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
	<div class="headline">#request.content.search_headline#</div>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
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
					<td><a href="#myself##myfusebox.thiscircuit#.topic&id=#id#&#request.session.urltoken#">#title#</a></td>
					<td align="center">#postcount#</td>
					<td><cfif len(dt_lastpost)>
							#UDF_DateTimeFormat(dt_lastpost)#
						<cfelse>
							#UDF_DateTimeFormat(dt_created)#
						</cfif></td>
				</tr>
			</cfloop>
		</table>
	</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">