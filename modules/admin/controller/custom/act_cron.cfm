<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.switchtask" default="">

<cfif isNumeric(attributes.switchtask)>
	<cfscript>
		oObCron = objectBreeze.objectCreate("core_cron");
		oObCron.read(attributes.switchtask);
		oObCron.setProperty('active',abs(oObCron.getProperty('active')-1));
		oObCron.commit();
	</cfscript>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" addtoken="false">
</cfif>

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "module|ASC">

<cfinvoke component="#application.lanshock.oFactory.load('core_cron','reactorGateway')#" method="getRecords" returnvariable="qCronlist">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.configmanager')#" method="getConfig" returnvariable="stCronConfig">
	<cfinvokeargument name="module" value="cron">
</cfinvoke>

<cfsetting enablecfoutputonly="No">