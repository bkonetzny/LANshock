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
<div class="headline">#request.content.category_edit_headline#</div>
	
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

<div class="headline2">#request.content.category_edit#</div>

<table>
	<cfif attributes.category_id NEQ 0>
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" class="link_extended">#request.content.add_new_category#</a></td>
		</tr>
	</cfif>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="category_id" value="#attributes.category_id#">
	<tr>
		<td>#request.content.title#<br>
			<input type="text" name="name" maxlength="255" value="#attributes.name#"></td>
	</tr>
	<tr>
		<td align="center"><input type="Submit" value="#request.content.form_save#"></td>
	</tr>
	</form>
</table>

<div class="headline2">#request.content.avaible_categories#</div>

<cfloop list="#ArrayToList(StructSort(stCategories,'textnocase','asc','name'))#" index="idx">
	<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&category_id=#idx#&#request.session.UrlToken#">#stCategories[idx].name# (#stCategories[idx].entrys#)</a><br>
</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="No">