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
<h3>#request.content.gallery_edit#</h3>
	
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

<h4>#request.content.gallery_edit#</h4>

<table class="vlist">
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" name="gallery_edit">
	<input type="hidden" name="form_submitted" value="true"/>
	<input type="hidden" name="id" value="#attributes.id#"/>
	<tr>
		<th>#request.content.gallery_name#</th>
		<td><input type="text" name="title" value="#attributes.title#"/></td>
	</tr>
	<script language="javascript">
	var cal = new CalendarPopup("cal_div");
	cal.showNavigationDropdowns();
	</script>
	<tr>
		<th><!--- TODO: $$$ ---> Date</th>
		<td><input type="text" name="date" value="#LSDateFormat(attributes.date)#" maxlength="10" size="10"/> <a href="##" onClick="cal.select(document.forms['gallery_edit'].date,'cal_img_1','dd.MM.yyyy'); return false;" name="cal_img_1" id="cal_img_1"><img src="#stImageDir.general#/calendar.gif"></a></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Time</th>
		<td><input type="text" name="time" value="#LSTimeFormat(attributes.date)#" maxlength="10" size="10"/></td>
	</tr>
	<tr>
		<th>#request.content.description#</th>
		<td><textarea name="text">#attributes.text#</textarea></td>
	</tr>
	<tr>
		<th>#request.content.gallery_visible_show_hide#</th>
		<td><input type="radio" name="visible" value="true"<cfif attributes.visible> checked="checked"</cfif>/> #request.content.gallery_visible_show#<br>
			<input type="radio" name="visible" value="false"<cfif NOT attributes.visible> checked="checked"</cfif>/> #request.content.gallery_visible_hide#</td>
	</tr>
	<cfif attributes.id NEQ 0>
		<tr>
			<th>#request.content.gallery_previewimage#</th>
			<td><select name="tn">
					<option value=""></option>
					<cfloop query="qItemlist">
						<option value="#filename#"<cfif attributes.tn EQ filename> selected="selected"</cfif>>#title#</option>
					</cfloop>
				</select></td>
		</tr>
	</cfif>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="#request.content.form_save#"/></td>
	</tr>
	</form>
</table>
<div id="cal_div" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></div>
</cfoutput>

<cfsetting enablecfoutputonly="No">