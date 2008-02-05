<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_tabledump.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
	<div class="headline">Tabledump</div>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.urltoken#" method="post">
		<div align="center">
			<select name="table">
				<cfloop list="#listSort(StructKeyList(application.datasource),'textnocase','ASC')#" index="idx">
					<option value="#idx#"<cfif attributes.table EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			<input type="submit" value="#request.content.form_save#">
		</div>
	</form>
</cfoutput>

<cfif len(attributes.table) AND StructKeyExists(application.datasource,attributes.table)>
	<cfdump var="#qTabledump#" label="#attributes.table#">
</cfif>

<cfsetting enablecfoutputonly="No">