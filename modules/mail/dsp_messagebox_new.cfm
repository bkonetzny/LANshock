<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/dsp_messagebox_new.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfoutput>
<h3>#request.content.create_new_message#</h3>

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" class="uniForm" method="post">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
	</div>
	
	<fieldset class="inlineLabels">
		<legend>#request.content.create_new_message#</legend>
		
		<div class="ctrlHolder">
			<label for="formrow_language"><em>*</em> #request.content.to#</label>
			<select class="selectInput" name="user_id" id="user_id" multiple="multiple">
				<cfloop query="qBuddylist">
					<option value="#qBuddylist.id#">#qBuddylist.buddyname#</option>
				</cfloop>
			</select>
		</div>

		<div class="ctrlHolder">
			<label for="title"><em>*</em> #request.content.topic#</label>
			<input type="text" class="textInput" name="title" id="title" value="#attributes.title#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="text"><em>*</em> #request.content.text#</label>
			<textarea name="text" id="text">#attributes.text#</textarea>
		</div>

	</fieldset>
	<div class="buttonHolder">
		<button type="submit" class="submitButton">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.inbox')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">