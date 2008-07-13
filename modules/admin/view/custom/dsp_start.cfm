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
	<h3>#request.content.serverdata#</h3>
	
	#application.lanshock.oHelper.notificationBox(sMode='global')#

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
			<th>#request.content.application_started#</th>
			<td>#session.oUser.dateTimeFormat(application.lanshock.dtAppStart)# (#timeSpanConvert(DateDiff('s',application.lanshock.dtAppStart,now()))#)</td>
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
			<th><!--- TODO: $$$ ---> LANshock Cache Size</th>
			<td>#byteConvert(application.lanshock.oCache.size(),'MB')#</td>
		</tr>
		<tr>
			<th>#request.content.fusebox_version#</th>
			<td>#myfusebox.version.runtime#</td>
		</tr>
		<tr>
			<th><!--- #request.content.coldfusion# ---><!--- TODO: $$$ ---> CFML Engine</th>
			<td>#Server.ColdFusion.ProductName#<cfif StructKeyExists(server,'railo')> (#server.railo.version#)</cfif></td>
		</tr>
		<tr>
			<th><!--- #request.content.coldfusion_version# ---><!--- TODO: $$$ ---> CFML Version</th>
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
			<th><!--- TODO: $$$ ---> Free Space on Server</th>
			<td><cfif ListGetAt(sJavaVersion,2,'.') GTE 6>#byteConvert(oFile.init(expandPath('.')).getFreeSpace())#<cfelse>unknown (Java 1.6+ needed)</cfif></td>
		</tr>
		<tr>
			<th><!--- TODO: $$$ ---> JVM Version</th>
			<td>#sJavaVersion# (#oSystem.getProperty("java.vendor")#)</td>
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
		<tr>
			<th><!--- TODO: $$$ ---> JVM Starttime</th>
			<td><cfif ListGetAt(sJavaVersion,2,'.') GTE 6>#session.oUser.DateTimeFormat(oDate.init(oManagementFactory.getRuntimeMXBean().getStartTime()))# (#timeSpanConvert(DateDiff('s',oDate.init(oManagementFactory.getRuntimeMXBean().getStartTime()),now()))#)<cfelse>unknown (Java 1.6+ needed)</cfif></td>
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
			<th><!--- TODO: $$$ ---> DB Name</th>
			<td>#application.lanshock.oRuntime.getEnvironment().sDatasource#</td>
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
	
	<h4>#request.content.application_headline#</h4>
	
	<p>
		#request.content.application_reload_txt#<br/>
		#request.content.application_reload_time_txt#
	</p>

	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" class="uniForm" method="post">
		<div class="hidden">
			<input type="hidden" name="form_submitted" value="true"/>
		</div>
	
		<fieldset class="inlineLabels">
			<legend>#request.content.application_reload_button#</legend>
			
			<div class="ctrlHolder">
				<p class="label">Reload Mode</p>
				<label for="reload_type_cache" class="inlineLabel">
					<input type="radio" name="reload_type" id="reload_type_cache" value="cache" checked="checked"/>
					<!--- TODO: $$$ ---> Clear Cache
				</label>
				<label for="reload_type_application" class="inlineLabel">
					<input type="radio" name="reload_type" id="reload_type_application" value="application"/>
					<!--- TODO: $$$ ---> Reload Application
				</label>
			</div>
	
		</fieldset>
	
		<div class="buttonHolder">
			<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		</div>
	</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">