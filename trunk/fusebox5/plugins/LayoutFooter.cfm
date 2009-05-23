<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset plugin = myFusebox.plugins[myFusebox.thisPlugin]>
<cfset plugin.ShowLayout = request.ShowLayout>
<cfset plugin.layoutFile = '../../templates/#application.lanshock.settings.layout.template#/layoutFooter.cfm'>

<cfswitch expression="#plugin.ShowLayout#">
	<!--- Show Only Basic HTML Layout --->
	<cfcase value="basic">
		<cfinclude template="../../templates/basic.footer.cfm">
	</cfcase>

	<!--- Show Only Generated Content --->
	<cfcase value="none">
		<!--- Do Nothing --->
	</cfcase>

	<!--- Show Full HTML Layout --->
	<cfdefaultcase>
		<cfinclude template="#plugin.layoutFile#">
	</cfdefaultcase>
</cfswitch>

<cfsetting enablecfoutputonly="false">