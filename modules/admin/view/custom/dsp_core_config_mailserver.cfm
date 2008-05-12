<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/admin/raw_files/view/custom/dsp_core_config_mailserver.cfm $
$LastChangedDate: 2008-05-12 14:49:49 +0200 (Mo, 12 Mai 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 298 $
--->

<cfoutput>
<h3><!--- TODO: $$$ ---> Mailserver</h3>

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
		<legend><!--- TODO: $$$ ---> Mailserver</legend>
		
		<div class="ctrlHolder">
			<label for="formrow_from"><em>*</em> <!--- TODO: $$$ ---> Default Sender E-Mail Address</label>
			<input type="text" class="textInput" name="from" id="formrow_from" value="#attributes.from#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_server"><em>*</em> <!--- TODO: $$$ ---> Server</label>
			<input type="text" class="textInput" name="server" id="formrow_server" value="#attributes.server#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_port"><em>*</em> <!--- TODO: $$$ ---> Port</label>
			<input type="text" class="textInput" name="port" id="formrow_port" value="#attributes.port#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_username"><!--- TODO: $$$ ---> Username</label>
			<input type="text" class="textInput" name="username" id="formrow_username" value="#attributes.username#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_password"><!--- TODO: $$$ ---> Password</label>
			<input type="password" class="textInput" name="password" id="formrow_password" value="#attributes.password#"/>
		</div>
	
	</fieldset>

	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.core_config')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">