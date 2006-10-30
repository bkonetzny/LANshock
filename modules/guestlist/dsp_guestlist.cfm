<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	if(attributes.all) maxrows = qGuests.recordcount;
	else maxrows = 50;
</cfscript>

<cfoutput>
<div class="headline">#request.content.guestlist#</div>

<table cellpadding="5" cellspacing="0" align="center" width="100%">
	<tr>		
		<td>#qGuests.recordcount# #request.content.counter#</td>
		<form name="search" action="#myself##myfusebox.thiscircuit#.guestlist&#request.session.UrlToken#" method="post">
			<td align="right"><input type="text" name="search" value="#attributes.search#">
				<input type="Submit" value="#request.content.form_search#"></td>
		</form>
	</tr>
	<tr>
		<td colspan="2">
			<table>
				<tr>
					<form action="#myself##myfusebox.thiscircuit#.guestlist&#request.session.UrlToken#" method="post">
						<input type="hidden" name="list_order" value="#attributes.list_order#">
						<input type="hidden" name="list_order_type" value="#attributes.list_order_type#">
						<input type="hidden" name="search" value="#attributes.search#">
						<input type="hidden" name="startrow" value="#attributes.startrow-50#">
					<td><input type="submit" value=" << "<cfif attributes.startrow-50 LTE 0 OR attributes.all> disabled</cfif>></td>
					</form>
					<form action="#myself##myfusebox.thiscircuit#.guestlist&#request.session.UrlToken#" method="post">
						<input type="hidden" name="list_order" value="#attributes.list_order#">
						<input type="hidden" name="list_order_type" value="#attributes.list_order_type#">
						<input type="hidden" name="search" value="#attributes.search#">
					<td><select name="startrow">
							<option value="1">01-50</option>
							<cfloop from="1" to="#pages#" index="i">
								<option value="#50*i+1#"<cfif attributes.startrow EQ 50*i+1> selected</cfif>>#evaluate((50*i)+1)#-#evaluate(50*(i+1))#</option>
							</cfloop>
							<option value="ALL"<cfif attributes.all> selected</cfif>>ALL</option>
						</select></td>
						<td><input type="submit" value=" SHOW "></td>
					</form>
					<form action="#myself##myfusebox.thiscircuit#.guestlist&#request.session.UrlToken#" method="post">
						<input type="hidden" name="list_order" value="#attributes.list_order#">
						<input type="hidden" name="list_order_type" value="#attributes.list_order_type#">
						<input type="hidden" name="search" value="#attributes.search#">
						<input type="hidden" name="startrow" value="#attributes.startrow+50#">
					<td><input type="submit" value=" >> "<cfif attributes.startrow+50 GT qGuests.recordcount OR attributes.all> disabled</cfif>></td>
					</form>
				</tr>
			</table></td>
	</tr>
</table>

<table class="list">
	<tr>
		<cfif request.session.userloggedin>
			<th class="empty">&nbsp;</th>
		</cfif>
		<th><a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=nick&list_order_type=asc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="#request.content.form_asc#" border="0"></a>
			<a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=nick&list_order_type=desc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="#request.content.form_desc#" border="0"></a> #request.content.nickname#</th>
		<th><a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=firstname&list_order_type=asc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="#request.content.form_asc#" border="0"></a>
			<a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=firstname&list_order_type=desc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="#request.content.form_desc#" border="0"></a> #request.content.firstname#</th>
		<th><a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=lastname&list_order_type=asc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="#request.content.form_asc#" border="0"></a>
			<a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=lastname&list_order_type=desc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="#request.content.form_desc#" border="0"></a> #request.content.lastname#</th>
		<th><a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=clan&list_order_type=asc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="#request.content.form_asc#" border="0"></a>
			<a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=clan&list_order_type=desc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="#request.content.form_desc#" border="0"></a> #request.content.clan#</th>
		<th><a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=ort&list_order_type=asc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="#request.content.form_asc#" border="0"></a>
			<a href="#myself##myfusebox.thiscircuit#.guestlist&list_order=ort&list_order_type=desc&search=#attributes.search#&all=#attributes.all#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="#request.content.form_desc#" border="0"></a> #request.content.seat#</th>
	</tr>
	<cfloop query="qGuests" startrow="#attributes.startrow#" endrow="#attributes.startrow+maxrows#">
		<cfscript>		
			if(len(row) AND len(col)){
				if(ListLen(labels_x) GTE col) sCurrentCol = ListGetAt(labels_x,col);
				else sCurrentCol = '';
				if(ListLen(labels_y) GTE row) sCurrentRow = ListGetAt(labels_y,row);
				else sCurrentRow = '';
			}
		</cfscript>
		<tr>
			<cfif request.session.userloggedin>
				<td class="empty"><a href="#myself##request.lanshock.settings.modulePrefix.core#mail.buddy_add&buddy_id=#user_id#&#request.session.URLToken#"><img src="#stImageDir.general#/btn_add.gif" alt="#request.content.addbuddy#" border="0"></a></td>
			</cfif>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#nick#</a></td>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#firstname#</a></td>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#lastname#</a></td>
			<td><cfif len(clan_id)><a href="#myself##request.lanshock.settings.modulePrefix.core#clan.details&id=#clan_id#&#request.session.UrlToken#">#clan#</a><cfelse>&nbsp;</cfif></td>
			<td><cfif len(row) and len(col)><a href="#myself##request.lanshock.settings.modulePrefix.module#seatplan.seatplan&roomid=#roomid#&markseat=#seat_id#&#request.session.UrlToken#">#ort#, #sCurrentRow# #sCurrentCol#</a><cfelse>&nbsp;</cfif></td>
		</tr>
	</cfloop>
</table>

<table>
	<tr>
		<form action="#myself##myfusebox.thiscircuit#.guestlist&list_order=#attributes.list_order#&list_order_type=#attributes.list_order_type#&search=#attributes.search#&startrow=#attributes.startrow-50#&#request.session.UrlToken#" method="post">
		<td><input type="submit" value=" << "<cfif attributes.startrow-50 LTE 0 OR attributes.all> disabled</cfif>></td>
		</form>
		<form action="#myself##myfusebox.thiscircuit#.guestlist&list_order=#attributes.list_order#&list_order_type=#attributes.list_order_type#&search=#attributes.search#&#request.session.UrlToken#" method="post">
		<td><select name="startrow">
				<option value="1">01-50</option>
				<cfloop from="1" to="#pages#" index="i">
					<option value="#50*i+1#"<cfif attributes.startrow EQ 50*i+1> selected</cfif>>#evaluate((50*i)+1)#-#evaluate(50*(i+1))#</option>
				</cfloop>
				<option value="ALL"<cfif attributes.all> selected</cfif>>ALL</option>
			</select></td>
			<td><input type="submit" value=" SHOW "></td>
		</form>
		<form action="#myself##myfusebox.thiscircuit#.guestlist&list_order=#attributes.list_order#&list_order_type=#attributes.list_order_type#&search=#attributes.search#&startrow=#attributes.startrow+50#&#request.session.UrlToken#" method="post">
		<td><input type="submit" value=" >> "<cfif attributes.startrow+50 GT qGuests.recordcount OR attributes.all> disabled</cfif>></td>
		</form>
	</tr>
</table>

<SCRIPT LANGUAGE="JavaScript">
<!--
	document.search.search.focus();
//-->
</SCRIPT>
</cfoutput>

<cfsetting enablecfoutputonly="No">