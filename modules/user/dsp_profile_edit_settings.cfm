<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_profile_edit_settings.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<h3>#request.content.misc#</h3>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<input type="hidden" name="id" value="#attributes.id#">

<h4>#request.content.misc#</h4>

<div class="form">
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_homepage">#request.content.homepage#</label>
		</div>
		<div class="formrow_input">
			<input type="text" name="homepage" id="profile_homepage" value="#attributes.homepage#">
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_geo_lat">#request.content.geo_lat#</label>
		</div>
		<div class="formrow_input">
			<input type="text" name="geo_lat" id="profile_geo_lat" value="#attributes.geo_lat#">
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_geo_long">#request.content.geo_long#</label>
		</div>
		<div class="formrow_input">
			<input type="text" name="geo_long" id="profile_geo_long" value="#attributes.geo_long#">
		</div>
	</div>
	<div class="formrow">
		<div class="formrow_label">
			<label for="profile_signature">#request.content.signature#</label>
		</div>
		<div class="formrow_input">
			<textarea name="signature" id="profile_signature">#attributes.signature#</textarea>
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