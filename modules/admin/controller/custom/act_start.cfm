<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/admin/raw_files/controller/custom/act_start.cfm $
$LastChangedDate: 2008-05-12 14:49:49 +0200 (Mo, 12 Mai 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 298 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.reload_type" default="">

<cfif attributes.form_submitted>
	<cfswitch expression="#attributes.reload_type#">
		<cfcase value="cache">
			<cfset application.lanshock.oCache.dropAll()>
		</cfcase>
		<cfcase value="application">
			<cfset application.lanshock.oApplication.reloadApplication()>
		</cfcase>
	</cfswitch>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" addtoken="false">
</cfif>

<cfset oSystem = CreateObject("java", "java.lang.System")>
<cfset sJavaVersion = oSystem.getProperty("java.version")>

<cfset oRuntime = CreateObject("java", "java.lang.Runtime")>
<cfset oStreamReader = CreateObject("java", "java.io.InputStreamReader")>
<cfset oStreamReader.init(oSystem.in)>
<cfset oDbDriver = CreateObject("java", "com.mysql.jdbc.Driver")>

<cfif ListGetAt(sJavaVersion,2,'.') GTE 6>
	<cfset oFile = CreateObject("java", "java.io.File")>
	<cfset oManagementFactory = CreateObject("java", "java.lang.management.ManagementFactory")>
	<cfset oDate = CreateObject("java", "java.util.Date")>
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.datasource')#" method="getVersionInformation" returnvariable="sDbVersion"/>

<cfset stVersion = application.lanshock.oRuntime.getVersion()>

<cfset sServerSoftware = cgi.server_software>
<cfset sServerSoftware = rereplacenocase(sServerSoftware,'( \()','&nbsp;(','ALL')>
<cfset sServerSoftware = rereplacenocase(sServerSoftware,' ','<br>','ALL')>

<cfsetting enablecfoutputonly="No">