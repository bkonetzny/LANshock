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
	<h3>$$$ Scaffolding</h3>
	<p>Here you can re-build the LANshock modules</p>
	
	#application.lanshock.oHelper.notificationBox(sMode='global')#
	
	<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&bUpdateScaffoldingXml=true')#">$$$ Update Scaffolding.xml with latest DB definitions</a>
	
	<h4>$$$ Scaffolds</h4>
	<table class="list">
		<tr>
			<th>$$$ Module</th>
			<th>$$$ Tables</th>
			<th>$$$ Options</th>
		</tr>
		<cfloop list="#ListSort(StructKeyList(stScaffolding),'textnocase')#" index="idx">
			<cfset idx = LCase(idx)>
			<cfset lTables = ListSort(LCase(StructKeyList(stScaffolding[idx].database.tables)),'textnocase')>
			<cfif len(lTables)>
				<tr>
					<td>#idx#</td>
					<td>#ListChangeDelims(lTables,'<br/>')#</td>
					<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#_progress&module=#idx#')#" target="scaffolding_progress" onclick="$('##scaffolding_progress').show();"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/application_xp_terminal.png" alt="" title="" /> Generate</a>
						<cfif directoryExists(expandPath('storage/secure/scaffolding/modules/#idx#/'))>
							<br/><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sDeployModule=#idx#')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/arrow_right.png" alt="" title="" /> Deploy</a>
							<br/><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sDeployModule=#idx#&bReload=true')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/arrow_refresh.png" alt="" title="" /> Deploy & Reload</a>
						</cfif>
					</td>
				</tr>
			</cfif>
		</cfloop>
	</table>
	<div id="elmProgressBar"></div>
	<script type="text/javascript">
		oProgressBar = new Ext.ProgressBar ({
				id: 'progressBar',
				text: '0%',
				bodyStyle: '',
				renderTo: 'elmProgressBar'
			});
	</script>
	<div id="scaffolding_progress" style="display: none;">
		<iframe name="scaffolding_progress" width="100%" height="300"></iframe>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="No">