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
<cfset plugin.ShowLayout = request.ShowLayout>
<cfset plugin.layoutFile = "../templates/#application.lanshock.settings.layout.template#/layoutFooter.cfm">

<cfswitch expression="#plugin.ShowLayout#">

	<!--- Show Full HTML Layout --->
	<cfdefaultcase>

		<!--- Cookie-Detection only if Sites with Layout are requested to exclude Sites like Stylesheets --->
		<cfif StructKeyExists(request,'session') AND StructKeyExists(request.session,'UserLoggedIn') AND NOT request.session.UserLoggedIn>
			<!--- if Cookie exists relocate to Login --->
			<cfif isDefined("cookie.email") AND len(cookie.email) AND isDefined("cookie.password") AND len(cookie.password) AND myfusebox.thiscircuit NEQ "#request.lanshock.settings.modulePrefix.core#user" AND myfusebox.thisfuseaction NEQ "login">
				<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.login&#request.session.UrlToken#" addtoken="false">
			</cfif>
		</cfif>
	
		<cfinclude template="#plugin.layoutFile#">
	
	</cfdefaultcase>

	<!--- Show Only Basic HTML Layout --->
	<cfcase value="basic">
	
		<cfinclude template="../templates/basic.footer.cfm">
	
	</cfcase>

	<!--- Show Only Generated Content --->
	<cfcase value="none">
		<!--- Do Nothing --->
	</cfcase>
</cfswitch>

<cfsetting enablecfoutputonly="No">