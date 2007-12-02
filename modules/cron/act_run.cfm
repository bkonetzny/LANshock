<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/cron/act_run.cfm $
$LastChangedDate: 2006-10-23 00:23:08 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 45 $
--->

<cfparam name="attributes.securityhash" default="">
<cfparam name="attributes.cron_id" default="">
<cfparam name="variables.last_tasks" default="0">
<cfset cronstart = now()>

<cfif attributes.securityhash EQ application.lanshock.settings.security.cron_hashkey>
	
	<cfif NOT len(attributes.cron_id)>
		<cfset variables.mode = 'cron'>
		<cfset stOldSessionData = StructNew()>
		<cfloop list="#structKeyList(request.session)#" index="idx">
			<cfset stOldSessionData[idx] = request.session[idx]>
		</cfloop>
		
		<cfscript>
			StructDelete(request.session,'ip_address');
			request.session.userloggedin = true;
			request.session.isadmin = true;
			request.session.urltoken = 'cfid=#request.session.cfid#&cftoken=#request.session.cftoken#';
			qCronlist = objectBreeze.getByWhere('core_cron','active = 1','module ASC, action ASC').getQuery();
		</cfscript>
	<cfelse>
		<cfset variables.mode = 'manual'>
		<cfset qCronlist = objectBreeze.getByWhere('core_cron','id IN (#attributes.cron_id#)','module ASC, action ASC').getQuery()>
	</cfif>
	
	<cfloop query="qCronlist">
		<cfif isCronInTime(run) OR len(attributes.cron_id)>
			<cfset variables.task_time = GetTickCount()>
			<cftry>
				<cfif variables.mode EQ 'cron'>
					<cfhttp url="#application.lanshock.environment.webpathfull##myself##module#.#action#&mode=#variables.mode#&#request.session.urltoken#" useragent="LANshock Cron Service">
				<cfelse>
					<cflocation url="#application.lanshock.environment.webpathfull##myself##module#.#action#&mode=#variables.mode#&#request.session.urltoken#">
				</cfif>
				<cfscript>
					oObCron = objectBreeze.objectCreate("core_cron");
					oObCron.read(id);
					oObCron.setProperty('executions',executions+1);
					oObCron.setProperty('result',trim(cfhttp.filecontent));
					oObCron.setProperty('lastrun_dt',now());
					oObCron.setProperty('lastrun_time',((GetTickCount()-variables.task_time)/1000));
					oObCron.commit();
				</cfscript>
				<cfset variables.last_tasks = variables.last_tasks + 1>
				<cfcatch>
					<cfscript>
						oObCron = objectBreeze.objectCreate("core_cron");
						oObCron.read(id);
						oObCron.setProperty('executions',oObCron.getProperty('executions')+1);
						oObCron.setProperty('result',cfcatch.message);
						oObCron.setProperty('lastrun_dt',now());
						oObCron.setProperty('lastrun_time',((GetTickCount()-variables.task_time)/1000));
						oObCron.commit();
					</cfscript>
				</cfcatch>
			</cftry>
		</cfif>
	</cfloop>
	
	<cfif NOT len(attributes.cron_id)>
		<cfset request.session = stOldSessionData>

		<cfset stModuleConfig.last_dt = cronstart>
		<cfset stModuleConfig.last = (GetTickCount()-request.processtime_part1)/1000>
		<cfset stModuleConfig.last_tasks = variables.last_tasks>
		<cfif stModuleConfig.last GT stModuleConfig.max>
			<cfset stModuleConfig.max = stModuleConfig.last>
			<cfset stModuleConfig.max_dt = stModuleConfig.last_dt>
			<cfset stModuleConfig.max_tasks = variables.last_tasks>
		</cfif>
		<!--- set config --->
		<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="setConfig">
			<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
			<cfinvokeargument name="data" value="#stModuleConfig#">
		</cfinvoke>
	</cfif>
	
	<cfoutput>
	#stModuleConfig.last_tasks# Tasks done @ #now()#
	</cfoutput>
<cfelse>
	<cfoutput>
	Access Denied
	</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="No">