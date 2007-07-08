<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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
<cfparam name="attributes.country" default="#listFirst(attributes.language,'_')#">

<cfscript>
	if(NOT len(attributes.language)) attributes.language = request.lanshock.settings.language;
	if(NOT len(attributes.country)) attributes.country = listFirst(attributes.language,'_');
	if(NOT isDate(attributes.dt_birthdate)) attributes.dt_birthdate = now();
</cfscript>

<cfif attributes.form_submitted>
	
	<cfinvoke component="user" method="checkEmail" returnvariable="bEmailIsFree">
		<cfinvokeargument name="email" value="#attributes.email#">
	</cfinvoke>
	
	<cfinvoke component="user" method="checkUsername" returnvariable="bUsernameIsFree">
		<cfinvokeargument name="username" value="#attributes.name#">
	</cfinvoke>

	<cfscript>
		if(attributes.pass1 NEQ attributes.pass2) ArrayAppend(aError, request.content.password);
		else if(len(attributes.pass1)) attributes.password = attributes.pass1;
		if(NOT len(attributes.name) OR NOT bUsernameIsFree)ArrayAppend(aError, request.content.name);
		if(NOT len(attributes.email) OR NOT isEmail(attributes.email) OR NOT bEmailIsFree) ArrayAppend(aError, request.content.email);
		if(NOT len(attributes.firstname)) ArrayAppend(aError, request.content.firstname);
		if(NOT len(attributes.lastname)) ArrayAppend(aError, request.content.lastname);
		if(NOT isDate(attributes.dt_birthdate)) ArrayAppend(aError, request.content.dt_birthdate);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
		
		<cfset attributes.id = 0>

		<cfinvoke component="user" method="setUser" argumentcollection="#attributes#" returnvariable="iUserID">
		
		<cfloop collection="#cookie#" item="idx">
			<cfcookie name="#idx#" expires="NOW">
		</cfloop>
			
		<cflocation url="#myself##myfusebox.thiscircuit#.login&email=#UrlDecode(attributes.email)#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<cfsetting enablecfoutputonly="No">