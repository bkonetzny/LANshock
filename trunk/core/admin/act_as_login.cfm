<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<CFlock scope="APPLICATION" timeout="30" type="EXCLUSIVE">  
	<CFset StructInsert(application.aslogin,"#attributes.user_id#",true,true)>
</CFLOCK>

<cfcookie name="email" expires="NOW">
<cfcookie name="password" expires="NOW">

<cfinvoke component="#request.lanshock.environment.componentpath#core.user.user" method="updateHistory">
	<cfinvokeargument name="userid" value="#attributes.user_id#">
	<cfinvokeargument name="status" value="status_loggedinas">
</cfinvoke>

<cfquery datasource="#application.lanshock.environment.datasource#" name="qUserdata">
	SELECT pwd, email
	FROM user
	WHERE id = <CFqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.user_id#">
</cfquery>

<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.login&user_id=#attributes.user_id#&as_login=true" addtoken="false">

<cfsetting enablecfoutputonly="No">