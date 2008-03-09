<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_cron_dbbackup.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfset stDbBackup = StructNew()>
<cfset sFilename = "core_admin_dbbackup_#DateFormat(now(),'YYYY-MM-DD')#_#TimeFormat(now(),'HH-MM')#.wddx">
<cfset sFile = "#application.lanshock.oRuntime.getEnvironment().sBasePath#storage/secure/logs/#sFilename#.cfm">

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