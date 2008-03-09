<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_start.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted_application" default="false">
<cfparam name="attributes.cb_application" default="false">

<cfif attributes.form_submitted_application AND attributes.cb_application>
	
	<cfinvoke component="#application.lanshock.oApplication#" method="reloadApplication"/>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" addtoken="false">

</cfif>

<cfset oSystem = CreateObject("java", "java.lang.System")>
<cfset oRuntime = CreateObject("java", "java.lang.Runtime")>
<cfset oStreamReader = CreateObject("java", "java.io.InputStreamReader")>
<cfset oStreamReader.init(oSystem.in)>
<cfset oDbDriver = CreateObject("java", "com.mysql.jdbc.Driver")>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.datasource')#" method="getVersionInformation" returnvariable="sDbVersion"/>

<cfinvoke component="#application.lanshock.oRuntime#" method="getVersion" returnvariable="stVersion"/>

<cfset sServerSoftware = cgi.server_software>
<cfset sServerSoftware = rereplacenocase(sServerSoftware,'( \()','&nbsp;(','ALL')>
<cfset sServerSoftware = rereplacenocase(sServerSoftware,' ','<br>','ALL')>

<cfsetting enablecfoutputonly="No">