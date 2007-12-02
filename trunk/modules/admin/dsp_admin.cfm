<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_admin.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
	<div class="headline">#request.content.orga1#</div>

	<a href="#myself##myfusebox.thiscircuit#.admin_new&#request.session.UrlToken#"class="link_extended">#request.content.orga2#</a>
	
	<br>	
	<table>
		<tr>
			<td><img src="#stImageDir.general#/status_led_green.gif" alt=""></td>	
			<td>#request.content.orga3#</td>
		</tr>
		<tr>
			<td><img src="#stImageDir.general#/status_led_orange.gif" alt=""></td>	
			<td>#request.content.orga4#</td>
		</tr>
		<tr>
			<td><img src="#stImageDir.general#/status_led_red.gif" alt=""></td>	
			<td>#request.content.orga5#</td>
		</tr>
	</table>

	<table class="list">
		<tr>
			<th>#request.content.admins#</th>
			<th>#request.content.rights#</th>
			<cfif UDF_SecurityCheck(area='setrights',returntype='boolean')>
				<td class="empty">&nbsp;</td>
			</cfif>
		</tr>
		<cfloop list="#ListSort(StructKeyList(stAdmins),'textnocase','ASC')#" index="CurrUser">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.show_modulrights&userid=#stAdmins[curruser].id#&#request.session.UrlToken#">#curruser#</a></td>			
				<td>
				<cfloop list="#ListSort(StructKeyList(stAdmins[curruser].security),'textnocase')#" index="idx">
					<cftry>
						<cfset sModuleName = stNav[idx].name>
						<cfcatch><cfset sModuleName = idx></cfcatch>
					</cftry>
					<img src="#stImageDir.general#/status_led_<cfif stAdmins[CurrUser].security[idx] eq 0>orange<cfelseif stAdmins[CurrUser].security[idx] eq 1>green<cfelse>red</cfif>.gif" alt="#sModuleName#" hspace="5">
				</cfloop>
				</td>
				<cfif UDF_SecurityCheck(area='setrights',returntype='boolean')>
					<td class="empty"><a href="#myself##myfusebox.thiscircuit#.admin_del&admin_id=#stAdmins[curruser].admin_id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></a></td>
				</cfif>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">