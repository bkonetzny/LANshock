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

<cfif attributes.bConfigSaved>
	<div align="center" class="text_important">#request.content.configuration_saved#</div>
</cfif>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th>#request.content.setup_password#</th>
		<td><input type="password" name="password" value="#attributes.password#"></td>
	</tr>
	<tr>
		<th>#request.content.datasource#</th>
		<td><cfif listlen(lDatasources)>
				<select name="datasource">
					<option value=""></option>
					<cfloop list="#ListSort(lDatasources,'textnocase')#" index="idx">
						<option value="#idx#"<cfif attributes.datasource EQ idx> selected</cfif>>#idx#</option>
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
					<option value="#idx#"<cfif attributes.datasource_type EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<th>$$$ Index File</th>
		<td><input type="text" name="index_file" value="#attributes.index_file#"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>
	
<div style="text-align: left;">
<em>MySQL:</em><br>
<ol>
	<li><a href="http://dev.mysql.com/downloads/connector/j/" target="_blank">Download MySQL Connector J JDBC driver</a></li>
	<li>Extract <strong>mysql-connector-java-3.{n}-bin.jar</strong> from the downloaded archive.</li>
	<li>Save <strong>mysql-connector-java-3.{n}-bin.jar</strong> in the lib folder.<br>
		("<em>##CFROOT##/WEB-INF/lib/</em>" or "<em>##CFROOT##/lib/</em>")</li>
	<li>Restart the ColdFusion service.</li>
	<li>Add the Datasource in ColdFusion MX Administrator, using driver <strong>Other</strong>.</li>
	<li>Enter the JDBC URL: <strong>jdbc:mysql://[host]:[port]/[database]?zeroDateTimeBehavior=convertToNull</strong></li>
	<li>Enter the Driver Class: <strong>com.mysql.jdbc.Driver</strong></li>
	<li>Complete username/password and adjust other Datasource settings.</li>
	<li>Submit the data source for verification.</li>
</ol>

<br>&nbsp;<br>

<em>Index File:</em><br>
<ul>
	<li>Default is <em>index.cfm</em>. If you have renamed this file enter it here.</li>
	<li>You can leave this blank if your server can handle requests without a file.<br>
		(like http://example.com/?fuseaction=parameter)</li>
</ul>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="No">