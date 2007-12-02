<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/cron/mySettings.cfm $
$LastChangedDate: 2006-10-23 00:23:08 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 45 $
--->

<!--- create default config --->
<cfscript>
	stDefaultModuleConfig = StructNew();
	stDefaultModuleConfig.last = "";
	stDefaultModuleConfig.last_dt = "";
	stDefaultModuleConfig.last_tasks = 0;
	stDefaultModuleConfig.max = "";
	stDefaultModuleConfig.max_dt = "";
	stDefaultModuleConfig.max_tasks = 0;
</cfscript>

<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="createConfig" returnvariable="stModuleConfig">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="data" value="#stDefaultModuleConfig#">
	<cfinvokeargument name="version" value="1">
</cfinvoke>

<cffunction name="isCronInTime" output="false" returntype="boolean">
	<cfargument name="crontime" type="string" required="true">
	<cfargument name="now" type="string" required="false" default="#now()#">
	
	<cfscript>
		var stLocal = StructNew();
		stLocal.bReturn = true;
		stLocal.stCrontime = parseCronTime(arguments.crontime);
	</cfscript>
	
	<cfscript>
		if(NOT listFind(stLocal.stCrontime.lMinutes,minute(arguments.now))) stLocal.bReturn = false;
		if(NOT listFind(stLocal.stCrontime.lHours,hour(arguments.now))) stLocal.bReturn = false;
		if(NOT listFind(stLocal.stCrontime.lDays,day(arguments.now))) stLocal.bReturn = false;
		if(NOT listFind(stLocal.stCrontime.lMonths,month(arguments.now))) stLocal.bReturn = false;
		if(NOT listFind(stLocal.stCrontime.lWeekdays,DayOfWeek(arguments.now))) stLocal.bReturn = false;
	</cfscript>
	
	<cfreturn stLocal.bReturn>
</cffunction>

<cffunction name="parseCronTime" output="false" returntype="struct">
	<cfargument name="crontime" type="string" required="true">
	
	<cfscript>
		var stLocal = StructNew();
		stLocal.stReturn = StructNew();
		stLocal.stReturn.lMinutes = '';
		stLocal.stReturn.lHours = '';
		stLocal.stReturn.lDays = '';
		stLocal.stReturn.lMonths = '';
		stLocal.stReturn.lWeekdays = '';
	</cfscript>
	
	<cfif listLen(arguments.crontime,' ') EQ 5>
		<cfscript>
			stLocal.stRaw = StructNew();
			stLocal.stRaw.lMinutes = listGetAt(arguments.crontime,1,' ');
			stLocal.stRaw.lHours = listGetAt(arguments.crontime,2,' ');
			stLocal.stRaw.lDays = listGetAt(arguments.crontime,3,' ');
			stLocal.stRaw.lMonths = listGetAt(arguments.crontime,4,' ');
			stLocal.stRaw.lWeekdays = listGetAt(arguments.crontime,5,' ');

			stLocal.stReturn.lMinutes = getFullValueList(stLocal.stRaw.lMinutes,0,59);
			stLocal.stReturn.lHours = getFullValueList(stLocal.stRaw.lHours,0,23);
			stLocal.stReturn.lDays = getFullValueList(stLocal.stRaw.lDays,1,31);
			stLocal.stReturn.lMonths = getFullValueList(stLocal.stRaw.lMonths,1,12);
			stLocal.stReturn.lWeekdays = getFullValueList(stLocal.stRaw.lWeekdays,0,7);
		</cfscript>
	</cfif>
	
	<cfreturn stLocal.stReturn>
</cffunction>

<cffunction name="getFullValueList" output="false" returntype="string">
	<cfargument name="list" type="string" required="true">
	<cfargument name="min" type="numeric" required="true">
	<cfargument name="max" type="numeric" required="true">
	
	<cfscript>
		var stLocal = StructNew();
		stLocal.sReturn = '';
	</cfscript>
	
	<cfloop list="#arguments.list#" index="stLocal.idx">
		<cfif isNumeric(stLocal.idx)>
			<cfset stLocal.sReturn = ListAppend(stLocal.sReturn,stLocal.idx)>
		<cfelseif listLen(stLocal.idx,'-') EQ 2>
			<cfloop from="#listFirst(stLocal.idx,'-')#" to="#listLast(stLocal.idx,'-')#" index="stLocal.idx2">
				<cfset stLocal.sReturn = ListAppend(stLocal.sReturn,stLocal.idx2)>
			</cfloop>
		<cfelseif listLen(stLocal.idx,'/') EQ 2 AND listFirst(stLocal.idx,'/') EQ '*'>
			<cfset stLocal.sReturn = 0>
			<cfset stLocal.nextValue = 0>
			<cfloop condition="#stLocal.nextValue# LTE #arguments.max#">
				<cfset stLocal.sReturn = ListAppend(stLocal.sReturn,listLast(stLocal.sReturn)+listLast(stLocal.idx,'/'))>
				<cfset stLocal.nextValue = listLast(stLocal.sReturn)+listLast(stLocal.idx,'/')>
			</cfloop>
		<cfelseif stLocal.idx EQ '*'>
			<cfloop from="#arguments.min#" to="#arguments.max#" index="stLocal.idx2">
				<cfset stLocal.sReturn = ListAppend(stLocal.sReturn,stLocal.idx2)>
			</cfloop>
		</cfif>
	</cfloop>
	
	<cfreturn stLocal.sReturn>
</cffunction>

<cfsetting enablecfoutputonly="No">