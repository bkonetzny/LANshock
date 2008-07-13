<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif qContent.recordcount>
	<cfoutput>
		<h3>#qContent.title#</h3>
		#qContent.content#
	</cfoutput>
<cfelse>
	<cfoutput>
		<h3>Content</h3>
		<p>Keine Inhalte gefunden.</p>
	</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="No">