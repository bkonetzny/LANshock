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
	<div class="headline">#request.content.roomlist#</div>

	<a href="#myself##myfusebox.thiscircuit#.room_create&#request.session.UrlToken#"class="link_extended">#request.content.new_room#</a><br>

	<table class="list">
		<tr>
			<th>#request.content.name#</th>
			<th>#request.content.elements#</th>
			<th>#request.content.structure#</th>
			<th class="empty">&nbsp;</th>
		</tr>
		<cfloop query="qRooms">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.room_structure_edit&roomid=#id#&#request.session.UrlToken#">#name#</a></td>
				<td align="center">#cols*rows#</td>
				<td align="center">#cols# * #rows#</td>
				<td class="empty"><a href="#myself##myfusebox.thiscircuit#.room_delete&roomid=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></a></td>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">