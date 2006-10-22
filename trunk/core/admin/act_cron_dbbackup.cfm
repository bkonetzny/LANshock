<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stDbBackup = StructNew()>
<cfset sFilename = "core_admin_dbbackup_#DateFormat(now(),'YYYY-MM-DD')#_#TimeFormat(now(),'HH-MM')#.wddx">
<cfset sFile = "#application.lanshock.environment.abspath#logs/#sFilename#.cfm">

<cfloop collection="#application.datasource#" item="idx">

	<cftry>
		<cfset stDbBackup[idx] = objectBreeze.list(idx).getQuery()>
		<cfcatch></cfcatch>
	</cftry>

</cfloop>

<cfwddx action="cfml2wddx" input="#stDbBackup#" output="wddxDbBackup">

<cffile action="write" file="#sFile#" output="#wddxDbBackup#">

<cfif attributes.mode EQ 'manual'>
	<cfheader name="Content-Disposition" value="attachment; filename=#sFilename#">
	<cfcontent file="#sFile#" type="text/plain">
<cfelse>
	<cfoutput>OK</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="No">