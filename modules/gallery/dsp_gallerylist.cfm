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
<div class="headline">#request.content.gallery_list#</div>

<div class="headline2">#request.content.gallery_list#</div>

<cfif (request.session.userloggedin AND stModuleConfig.user_create) OR request.session.isAdmin>
	<a href="#myself##myfusebox.thiscircuit#.gallery_edit&#request.session.UrlToken#"class="link_extended">#request.content.gallery_new#</a>
	<br><br>
</cfif>

<table class="list">
	<tr>
		<th>#request.content.gallery_name#</th>
		<th>#request.content.gallery_itemcount#</th>
		<th>#request.content.gallery_commentcount#</th>
		<th>#request.content.gallery_date#</th>
		<th>#request.content.gallery_owner#</th>
	</tr>
	<cfloop query="qGallerylist">
		<cfquery dbtype="query" name="qGetComments">
			SELECT postcount
			FROM qCommentCount
			WHERE linktosource LIKE '%gallery_id=#id#%'
		</cfquery>
		<cfset iPosts = 0>
		<cfloop query="qGetComments"><cfset iPosts = iPosts + postcount></cfloop>
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.gallery&id=#id#&#request.session.UrlToken#">#title#<cfif len(tn)><br><img src="#UDF_Module('webPath')#galleries/#id#/tn/#tn#" title="#title#"></cfif></a><cfif NOT visible><br><span class="text_small text_light">#request.content.gallery_invisible#</span></cfif></td>
			<td align="center">#itemcount#</td>
			<td align="center">#iPosts#</td>
			<td align="center">#LSDateFormat(dt_created)#</td>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#getUsernameById(user_id)#</a></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">