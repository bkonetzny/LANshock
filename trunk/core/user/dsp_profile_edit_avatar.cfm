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
<script language="javascript" type="text/javascript">
<!--
function updatePicture(imagename) {
	window.document.images['avatarimage'].src = imagename;
}
//-->
</script>
<div class="headline">#request.content.avatar#</div>

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

<div class="headline2">#request.content.avatar#</div>

<table class="vlist" width="100%">
	<cfif len(UserShowAvatar(attributes.id))>
		<tr>
			<th valign="top">#request.content.current_avatar#</th>
			<td>#UserShowAvatar(attributes.id)#</td>
		</tr>
		<tr>
			<th><label for="avatar_delete">#request.content.delete_avatar#</label></th>
			<td><input type="checkbox" name="avatar_delete" id="avatar_delete" value="true"></td>
		</tr>
	</cfif>
	<tr>
		<th>#request.content.upload_avatar#</th>
		<td><input type="file" name="avatar" onChange="updatePicture(this.value);"></td>
	</tr>
	<tr>
		<th>#request.content.avatar_samples#</th>
		<td><select name="avatar_sample" onChange="updatePicture('#stImageDir.module#/../avatar/samples/' + this.value);">
				<option value="" selected></option>
				<cfloop list="#ListSort(lSamples,'textnocase')#" index="idx">
					<option value="#idx#">#idx#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<th>#request.content.avatar_preview#</th>
		<td><img src="#stImageDir.general#/spacer.gif" name="avatarimage" height="#application.lanshock.settings.layout.avatar.height#" width="#application.lanshock.settings.layout.avatar.width#" alt=""></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="Submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">