<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/dsp_config.cfm $
$LastChangedDate: 2007-09-30 14:42:48 +0200 (So, 30 Sep 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 102 $
--->

<cfoutput>

<cfif attributes.bConfigSaved>
	<div class="box_success">#request.content.configuration_saved#</div>
</cfif>
<cfif bUserSaved>
	<div class="box_success">#request.content.root_account_created#</div>
</cfif>

<cfif stStatusDb.bStatus>
	<div class="box_success" onclick="$('##form_config').toggle();">#request.content.status_config_success#</div>
<cfelse>
	<div class="box_failure">#request.content.status_config_failure# #stStatus.cfcatch.message#</div>
</cfif>

<cfif ArrayLen(aError)>
	<div class="errorBox">
		<h3>#request.content.error#</h3>
		<ul>
			<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
			<li>#aError[idxError]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<div id="form_config"<cfif stStatusDb.bStatus> style="display:none"</cfif>>
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
	<input type="hidden" name="form_submitted" value="true"/>
	<input type="hidden" name="form_action" value="config"/>
	<table class="vlist">
		<tr>
			<th>#request.content.setup_password#</th>
			<td><input type="password" name="password" value="#attributes.password#"/></td>
		</tr>
		<tr>
			<th>#request.content.datasource#</th>
			<td><cfif listlen(lDatasources)>
					<select name="datasource">
						<option value=""></option>
						<cfloop list="#ListSort(lDatasources,'textnocase')#" index="idx">
							<option value="#idx#"<cfif attributes.datasource EQ idx> selected="selected"</cfif>>#idx#</option>
						</cfloop>
					</select>
				<cfelse>
					<input type="text" name="datasource" value="#attributes.datasource#">
				</cfif></td>
		</tr>
		<tr>
			<th>#request.content.datasource_type#</th>
			<td><select name="datasource_type">
					<cfloop list="#ListSort(lDatasourcesTypes,'textnocase')#" index="idx">
						<option value="#idx#"<cfif attributes.datasource_type EQ idx> selected="selected"</cfif>>#idx#</option>
					</cfloop>
				</select></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" value="#request.content.form_save#"/></td>
		</tr>
	</table>
	</form>
</div>

<cfif stStatusUser.bStatus>
	<div class="box_success" onclick="$('##form_user').toggle();">#request.content.status_user_success#</div>
<cfelse>
	<div class="box_failure">#request.content.status_user_failure#</div>
</cfif>

<div id="form_user"<cfif stStatusUser.bStatus> style="display:none"</cfif>>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true"/>
	<input type="hidden" name="form_action" value="user"/>
	<table>
		<tr>
			<th>#request.content.root_username#</th>
			<td><em>root</em></td>
		</tr>
		<tr>
			<th>#request.content.root_email#</th>
			<td><input type="text" name="root_email"/></td>
		</tr>
		<tr>
			<th>#request.content.root_password#</th>
			<td><input type="password" name="root_password"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" value="#request.content.form_save#"/></td>
		</tr>
	</table>
	</form>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="No">