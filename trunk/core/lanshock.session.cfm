<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- Default sessionsettings --->
<cfparam name="session.userLoggedIn" default="false">
<cfparam name="session.userID" default="">
<cfparam name="session.isAdmin" default="false">
<cfparam name="session.rights" default="">
<cfparam name="session.ip_address" default="#cgi.remote_addr#">
<cfparam name="session.lang" default="#UCase(application.lanshock.settings.language)#">
<cfparam name="session.stCustom" default="#StructNew()#"> <!--- struct for custom settings by other modules --->
<cfif isNumeric(session.userID) AND NOT StructKeyExists(session,'oPreferences')>
	<cfset session.oPreferences = CreateObject('component','#request.lanshock.environment.componentpath#core.preferences').init(session.userid)>
</cfif>

<cfscript>
	// timestamp
	session.timestamp = now();

	// switch session language
	if(isdefined("url.newlang")) session.lang = url.newlang;
	if(isdefined("form.newlang")) session.lang = form.newlang;
	
	request.session = session;
</cfscript>

<cfparam name="application.sessions" default="#StructNew()#">
<cfinvoke component="#request.lanshock.environment.componentpath#core.session" method="refreshSessionCache" returnvariable="application.sessions">
	<cfinvokeargument name="cache" value="#application.sessions#">
	<cfinvokeargument name="timeout" value="#application.lanshock.settings.sessionmanagement.timeout#">
</cfinvoke>

<cfscript>
	if(application.lanshock.settings.sessionmanagement.type EQ 'cookie'){
		if(NOT len(UrlSessionFormat(''))) request.session.urltoken = '';
	}
	
	if(application.lanshock.settings.sessionmanagement.type EQ 'force_cookie') request.session.urltoken = '';
	
	request.application.sessions = application.sessions;
</cfscript>

</cfsilent><cfsetting enablecfoutputonly="No">