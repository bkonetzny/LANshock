<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_profile_edit_logindata.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfset oUser = application.lanshock.oFactory.load('user','reactorRecord')>
<cfset oUser.setId(session.userid)>
<cfset oUser.load()>

<cfparam name="attributes.name" default="#oUser.getName()#">
<cfparam name="attributes.email" default="#oUser.getEmail()#">
<cfset attributes.status = oUser.getStatus()>

<cfif attributes.form_submitted>
	
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.user.model.user')#" method="checkEmail" returnvariable="bEmailIsFree">
		<cfinvokeargument name="id" value="#session.userid#">
		<cfinvokeargument name="email" value="#attributes.email#">
	</cfinvoke>
	
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.user.model.user')#" method="checkUsername" returnvariable="bUsernameIsFree">
		<cfinvokeargument name="id" value="#session.userid#">
		<cfinvokeargument name="username" value="#attributes.name#">
	</cfinvoke>

	<cfscript>
		if(attributes.pass1 NEQ attributes.pass2) ArrayAppend(aError, request.content.password);
		else if(len(attributes.pass1)) attributes.password = attributes.pass1;

		if(stModuleConfig.userprofile.edit_nickname){
			if(NOT len(attributes.name) OR NOT bUsernameIsFree) ArrayAppend(aError, request.content.name);
		}

		if(NOT len(attributes.email) OR NOT isValid("email",attributes.email) OR NOT bEmailIsFree) ArrayAppend(aError, request.content.email);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfif stModuleConfig.userprofile.edit_nickname>
			<cfset oUser.setName(attributes.name)>
		</cfif>
		<cfset oUser.setEmail(attributes.email)>
		<cfif len(attributes.pass1)>
			<cfset oUser.setPwd(hash(attributes.pass1))>
		</cfif>
		<cfset oUser.save()>

		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#" addtoken="false">
	
	</cfif>

</cfif>

<cfset bLockEditing = false>
<cfif NOT stModuleConfig.userprofile.edit_nickname AND attributes.status EQ 'confirmed'>
	<cfset bLockEditing = true>
	<cfset ArrayAppend(aError,'<img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/lock.png" alt=""/> Username is locked.')>
</cfif>

<cfsetting enablecfoutputonly="No">