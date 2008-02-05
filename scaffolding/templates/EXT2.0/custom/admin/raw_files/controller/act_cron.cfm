<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_cron.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.switchtask" default="">

<cfif isNumeric(attributes.switchtask)>
	<cfscript>
		oObCron = objectBreeze.objectCreate("core_cron");
		oObCron.read(attributes.switchtask);
		oObCron.setProperty('active',abs(oObCron.getProperty('active')-1));
		oObCron.commit();
	</cfscript>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.urltoken#" addtoken="false">
</cfif>

<cfscript>
	qCronlist = objectBreeze.list('core_cron', 'module ASC, action ASC').getQuery();
</cfscript>

<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="getConfig" returnvariable="stCronConfig">
	<cfinvokeargument name="module" value="#application.lanshock.settings.modulePrefix.core#cron">
</cfinvoke>

<cfsetting enablecfoutputonly="No">