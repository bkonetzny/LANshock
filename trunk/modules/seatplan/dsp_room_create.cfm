<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.name" default="">

<cfoutput>
	<div class="headline2">#request.content.seatplan#</div>
	<br><br>
	<a href="#myself##myfusebox.thiscircuit#.roomlist&#request.session.UrlToken#"class="link_extended">#request.content.roomlist#</a><br>
	<br>

	<cfif ArrayLen(aError)>
		<div class="errorBox">
			#request.content.error#
			<ul>
				<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
				<li>#aError[idxError]#</li>
				</cfloop>
			</ul>
		</div>
	</cfif>

	<form action="#myself##myfusebox.thiscircuit#.room_create&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<table>
		<tr>
			<td>#request.content.name#</td>
			<td><input type="text" name="name" value="#HTMLEditFormat(attributes.name)#"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="#request.content.form_save#"></td>
		</tr>
	</table>
	</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">