<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.table" default="">

<cfif len(attributes.table) AND StructKeyExists(application.datasource,attributes.table)>
	<cfquery datasource="#application.lanshock.environment.datasource#" name="qTabledump">
		SELECT *
		FROM #attributes.table#		
	</cfquery>
</cfif>

<cfsetting enablecfoutputonly="No">