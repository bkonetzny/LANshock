<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput query="qTicketdetails">
<div class="headline">#request.content.ticketdetails#</div>
<br><br>
<div align="center"><a href="#myself##myfusebox.thiscircuit#.ticketlist&#request.session.UrlToken#"class="link_extended">#request.content.toticketlist#</a></div>
<br><br>
<table cellpadding="5">
	<tr>
		<td>#request.content.title#</td>
		<td>#title#</td>
	</tr>
	<tr>
		<td>#request.content.ticketid#</td>
		<td>#id#</td>
	</tr>
	<tr>
		<td>#request.content.status#</td>
		<td><img src="#stImageDir.general#/status_led_<cfif status EQ 0>red<cfelseif status EQ 1>green<cfelseif status EQ 2>orange</cfif>.gif" alt="<cfif status EQ 0>#request.content.status0#<cfelseif status EQ 1>#request.content.status1#<cfelseif status EQ 2>#request.content.status2#</cfif>"> <cfif status EQ 0>#request.content.status0#<cfelseif status EQ 1>#request.content.status1#<cfelseif status EQ 2>#request.content.status2#</cfif></td>
	</tr>
	<tr>
		<td>#request.content.creator#</td>
		<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user#&#request.session.UrlToken#">#getUsernameById(user)#</a></td>
	</tr>
	<tr>
		<td>#request.content.dtcreated#</td>
		<td>#UDF_DateTimeFormat(dtcreated)#</td>
	</tr>
	<cfif status NEQ 0>
		<tr>
			<td>#request.content.editor#</td>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#editor#&#request.session.UrlToken#">#getUsernameById(editor)#</a></td>
		</tr>
	</cfif>
	<cfif status EQ 1>
		<tr>
			<td>#request.content.dtfinished#</td>
			<td>#UDF_DateTimeFormat(dtfinished)#</td>
		</tr>
	</cfif>
</table>
<cfif request.session.isAdmin>
	<table align="right">
		<tr>
			<cfif status EQ 0>
				<form action="#myself##myfusebox.thiscircuit#.acceptticket&id=#id#&#request.session.UrlToken#" method="post">
				<td><input type="submit" value="#request.content.acceptticket#"></td>
				</form>
			</cfif>
			<cfif status EQ 2 AND len(answer) AND editor EQ request.session.userid>
				<form action="#myself##myfusebox.thiscircuit#.finishticket&id=#id#&#request.session.UrlToken#" method="post">
				<td><input type="submit" value="#request.content.finishticket#"></td>
				</form>
			</cfif>
			<cfif NOT status EQ 2 OR editor EQ request.session.userid>
				<form action="#myself##myfusebox.thiscircuit#.delete&id=#id#&#request.session.UrlToken#" method="post">
				<td><input type="submit" value="#request.content.deleteticket#"></td>
				</form>
			</cfif>
		</tr>
	</table>
	<br><br>
</cfif>
<table width="90%" align="center" cellpadding="5">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<th>#request.content.problem#</th>
	</tr>
	<tr>
		<td class="alternate">#ConvertText(problem)#</td>
	</tr>
	<cfif len(answer)>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>#request.content.answer#</th>
		</tr>
		<tr>
			<td class="alternate">#ConvertText(answer)#</td>
		</tr>
	</cfif>
</table>

<cfif request.session.isAdmin AND status EQ 2 AND editor EQ request.session.userid>
	<br><br>
	<form action="#myself##myfusebox.thiscircuit#.saveanswer&#request.session.UrlToken#" method="post">
	<input type="hidden" name="id" value="#id#">
	<table align="center" width="90%">
		<tr>
			<td colspan="2">#request.content.title#<br>
				<input name="title" type="text" style="width: 90%;" value="#HTMLEditFormat(title)#" maxlength="255"></td>
		</tr>
		<tr>
			<td colspan="2">#request.content.problem#<br>
				<textarea name="problem" style="width: 90%; height: 100px;">#HTMLEditFormat(problem)#</textarea></td>
		</tr>
		<tr>
			<td colspan="2">#request.content.answer#<br>
				<textarea name="answer" style="width: 90%; height: 150px;">#HTMLEditFormat(answer)#</textarea></td>
		</tr>
		<tr>
			<td>#request.content.editor#</td>
			<td><select name="editor">
					<cfset iEditor = editor>
					<cfloop query="qAdmins">
						<option value="#id#"<cfif iEditor EQ id> selected</cfif>>#name#</option>
					</cfloop>
				</select></td>
		</tr>
		<tr>
			<td>#request.content.admin_only#</td>
			<td><input type="radio" name="badmin" value="true"<cfif badmin> checked</cfif>> #request.content.admin_only_yes# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="badmin" value="false"<cfif NOT badmin> checked</cfif>> #request.content.admin_only_no#</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="#request.content.form_save#"></td>
		</tr>
	</table>
	</form>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">