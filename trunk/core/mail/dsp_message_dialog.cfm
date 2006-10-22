<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfhtmlhead text='<title>#request.content.newmsg#</title>'>

<cfif qMessages.recordcount>
	<cfoutput>
		<div class="headline">#request.content.inbox#</div>
		
		<table width="100%" cellpadding="5">
		<cfloop query="qMessages">
			<cfif NOT len(title)>
				<cfset tmp_topic = "<em>#request.content.notopic#</em>">
			<cfelse>
				<cfset tmp_topic = title>
			</cfif>
			<tr>
				<td class="alternate">#tmp_topic#</td>
				<td class="alternate" align="right">#UDF_DateTimeFormat(datetime)#</td>
			</tr>
			<tr>
				<td colspan="2">#ConvertText(text)#</td>
			</tr>
		</cfloop>
		</table>
		
		<div class="headline">#request.content.newmsg#</div>
	</cfoutput>
</cfif>

<cfoutput>
	<form action="#myself##myfusebox.thiscircuit#.message_dialog&#request.session.UrlToken#" name="newmsg" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<input type="hidden" name="user_id" value="#attributes.user_id#">
		&nbsp;
		<table style="width: 95%; height: 90%;" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td>#request.content.to#<br>
					<strong>#GetUsernameByID(attributes.user_id)#</strong></td>
				<td align="center" valign="top" rowspan="2"><span style="width: 80px; height: 80px; border: 1px dotted black;">#UserShowAvatar(attributes.user_id)#</span></td>
			</tr>
			<tr>
				<td width="90%">#request.content.topic#<br>
					<input type="text" name="title" maxlength="255" style="width: 90%;" value="#attributes.title#"></td>
			</tr>
			<tr>
				<td colspan="2" height="90%">#request.content.text#<br>
					<textarea name="text" style="text" style="width: 100%; height: 90%">#attributes.text#</textarea>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="#request.content.send#"></td>
				<td><input type="button" value="#request.content.form_cancel#" onclick="javascript:window.close();"></td>
			</tr>
		</table>
	</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">