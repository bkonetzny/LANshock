<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_profile_edit_logindata.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<h3>#request.content.headline_userdata#</h3>

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
	</div>
	
	<fieldset class="inlineLabels">
		<legend>#request.content.headline_userdata#</legend>
		
		<cfif NOT stModuleConfig.userprofile.edit_nickname>
			<div class="ctrlHolder">
				<label></label>
				<img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_nickname_admin_edit_hint#
			</div>
		</cfif>

		<div class="ctrlHolder">
			<label for="profile_name"><em>*</em> #request.content.name#</label>
			<input type="text" class="textInput" name="name" id="profile_name" value="#attributes.name#"<cfif NOT session.isAdmin AND NOT stModuleConfig.userprofile.edit_nickname> disabled="disabled"</cfif>/><cfif NOT stModuleConfig.userprofile.edit_nickname> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
		
		<div class="ctrlHolder">
			<label for="profile_email"><em>*</em> #request.content.email#</label>
			<input type="text" class="textInput" name="email" id="profile_email" value="#attributes.email#"/>
		</div>

	</fieldset>
	
	<fieldset class="inlineLabels">
		<legend>#request.content.security#</legend>
		
		<div class="ctrlHolder">
			<label for="profile_password1"><em>*</em> #request.content.password#</label>
			<input type="password" class="textInput" name="pass1" id="profile_password1"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="profile_password2"><em>*</em> #request.content.password_repeat#</label>
			<input type="password" class="textInput" name="pass2" id="profile_password2"/>
		</div>

	</fieldset>
	<div class="buttonHolder">
		<button type="submit" class="submitButton">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">