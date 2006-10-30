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
<table width="100%">
	<tr>
		<td><strong>#request.content.mytickets# (#qMyTickets.recordcount#)</strong></td>
	</tr>
	<cfloop query="qMyTickets">
		<tr>
			<td>&middot; <a href="#myself##myfusebox.thiscircuit#.details&id=#id#&#request.session.UrlToken#">[#id#] #left(title,15)#<cfif len(title) GT 15>...</cfif></a></td>
		</tr>
	</cfloop>
	<tr>
		<td><strong>#request.content.opentickets# (#qOpenTickets.recordcount#)</strong></td>
	</tr>
	<cfloop query="qOpenTickets">
		<tr>
			<td>&middot; <a href="#myself##myfusebox.thiscircuit#.details&id=#id#&#request.session.urltoken#">[#id#] #left(title,15)#<cfif len(title) GT 15>...</cfif></a></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">