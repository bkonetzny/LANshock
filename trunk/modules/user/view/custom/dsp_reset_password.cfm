<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_reset_password.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<h3>#request.content.password_reset_headline#</h3>

<p>#request.content.password_reset_info#</p>

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

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" class="uniForm" method="post">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
	</div>
								
	<fieldset class="inlineLabels">
		<legend>#request.content.password_reset_headline#</legend>

		<div class="ctrlHolder">
			<label for="email"><em>*</em> #request.content.email#</label>
			<input type="text" class="textInput" name="email" id="email" maxlenght="255" value="#HTMLEditFormat(attributes.email)#"/>
		</div>

	</fieldset>
	<div class="buttonHolder">
		<button type="submit" class="submitButton">#request.content.password_reset_headline#</button>
	</div>
</form>

<script type="text/javascript">
<!--
	$('##email').focus();
//-->
</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">