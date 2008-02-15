<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset plugin = myFusebox.plugins[myFusebox.thisPlugin]>
<cfset plugin.ShowLayout = 'full'>
<cfset plugin.layoutFile = '../../templates/#application.lanshock.settings.layout.template#/layoutHeader.cfm'>

<cfset plugin.lanshock = myfusebox.getCurrentFuseaction().getCustomAttributes('lanshock')>
<cfif StructKeyExists(plugin.lanshock,'showlayout')>
	<cfset plugin.ShowLayout = plugin.lanshock.showlayout>
</cfif>
<cfset request.ShowLayout = plugin.ShowLayout>

<cfswitch expression="#plugin.ShowLayout#">
	<!--- Show Only Basic HTML Layout --->
	<cfcase value="basic">
		<cfinclude template="../../templates/basic.header.cfm">
	</cfcase>

	<!--- Show Only Generated Content --->
	<cfcase value="none">
		<!--- Do Nothing --->
	</cfcase>

	<!--- Show Full HTML Layout --->
	<cfdefaultcase>
		<!--- Cookie-Detection only if Sites with Layout are requested to exclude Sites like Stylesheets --->
		<cfif NOT session.UserLoggedIn>
			<!--- if Cookie exists relocate to Login --->
			<cfif isDefined("cookie.email") AND len(cookie.email) AND isDefined("cookie.password") AND len(cookie.password) AND myfusebox.thiscircuit NEQ "c_user" AND myfusebox.thisfuseaction NEQ "login">
				<cflocation url="#myself#c_user.login&#session.UrlToken#" addtoken="false">
			</cfif>
		</cfif>
		<cfinclude template="#plugin.layoutFile#">
	</cfdefaultcase>
</cfswitch>

<cfsetting enablecfoutputonly="No">