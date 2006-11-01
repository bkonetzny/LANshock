<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">

<cfif attributes.form_submitted>

	<cfswitch expression="#attributes.type#">
		<cfcase value="wwcl">
			<cfinclude template="act_export_generate_wwcl.cfm">
		</cfcase>
	</cfswitch>
</cfif>

<cfinvoke component="tournaments" method="getTournaments" returnvariable="qTournaments">

<cfscript>
	stExportData = StructNew();
	stExportData.WWCL = StructNew();
	stExportData.NGL = StructNew();
</cfscript>

<cfinclude template="act_export_wwcl.cfm">

<cfsetting enablecfoutputonly="No">