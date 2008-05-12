<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_login.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfset sImage = application.lanshock.oHelper.UserShowAvatar(attributes.userid)>

<cfoutput>
	<h3>#request.content.login#</h3>
	
	<cfif stModuleConfig.registration_active>
		<p>
			#request.content.login_notice# <a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.register')#">#request.content.register#</a>.<br>
			<noscript><span class="text_important">#request.content.jscript#</span></noscript>
		</p>
	</cfif>
	
	<cfif ArrayLen(aError)>
		<div class="errorBox">
			<h3>#request.content.error#</h3>
			<ul>
				<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
				<li>#aError[idxError]#</li>
				</cfloop>
			</ul>
		</div>
	</cfif>

	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" class="uniForm" method="post">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
		<input type="hidden" name="loginmode" value="password"/>
		<input type="hidden" name="relocationurl" value="#attributes.relocationurl#"/>
	</div>
							
	<fieldset class="inlineLabels">
		<legend>#request.content.login#</legend>

		<cfif len(sImage)>
			<div class="ctrlHolder">
				<label for=""></label>
				#sImage#
			</div>
			<div class="ctrlHolder">
				<label for="">#request.content.name#</label>
				#application.lanshock.oHelper.GetUsernameByID(attributes.userid)#
			</div>
		</cfif>

		<div class="ctrlHolder">
			<label for="email"><em>*</em> #request.content.email#</label>
			<input type="text" class="textInput" name="email" id="email" maxlenght="255" value="#HTMLEditFormat(attributes.email)#"/>
		</div>

		<div class="ctrlHolder">
			<label for="password"><em>*</em> #request.content.login_password#</label>
			<input type="password" class="textInput" name="password" id="password" maxlenght="255"/>
		</div>

		<div class="ctrlHolder">
			<div>
				<label for="cookie" class="inlineLabel"><input type="checkbox" name="bSaveCookie" id="cookie" value="true"<cfif len(sImage)> checked="checked"</cfif>/> #request.content.cookie#</label>
			</div>
		</div>

		<div class="ctrlHolder">
			<ul>
				<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.reset_password')#">#request.content.forgot_password#</a></li>
				<cfif len(sImage)>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&changeuser=true')#">#request.content.changeuser#</a></li>
				</cfif>
			</ul>
		</div>

		</fieldset>
		<div class="buttonHolder">
			<button type="submit" class="submitButton"<cfif session.isBot> disabled="disabled"</cfif>>#request.content.login#</button>
		</div>
	</form>

	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" class="uniForm" method="post">
		<div class="hidden">
			<input type="hidden" name="form_submitted" value="true"/>
			<input type="hidden" name="loginmode" value="openid"/>
			<input type="hidden" name="relocationurl" value="#attributes.relocationurl#"/>
		</div>
								
		<fieldset class="inlineLabels">
			<legend>OpenID</legend>
	
			<div class="ctrlHolder">
				<label for="openid_url"><em>*</em> OpenID</label>
				<input type="text" class="textInput" name="openid_url" id="openid_url" maxlenght="255" style="padding-left: 20px; background: url(#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/icons/openid.gif) no-repeat;"/>
			</div>
	
			<div class="ctrlHolder">
				<ul>
					<li><a href="http://openid.net/what/" target="_blank">What is OpenID?</a></li>
				</ul>
			</div>

		</fieldset>
		<div class="buttonHolder">
			<button type="submit" class="submitButton"<cfif session.isBot> disabled="disabled"</cfif>>#request.content.login# with OpenID</button>
		</div>
	</form>

	<cfset sFocusField = 'email'>
	<cfif attributes.loginmode EQ "password" AND len(attributes.email)>
		<cfset sFocusField = 'password'>
	<cfelseif attributes.loginmode EQ "openid">
		<cfset sFocusField = 'openid_url'>
	</cfif>

	<script type="text/javascript">
	<!--
		$('###sFocusField#').focus();
	//-->
	</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">