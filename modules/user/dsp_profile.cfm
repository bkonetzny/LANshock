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

<cfif session.UserLoggedIn AND session.UserID NEQ id>
	<h4>#request.content.options_headline#</h4>
	
	<ul class="options">
		<li><a href="javascript:SendMsg(#id#);"><img src="#stImageDir.general#/mail.gif" alt=""> #request.content.user_send_message#</a></li>
		<li><a href="#application.lanshock.oHelper.buildUrl('mail.buddy_add&buddy_id=#id#')#"><img src="#stImageDir.general#/btn_add.gif" alt=""> #request.content.user_add_to_buddylist#</a></li>
	</ul>
</cfif>

<cfif session.isAdmin>
	<h4 onclick="$('##adminpanel').toggle();">#request.content.admin_options#</h4>

	<div id="adminpanel" style="display: none;">
		<div>
			<table cellspacing="10">
				<tr>
					<td valign="top">
						<!--- <a href="#myself##myfusebox.thiscircuit#.userdetails_edit&id=#id#&#session.UrlToken#" class="link_extended">#request.content.profile_edit#</a><br> --->
						<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.user_history&id=#id#')#" class="link_extended">#request.content.show_history#</a>
						
						<form name="search" action="#application.lanshock.oHelper.buildUrl('admin.userlist')#" method="post">
							<a href="#application.lanshock.oHelper.buildUrl('admin.userlist')#" class="link_extended">#request.content.show_userlist#</a><br>
							<input type="text" name="search" value=""> <input type="submit" value="#request.content.form_search#">
						</form>
						
						<form action="#application.lanshock.oHelper.buildUrl('admin.userpassword_change')#" method="post">
							<input type="hidden" name="userid" value="#id#">
							#request.content.userpassword_change#<br>
							<input type="password" name="password" value=""> <input type="submit" value="#request.content.form_save#">
						</form>
						
						<form action="#application.lanshock.oHelper.buildUrl('admin.userstatus_change')#" method="post">
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
						<form action="#application.lanshock.oHelper.buildUrl('admin.usernotice_save')#" method="post">
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

<cfif session.userid EQ id OR (session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))>
	<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.profile_edit_logindata')#" class="link_extended"><!--- TODO: $$$ ---> Logindaten und Passwort &auml;ndern</a>
</cfif>

<table class="vlist">
	<cfif session.UserLoggedIn>
		<tr>
			<th>#request.content.id#</th>
			<td>#id#</td>
			<th>#request.content.avatar#</th>
		</tr>
	</cfif>
	<tr>
		<th>#request.content.name#</th>
		<td>#name#</td>
		<td<cfif session.UserLoggedIn> rowspan="4"</cfif> align="center">#application.lanshock.oHelper.UserShowAvatar(id)#
			<cfif (session.userid EQ id OR (session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))) AND application.lanshock.settings.layout.avatar.mode EQ 'lanshock'>
				<br><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.profile_edit_avatar')#" class="link_extended"><!--- TODO: $$$ ---> Avatar &auml;ndern</a>
			</cfif>
		</td>
	</tr>
	<cfif session.UserLoggedIn>
		<tr>
			<th>#request.content.email#</th>
			<td><a href="mailto:#email#">#email#</a></td>
		</tr>
		<tr>
			<th>#request.content.lastlogin#</th>
			<td><span class="text_light"><cfif len(dt_lastlogin)>#session.oUser.dateTimeFormat(dt_lastlogin)#<cfelse>#request.content.lastlogin_never#</cfif></span></td>
		</tr>
	</cfif>
</table>

<cfif session.UserLoggedIn>
	<h4>#request.content.personal_data#</h4>
	
	<cfif status EQ 'confirmed'>
		<p><img src="#stImageDir.general#/locked.gif" alt=""/> #request.content.profile_verified#</p>
	</cfif>
	
	<cfif session.userid EQ id OR (session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))>
		<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.profile_edit_personaldata')#" class="link_extended"><!--- TODO: $$$ ---> Pers&ouml;nliche Daten &auml;ndern</a>
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
		<cfif isDate(dt_birthdate)>
			<tr>
				<th>#request.content.birthday#</th>
				<td>#LSDateFormat(dt_birthdate)# (<!--- TODO: $$$ ---> Alter #DateDiff('yyyy',dt_birthdate,now())#)</td>
			</tr>
		</cfif>
		<cfif ListFind('1,2',gender)>
			<tr>
				<th>#request.content.gender#</th>
				<td><cfswitch expression="#gender#">
						<cfcase value="1"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/male.png"/></cfcase>
						<cfcase value="2"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/female.png"/></cfcase>
					</cfswitch></td>
			</tr>
		</cfif>
		<cfif len(language)>
			<tr>
				<th>#request.content.settings_language#</th>
				<td><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/#LCase(ListLast(language,'_'))#.png" alt="#GetLocaleDisplayName(language)#"> #GetLocaleDisplayName(language)#</td>
			</tr>
		</cfif>
		<cfif session.isAdmin AND len(idcardnumber)>
			<tr>
				<th>#request.content.id_card_number#</th>
				<td>#idcardnumber#</td>
			</tr>
		</cfif>
	</table>

	<!--- <h4><!--- TODO: $$$ ---> Messaging</h4>
	
	<cfif session.userid EQ id>
		<a href="#myself##myfusebox.thiscircuit#.userdetails_edit&#session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Messaging Daten &auml;ndern</a>
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
	<cfif session.UserLoggedIn>
		<cfif application.lanshock.oModules.isLoaded('seatplan')>
			<tr>
				<th>#request.content.seat#</th>
				<td><cftry>
						<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#id#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#application.lanshock.oHelper.buildUrl('#stSeat.linkurl#')#">#stSeat.description#</a>
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
			<td><cfif len(dt_lastlogin)>#session.oUser.dateTimeFormat(dt_lastlogin)#<cfelse>#request.content.lastlogin_never#</cfif></td>
		</tr>
		<tr>
			<th>#request.content.registered#</th>
			<td><cfif len(dt_registered)>#session.oUser.dateTimeFormat(dt_registered)#<cfelse>#request.content.registered_notavaible#</cfif></td>
		</tr>
	</cfif>
	<cftry>
	<tr>
		<th>#request.content.comment_posts#</th>
		<td>#post_count#</td>
	</tr>
	<cfcatch></cfcatch>
	</cftry>
</table>

<h4>#request.content.misc#</h4>

<cfif session.userid EQ id OR (session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))>
	<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.profile_edit_settings')#" class="link_extended"><!--- TODO: $$$ ---> Einstellungen &auml;ndern</a>
</cfif>

<table class="vlist">
	<cfif len(homepage)>
		<tr>
			<th>#request.content.homepage#</th>
			<td><a href="#homepage#" target="_blank">#homepage#</a></td>
		</tr>
	</cfif>
	<cfif session.UserLoggedIn>
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
			<td>#application.lanshock.oHelper.ConvertText(signature)#</td>
		</tr>
	</cfif>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">