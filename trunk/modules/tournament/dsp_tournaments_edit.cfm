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
<div class="headline">#request.content.tournamentoverview#</div>

<div class="headline2">#request.content.new_tournament#</div>

<table align="center">
	<form action="#myself##myfusebox.thiscircuit#.tournaments_edit_exportsettings&#request.session.UrlToken#" method="post">
	<tr>
		<td valign="top">#request.content.tournament_type#<br>
			<select name="type" size="4" style="width: 200px;">
				<option value="se" selected>#request.content.tournament_type_se#</option>
				<option value="de">#request.content.tournament_type_de#</option>
				<option value="group">#request.content.tournament_type_group#</option>
				<option value="customranking">Custom Ranking</option>
				<!--- <option value="league">#request.content.tournament_type_league#</option>
				<option value="schweizer">#request.content.tournament_type_schweizer#</option> --->
			</select></td>
	</tr>
	<tr>
		<td align="center"><input type="Submit" value=" #request.content.tournament_edit_nextbutton# "></td>
	</tr>
	</form>
</table>

<div class="headline2">#request.content.avaible_tournaments#</div>
<table class="list">
<cfloop query="qGroups">
	<tr>
		<td class="empty" colspan="6"><div class="headline2">#name#</div><br>
			<cfif len(description)>#HTMLEditFormat(description)#<br>&nbsp;</cfif>	
			<br>&nbsp;#request.content.group_signups_maxsignups# <cfif maxsignups EQ 0>#request.content.group_maxsignups_nolimit#<cfelse>#maxsignups#</cfif></td>
	</tr>
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.tournament_name#</th>
		<th>#request.content.tournament_maxteams#</th>
		<th>#request.content.tournament_teamsize#</th>
		<th>#request.content.tournament_type#</th>
		<th>#request.content.tournament_status#</th>
		<th>#request.content.tournament_export_league#</th>
		<th>#request.content.tournament_req_coins#</th>
		<th class="empty">&nbsp;</th>
	</tr>
	<cfset iCurrentGroup = id>
	<cfloop query="qTournaments">
		<cfif groupid EQ iCurrentGroup>
			<tr>
				<td class="empty"><cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#" width="16" height="16"><cfelse><img src="#stImageDir.general#/spacer.gif" width="16" height="16"></cfif></td>
				<td><a href="#myself##myfusebox.thiscircuit#.tournaments_edit_settings&id=#id#&#request.session.urltoken#">#name#</a></td>
				<td align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#"><strong>#currentteams#</strong> / #maxteams#</a></td>
				<td align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#teamsize# #request.content.players#<cfif teamsubstitute GT 0> (+ #teamsubstitute#)</cfif></a></td>
				<td><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_type_' & type]#</a></td>
				<td align="center"><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_status_' & status]#</a></td>
				<td>#request.content['tournament_export_league_' & export_league]#</td>
				<td align="center">#coins#</td>
				<td class="empty"><a href="#myself##myfusebox.thiscircuit#.tournaments_delete&tournamentid=#id#&#request.session.UrlToken#" title="#request.content.form_delete#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></a></td>
			</tr>
		</cfif>
	</cfloop>
</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">