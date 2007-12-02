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
<script type="text/javascript">
<!--
none = new Image;
low = new Image;
medium = new Image;
high = new Image;
none.src = "#stImageDir.module#/security-none.gif";
none.name = "none";
low.src = "#stImageDir.module#/security-low.gif";
low.name = "low";
medium.src = "#stImageDir.module#/security-medium.gif";
medium.name = "medium";
high.src = "#stImageDir.module#/security-high.gif";
high.name = "high";

function SetLevel(PicName, PicObject) {
	window.document.images[PicName].src = PicObject.src;
	window.document.form.password_level.value = PicObject.name;
}

function checkInput() {
	var TestNumberOfChars = false;
	var TestUppercaseChars = false;
	var TestLowercaseChars = false;
	var TestDigits = false;
	var TestSpecialChars = false;
	var TestWhiteSpaces = false;

	checkstring = window.document.form.pass1.value;
	
	/* Check if length of password is greather then 8 */
	if(checkstring.length >= 8) { TestNumberOfChars = true;	}
	else { TestNumberOfChars = false; }
	
	/* Check for minimum of 2 uppercase Letters */
	if(checkstring.match(/[A-Z].*[A-Z]/)) {	TestUppercaseChars = true; }
	else { TestUppercaseChars = false; }
	
	/* Check for minimum of 2 lowercase letters */
	if(checkstring.match(/[a-z].*[a-z]/)) {	TestLowercaseChars = true; }
	else { TestLowercaseChars = false; }
	
	/* Check for minimum of 2 digits */
	if(checkstring.match(/[0-9].*[0-9]/)) { TestDigits = true; }
	else { TestDigits = false; }
	
	/* Check for minimum of 2 special chars */
	var specCharCounter = 0;
	if(checkstring.length > 0) {
		characters = checkstring.split("");
		for(var i = 0; i < characters.length; i++) {
			singleChar = characters[i];
			if(singleChar.match(/[^a-zA-Z0-9]/)) { specCharCounter++; }
		}
		if(specCharCounter >= 2) { TestSpecialChars = true; }
		else { TestSpecialChars = false; }
	}
	
	/* Check for minimum of 2 true ifs */
	var counter = 0;

	if(TestUppercaseChars || TestLowercaseChars){ counter++; }
	if(TestDigits)								{ counter++; }
	if(TestSpecialChars)						{ counter++; }
	if(TestNumberOfChars)						{ counter++; }

	if(counter == 0) { SetLevel('seclevel', none); }
	if(counter == 1) { SetLevel('seclevel', low); }
	if(counter == 2) { SetLevel('seclevel', low); }
	if(counter == 3) { SetLevel('seclevel', medium); }
	if(counter == 4) { SetLevel('seclevel', high); }
}
//-->
</script>

<h3>#request.content.headline_userdata#</h3>

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

<cfif isNumeric(attributes.id)>
	<a href="#myself##myfusebox.thiscircuit#.userdetails<cfif request.session.isAdmin>&id=#attributes.id#</cfif>&#request.session.UrlToken#" class="link_extended">#request.content.show_profile#</a>
</cfif>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post" name="form">
<input type="hidden" name="form_submitted" value="true">
<input type="hidden" name="id" value="#attributes.id#">
<input type="hidden" name="password_level" value="#attributes.password_level#">

<h4>#request.content.headline_userdata#</h4>

<div class="form">
	<cfif NOT stModuleConfig.userprofile.edit_nickname>
		<div class="formrow">
			<div class="formrow_input formrow_nolabel">
				<img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_nickname_admin_edit_hint#
			</div>
		</div>
	</cfif>
	<div class="formrow">
		<div class="formrow_label">
			#request.content.id#
		</div>
		<div class="formrow_input">
			#attributes.id#
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_name">#request.content.name#</label>
			<span class="required">*</span>
		</div>
		<div class="formrow_input">
			<input type="text" name="name" id="profile_name" value="#attributes.name#"<cfif NOT request.session.isAdmin AND NOT stModuleConfig.userprofile.edit_nickname> disabled="disabled"</cfif>/><cfif NOT stModuleConfig.userprofile.edit_nickname> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_email">#request.content.email#</label>
			<span class="required">*</span>
		</div>
		<div class="formrow_input">
			<input type="text" name="email" id="profile_email" value="#attributes.email#"/>
		</div>
	</div>
	<div class="clearer"></div>
</div>

<h4>#request.content.security#</h4>

<div class="form">
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_password1">#request.content.password#</label>
			<span class="required">*</span>
		</div>
		<div class="formrow_input">
			<input type="password" name="pass1" id="profile_password1" onkeyup="checkInput()"/>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_password2">#request.content.password_repeat#</label>
			<span class="required">*</span>
		</div>
		<div class="formrow_input">
			<input type="password" name="pass2" id="profile_password2"/>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			#request.content.password_securitylevel#
		</div>
		<div class="formrow_input">
			<img src="#stImageDir.module#/security-none.gif" name="seclevel" alt="">
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_buttonbar">
			<input type="submit" value="#request.content.form_save#"/>
		</div>
	</div>
	<div class="clearer"></div>
</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">