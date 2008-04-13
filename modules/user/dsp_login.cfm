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
			#request.content.error#
			<ul>
				<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
				<li>#aError[idxError]#</li>
				</cfloop>
			</ul>
		</div>
	</cfif>

	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
	<input type="hidden" name="form_submitted" value="true"/>
	<input type="hidden" name="loginmode" value="password"/>
	<input type="hidden" name="relocationurl" value="#attributes.relocationurl#"/>
	
	<div class="form">
		<cfif len(sImage)>
			<div class="formrow">
				<div class="formrow_input formrow_nolabel">
					#sImage#
				</div>
			</div>
			<div class="formrow">
				<div class="formrow_label">
					#request.content.name#
				</div>
				<div class="formrow_input">
					#application.lanshock.oHelper.GetUsernameByID(attributes.userid)#
				</div>
			</div>
		</cfif>
		<div class="formrow">
			<div class="formrow_label">
				<label for="email">#request.content.email#</label>
				<cfif NOT len(sImage)>
					<span class="required">*</span>
				</cfif>
			</div>
			<div class="formrow_input">
				<cfif len(sImage)>
					#attributes.email#
				<cfelse>
					<input type="text" name="email" id="email" maxlenght="255" value="#HTMLEditFormat(attributes.email)#"/>
				</cfif>
			</div>
		</div>
		<div class="formrow">
			<div class="formrow_label">
				<label for="password">#request.content.login_password#</label>
				<span class="required">*</span>
			</div>
			<div class="formrow_input">
				<input type="password" name="password" id="password" maxlenght="255"/>
			</div>
		</div>
		<div class="formrow">
			<div class="formrow_input formrow_nolabel">
				<fieldset>
					<input type="checkbox" name="bSaveCookie" id="cookie" value="true"<cfif len(sImage)> checked="checked"</cfif>/>
					<label for="cookie">#request.content.cookie#</label>
				</fieldset>
			</div>
		</div>
		<div class="formrow">
			<div class="formrow_buttonbar">
				<input type="submit" value="#request.content.login#"/>
				<ul>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.reset_password')#">#request.content.forgot_password#</a></li>
					<cfif len(sImage)>
						<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&changeuser=true')#">#request.content.changeuser#</a></li>
					</cfif>
				</ul>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
	</form>

	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
	<input type="hidden" name="form_submitted" value="true"/>
	<input type="hidden" name="loginmode" value="openid"/>
	<input type="hidden" name="relocationurl" value="#attributes.relocationurl#"/>
	
	<div class="form">
		<div class="formrow">
			<div class="formrow_label">
				<label for="password">OpenID</label>
				<span class="required">*</span>
			</div>
			<div class="formrow_input">
				<input type="text" name="openid_url" id="openid_url" maxlenght="255" style="padding-left: 20px; background: url(#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/icons/openid.gif) no-repeat;"/>
			</div>
		</div>
		<div class="formrow">
			<div class="formrow_buttonbar">
				<input type="submit" value="#request.content.login# with OpenID"/>
				<ul>
					<li><a href="http://openid.net/what/" target="_blank">What is OpenID?</a></li>
				</ul>
			</div>
		</div>
		<div class="clearer"></div>
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