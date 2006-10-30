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
<div class="headline">#request.content.ticketlist#</div>
<br><br>
<span style="text-align: justify;">#request.content.ticketsystem_description#</span>
<br><br>
<cfif request.session.userloggedin>
	<a href="#myself##myfusebox.thiscircuit#.create&#request.session.UrlToken#"class="link_extended">#request.content.newticket#</a>
	<br><br>
</cfif>
<table class="list">
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.ticketid#</th>
		<th width="50%">#request.content.title#</th>
		<th>#request.content.creator#</th>
		<th>#request.content.dtcreated#</th>
		<th>#request.content.editor#</th>
	</tr>
	<cfloop query="qTicketlist">
		<cfif NOT badmin OR (badmin AND request.session.isAdmin)>
			<tr>
				<td class="empty"><img src="#stImageDir.general#/status_led_<cfif status EQ 0>red<cfelseif status EQ 1>green<cfelseif status EQ 2>orange</cfif>.gif" alt="<cfif status EQ 0>#request.content.status0#<cfelseif status EQ 1>#request.content.status1#<cfelseif status EQ 2>#request.content.status2#</cfif>"></td>
				<td align="right"><strong>#id#</strong></td>
				<td><a href="#myself##myfusebox.thiscircuit#.details&id=#id#&#request.session.UrlToken#">#title#</a></td>
				<td nowrap><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user#&#request.session.UrlToken#">#getUsernameById(user)#</a></td>
				<td nowrap>#UDF_DateTimeFormat(dtcreated)#</td>
				<td nowrap><cfif len(editor)><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#editor#&#request.session.UrlToken#">#getUsernameById(editor)#</a></cfif></td>	
			</tr>
		</cfif>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">