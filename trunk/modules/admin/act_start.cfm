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
<cfparam name="attributes.form_submitted_j2ee_instance" default="false">
<cfparam name="attributes.cb_j2ee_instance" default="false">

<cftry>
	<cfset is_j2ee_instance = true>
	<cfset oJRun = CreateObject("java", "jrunx.kernel.JRun")>
	<cfcatch>
		<cfset is_j2ee_instance = false>
	</cfcatch>
</cftry>

<cfif attributes.form_submitted_j2ee_instance AND attributes.cb_j2ee_instance AND is_j2ee_instance>

	<cfset oJRun.restart(oJRun.getServerName())>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#" addtoken="false">

</cfif>

<cfif attributes.form_submitted_application AND attributes.cb_application>

	<cfset StructDelete(application,'lanshock')>
	<cfset myfusebox.getApplication().reload('','',myfusebox)>

	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" addtoken="false">

</cfif>

<cfset oSystem = CreateObject("java", "java.lang.System")>
<cfset oStreamReader = CreateObject("java", "java.io.InputStreamReader")>
<cfset oStreamReader.init(oSystem.in)>
<cfset oDbDriver = CreateObject("java", "com.mysql.jdbc.Driver")>

<cfinvoke component="datasource" method="getVersionInformation" returnvariable="sDbVersion">

<cfset sServerSoftware = cgi.server_software>
<cfset sServerSoftware = rereplacenocase(sServerSoftware,'( \()','&nbsp;(','ALL')>
<cfset sServerSoftware = rereplacenocase(sServerSoftware,' ','<br>','ALL')>

<cfsetting enablecfoutputonly="No">