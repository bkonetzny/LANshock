<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_register.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<div class="headline">#request.content.register#</div>

<div align="center">
	#request.content.register_notice# <a href="#myself##myfusebox.thiscircuit#.login&#request.session.UrlToken#">#request.content.login#</a>.
</div>

<cfif myfusebox.thisfuseaction NEQ 'register' OR stModuleConfig.registration_active>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post" enctype="multipart/form-data" name="user" id="user">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<td colspan="2"><div class="headline2">#request.content.headline_userdata#</div></td>
	</tr>
	<tr>
		<th>#request.content.name#</th>
		<td><input type="text" name="name" value="#attributes.name#" <cfif NOT request.session.isAdmin AND NOT stModuleConfig.userprofile.edit_nickname> disabled</cfif>> <span class="required">*</span><cfif NOT stModuleConfig.userprofile.edit_nickname> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<tr>
		<th>#request.content.email#</th>
		<td><input type="text" name="email" value="#attributes.email#"> <span class="required">*</span></td>
	</tr>
	<tr>
		<td colspan="2"><div class="headline2">#request.content.security#</div></td>
	</tr>
	<tr>
		<th>#request.content.password#</th>
		<td><input type="password" name="pass1"> <span class="required">*</span></td>
	</tr>
	<tr>
		<th>#request.content.password_repeat#</th>
		<td><input type="password" name="pass2"> <span class="required">*</span></td>
	</tr>
	<tr>
		<td colspan="2"><div class="headline2">#request.content.personal_data#</div></td>
	</tr>
	<tr>
		<th>#request.content.firstname#</th>
		<td><input type="text" name="firstname" value="#attributes.firstname#"> <span class="required">*</span></td>
	</tr>
	<tr>
		<th>#request.content.lastname#</th>
		<td><input type="text" name="lastname" value="#attributes.lastname#"> <span class="required">*</span></td>
	</tr>
	<script language="javascript">
	var cal = new CalendarPopup("cal_div");
	cal.showNavigationDropdowns();
	</script>
	<tr>
		<th>#request.content.birthday#</th>
		<td><input type="text" name="dt_birthdate" value="#LSDateFormat(attributes.dt_birthdate)#" maxlength="10" size="10"> <a href="##" onClick="cal.select(document.forms['user'].dt_birthdate,'cal_img_1','dd.MM.yyyy'); return false;" name="cal_img_1" id="cal_img_1"><img src="#stImageDir.general#/calendar.gif"></a>
			 <span class="required">*</span></td>
	</tr>
	<tr>
		<th>#request.content.gender#</th>
		<td><select name="gender">
				<option value="1"<cfif attributes.gender EQ 1> selected</cfif>>#request.content.gender_male#</option>
				<option value="2"<cfif attributes.gender EQ 2> selected</cfif>>#request.content.gender_female#</option>
			</select> <span class="required">*</span></td>
	</tr>
	<tr>
		<th>#request.content.country#</th>
		<td><cfset aCountryList = StructSort(stCountryList)>
			<select name="country">
				<cfloop from="1" to="#ArrayLen(aCountryList)#" index="idx">
					<option value="#aCountryList[idx]#"<cfif attributes.country EQ aCountryList[idx]> selected</cfif>>#stCountryList[aCountryList[idx]]#</option>
				</cfloop>
			</select> <span class="required">*</span></td>
	</tr>
	<tr>
		<th>#request.content.settings_language#</th>
		<td><select name="language">
				<cfloop list="#ListSort(StructKeyList(stLocales),'textnocase')#" index="idx">
					<option value="#idx#"<cfif attributes.language EQ idx> selected</cfif>>#idx# --- #stLocales[idx]#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>
<div id="cal_div" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></div>
<cfelse>
	#request.content.register_deactivated#
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">