<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/mySettings.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<!--- create default config --->
<cfscript>
	stDefaultModuleConfig = StructNew();
	stDefaultModuleConfig.coinsystem = false;
	stDefaultModuleConfig.coinsystem_usercoins = 20;
	stDefaultModuleConfig.groupmaxsignups = true;
</cfscript>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.configmanager')#" method="createConfig" returnvariable="stModuleConfig">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="data" value="#stDefaultModuleConfig#">
	<cfinvokeargument name="version" value="1">
</cfinvoke>

<cfscript>
	function LogN(x,base)
	{
		if(x GT 0) return(log(x)/log(base));
		else return false;
	}

	function ListRandom(list)
	{
		var final_list = '';
		var elements = ListLen(list);

		for(x=1; x LTE elements; x=x+1){
			random_i = RandRange(1, ListLen(list));
			random_val = ListGetAt(list, random_i);
			list = ListDeleteAt(list, random_i);
	
			final_list = ListAppend(final_list, random_val);
		}
	
		return(final_list);
	}

	function calcRemainingTime(starttime)
	{
		var days = '';
		var hours = '';
		var minutes = '';

		days = DateDiff('d',now(),starttime);
		hours = DateDiff('h',now(),starttime) - 24 * DateDiff('d',now(),starttime);
		minutes = DateDiff('n',now(),starttime) - 60 * DateDiff('h',now(),starttime);
		
		if(days GT 0){
			if(days EQ 1) days = 'Morgen, ';
			else days = '#days# Tagen, ';
		}
		else days = '';
		
		return('#request.content.starttime_formatter_startsin# <strong>#days##hours# #request.content.starttime_formatter_hours#</strong> #request.content.starttime_formatter_and# <strong>#minutes# #request.content.starttime_formatter_minutes#</strong>.');
	}

	stGlobalVars = StructNew();
	stGlobalVars.statuslist = 'signup,warmup,playing,done,paused,cancelled';
</cfscript>

<cfset sStorageRules = application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'rules'>

<cfsetting enablecfoutputonly="No">