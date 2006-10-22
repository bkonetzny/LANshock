<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- std vars --->
<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">

<cfparam name="attributes.email" default="">
<cfparam name="attributes.key" default="">

<cfif len(attributes.email) AND len(attributes.key)>
	
	<cfscript>
		sNewPassword = generatePassword(8);
		bSendMail = false;
		
		iPrimaryKey = objectBreeze.getByProperty('user','email',attributes.email).GetQuery().id;

		oObUser = objectBreeze.objectCreate("user");
		oObUser.read(iPrimaryKey);
		if(oObUser.getProperty("reset_password_key") EQ attributes.key){
			oObUser.setProperty("pwd",LCase(hash(sNewPassword)));
			oObUser.setProperty("reset_password_key",'');
			oObUser.commit();
			bSendMail = true;
		}
	</cfscript>
	
	<cfif bSendMail>
		<cfmail to="#attributes.email#" subject="#request.content.password_reset_mail_new_password#" server="#application.lanshock.settings.mailserver.server#" port="#application.lanshock.settings.mailserver.port#" username="#application.lanshock.settings.mailserver.username#" password="#application.lanshock.settings.mailserver.password#" from="#application.lanshock.settings.mailserver.from#">
#request.content.password_reset_mail_new_password_txt# #sNewPassword#
		</cfmail>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.reset_password_done&#request.session.urltoken#" addtoken="false">
	</cfif>

</cfif>

<cfif attributes.form_submitted>
	
	<cfset iPrimaryKey = objectBreeze.getByProperty('user','email',attributes.email).GetQuery().id>

	<cfif isNumeric(iPrimaryKey)>
	
		<cfscript>
			key = hash(attributes.email);

			oObUser = objectBreeze.objectCreate("user");
			oObUser.read(iPrimaryKey);
			oObUser.setProperty("reset_password_key",key);
			oObUser.commit();
		</cfscript>
	
		<cfmail to="#attributes.email#" subject="#request.content.password_reset_mail_reset_password#" server="#application.lanshock.settings.mailserver.server#" port="#application.lanshock.settings.mailserver.port#" username="#application.lanshock.settings.mailserver.username#" password="#application.lanshock.settings.mailserver.password#" from="#application.lanshock.settings.mailserver.from#">
#request.content.password_reset_mail_reset_password_txt#
#application.lanshock.environment.serveraddress##application.lanshock.environment.webpath##myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&email=#attributes.email#&key=#key#
		</cfmail>
		
		<cffile action="append" file="#application.lanshock.environment.abspath#logs/core_user_resetpassword.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] userid_#oObUser.getProperty('id')#, #oObUser.getProperty('email')#, #oObUser.getProperty('name')#">
		
		<cflocation url="#myself##myfusebox.thiscircuit#.reset_password_confirm&#request.session.urltoken#" addtoken="false">

	<cfelse>

		<cfset ArrayAppend(aError, request.content.error_user_notfound)>

	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">