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
<div class="headline">#request.content.news_edit_headline#</div>
	
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

<div class="headline2">#request.content.news_edit#</div>

<table width="90%">
	<cfif attributes.news_id NEQ 0>
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" class="link_extended">#request.content.add_new_news#</a></td>
		</tr>
	</cfif>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post" name="news_edit">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="news_id" value="#attributes.news_id#">
	<tr>
		<td>#request.content.title#<br>
			<input type="text" name="title" maxlength="255" value="#attributes.title#" style="width: 100%;"></td>
	</tr>
	<script language="javascript">
	var cal = new CalendarPopup("cal_div");
	cal.showNavigationDropdowns();
	</script>
	<tr>
		<td>#request.content.news_date#<br>
			<input type="text" name="date" value="#LSDateFormat(attributes.date)#" maxlength="10" size="10"> <a href="##" onClick="cal.select(document.forms['news_edit'].date,'cal_img_1','dd.MM.yyyy'); return false;" name="cal_img_1" id="cal_img_1"><img src="#stImageDir.general#/calendar.gif"></a></td>
	</tr>
	<tr>
		<td>#request.content.news_time#<br>
			<input type="text" name="time" value="#LSTimeFormat(attributes.date)#" maxlength="10" size="10"></td>
	</tr>
	<tr>
		<td>#request.content.text#<br>
			<textarea name="text" style="width: 100%; height: 200px;">#attributes.text#</textarea><br>
			<input type="checkbox" name="ishtml" id="ishtml" value="1"<cfif attributes.ishtml> checked</cfif>> <label for="ishtml"><!--- TODO: $$$ ---> Contains HTML</label></td>
	</tr>
	<tr>
		<td>#request.content.mp3_url#<br>
			<input type="text" name="mp3url" maxlength="255" value="#attributes.mp3url#" style="width: 100%;"></td>
	</tr>
	<tr>
		<td>#request.content.trackback_url#<br>
			<input type="text" name="trackback" maxlength="255" value="#attributes.trackback#" style="width: 100%;"></td>
	</tr>
	<tr>
		<td>#request.content.categories#<br>
			<select name="category_ids" size="6" multiple>
				<option value=""></option>
				<cfloop list="#ArrayToList(StructSort(stCategories,'textnocase','asc','name'))#" index="idx">
					<option value="#idx#"<cfif ListFind(attributes.category_ids,idx)> selected</cfif>>#stCategories[idx].name#</option>
				</cfloop>
			</select></td>
	</tr>
	<cfif qPingUrls.recordcount>
		<tr>
			<td><!--- TODO: $$$ ---> Ping-URLs<br>
				<select name="ping" size="6" multiple>
					<option value=""></option>
					<cfloop query="qPingUrls">
						<option value="#id#"<cfif ListFind(attributes.ping,id)> selected</cfif>>#name#</option>
					</cfloop>
				</select></td>
		</tr>
	<cfelse>
		<input type="hidden" name="ping" value="">
	</cfif>
	<tr>
		<td align="center"><input type="Submit" value="#request.content.form_save#"></td>
	</tr>
	</form>
</table>
<div id="cal_div" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></div>

<div class="headline2">#request.content.avaible_news#</div>

<table class="list">
	<tr>
		<th>#request.content.postedat#</th>
		<th>#request.content.title#</th>
		<th>#request.content.author#</th>
		<th class="empty">&nbsp;</th>
	</tr>
	<cfloop query="qNews">
		<tr>
			<td>#UDF_DateTimeFormat(date)#</td>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&news_id=#id#&#request.session.UrlToken#">#title#</a></td>
			<td>#GetUsernameByID(author)#</td>
			<td class="empty"><a href="#myself##myfusebox.thiscircuit#.news_del&news_id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></a></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">