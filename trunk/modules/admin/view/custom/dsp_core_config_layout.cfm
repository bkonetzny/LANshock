<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/admin/raw_files/view/custom/dsp_core_config_layout.cfm $
$LastChangedDate: 2008-05-12 14:49:49 +0200 (Mo, 12 Mai 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 298 $
--->

<cfoutput>
<h3><!--- TODO: $$$ ---> System Apperance</h3>

<p>#request.content.template_txt#</p>

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

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
	</div>
	
	<fieldset class="inlineLabels">
		<legend><!--- TODO: $$$ ---> System Apperance</legend>
		
		<div class="ctrlHolder">
			<label for="formrow_template"><em>*</em> #request.content.template#</label>
			<select class="selectInput" name="template" id="formrow_template" onchange="$('##imgPreviewImage').attr('src','#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/'+this.value+'/_preview.png');">
				<cfset sActiveTemplate = attributes.template>
				<cfloop query="qTemplates">
					<cfif type EQ "dir">
						<option value="#qTemplates.name#"<cfif sActiveTemplate EQ qTemplates.name> selected="selected"</cfif>>#qTemplates.name#</option>
					</cfif>
				</cfloop>
			</select>
			<p class="formHint">
				<img id="imgPreviewImage" style="border: 1px dotted gray;" vspace="2" hspace="2" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/#UrlEncodedFormat(application.lanshock.settings.layout.template)#/_preview.png">
			</p>
		</div>
			
		<div class="ctrlHolder">
			<p class="label"><!--- TODO: $$$ ---> Avatar Mode</p>
			<label for="avatar_mode_lanshock" class="inlineLabel"><input type="radio" name="avatar_mode" id="avatar_mode_lanshock" value="lanshock"<cfif attributes.avatar_mode EQ 'lanshock'> checked="checked"</cfif>> <!--- TODO: $$$ ---> LANshock</label>
			<label for="avatar_mode_gravatar" class="inlineLabel"><input type="radio" name="avatar_mode" id="avatar_mode_gravatar" value="gravatar"<cfif attributes.avatar_mode EQ 'gravatar'> checked="checked"</cfif>> <!--- TODO: $$$ ---> Gravatar.com</label>
		</div>
	
	</fieldset>

	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.core_config')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">