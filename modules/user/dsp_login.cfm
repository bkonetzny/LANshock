<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_login.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfset sImage = UserShowAvatar(attributes.userid)>

<cfoutput>
	<h3>#request.content.login#</h3>
	
	<cfif stModuleConfig.registration_active>
		<p>
			#request.content.login_notice# <a href="#myself##myfusebox.thiscircuit#.register&#request.session.UrlToken#">#request.content.register#</a>.<br>
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

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true"/>
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
					#GetUsernameByID(attributes.userid)#
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
					<input type="checkbox" name="cookie" id="cookie" value="true"<cfif len(sImage)> checked="checked"</cfif>/>
					<label for="cookie">#request.content.cookie#</label>
				</fieldset>
			</div>
		</div>
		<div class="formrow">
			<div class="formrow_buttonbar">
				<input type="submit" value="#request.content.login#"/>
				<ul>
					<li><a href="#myself##myfusebox.thiscircuit#.reset_password&#request.session.urltoken#">#request.content.forgot_password#</a></li>
					<cfif len(sImage)>
						<li><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&changeuser=true&#request.session.urltoken#">#request.content.changeuser#</a></li>
					</cfif>
				</ul>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
	</form>

	<script type="text/javascript">
	<!--
		<cfif len(attributes.email)>
			document.getElementById('password').focus();
		<cfelse>
			document.getElementById('email').focus();
		</cfif>
	//-->
	</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">