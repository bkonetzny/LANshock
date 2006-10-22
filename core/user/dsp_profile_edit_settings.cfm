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
<div class="headline">#request.content.misc#</div>

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

<cfif isNumeric(attributes.id)>
	<a href="#myself##myfusebox.thiscircuit#.userdetails<cfif request.session.isAdmin>&id=#attributes.id#</cfif>&#request.session.UrlToken#" class="link_extended">#request.content.show_profile#</a>
</cfif>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<input type="hidden" name="id" value="#attributes.id#">

<div class="headline2">#request.content.misc#</div>

<table class="vlist" width="100%">
	<tr>
		<th>#request.content.homepage#</th>
		<td><input type="text" name="homepage" value="#attributes.homepage#"></td>
	</tr>
	<tr>
		<th>#request.content.geo_lat#</th>
		<td><input type="text" name="geo_lat" value="#attributes.geo_lat#"></td>
	</tr>
	<tr>
		<th>#request.content.geo_long#</th>
		<td><input type="text" name="geo_long" value="#attributes.geo_long#"></td>
	</tr>
	<tr>
		<th>#request.content.signature#</th>
		<td><textarea name="signature" style="width: 100%; height: 200px;">#attributes.signature#</textarea></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="Submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">