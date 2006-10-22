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
	<div class="headline">Tabledump</div>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
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