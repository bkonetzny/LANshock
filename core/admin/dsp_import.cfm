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
	<div class="headline">#request.content.import#</div>
	
	<cfif ArrayLen(aError)>
		<div class="errorBox">
			#request.content.error#
			<ul>
				<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
				<li>#aError[idxError]#</li>
				</cfloop>
			</ul>
		</div>
	</cfif>

	<cfif len(attributes.type)>
		Type: #attributes.type#
	<cfelse>
	<table>
		<form action="#myself##myfusebox.thiscircuit#.import&#request.session.UrlToken#" enctype="multipart/form-data" method="post">
		<tr>
			<td><select name="type">
				<!--- <option value="lanshock">LANshock</option> --->
				<option value="lansurfer">LANsurfer (intranet.xml)</option>
			</select></td>
		</tr>
		<tr>
			<td><input type="Submit" name="submit" value="#request.content.import#"></td>
		</tr>
		</form>
	</table>
	</cfif>
</cfoutput>

<cfif len(attributes.type)>
	<cfinclude template="dsp_import_#attributes.type#.cfm">
</cfif>

<cfsetting enablecfoutputonly="No">