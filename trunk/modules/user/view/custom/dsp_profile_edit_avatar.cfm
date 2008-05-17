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
<h3>#request.content.avatar#</h3>

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

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" class="uniForm" method="post" enctype="multipart/form-data">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
	</div>
	
	<fieldset class="inlineLabels">
		<legend>#request.content.avatar#</legend>
		
		<cfif len(application.lanshock.oHelper.UserShowAvatar(session.userid))>
			<div class="ctrlHolder">
				<label>#request.content.current_avatar#</label>
				#application.lanshock.oHelper.UserShowAvatar(session.userid)#
			</div>
			
			<div class="ctrlHolder">
				<div>
					<label for="avatar_delete" class="inlineLabel"><input type="checkbox" name="avatar_delete" id="avatar_delete" value="true"/> #request.content.delete_avatar#</label>
				</div>
			</div>
		</cfif>

		<div class="ctrlHolder">
			<label for="profile_avatar_upload">#request.content.upload_avatar#</label>
			<input type="file" class="fileUpload" name="avatar" id="profile_avatar_upload" onChange="$('##ctrlHolderAvatarPreview').show();$('##avatarimage').attr('src',$('##profile_avatar_upload').val());"/>
		</div>

		<div class="ctrlHolder" id="ctrlHolderAvatarPreview" style="display: none;">
			<label>#request.content.avatar_preview#</label>
			<img id="avatarimage" src="" style="width: 80px; height: 80px;"/>
		</div>

	</fieldset>
	<div class="buttonHolder">
		<button type="submit" class="submitButton">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">