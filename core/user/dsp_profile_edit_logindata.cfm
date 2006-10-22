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

<div class="headline">#request.content.headline_userdata#</div>

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

<div class="headline2">#request.content.headline_userdata#</div>

<table class="vlist" width="100%">
	<cfif NOT stModuleConfig.userprofile.edit_nickname>
		<tr>
			<td colspan="2"><img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_nickname_admin_edit_hint#</td>
		</tr>
	</cfif>
	<tr>
		<th>#request.content.id#</th>
		<td>#attributes.id#</td>
	</tr>
	<tr>
		<th>#request.content.name#</th>
		<td><input type="text" name="name" value="#attributes.name#" <cfif NOT request.session.isAdmin AND NOT stModuleConfig.userprofile.edit_nickname> disabled</cfif>> <span class="required">*</span><cfif NOT stModuleConfig.userprofile.edit_nickname> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<tr>
		<th>#request.content.email#</th>
		<td><input type="text" name="email" value="#attributes.email#"> <span class="required">*</span></td>
	</tr>
</table>

<div class="headline2">#request.content.security#</div>

<table class="vlist" width="100%">
	<tr>
		<th>#request.content.password#</th>
		<td><input type="password" name="pass1" onkeyup="checkInput()"> <span class="required">*</span></td>
	</tr>
	<tr>
		<th>#request.content.password_repeat#</th>
		<td><input type="password" name="pass2"> <span class="required">*</span></td>
	</tr>
	<tr>
		<th>#request.content.password_securitylevel#</th>
		<td><img src="#stImageDir.module#/security-none.gif" name="seclevel" alt=""></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="Submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">