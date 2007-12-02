<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_profile_edit_avatar.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<script type="text/javascript">
<!--
function updatePicture(imagename) {
	window.document.images['avatarimage'].src = imagename;
}
//-->
</script>
<h3>#request.content.avatar#</h3>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post" enctype="multipart/form-data" name="form">
<input type="hidden" name="form_submitted" value="true">
<input type="hidden" name="id" value="#attributes.id#">

<h4>#request.content.avatar#</h4>

<div class="form">
	<cfif len(UserShowAvatar(attributes.id))>
		<div class="formrow">
			<div class="formrow_label">
				#request.content.current_avatar#
			</div>
			<div class="formrow_input">
				#UserShowAvatar(attributes.id)#
			</div>
		</div>
		<div class="formrow">
			<div class="formrow_input formrow_nolabel">
				<input type="checkbox" name="avatar_delete" id="avatar_delete" value="true">
				<label for="avatar_delete">#request.content.delete_avatar#</label>
			</div>
		</div>
	</cfif>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_avatar_upload">#request.content.upload_avatar#</label>
		</div>
		<div class="formrow_input">
			<input type="file" name="avatar" id="profile_avatar_upload" onChange="updatePicture(this.value);">
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_avatar_samples">#request.content.avatar_samples#</label>
		</div>
		<div class="formrow_input">
			<select name="avatar_sample" id="profile_avatar_samples" onChange="updatePicture('#stImageDir.module#/../avatar/samples/' + this.value);">
				<option value=""></option>
				<cfloop list="#ListSort(lSamples,'textnocase')#" index="idx">
					<option value="#idx#">#idx#</option>
				</cfloop>
			</select>
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			#request.content.avatar_preview#
		</div>
		<div class="formrow_input">
			<img src="#stImageDir.general#/spacer.gif" name="avatarimage" height="#application.lanshock.settings.layout.avatar.height#" width="#application.lanshock.settings.layout.avatar.width#" alt="">
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