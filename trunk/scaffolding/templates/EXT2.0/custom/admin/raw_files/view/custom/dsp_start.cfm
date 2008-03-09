<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_start.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
	<h3>#request.content.serverdata#</h3>

	<h4>#request.content.installed_versions#</h4>

	<table class="vlist">
		<tr>
			<th>#request.content.lanshock_version#</th>
			<td>#stVersion.version# (#stVersion.build#)</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> Applicationname</th>
			<td>#application.applicationName#</td>
		</tr>
		<tr>
			<th>#request.content.path_abs#</th>
			<td>#application.lanshock.oRuntime.getEnvironment().sBasePath#</td>
		</tr>
		<tr>
			<th>#request.content.path_web#</th>
			<td>#application.lanshock.oRuntime.getEnvironment().sWebPath#</td>
		</tr>
		<tr>
			<th>#request.content.component_path#</th>
			<td>#application.lanshock.oRuntime.getEnvironment().sComponentPath#</td>
		</tr>
		<tr>
			<th>#request.content.fusebox_version#</th>
			<td>#myfusebox.version.runtime#</td>
		</tr>
		<!--- <tr>
			<th><!--- TODO: $$$ ---> Transfer ORM Version</th>
			<td>#myFusebox.getApplication().getApplicationData().transferFactory.getVersion()#</td>
		</tr> --->
		<tr>
			<th>#request.content.coldfusion#</th>
			<td>#Server.ColdFusion.ProductName#<cfif StructKeyExists(server,'railo')> (#server.railo.version#)</cfif></td>
		</tr>
		<tr>
			<th>#request.content.coldfusion_version#</th>
			<td>#Server.ColdFusion.ProductVersion# #Server.ColdFusion.ProductLevel#</td>
		</tr>
		<cfif len(sServerSoftware)>
			<tr>
				<th>#request.content.serversoftware#</th>
				<td>#sServerSoftware#</td>
			</tr>
		</cfif>
		<tr>
			<th>#request.content.os_name#</th>
			<td>#Server.OS.Name# (#Server.OS.Version#)<cfif StructKeyExists(Server.OS,'BuildNumber') AND len(Server.OS.BuildNumber)> #request.content.os_build#: #Server.OS.BuildNumber#</cfif><cfif StructKeyExists(Server.OS,'AdditionalInformation') AND len(Server.OS.AdditionalInformation)> #Server.OS.AdditionalInformation#</cfif></td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> User</th>
			<td>#oSystem.getProperty("user.name")#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> JVM Version</th>
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
			<th><!--- TODO: $$$ ---> JVM Heap</th>
			<td>#byteConvert(oRuntime.getRuntime().freeMemory(),'MB')# <!--- TODO: $$$ --->free of #byteConvert(oRuntime.getRuntime().maxMemory(),'MB')# maximum</td>
		</tr>
		<!--- <tr>
			<th><!--- TODO: $$$ ---> JVM System Encoding</th>
			<td>#oSystem.getProperty("file.encoding")#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> JVM StreamReader Encoding</th>
			<td>#oStreamReader.getEncoding()#</td>
		</tr> --->
		<tr>
			<th><!--- TODO: $$$ ---> DB Version</th>
			<td>#sDbVersion#</td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> DB Driver Version</th>
			<td>#oDbDriver.getMajorVersion()#.#oDbDriver.getMinorVersion()#</td>
		</tr>
	</table>
	
	<h4>#request.content.application_headline#</h4>
	
	<p>
		#request.content.application_reload_txt#<br>
		#request.content.application_reload_time_txt#<br>
		#request.content.application_started# <strong>#session.oUser.dateTimeFormat(application.lanshock.dtAppStart,'datetime')#</strong>
	</p>

	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
	<input type="hidden" name="form_submitted_application" value="true"/>
	<div class="form">
		<div class="formrow">
			<div class="formrow_input formrow_nolabel">
				<input type="checkbox" name="cb_application" id="cb_application" value="true"/> <label for="cb_application">#request.content.application_reload_confirmation#</label>
			</div>
		</div>
		<div class="formrow">
			<div class="formrow_buttonbar">
				<input type="submit" value="#request.content.application_reload_button#"/>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
	</form>
		
	<!--- <cfif is_j2ee_instance>
		<h4>#request.content.j2ee_headline#</h4>
	
		<p>
			#request.content.j2ee_restart_txt#<br>
			#request.content.j2ee_restart_time_txt#<br>
			#request.content.j2ee_name# <strong>#oJRun.getServerName()#</strong>
		</p>
	
		<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
		<input type="hidden" name="form_submitted_j2ee_instance" value="true">
		<div class="form">
			<div class="formrow">
				<div class="formrow_input formrow_nolabel">
					<input type="checkbox" name="cb_j2ee_instance" id="cb_j2ee_instance" value="true"> <label for="cb_j2ee_instance">#request.content.j2ee_restart_confirmation#</label>
				</div>
			</div>
			<div class="formrow">
				<div class="formrow_buttonbar">
					<input type="submit" value="#request.content.j2ee_restart_button#"/>
				</div>
			</div>
			<div class="clearer"></div>
		</div>
		</form>
	</cfif> --->
</cfoutput>

<cfsetting enablecfoutputonly="No">