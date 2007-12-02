<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_profile.cfm $
$LastChangedDate: 2007-07-07 16:11:30 +0200 (Sa, 07 Jul 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 91 $
--->

<cfoutput query="qUserData">
<h3>#request.content.profile#</h3>

<cfif request.session.UserLoggedIn>
	<h4>#request.content.options_headline#</h4>
	
	<ul class="options">
		<cfif NOT request.session.UserID EQ id>
			<li><a href="javascript:SendMsg(#id#);"><img src="#stImageDir.general#/mail.gif" alt=""> #request.content.user_send_message#</a></li>
			<li><a href="#myself##request.lanshock.settings.modulePrefix.core#mail.buddy_add&buddy_id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_add.gif" alt=""> #request.content.user_add_to_buddylist#</a></li>
		<cfelse>
			<li><a href="javascript:Panel();"><img src="#stImageDir.general#/openpanel.gif" alt="" align="absmiddle"> #request.content.show_panel#</a></li>
			<cfif qNewMail.recordcount>
				<li><a href="#myself##request.lanshock.settings.modulePrefix.core#mail.main&#request.session.UrlToken#">#formatContentString('<!--- TODO: $$$ ---> You have <strong>{1}</strong> new Messages.',qNewMail.recordcount)#</a></li>
			</cfif>
		</cfif>
	</ul>
</cfif>

<cfif request.session.isAdmin>
	<h4>#request.content.admin_options#</h4>

	<div class="expandable">
		<div>
			<table cellspacing="10">
				<tr>
					<td valign="top">
						<!--- <a href="#myself##myfusebox.thiscircuit#.userdetails_edit&id=#id#&#request.session.UrlToken#" class="link_extended">#request.content.profile_edit#</a><br> --->
						<a href="#myself##request.lanshock.settings.modulePrefix.core#admin.as_login&user_id=#id#&as_login=true&#request.session.UrlToken#" target="_blank" class="link_extended">#request.content.option_login_as#</a><br>
						<a href="#myself##myfusebox.thiscircuit#.user_history&id=#id#&#request.session.UrlToken#" class="link_extended">#request.content.show_history#</a>
						
						<form name="search" action="#myself##request.lanshock.settings.modulePrefix.core#admin.userlist&#request.session.urltoken#" method="post">
							<a href="#myself##request.lanshock.settings.modulePrefix.core#admin.userlist&#request.session.urltoken#" class="link_extended">#request.content.show_userlist#</a><br>
							<input type="text" name="search" value=""> <input type="submit" value="#request.content.form_search#">
						</form>
						
						<form action="#myself##request.lanshock.settings.modulePrefix.core#admin.userpassword_change&#request.session.urltoken#" method="post">
							<input type="hidden" name="userid" value="#id#">
							#request.content.userpassword_change#<br>
							<input type="password" name="password" value=""> <input type="submit" value="#request.content.form_save#">
						</form>
						
						<form action="#myself##request.lanshock.settings.modulePrefix.core#admin.userstatus_change&#request.session.urltoken#" method="post">
							<input type="hidden" name="userid" value="#id#">
							<input type="hidden" name="locked" value="#abs(locked-1)#">
								<cfif locked>
									<input type="submit" value="Unlock User">
								<cfelse>
									<input type="submit" value="Lock User">
								</cfif>
						</form>
					</td>
					<td valign="top">
						<form action="#myself##request.lanshock.settings.modulePrefix.core#admin.usernotice_save&#request.session.urltoken#" method="post">
							<input type="hidden" name="userid" value="#id#">
							#request.content.usernotice#<br>
							<textarea style="width: 400px; height: 100px;" name="notice">#notice#</textarea><br>
							<input type="submit" value="#request.content.form_save#">
						</form>
					</td>
				</tr>
			</table>
		</div>
	</div>
</cfif>

<h4>#request.content.headline_userdata#</h4>

<cfif request.session.userid EQ id OR (request.session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))>
	<a href="#myself##myfusebox.thiscircuit#.profile_edit_logindata<cfif request.session.isAdmin>&id=#id#</cfif>&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Logindaten und Passwort &auml;ndern</a>
</cfif>

<table class="vlist">
	<cfif request.session.UserLoggedIn>
		<tr>
			<th>#request.content.id#</th>
			<td>#id#</td>
			<th>#request.content.avatar#</th>
		</tr>
	</cfif>
	<tr>
		<th>#request.content.name#</th>
		<td>#name#</td>
		<td<cfif request.session.UserLoggedIn> rowspan="4"</cfif> align="center">#UserShowAvatar(id)#
			<cfif (request.session.userid EQ id OR (request.session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))) AND application.lanshock.settings.layout.avatar.mode EQ 'lanshock'>
				<br><a href="#myself##myfusebox.thiscircuit#.profile_edit_avatar<cfif request.session.isAdmin>&id=#id#</cfif>&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Avatar &auml;ndern</a>
			</cfif>
		</td>
	</tr>
	<cfif request.session.UserLoggedIn>
		<tr>
			<th>#request.content.email#</th>
			<td><a href="mailto:#email#">#email#</a></td>
		</tr>
		<tr>
			<th>#request.content.lastlogin#</th>
			<td><span class="text_light"><cfif len(dt_lastlogin)>#UDF_DateTimeFormat(dt_lastlogin)#<cfelse>#request.content.lastlogin_never#</cfif></span></td>
		</tr>
		<cfif request.session.userid EQ id OR request.session.isAdmin>
			<tr>
				<th>#request.content.password_securitylevel#</th>
				<td><img src="#stImageDir.module#/security-#password_level#.gif" alt=""></td>
			</tr>
		</cfif>
	</cfif>
</table>

<cfif request.session.UserLoggedIn>
	<h4>#request.content.personal_data#</h4>
	
	<cfif profile_verified>
		<p><img src="#stImageDir.general#/locked.gif" alt=""/> #request.content.profile_verified#</p>
	</cfif>
	
	<cfif request.session.userid EQ id OR (request.session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))>
		<a href="#myself##myfusebox.thiscircuit#.profile_edit_personaldata<cfif request.session.isAdmin>&id=#id#</cfif>&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Pers&ouml;nliche Daten &auml;ndern</a>
	</cfif>
	
	<table class="vlist">
		<tr>
			<th>#request.content.firstname#</th>
			<td>#firstname#</td>
		</tr>
		<tr>
			<th>#request.content.lastname#</th>
			<td>#lastname#</td>
		</tr>
		<tr>
			<th>#request.content.birthday#</th>
			<td><cfif isDate(dt_birthdate)>#LSDateFormat(dt_birthdate)# (<!--- TODO: $$$ ---> Alter #DateDiff('yyyy',dt_birthdate,now())#)<cfelse><span class="text_light">#request.content.data_unknown#</span></cfif></td>
		</tr>
		<tr>
			<th>#request.content.gender#</th>
			<td><cfswitch expression="#gender#">
					<cfcase value="0"><span class="text_light">#request.content.data_unknown#</span></cfcase>
					<cfcase value="1"><img src="#stImageDir.module#/male.gif" alt="" border="0"></cfcase>
					<cfcase value="2"><img src="#stImageDir.module#/female.gif" alt="" border="0"></cfcase>
				</cfswitch></td>
		</tr>
		<cfif len(language)>
			<tr>
				<th>#request.content.settings_language#</th>
				<td><img src="#UDF_Module('webPath','#request.lanshock.settings.modulePrefix.core#general')#flags/#LCase(ListLast(language,'_'))#.gif" alt="#language#"> #GetLocaleDisplayName(language)#</td>
			</tr>
		</cfif>
		<cfif request.session.isAdmin AND len(idcardnumber)>
			<tr>
				<th>#request.content.id_card_number#</th>
				<td>#idcardnumber#</td>
			</tr>
		</cfif>
	</table>

	<!--- <h4><!--- TODO: $$$ ---> Messaging</h4>
	
	<cfif request.session.userid EQ id>
		<a href="#myself##myfusebox.thiscircuit#.userdetails_edit&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Messaging Daten &auml;ndern</a>
	</cfif>
	
	<table class="vlist">
		<tr>
			<th><!--- TODO: $$$ ---> Jabber</th>
			<td></td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> IRC</th>
			<td>majestixs @ irc.quakenet.org</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> ICQ</th>
			<td>101452807</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> MSN</th>
			<td>bkonetzny @ msn.de</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> AIM</th>
			<td></td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> Yahoo!</th>
			<td></td>
		</tr>
	</table> --->
</cfif>

<h4><!--- TODO: $$$ ---> Info</h4>

<table class="vlist">
	<cfif request.session.UserLoggedIn>
		<cfif StructKeyExists(application.module,'#request.lanshock.settings.modulePrefix.module#seatplan')>
			<tr>
				<th>#request.content.seat#</th>
				<td><cftry>
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#id#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#">#stSeat.description#</a>
						<cfelse>
							<span class="text_light">#request.content.data_unknown#</span>
						</cfif>
						<cfcatch>
							<span class="text_light">#request.content.seat_notavaible#</span>
						</cfcatch>
					</cftry>
				</td>
			</tr>
		</cfif>
		<tr>
			<th><!--- TODO: $$$ ---> Logins</th>
			<td>#logincount#</td>
		</tr>
		<tr>
			<th>#request.content.lastlogin#</th>
			<td><cfif len(dt_lastlogin)>#UDF_DateTimeFormat(dt_lastlogin)#<cfelse>#request.content.lastlogin_never#</cfif></td>
		</tr>
		<tr>
			<th>#request.content.registered#</th>
			<td><cfif len(dt_registered)>#UDF_DateTimeFormat(dt_registered)#<cfelse>#request.content.registered_notavaible#</cfif></td>
		</tr>
	</cfif>
	<tr>
		<th>#request.content.comment_posts#</th>
		<td>#post_count#</td>
	</tr>
</table>

<h4>#request.content.misc#</h4>

<cfif request.session.userid EQ id OR (request.session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))>
	<a href="#myself##myfusebox.thiscircuit#.profile_edit_settings<cfif request.session.isAdmin>&id=#id#</cfif>&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Einstellungen &auml;ndern</a>
</cfif>

<table class="vlist">
	<cfif len(homepage)>
		<tr>
			<th>#request.content.homepage#</th>
			<td><a href="#homepage#" target="_blank">#homepage#</a></td>
		</tr>
	</cfif>
	<cfif request.session.UserLoggedIn>
		<tr>
			<th>#request.content.geo_lat#</th>
			<td>#geo_lat#</td>
		</tr>
		<tr>
			<th>#request.content.geo_long#</th>
			<td>#geo_long#</td>
		</tr>
	</cfif>
	<cfif len(signature)>
		<tr>
			<th>#request.content.signature#</th>
			<td>#ConvertText(signature)#</td>
		</tr>
	</cfif>
	<cfif len(additional_data) AND (request.session.userid EQ id OR request.session.isAdmin)>
		<tr>
			<th>#request.content.additional_data#</th>
			<td><cfloop list="#additional_data#" index="idx" delimiters=";">#idx#<br/></cfloop></td>
		</tr>
	</cfif>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">