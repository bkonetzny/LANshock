<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_config_editor.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<div class="headline">Config Editor</div>

<div class="headline2">Select Config</div>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
	<table class="list">
		<tr>
			<th class="empty">&nbsp;</th>
			<th>Module</th>
			<th>Data</th>
			<th>Version</th>
			<th>Timestamp</th>
		</tr>
		<cfloop query="qConfiglist">
			<tr>
				<td class="empty"><input type="checkbox" name="module" value="#module#"></td>
				<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&module=#module#&#request.session.urltoken#">#module#</a></td>
				<td align="center"><cfif isWDDX(data)>Yes<cfelse>No</cfif></td>
				<td align="center"><cfif len(version)>#version#<cfelse><em>[unknown]</em></cfif></td>
				<td>#UDF_DateTimeFormat(dtlastchanged)#</td>
			</tr>
		</cfloop>
	</table>
	<input type="submit" name="reset_selected" value="Reset Selected">
	<input type="submit" name="reset_all" value="Reset All">
</form>

<cfif listLen(attributes.module) EQ 1>
	<div class="headline2">Config Dump</div>
	
	<cfdump var="#stConfig#">
	<!--- #newConfigLevel(stConfig)# --->
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">