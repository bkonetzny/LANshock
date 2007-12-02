<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_tabledump.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.table" default="">

<cfif len(attributes.table) AND StructKeyExists(application.datasource,attributes.table)>
	<cfquery datasource="#application.lanshock.environment.datasource#" name="qTabledump">
		SELECT *
		FROM #attributes.table#		
	</cfquery>
</cfif>

<cfsetting enablecfoutputonly="No">