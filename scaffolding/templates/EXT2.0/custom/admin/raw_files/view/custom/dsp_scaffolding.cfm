<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_logviewer.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
	<h3>$$$ Scaffolding</h3>
	<p>Here you can re-build the LANshock Modules</p>
	
	<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&bUpdateScaffoldingXml=true')#">$$$ Update Scaffolding.xml with latest DB definitions</a>
	
	<h4>$$$ Scaffolds</h4>
	<table class="list">
		<tr>
			<th>$$$ Module</th>
			<th>$$$ Tables</th>
			<th>$$$ Options</th>
		</tr>
		<cfloop collection="#stScaffolding#" item="idx">
			<cfset idx = LCase(idx)>
			<tr>
				<td>#idx#</td>
				<td>#ListChangeDelims(stScaffolding[idx].lTables,'<br/>')#</td>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#_progress&module=#idx#')#" target="scaffolding_progress" onclick="$('##scaffolding_progress').show();">$$$ Generate</a></td>
			</tr>
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