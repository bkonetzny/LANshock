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
<cfparam name="attributes.id" default="#request.session.userid#">

<cfif NOT isNumeric(attributes.id)>
	<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.user_not_found&1&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif request.session.isAdmin AND NOT attributes.id EQ request.session.userid>
	<cfset check = UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin')>
</cfif>
	
<cfif request.session.isAdmin>
	<cfset UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin')>
<cfelse>
	<cfset attributes.id = request.session.userid>
</cfif>
	
<cfscript>
	oObUser = objectBreeze.objectCreate("user");
	oObUser.read(attributes.id);
</cfscript>

<cfparam name="attributes.name" default="#oObUser.getProperty('name')#">
<cfparam name="attributes.email" default="#oObUser.getProperty('email')#">
<cfparam name="attributes.password_level" default="#oObUser.getProperty('password_level')#">

<cfif attributes.form_submitted>
	
	<cfinvoke component="user" method="checkEmail" returnvariable="bEmailIsFree">
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="email" value="#attributes.email#">
	</cfinvoke>
	
	<cfinvoke component="user" method="checkUsername" returnvariable="bUsernameIsFree">
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="username" value="#attributes.name#">
	</cfinvoke>

	<cfscript>
		if(attributes.pass1 NEQ attributes.pass2 OR (NOT len(attributes.pass1) AND NOT isNumeric(attributes.id))) ArrayAppend(aError, request.content.password);
		else if(len(attributes.pass1)) attributes.password = attributes.pass1;
		
		if(request.session.isAdmin OR stModuleConfig.userprofile.edit_nickname){
			if(NOT len(attributes.name) OR NOT bUsernameIsFree) ArrayAppend(aError, request.content.name);
		}
		if(request.session.isAdmin OR stModuleConfig.userprofile.edit_personal_data){
			if(NOT len(attributes.email) OR NOT isEmail(attributes.email) OR NOT bEmailIsFree) ArrayAppend(aError, request.content.email);
		}
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfscript>
			oObUser.setProperty("name",attributes.name);
			oObUser.setProperty("email",attributes.email);
			if(len(attributes.pass1)){
				oObUser.setProperty("pwd",LCase(hash(attributes.pass1)));
				oObUser.setProperty("password_level",attributes.password_level);
			}
			oObUser.commit();
		</cfscript>

		<cflocation url="#myself##myfusebox.thiscircuit#.userdetails&id=#attributes.id#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">