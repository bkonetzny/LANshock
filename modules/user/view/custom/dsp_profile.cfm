<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_profile.cfm $
$LastChangedDate: 2007-07-07 16:11:30 +0200 (Sa, 07 Jul 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 91 $
--->

<cfoutput>
<h3>#request.content.profile#</h3>

<cfif session.oUser.isLoggedIn() AND session.oUser.getDataValue('userid') NEQ qUserData.id>
	<h4>#request.content.options_headline#</h4>
	
	<ul class="options">
		<li><a href="javascript:SendMsg(#qUserData.id#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt="#request.content.user_send_message#"> #request.content.user_send_message#</a></li>
		<li><a href="#application.lanshock.oHelper.buildUrl('mail.buddy_add&buddy_id=#qUserData.id#')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/user_add.png" alt="#request.content.user_add_to_buddylist#"> #request.content.user_add_to_buddylist#</a></li>
	</ul>
</cfif>

<h4>#request.content.headline_userdata#</h4>

<cfif session.oUser.getDataValue('userid') EQ qUserData.id>
	<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.profile_edit_logindata')#"><!--- TODO: $$$ ---> Logindaten und Passwort &auml;ndern</a>
</cfif>

<table class="vlist">
	<cfif session.oUser.isLoggedIn()>
		<tr>
			<th>#request.content.id#</th>
			<td>#qUserData.id#</td>
			<th>#request.content.avatar#</th>
		</tr>
	</cfif>
	<tr>
		<th>#request.content.name#</th>
		<td>#qUserData.name#</td>
		<td<cfif session.oUser.isLoggedIn()> rowspan="4"</cfif> align="center">#application.lanshock.oHelper.UserShowAvatar(qUserData.id)#
			<cfif (session.userid EQ qUserData.id OR (session.isAdmin AND UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin','boolean'))) AND application.lanshock.settings.layout.avatar.mode EQ 'lanshock'>
				<br><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.profile_edit_avatar')#"><!--- TODO: $$$ ---> Avatar &auml;ndern</a>
			</cfif>
		</td>
	</tr>
	<cfif session.oUser.isLoggedIn()>
		<tr>
			<th>#request.content.email#</th>
			<td><a href="mailto:#qUserData.email#">#qUserData.email#</a></td>
		</tr>
	</cfif>
</table>

<cfif session.oUser.isLoggedIn()>
	<h4>#request.content.personal_data#</h4>
	
	<cfif qUserData.status EQ 'confirmed'>
		<p><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/lock.png" alt="#request.content.profile_verified#" title="#request.content.profile_verified#"/> #request.content.profile_verified#</p>
	</cfif>
	
	<cfif session.oUser.getDataValue('userid') EQ qUserData.id>
		<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.profile_edit_personaldata')#"><!--- TODO: $$$ ---> Pers&ouml;nliche Daten &auml;ndern</a>
	</cfif>
	
	<table class="vlist">
		<tr>
			<th>#request.content.firstname#</th>
			<td>#qUserData.firstname#</td>
		</tr>
		<tr>
			<th>#request.content.lastname#</th>
			<td>#qUserData.lastname#</td>
		</tr>
		<cfif isDate(qUserData.dt_birthdate)>
			<tr>
				<th>#request.content.birthday#</th>
				<td>#LSDateFormat(qUserData.dt_birthdate)# (<!--- TODO: $$$ --->Alter #DateDiff('yyyy',qUserData.dt_birthdate,now())#)</td>
			</tr>
		</cfif>
		<cfif ListFind('1,0',qUserData.gender)>
			<tr>
				<th>#request.content.gender#</th>
				<td><cfswitch expression="#qUserData.gender#">
						<cfcase value="1"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/male.png"/></cfcase>
						<cfcase value="0"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/female.png"/></cfcase>
					</cfswitch></td>
			</tr>
		</cfif>
		<cfif len(qUserData.language)>
			<tr>
				<th>#request.content.settings_language#</th>
				<td><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/#LCase(ListLast(qUserData.language,'_'))#.png" alt="#GetLocaleDisplayName(qUserData.language)#"> #GetLocaleDisplayName(qUserData.language)#</td>
			</tr>
		</cfif>
	</table>

	<!--- <h4><!--- TODO: $$$ ---> Messaging</h4>
	
	<cfif session.oUser.getDataValue('userid') EQ id>
		<a href="#myself##myfusebox.thiscircuit#.userdetails_edit&#session.UrlToken#"><!--- TODO: $$$ ---> Messaging Daten &auml;ndern</a>
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
	<cfif session.oUser.isLoggedIn()>
		<cfif application.lanshock.oModules.isLoaded('seatplan')>
			<tr>
				<th>#request.content.seat#</th>
				<td><cftry>
						<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#qUserData.id#">
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
			<td>#qUserData.logincount#</td>
		</tr>
		<cfif len(qUserData.dt_lastlogin)>
			<tr>
				<th>#request.content.lastlogin#</th>
				<td>#session.oUser.dateTimeFormat(qUserData.dt_lastlogin)#</td>
			</tr>
		</cfif>
		<tr>
			<th>#request.content.registered#</th>
			<td>#session.oUser.dateTimeFormat(qUserData.dt_registered)#</td>
		</tr>
	</cfif>
	<tr>
		<th>#request.content.comment_posts#</th>
		<td>#iPostCount#</td>
	</tr>
</table>

<h4>#request.content.misc#</h4>
<cfif session.oUser.getDataValue('userid') EQ qUserData.id>
	<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.profile_edit_settings')#"><!--- TODO: $$$ ---> Einstellungen &auml;ndern</a>
</cfif>

<table class="vlist">
	<cfif len(qUserData.homepage)>
		<tr>
			<th>#request.content.homepage#</th>
			<td><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/world.png" alt=""> <a href="#qUserData.homepage#" target="_blank">#qUserData.homepage#</a></td>
		</tr>
	</cfif>
	<cfif session.oUser.isLoggedIn() AND len(qUserData.geo_latlong)>
		<tr>
			<th>Position</th>
			<td>#qUserData.geo_latlong#</td>
		</tr>
		<tr>
			<th>Position</th>
			<td><div id="google_map" style="width: 100%; height: 300px;"></div>
				<script type="text/javascript" src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=#application.lanshock.settings.google_maps_key#"></script>
				<script type="text/javascript">
					<!--
					$(document).ready(function() {
						if (GBrowserIsCompatible()) {
							var map = new GMap2(document.getElementById("google_map"));
							map.addControl(new GLargeMapControl());
							map.addControl(new GMapTypeControl());
							map.setCenter(new GLatLng(#qUserData.geo_latlong#),6,G_HYBRID_MAP);
							map.addOverlay(new GMarker(new GLatLng(#qUserData.geo_latlong#)));
						}
					});
					//-->
				</script>
			</td>
		</tr>
	</cfif>
	<cfif len(qUserData.signature)>
		<tr>
			<th>#request.content.signature#</th>
			<td>#application.lanshock.oHelper.ConvertText(qUserData.signature)#</td>
		</tr>
	</cfif>
</table>

<cfif session.oUser.checkPermissions(area="user",module="admin")>
	<form action="#application.lanshock.oHelper.buildUrl('admin.usernotice_save')#" class="uniForm" method="post">
		<div class="hidden">
			<input type="hidden" name="userid" value="#qUserData.id#"/>
		</div>
							
		<fieldset class="inlineLabels">
			<legend>#request.content.admin_options#</legend>
			
			<div class="ctrlHolder">
				<label for="notice">#request.content.usernotice#</label>
				<textarea name="notice" id="notice">#qUserData.internal_note#</textarea>
			</div>

		</fieldset>
		<div class="buttonHolder">
			<button type="submit" class="submitButton">#request.content.form_save#</button>
		</div>
	</form>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">