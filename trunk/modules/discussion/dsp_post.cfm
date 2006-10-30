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
	<div class="headline">#qBoard.title#</div>
	
	<div class="headline2">#request.content.new_topic#</div>

	#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">