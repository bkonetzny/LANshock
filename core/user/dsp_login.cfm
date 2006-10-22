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
	<div class="headline">#request.content.login#</div>
	
	<cfif stModuleConfig.registration_active>
		<div align="center">
			#request.content.login_notice# <a href="#myself##myfusebox.thiscircuit#.register&#request.session.UrlToken#">#request.content.register#</a>.<br>
			<noscript><span class="text_important">#request.content.jscript#</span></noscript>
		</div>
	</cfif>
	
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

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post" name="login">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="relocationurl" value="#attributes.relocationurl#">
	<table class="vlist">
		<cfset sImage = UserShowAvatar(attributes.userid)>
		<cfif len(sImage)>
			<tr>
				<td rowspan="5" valign="top">#sImage#</td>
				<th>#request.content.name#</em></th>
				<td><strong>#GetUsernameByID(attributes.userid)#</strong></td>
			</tr>
		</cfif>
		<tr>
			<th>#request.content.email#</th>
			<td><cfif len(sImage)>
					<strong>#attributes.email#</strong>
				<cfelse>
					<input type="Text" name="email" size="40" value="#HTMLEditFormat(attributes.email)#">
				</cfif></td>
		</tr>
		<tr>
			<th>#request.content.login_password#</th>
			<td><input type="Password" name="password" size="28">&nbsp;&nbsp;<input type="Submit" value="#request.content.login#"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="Checkbox" id="cookie" name="cookie" value="1"> <label for="cookie">#request.content.cookie#</label></td>
		</tr>
		<tr>
			<td colspan="2">
				<cfif len(sImage)>
					&nbsp;<br><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&changeuser=true&#request.session.urltoken#">#request.content.changeuser#</a>
				</cfif>
				&nbsp;<br><a href="#myself##myfusebox.thiscircuit#.reset_password&#request.session.urltoken#">#request.content.forgot_password#</a></td>
		</tr>
	</table>
	</form>

	<script language="javascript">
	<!--
		<cfif len(attributes.email)>
			document.login.password.focus();
		<cfelse>
			document.login.email.focus();
		</cfif>
	//-->
	</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">