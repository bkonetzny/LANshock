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
<div class="headline">#request.content.personal_data#</div>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post" name="personaldata">
<input type="hidden" name="form_submitted" value="true">
<input type="hidden" name="id" value="#attributes.id#">

<div class="headline2">#request.content.personal_data#</div>

<table class="vlist" width="100%">
	<cfif NOT stModuleConfig.userprofile.edit_nickname>
		<tr>
			<td colspan="2"><img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_nickname_admin_edit_hint#</td>
		</tr>
	</cfif>
	<cfif request.session.isAdmin>
		<tr>
			<td colspan="2"><input type="checkbox" name="profile_verified" id="profile_verified" value="1"<cfif attributes.profile_verified> checked</cfif>> <label for="profile_verified">#request.content.profile_verified#</label></td>
		</tr>
	<cfelse>
		<cfif attributes.profile_verified>
		<tr>
			<td colspan="2"><img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_verified#</td>
		</tr>
		</cfif>
	</cfif>
	<cfif NOT stModuleConfig.userprofile.edit_personal_data>
		<tr>
			<td colspan="2"><img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_userdata_admin_edit_hint#</td>
		</tr>
	</cfif>
	<tr>
		<th>#request.content.firstname# <span class="required">*</span></th>
		<td><input type="text" name="firstname" value="#attributes.firstname#" <cfif NOT request.session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>> <cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<tr>
		<th>#request.content.lastname# <span class="required">*</span></th>
		<td><input type="text" name="lastname" value="#attributes.lastname#" <cfif NOT request.session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>> <cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<script language="javascript">
	var cal = new CalendarPopup("cal_div");
	cal.showNavigationDropdowns();
	</script>
	<tr>
		<th>#request.content.birthday# <span class="required">*</span></th>
		<td><input type="text" name="dt_birthdate" value="#LSDateFormat(attributes.dt_birthdate)#" maxlength="10" size="10"<cfif NOT request.session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>> <a href="##" onClick="cal.select(document.forms['personaldata'].dt_birthdate,'cal_img_1','dd.MM.yyyy'); return false;" name="cal_img_1" id="cal_img_1"><img src="#stImageDir.general#/calendar.gif"></a>
			<cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<tr>
		<th>#request.content.gender#</th>
		<td><input type="radio" name="gender" id="gender_1" value="1"<cfif attributes.gender EQ 1> checked</cfif>> <label for="gender_1">#request.content.gender_male#</label>
			<input type="radio" name="gender" id="gender_2" value="2"<cfif attributes.gender EQ 2> checked</cfif>> <label for="gender_2">#request.content.gender_female#</label>
			<cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
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
		<th>#request.content.country#</th>
		<td><cfset aCountryList = StructSort(stCountryList)>
			<select name="country"<cfif NOT request.session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>>
				<cfloop from="1" to="#ArrayLen(aCountryList)#" index="idx">
					<option value="#aCountryList[idx]#"<cfif attributes.country EQ aCountryList[idx]> selected</cfif>>#stCountryList[aCountryList[idx]]#</option>
				</cfloop>
			</select>
			<cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<tr>
		<th>#request.content.city#</th>
		<td><input type="text" name="city" value="#attributes.city#" <cfif NOT request.session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>><cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<tr>
		<th>#request.content.street#</th>
		<td><input type="text" name="street" value="#attributes.street#" <cfif NOT request.session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>><cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<tr>
		<th>#request.content.zip#</th>
		<td><input type="text" name="zip" value="#attributes.zip#" <cfif NOT request.session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>><cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="Submit" value="#request.content.form_save#"></td>
	</tr>
</table>
<div id="cal_div" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">