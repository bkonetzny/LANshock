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
	<h3>#qBoard.title#</h3>
	
	<h4>#request.content.new_topic#</h4>

	#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">