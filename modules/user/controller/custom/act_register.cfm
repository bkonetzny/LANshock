<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_register.cfm $
$LastChangedDate: 2007-07-08 13:01:39 +0200 (So, 08 Jul 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 96 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfparam name="attributes.name" default="">
<cfparam name="attributes.email" default="">
<cfparam name="attributes.firstname" default="">
<cfparam name="attributes.lastname" default="">
<cfparam name="attributes.password" default="">
<cfparam name="attributes.dt_birthdate" default="#now()#">
<cfparam name="attributes.gender" default="1">
<cfparam name="attributes.language" default="#request.lanshock.settings.language#">

<cfif NOT len(attributes.language)>
	<cfset attributes.language = request.lanshock.settings.language>
</cfif>
<cfif NOT isDate(attributes.dt_birthdate)>
	<cfset attributes.dt_birthdate = now()>
</cfif>

<cfif attributes.form_submitted>
	
	<cfif isValid("email",attributes.email)>
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.user.model.user')#" method="checkEmail" returnvariable="bEmailIsFree">
			<cfinvokeargument name="email" value="#attributes.email#">
		</cfinvoke>
	</cfif>
	
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.user.model.user')#" method="checkUsername" returnvariable="bUsernameIsFree">
		<cfinvokeargument name="username" value="#attributes.name#">
	</cfinvoke>

	<cfscript>
		if(NOT len(attributes.pass1) OR attributes.pass1 NEQ attributes.pass2)
			ArrayAppend(aError, request.content.password);
		else if(len(attributes.pass1))
			attributes.password = hash(attributes.pass1);
		if(NOT len(attributes.name) OR NOT bUsernameIsFree)
			ArrayAppend(aError, request.content.name);
		if(NOT len(attributes.email) OR NOT isValid("email",attributes.email) OR NOT bEmailIsFree)
			ArrayAppend(aError, request.content.email);
		if(NOT len(attributes.firstname))
			ArrayAppend(aError, request.content.firstname);
		if(NOT len(attributes.lastname))
			ArrayAppend(aError, request.content.lastname);
		if(NOT isDate(attributes.dt_birthdate))
			ArrayAppend(aError, request.content.dt_birthdate);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfset ouser = application.lanshock.oFactory.load('user','reactorRecord')>
		<cfset ouser.setname(attributes.name)>
		<cfset ouser.setemail(attributes.email)>
		<cfset ouser.setpwd(attributes.password)>
		<cfset ouser.setfirstname(attributes.firstname)>
		<cfset ouser.setlastname(attributes.lastname)>
		<cfset ouser.setgender(attributes.gender)>
		<cfset ouser.setstatus('new')>
		<cfset ouser.setdt_birthdate(attributes.dt_birthdate)>
		<cfset ouser.setdt_registered(now())>
		<cfset ouser.setlanguage(attributes.language)>
		<cfset ouser.setlogincount(0)>
		
		<cfset ouser.validate()>
		
		<cfif NOT ouser.hasErrors()>
			<cfset ouser.save()>
			
			<cfloop collection="#cookie#" item="idx">
				<cfcookie name="#idx#" expires="NOW">
			</cfloop>
			
			<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.login&email=#UrlDecode(attributes.email)#')#" addtoken="false">
		</cfif>
	
	</cfif>

</cfif>

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<cfsetting enablecfoutputonly="No">