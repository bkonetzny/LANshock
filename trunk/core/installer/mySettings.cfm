<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif NOT listFind('de_DE,en_US',request.session.lang)>
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&newlang=en_US&#request.session.urltoken#" addtoken="false">
</cfif>

<!--- remove after 10 minutes of inactivity --->
<cfscript>
	if(StructKeyExists(request.session,'lanshock_installer') AND DateDiff('N',request.session.lanshock_installer,now()) LTE 10) request.session.lanshock_installer = now();
	else if(StructKeyExists(request.session,'lanshock_installer')) StructDelete(request.session,'lanshock_installer');
</cfscript>

<cfscript>
	sNextAction = "";

	if(myfusebox.thisfuseaction NEQ 'logout'){

		if(NOT request.lanshock.config.complete) sNextAction = "config";

	}
</cfscript>

<cfif myfusebox.thisfuseaction EQ "main">
	<cflocation url="#myself##myfusebox.thiscircuit#.config&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfif NOT request.lanshock.config.avaible>
	<cfif myfusebox.thisfuseaction NEQ "setpassword">
		<cflocation url="#myself##myfusebox.thiscircuit#.setpassword&#request.session.UrlToken#" addtoken="false">
	</cfif>
<cfelse>
	<cfif NOT StructKeyExists(request.session,'lanshock_installer') AND myfusebox.thisfuseaction NEQ "login">
		<cflocation url="#myself##myfusebox.thiscircuit#.login&#request.session.UrlToken#" addtoken="false">
	<cfelseif StructKeyExists(request.session,'lanshock_installer')>
		<cfif myfusebox.thisfuseaction NEQ "setpassword" AND sNextAction EQ "setpassword">
			<cflocation url="#myself##myfusebox.thiscircuit#.setpassword&#request.session.UrlToken#" addtoken="false">
		<cfelseif myfusebox.thisfuseaction NEQ "login" AND sNextAction EQ "login">
			<cflocation url="#myself##myfusebox.thiscircuit#.login&#request.session.UrlToken#" addtoken="false">
		<cfelseif myfusebox.thisfuseaction NEQ "config" AND sNextAction EQ "config">
			<cflocation url="#myself##myfusebox.thiscircuit#.config&#request.session.UrlToken#" addtoken="false">
		<cfelseif myfusebox.thisfuseaction EQ "setpassword" AND request.lanshock.config.avaible>
			<cflocation url="#myself##myfusebox.thiscircuit#.config&#request.session.UrlToken#" addtoken="false">
		<cfelseif myfusebox.thisfuseaction EQ "main">
			<cflocation url="#myself##myfusebox.thiscircuit#.config&#request.session.UrlToken#" addtoken="false">
		</cfif>
	</cfif>
</cfif>

<!--- get all avaible datasources --->
<cftry>
	<cfobject type="java" action="create" name="factory" class="coldfusion.server.ServiceFactory">
	<cfset lDatasources = StructKeyList(factory.getDataSourceService().getdatasources())>
	<cfcatch>
		<cfset lDatasources = ''>
	</cfcatch>
</cftry>

<cfset lDatasourcesTypes = 'mysql'>

<cfsetting enablecfoutputonly="No">