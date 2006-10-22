<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
	<div class="headline">#request.content.serverdata#</div>

	<div class="headline2">#request.content.installed_versions#</div>

	<table class="vlist">
		<tr>
			<th>#request.content.lanshock_version#</th>
			<td>#application.lanshock.settings.version# (#application.lanshock.settings.version_build#)</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> Applicationname</th>
			<td>#application.applicationName#</td>
		</tr>
		<tr>
			<th>#request.content.path_abs#</th>
			<td>#request.lanshock.environment.abspath#</td>
		</tr>
		<tr>
			<th>#request.content.path_web#</th>
			<td>#request.lanshock.environment.webpath#</td>
		</tr>
		<tr>
			<th>#request.content.component_path#</th>
			<td>#request.lanshock.environment.componentpath#</td>
		</tr>
		<tr>
			<th>#request.content.fusebox_version#</th>
			<td>#myfusebox.version.runtime#</td>
		</tr>
		<tr>
			<th>#request.content.coldfusion#</th>
			<td>#Server.ColdFusion.ProductName#</td>
		</tr>
		<tr>
			<th>#request.content.coldfusion_version#</th>
			<td>#Server.ColdFusion.ProductVersion# #Server.ColdFusion.ProductLevel#</td>
		</tr>
		<tr>
			<th>#request.content.serversoftware#</th>
			<td>#sServerSoftware#</td>
		</tr>
		<tr>
			<th>#request.content.os_name#</th>
			<td>#Server.OS.Name# (#Server.OS.Version#)<cfif StructKeyExists(Server.OS,'BuildNumber') AND len(Server.OS.BuildNumber)> #request.content.os_build#: #Server.OS.BuildNumber#</cfif><cfif StructKeyExists(Server.OS,'AdditionalInformation') AND len(Server.OS.AdditionalInformation)> #Server.OS.AdditionalInformation#</cfif></td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> User</th>
			<td>#oSystem.getProperty("user.name")#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> Java</th>
			<td>#oSystem.getProperty("java.version")# (#oSystem.getProperty("java.vendor")#)</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> JVM Locale</th>
			<td>#oSystem.getProperty("user.language")#, #oSystem.getProperty("user.country")#, #oSystem.getProperty("user.region")#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> JVM Timezone</th>
			<td>#oSystem.getProperty("user.timezone")#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> JVM System Encoding</th>
			<td>#oSystem.getProperty("file.encoding")#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> JVM StreamReader Encoding</th>
			<td>#oStreamReader.getEncoding()#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> DB Version</th>
			<td>#sDbVersion#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> DB Driver Version</th>
			<td>#oDbDriver.getMajorVersion()#.#oDbDriver.getMinorVersion()#</td>
		</tr>
	</table>
	
	<div class="headline2">#request.content.application_headline#</div>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
	<input type="hidden" name="form_submitted_application" value="true">
	<table cellpadding="5">
		<tr>
			<td>#request.content.application_reload_txt#</td>
		</tr>
		<tr>
			<td>#request.content.application_reload_time_txt#</td>
		</tr>
		<tr>
			<td>#request.content.application_started# <strong>#UDF_DateTimeFormat(application.lanshock.config.dtCreated)#</strong></td>
		</tr>
		<tr>
			<td><input type="submit" value="#request.content.application_reload_button#"></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="cb_application" id="cb_application" value="true"> <label for="cb_application">#request.content.application_reload_confirmation#</label></td>
		</tr>
	</table>
	</form>
	
	<div class="headline2">#request.content.j2ee_headline#</div>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
	<input type="hidden" name="form_submitted_j2ee_instance" value="true">
	<table cellpadding="5">
		<tr>
			<td>#request.content.j2ee_restart_txt#</td>
		</tr>
		<tr>
			<td>#request.content.j2ee_restart_time_txt#</td>
		</tr>
		<tr>
			<td>#request.content.j2ee_name# <strong><cfif NOT is_j2ee_instance>-<cfelse>#oJRun.getServerName()#</cfif></strong></td>
		</tr>
		<tr>
			<td><input type="submit" value="#request.content.j2ee_restart_button#"<cfif NOT is_j2ee_instance> disabled</cfif>></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="cb_j2ee_instance" id="cb_j2ee_instance" value="true"<cfif NOT is_j2ee_instance> disabled</cfif>> <label for="cb_j2ee_instance">#request.content.j2ee_restart_confirmation#</label></td>
		</tr>
	</table>
	</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">