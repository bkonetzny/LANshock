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
<div class="headline"><!--- TODO: $$$ ---> Cache</div>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th><!--- TODO: $$$ ---> languagefiles</th>
		<td><input type="radio" name="languagefiles" id="languagefiles1" value="true"<cfif attributes.languagefiles> checked</cfif>> <label for="languagefiles1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="languagefiles" id="languagefiles0" value="false"<cfif NOT attributes.languagefiles> checked</cfif>> <label for="languagefiles0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> circuitfiles</th>
		<td><input type="radio" name="circuitfiles" id="circuitfiles1" value="true"<cfif attributes.circuitfiles> checked</cfif>> <label for="circuitfiles1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="circuitfiles" id="circuitfiles0" value="false"<cfif NOT attributes.circuitfiles> checked</cfif>> <label for="circuitfiles0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
</table>
<input type="submit" value="#request.content.form_save#">
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">