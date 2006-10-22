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
<div class="headline">#request.content.userlist#</div>

<table width="100%">
	<tr>
		<td valign="top" width="50%">
			&nbsp;<br>
			<a href="#myself##request.lanshock.settings.modulePrefix.core#user.register_admin&#request.session.UrlToken#" target="_blank" class="link_extended">#request.content.adduser#</a><br>
			<a href="#myself##myfusebox.thiscircuit#.user_del_history&#request.session.UrlToken#" class="link_extended">#request.content.deleted_users_headline#</a><br>
			<br>
			#request.content.export_userlist_headline#<br>
			<a href="#myself##myfusebox.thiscircuit#.userlist_export&type=csv&#request.session.UrlToken#" target="_blank" class="link_extended">#request.content.export_userlist_csv#</a><br>
			<a href="#myself##myfusebox.thiscircuit#.userlist_export&type=xml&#request.session.UrlToken#" target="_blank" class="link_extended">#request.content.export_userlist_xml#</a><br>
		</td>
		<td valign="top" width="50%" rowspan="2">
			<fieldset>
			<legend>#request.content.search_label#</legend>
			<table cellpadding="5">
				<form name="search" action="#myself##myfusebox.thiscircuit#.userlist&#request.session.UrlToken#" method="post" name="search">
				<tr>
					<td valign="top">#request.content.search_searchtxt#<br>
						<input type="text" name="search" value="#HtmlEditFormat(attributes.search)#"> 
						<input type="submit" name="submit" value="#request.content.search_submit_search_filter#">
					</td>
					<td valign="top" rowspan="2">
						#request.content.search_filter#<br>
						<select name="filter" size="12" multiple>
							<option value=""></option>
							<optgroup label="#request.content.filter_label_locked#">
								<option value="locked_1"<cfif listFind(attributes.filter,'locked_1')> selected</cfif>>#request.content.locked#</option>
								<option value="locked_0"<cfif listFind(attributes.filter,'locked_0')> selected</cfif>>#request.content.locked_0#</option>
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						#request.content.search_search_in#<br>
						<select name="search_in" size="6" multiple>
							<option value="id"<cfif listFind(attributes.search_in,'id')> selected</cfif>>#request.content.id#</option>
							<option value="name"<cfif listFind(attributes.search_in,'name')> selected</cfif>>#request.content.nickname#</option>
							<option value="firstname"<cfif listFind(attributes.search_in,'firstname')> selected</cfif>>#request.content.prename#</option>
							<option value="lastname"<cfif listFind(attributes.search_in,'lastname')> selected</cfif>>#request.content.name#</option>
							<option value="email"<cfif listFind(attributes.search_in,'email')> selected</cfif>>#request.content.email#</option>
							<option value="notice"<cfif listFind(attributes.search_in,'notice')> selected</cfif>>#request.content.notice#</option>
						</select>
					</td>
				</tr>
				</form>
			</table>
			</fieldset>
		</td>
		<tr>
			<td valign="bottom">
				<cfif len(attributes.search) OR len(attributes.filter)>
					#request.content.users_matching_search#<br>
					<strong>#iUserCountSearch#</strong> #request.content.users_matching_search_delimiter# <strong>#iUserCountGlobal#</strong><br>
					<br>
					<cfif len(attributes.filter)>#request.content.search_active_filters#<br></cfif>
					<a style="color: red;" href="#myself##myfusebox.thiscircuit#.userlist&#request.session.UrlToken#">#request.content.show_without_filter#</a>
				<cfelse>
					<strong>#iUserCountGlobal#</strong> #request.content.users_global#<br>
					<strong>#iUserCountSearch#</strong> #request.content.users_showing#
				</cfif>
			</td>
		</tr>
	</tr>
</table>

<script language="javascript">
<!--
	document.search.search.focus();
//-->
</script>

<br>&nbsp;<br>

<table class="list">
	<tr>
		<td class="empty" colspan="2"><span class="text_big">#UCase(attributes.startkey)#</span></td>
		<td class="empty" colspan="5">
			<div align="center">
			<cfloop list="?,0-9,all,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z" index="idx">
				<a href="#myself##myfusebox.thiscircuit#.userlist&startkey=#idx#&#request.session.UrlToken#"><cfif attributes.startkey EQ idx><strong></cfif><cfif idx EQ 'all'>#request.content.all#<cfelse>#UCase(idx)#</cfif><cfif attributes.startkey EQ idx></strong></cfif></a>&nbsp;
			</cfloop>
			</div>
		</td>
	</tr>	
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.id#</th>
		<th nowrap><a href="#myself##myfusebox.thiscircuit#.userlist&list_order=name&list_order_type=asc&search=#attributes.search#&search_in=#attributes.search_in#&startkey=#attributes.startkey#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="aufsteigend"></a>
			<a href="#myself##myfusebox.thiscircuit#.userlist&list_order=name&list_order_type=desc&search=#attributes.search#&search_in=#attributes.search_in#&startkey=#attributes.startkey#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="absteigend"></a>
			#request.content.nickname#</th>
		<th nowrap><a href="#myself##myfusebox.thiscircuit#.userlist&list_order=firstname&list_order_type=asc&search=#attributes.search#&search_in=#attributes.search_in#&startkey=#attributes.startkey#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="aufsteigend"></a>
			<a href="#myself##myfusebox.thiscircuit#.userlist&list_order=firstname&list_order_type=desc&search=#attributes.search#&search_in=#attributes.search_in#&startkey=#attributes.startkey#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="absteigend"></a>
			#request.content.prename#</th>
		<th nowrap><a href="#myself##myfusebox.thiscircuit#.userlist&list_order=lastname&list_order_type=asc&search=#attributes.search#&search_in=#attributes.search_in#&startkey=#attributes.startkey#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="aufsteigend"></a>
			<a href="#myself##myfusebox.thiscircuit#.userlist&list_order=lastname&list_order_type=desc&search=#attributes.search#&search_in=#attributes.search_in#&startkey=#attributes.startkey#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="absteigend"></a>
			#request.content.name#</th>
		<th nowrap><a href="#myself##myfusebox.thiscircuit#.userlist&list_order=email&list_order_type=asc&search=#attributes.search#&search_in=#attributes.search_in#&startkey=#attributes.startkey#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_up.gif" alt="aufsteigend"></a>
			<a href="#myself##myfusebox.thiscircuit#.userlist&list_order=email&list_order_type=desc&search=#attributes.search#&search_in=#attributes.search_in#&startkey=#attributes.startkey#&#request.session.UrlToken#"><img src="#stImageDir.general#/arrow_down.gif" alt="absteigend"></a>
			#request.content.email#</th>
		<th class="empty">&nbsp;</th>
	</tr>
	<cfloop query="qUsers">
		<tr>
			<td class="empty"><cfif locked>
					<img src="#stImageDir.general#/locked.gif" alt="#request.content.locked#">
				</cfif></td>
			<td align="right"><span class="text_light text_small">#id#</span></td>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#id#&#request.session.UrlToken#" class="text_small">#name#</a></td>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#id#&#request.session.UrlToken#">#firstname#</a></td>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#id#&#request.session.UrlToken#">#lastname#</a></td>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#id#&#request.session.UrlToken#" class="text_small" title="#email#"><cfif len(email) GT 15 AND NOT ListFind(attributes.search_in, 'email')>#left(email,14)#...<cfelse>#email#</cfif></a></td>
			<td nowrap class="empty">
				<a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails_edit&id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_profile.gif" alt="#request.content.show_profile#"></a>
				<cfif NOT len(admin)>
					&nbsp;&nbsp;&nbsp;
					<a href="#myself##myfusebox.thiscircuit#.user_del&user_id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></a>
				</cfif>
			</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">