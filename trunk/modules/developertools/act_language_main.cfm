<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.directory" default="core/_utils/">
<cfparam name="attributes.selection1" default="#ListFirst(attributes.directory,'/')#">
<cfparam name="attributes.selection2" default="#ListLast(attributes.directory,'/')#">

<cfdirectory action="list" directory="#application.lanshock.environment.abspath#core/" name="qCore">
<cfdirectory action="list" directory="#application.lanshock.environment.abspath#modules/" name="qMod">
<cfdirectory action="list" directory="#application.lanshock.environment.abspath#templates/" name="qTemplates">

<cfscript>
	stDirs = StructNew();
	stDirs['core'] = StructNew();
	stDirs['modules'] = StructNew();
	stDirs['templates'] = StructNew();
	
	qDirs = QueryNew('name,dir');
</cfscript>

<cfloop query="qCore">
	<cfscript>
		if(type EQ 'dir'){
			QueryAddRow(qDirs,1);
			QuerySetCell(qDirs,'name',name,qDirs.recordcount);
			QuerySetCell(qDirs,'dir','core',qDirs.recordcount);
		}
	</cfscript>
</cfloop>

<cfloop query="qMod">
	<cfscript>
		if(type EQ 'dir'){
			QueryAddRow(qDirs,1);
			QuerySetCell(qDirs,'name',name,qDirs.recordcount);
			QuerySetCell(qDirs,'dir','modules',qDirs.recordcount);
		}
	</cfscript>
</cfloop>

<cfloop query="qTemplates">
	<cfscript>
		if(type EQ 'dir'){
			QueryAddRow(qDirs,1);
			QuerySetCell(qDirs,'name',name,qDirs.recordcount);
			QuerySetCell(qDirs,'dir','templates',qDirs.recordcount);
		}
	</cfscript>
</cfloop>



<cfloop query="qDirs">
	<cfscript>
		dirName = name;
		currentDir = dir;
		stDirs[currentDir][dirName] = StructNew();
		fileDefault = '#application.lanshock.environment.abspath##dir#/#name#/lang.default';
		langDefaults = '';
	</cfscript>
	<cfif fileExists(fileDefault)>
		<cffile action="read" file="#fileDefault#" variable="langDefaults">
	</cfif>
	<cfset langDefaults = trim(langDefaults)>
	<cfdirectory action="list" directory="#application.lanshock.environment.abspath##currentDir#/#name#/" name="qData" filter="*.properties" sort="name ASC">
	<cfloop query="qData">
		<cfif ListFirst(name,'.') EQ 'lang' AND ListLen(name,'.') EQ 3>
			<cfscript>
				stDirs[currentDir][dirName][name] = StructNew();
				stDirs[currentDir][dirName][name].size = size;
				stDirs[currentDir][dirName][name].date = datelastmodified;
				stDirs[currentDir][dirName][name].type = 'properties';
				if(name EQ langDefaults) stDirs[currentDir][dirName][name]['default'] = true;
				else stDirs[currentDir][dirName][name]['default'] = false;
			</cfscript>
		</cfif>
	</cfloop>
</cfloop>

<cfsetting enablecfoutputonly="No">