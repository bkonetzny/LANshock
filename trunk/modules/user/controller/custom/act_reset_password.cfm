<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_reset_password.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<!--- std vars --->
<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">

<cfparam name="attributes.email" default="">
<cfparam name="attributes.key" default="">

<cfif len(attributes.email) AND len(attributes.key)>
	
	<cfset bSendMail = false>

	<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getByFields" returnvariable="qUser">
		<cfinvokeargument name="email" value="#attributes.email#">
	</cfinvoke>
	
	<cfset oUser = application.lanshock.oFactory.load('user','reactorRecord')>
	<cfset oUser.setId(qUser.id)>
	<cfset oUser.load()>
	
	<cfif oUser.getReset_password_key() EQ attributes.key>
		<cfset sNewPassword = generatePassword(8)>
		<cfset oUser.setPwd(hash(sNewPassword))>
		<cfset oUser.setReset_password_key('')>
		<cfset oUser.save()>
		<cfset bSendMail = true>
	</cfif>
	
	<cfif bSendMail>
		<cfmail to="#attributes.email#" subject="#request.content.password_reset_mail_new_password#" server="#application.lanshock.settings.mailserver.server#" port="#application.lanshock.settings.mailserver.port#" username="#application.lanshock.settings.mailserver.username#" password="#application.lanshock.settings.mailserver.password#" from="#application.lanshock.settings.mailserver.from#">
#request.content.password_reset_mail_new_password_txt# #sNewPassword#
		</cfmail>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.reset_password_done')#" addtoken="false">
	</cfif>

</cfif>

<cfif attributes.form_submitted>

	<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getByFields" returnvariable="qUser">
		<cfinvokeargument name="email" value="#attributes.email#">
	</cfinvoke>
	
	<cfif qUser.recordcount>
		
		<cfset key = hash(attributes.email)>
	
		<cfset oUser = application.lanshock.oFactory.load('user','reactorRecord')>
		<cfset oUser.setId(qUser.id)>
		<cfset oUser.load()>
		<cfset oUser.setReset_password_key(key)>
		<cfset oUser.save()>
	
		<cfmail to="#attributes.email#" subject="#request.content.password_reset_mail_reset_password#" server="#application.lanshock.settings.mailserver.server#" port="#application.lanshock.settings.mailserver.port#" username="#application.lanshock.settings.mailserver.username#" password="#application.lanshock.settings.mailserver.password#" from="#application.lanshock.settings.mailserver.from#">
#request.content.password_reset_mail_reset_password_txt#
#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&email=#attributes.email#&key=#key#',true)#
		</cfmail>
		
		<cfset application.lanshock.oLogger.writeLog('modules.user.reset_password','E-Mail: "#oUser.getEmail()#" | ID: "#oUser.getId()#" | Name: "#oUser.getName()#"','warn')>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.reset_password_confirm')#" addtoken="false">

	<cfelse>

		<cfset ArrayAppend(aError, request.content.error_user_notfound)>

	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">