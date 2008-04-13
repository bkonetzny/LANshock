<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_profile_edit_personaldata.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfset aCountryList = StructSort(stCountryList)>

<cfoutput>
<h3>#request.content.personal_data#</h3>

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
	<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails<cfif session.isAdmin>&id=#attributes.id#</cfif>')#" class="link_extended">#request.content.show_profile#</a>
</cfif>

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" name="personaldata">
<input type="hidden" name="form_submitted" value="true">
<input type="hidden" name="id" value="#attributes.id#">

<h4>#request.content.personal_data#</h4>

<div class="form">
	<cfif NOT stModuleConfig.userprofile.edit_nickname>
		<div class="formrow">
			<div class="formrow_input formrow_nolabel">
				<img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_nickname_admin_edit_hint#
			</div>
		</div>
	</cfif>
	<cfif session.isAdmin>
		<div class="formrow">
			<div class="formrow_input formrow_nolabel">
				<input type="checkbox" name="profile_verified" id="profile_verified" value="1"<cfif attributes.profile_verified> checked</cfif>> <label for="profile_verified">#request.content.profile_verified#</label>
			</div>
		</div>
	<cfelseif attributes.profile_verified>
		<div class="formrow">
			<div class="formrow_input formrow_nolabel">
				<img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_verified#
			</div>
		</div>
	</cfif>
	<cfif NOT stModuleConfig.userprofile.edit_personal_data>
		<div class="formrow">
			<div class="formrow_input formrow_nolabel">
				<img src="#stImageDir.general#/locked.gif" alt="" border="0"> #request.content.profile_userdata_admin_edit_hint#
			</div>
		</div>
	</cfif>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_firstname">#request.content.firstname#</label>
			<span class="required">*</span>
		</div>
		<div class="formrow_input">
			<input type="text" name="firstname" id="profile_firstname" value="#attributes.firstname#"<cfif NOT session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled="disabled"</cfif>> <cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_lastname">#request.content.lastname#</label>
			<span class="required">*</span>
		</div>
		<div class="formrow_input">
			<input type="text" name="lastname" id="profile_lastname" value="#attributes.lastname#"<cfif NOT session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled="disabled"</cfif>> <cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<script language="javascript">
		var cal = new CalendarPopup("cal_div");
		cal.showNavigationDropdowns();
	</script>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_birthday">#request.content.birthday#</label>
			<span class="required">*</span>
		</div>
		<div class="formrow_input">
			<input type="text" name="dt_birthdate" id="profile_birthday" value="#LSDateFormat(attributes.dt_birthdate)#" maxlength="10" size="10"<cfif NOT session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>>
			<a href="##" onClick="cal.select(document.forms['personaldata'].dt_birthdate,'cal_img_1','dd.MM.yyyy'); return false;" name="cal_img_1" id="cal_img_1"><img src="#stImageDir.general#/calendar.gif"></a>
			<cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			#request.content.gender#
		</div>
		<div class="formrow_input">
			<fieldset>
				<input type="radio" name="gender" id="gender_1" value="1"<cfif attributes.gender EQ 1> checked</cfif>> <label for="gender_1">#request.content.gender_male#</label>
				<input type="radio" name="gender" id="gender_2" value="2"<cfif attributes.gender EQ 2> checked</cfif>> <label for="gender_2">#request.content.gender_female#</label>
			</fieldset>
			<cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_language">#request.content.settings_language#</label>
		</div>
		<div class="formrow_input">
			<select name="language" id="profile_language">
				<cfloop list="#ListSort(StructKeyList(stLocales),'textnocase')#" index="idx">
					<option value="#idx#"<cfif attributes.language EQ idx> selected="selected"</cfif>>#idx# --- #stLocales[idx]#</option>
				</cfloop>
			</select>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_country">#request.content.country#</label>
		</div>
		<div class="formrow_input">
			<select name="country" id="profile_country"<cfif NOT session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>>
				<cfloop from="1" to="#ArrayLen(aCountryList)#" index="idx">
					<option value="#aCountryList[idx]#"<cfif attributes.country EQ aCountryList[idx]> selected</cfif>>#stCountryList[aCountryList[idx]]#</option>
				</cfloop>
			</select>
			<cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_city">#request.content.city#</label>
		</div>
		<div class="formrow_input">
			<input type="text" name="city" id="profile_city" value="#attributes.city#" <cfif NOT session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>><cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_street">#request.content.street#</label>
		</div>
		<div class="formrow_input">
			<input type="text" name="street" id="profile_street" value="#attributes.city#" <cfif NOT session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>><cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_zip">#request.content.zip#</label>
		</div>
		<div class="formrow_input">
			<input type="text" name="zip" id="profile_zip" value="#attributes.zip#" <cfif NOT session.isAdmin AND (NOT stModuleConfig.userprofile.edit_personal_data OR attributes.profile_verified)> disabled</cfif>><cfif NOT stModuleConfig.userprofile.edit_personal_data> <img src="#stImageDir.general#/locked.gif" alt="" border="0"></cfif>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_buttonbar">
			<input type="submit" value="#request.content.form_save#"/>
		</div>
	</div>
	<div class="clearer"></div>
</div>
<div id="cal_div" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">