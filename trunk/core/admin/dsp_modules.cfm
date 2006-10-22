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
<script language="JavaScript">
<!--
	function selectAll(formObj){
		for (var i=0;i < formObj.length;i++){
			fldObj = formObj.elements[i];
			if (fldObj.type == 'checkbox' && fldObj.name != '_setup') fldObj.checked = true;
		}
	}
//-->
</script>
<div class="headline">#request.content.modules#</div>

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

<cfif attributes.bModulesSaved>
	<div align="center" class="text_important">#request.content.modules_saved#</div>
</cfif>

<!--- <cfset qModules = QueryNew('active,name,version,date,dir')>
<cfloop collection="#stModulesAvaible#" item="idx">
	<cfscript>
		QueryAddRow(qModules);
		if(ListFindNoCase(lModulesInstalled,idx)) QuerySetCell(qModules,'active','true');
		else QuerySetCell(qModules,'active','false');
		QuerySetCell(qModules,'name',stModulesAvaible[idx].name);
		QuerySetCell(qModules,'version',stModulesAvaible[idx].version);
		QuerySetCell(qModules,'date',LSDateFormat(stModulesAvaible[idx].date));
		QuerySetCell(qModules,'dir',stModulesAvaible[idx].type & '/' & stModulesAvaible[idx].dir);
	</cfscript>
</cfloop>

<cfform format="flash" height="400" width="600">
	<cfformgroup type="panel" label="Module">
		<cfgrid name="modules" query="qModules" height="200" rowheaders="false">
			<cfgridcolumn name="active" header="Aktiv" type="boolean" width="50" select="true">
			<cfgridcolumn name="name" header="#request.content.name#" select="true">
			<cfgridcolumn name="version" header="#request.content.version#" width="50">
			<cfgridcolumn name="date" header="#request.content.date#" width="100">
			<cfgridcolumn name="dir" header="#request.content.directory#">
		</cfgrid>
	</cfformgroup>
	<cfformgroup type="tabnavigator">
		<cfformgroup type="page" label="<!--- TODO: $$$ ---> Details">
			<cfformitem type="text" bind="#request.content.name# {modules.dataProvider[modules.selectedIndex]['name']}"/>
			<cfformitem type="text" bind="#request.content.version# {modules.dataProvider[modules.selectedIndex]['version']}"/>
		</cfformgroup>
		<cfformgroup type="page" label="<!--- TODO: $$$ ---> Dependencies">
			<cfformitem type="text" bind="{modules.dataProvider[modules.selectedIndex]['dependencies']}"/>
			<cftree name="dependencies">
				<cftreeitem value="filesystem" expand="false"/>
				<cftreeitem value="runtime" expand="false"/>
				<cftreeitem value="modules" expand="false"/>
			</cftree>
		</cfformgroup>
		<cfformgroup type="page" label="<!--- TODO: $$$ ---> Datasource">
			<cfformitem type="text" bind="{modules.dataProvider[modules.selectedIndex]['db']}"/>
			<cftree name="datasource">
				<cftreeitem value="table1" expand="false"/>
				<cftreeitem value="id" parent="table1"/>
				<cftreeitem value="name" parent="table1"/>
				<cftreeitem value="other" parent="table1"/>
				<cftreeitem value="table2" expand="false"/>
				<cftreeitem value="id" parent="table2"/>
				<cftreeitem value="name" parent="table2"/>
				<cftreeitem value="other" parent="table2"/>
			</cftree>
		</cfformgroup>
	</cfformgroup>
</cfform>
<cfexit> --->
<div class="headline2">#request.content.core#</div>
<table class="list">
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.name#</th>
		<th>#request.content.version#</th>
		<th>#request.content.date#</th>
		<th>#request.content.directory#</th>
	</tr>
	<cfloop list="#ArrayToList(StructSort(stModulesAvaible,'textnocase','ASC','name'))#" index="idx">
		<cfif stModulesAvaible[idx].type EQ "core">
			<tr>
				<td<!---  rowspan="2" ---> valign="top" align="center"><input type="Checkbox" checked disabled></td>
				<td><label for="#idx#">#stModulesAvaible[idx].name#</label></td>
				<cfif NOT StructKeyExists(stModulesInstalled,idx)>
					<cfparam name="stModulesInstalled['#idx#']" default="#StructNew()#">
					<cfparam name="stModulesInstalled['#idx#'].version" default="#stModulesAvaible[idx].version#">
				</cfif>
				<td align="center"><cfif stModulesInstalled[#idx#].version NEQ stModulesAvaible[idx].version><span class="text_important">#stModulesInstalled[idx].version# -&gt; #stModulesAvaible[idx].version#</span><cfelse>#stModulesAvaible[idx].version#</cfif></td>
				<td align="center"><cftry>#LSDateFormat(stModulesAvaible[idx].date)#<cfcatch>#LSDateFormat(ParseDateTime('#stModulesAvaible[idx].date# 00:00:00'))#<!--- for BlueDragon 6.2 ---></cfcatch></cftry></td>
				<td>#stModulesAvaible[idx].dir#/</td>
			</tr>
			<!--- <tr>
				<td class="empty text_light text_small" colspan="4">
					<!--- TODO: $$$ ---> Type: <strong>#stModulesAvaible[idx].general.type#</strong>
					<br>
					#request.content.author# <strong>#stModulesAvaible[idx].author#</strong>
					<br>
					<!--- TODO: $$$ ---> Url #stModulesAvaible[idx].url#
					<br>
					<!--- TODO: $$$ ---> License <strong><cfloop from="1" to="#ArrayLen(stModulesAvaible[idx].license)#" index="idx2">
									<cfif idx2 GT 1>, </cfif>
									<cfswitch expression="#stModulesAvaible[idx].license[idx2].type#">
										<cfcase value="gpl">GPL</cfcase>
										<cfcase value="other">
											<cfscript>
												if(NOT len(stModulesAvaible[idx].license[idx2].name)) sLicenseName = '<!--- TODO: $$$ ---> Other';
												else sLicenseName = stModulesAvaible[idx].license[idx2].name;
												
												if(len(stModulesAvaible[idx].license[idx2].file)) sLicenseLink = '#stModulesAvaible[idx].dir#/#stModulesAvaible[idx].license[idx2].file#';
												else sLicenseLink = '#stModulesAvaible[idx].license[idx2].url#';
											</cfscript>
												<cfif len(sLicenseLink)>
													<a href="#sLicenseLink#" target="_blank">#sLicenseName#</a>
												<cfelse>#sLicenseName#</cfif>
											</cfcase>
										<cfdefaultcase><!--- TODO: $$$ ---> Unknown type (#stModulesAvaible[idx].license[idx2].type#)</cfdefaultcase>
									</cfswitch>
								</cfloop></strong>
					
					<cfif len(stModulesAvaible[idx].hint)>
						<br>&nbsp;<br>#stModulesAvaible[idx].hint#
					</cfif>
					
					<cfif NOT StructIsEmpty(stModulesAvaible[idx].dependencies)>
						<br>&nbsp;<br><strong><!--- TODO: $$$ ---> Dependencies</strong><br>
						<cfloop collection="#stModulesAvaible[idx].dependencies#" item="item">
							#item#<br>
							<cfloop collection="#stModulesAvaible[idx].dependencies[item]#" item="item2">
								<cfscript>
									sFileFolderString = '[root]';
									if(len(stModulesAvaible[idx].dependencies[item][item2].file)){
										if(left(stModulesAvaible[idx].dependencies[item][item2].file,1) NEQ '/')
											sFileFolderString = sFileFolderString & '#stModulesAvaible[idx].type#/#stModulesAvaible[idx].dir#/';
										sFileFolderString = sFileFolderString & stModulesAvaible[idx].dependencies[item][item2].file;
									}
									else if(len(stModulesAvaible[idx].dependencies[item][item2].folder)){
										if(left(stModulesAvaible[idx].dependencies[item][item2].folder,1) NEQ '/')
											sFileFolderString = sFileFolderString & '#stModulesAvaible[idx].type#/#stModulesAvaible[idx].dir#/';
										sFileFolderString = sFileFolderString & stModulesAvaible[idx].dependencies[item][item2].folder;
										if(right(stModulesAvaible[idx].dependencies[item][item2].folder,1) NEQ '/')
											sFileFolderString = sFileFolderString & '/';
									}
								</cfscript>
								#sFileFolderString#<br>
							</cfloop>
						</cfloop>
					</cfif>
					<!--- <cfif NOT StructIsEmpty(stModulesAvaible[idx].db)>
						<cfdump var="#stModulesAvaible[idx].db#">
					</cfif> --->
				</td>
			</tr> --->
		</cfif>
	</cfloop>
</table>

<div class="headline2">#request.content.modules#</div>
<table class="list">
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.name#</th>
		<th>#request.content.version#</th>
		<th>#request.content.date#</th>
		<th>#request.content.directory#</th>
	</tr>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<cfloop list="#ArrayToList(StructSort(stModulesAvaible,'textnocase','ASC','name'))#" index="idx">
		<cfif stModulesAvaible[idx].type EQ "core">
			<input type="hidden" name="lmodules" value="#idx#">
		</cfif>
	</cfloop>
	<cfloop list="#ArrayToList(StructSort(stModulesAvaible,'textnocase','ASC','name'))#" index="idx">
		<cfif stModulesAvaible[idx].type EQ "module">
			<tr>
				<td<!---  rowspan="2" ---> valign="top" align="center"><input type="Checkbox" name="lmodules" value="#idx#" id="#idx#"<cfif ListFindNoCase(lModulesInstalled, idx)> checked</cfif>#sDisabled#></td>
				<td><label for="#idx#">#stModulesAvaible[idx].name#</label></td>
				<cftry>
				<cfif NOT StructKeyExists(stModulesInstalled,idx)>
					<cfparam name="stModulesInstalled['#idx#']" default="#StructNew()#">
					<cfparam name="stModulesInstalled['#idx#'].version" default="#stModulesAvaible[idx].version#">
				</cfif><cfcatch><cfdump var="#cfcatch#"><cfabort></cfcatch>
				</cftry>
				<td align="center"><cfif stModulesInstalled[#idx#].version NEQ stModulesAvaible[idx].version><span class="text_important">#stModulesInstalled[idx].version# -&gt; #stModulesAvaible[idx].version#</span><cfelse>#stModulesAvaible[idx].version#</cfif></td>
				<td align="center"><cftry>#LSDateFormat(stModulesAvaible[idx].date)#<cfcatch>#LSDateFormat(ParseDateTime('#stModulesAvaible[idx].date# 00:00:00'))#<!--- for BlueDragon 6.2 ---></cfcatch></cftry></td>
				<td>#stModulesAvaible[idx].dir#/</td>
			</tr>
			<!--- <tr>
				<td class="empty text_light text_small" colspan="4">
					<!--- TODO: $$$ ---> Type: <strong>#stModulesAvaible[idx].general.type#</strong>
					<br>
					#request.content.author# <strong>#stModulesAvaible[idx].author#</strong>
					<br>
					<!--- TODO: $$$ ---> Url #stModulesAvaible[idx].url#
					<br>
					<!--- TODO: $$$ ---> License <strong><cfloop from="1" to="#ArrayLen(stModulesAvaible[idx].license)#" index="idx2">
									<cfif idx2 GT 1>, </cfif>
									<cfswitch expression="#stModulesAvaible[idx].license[idx2].type#">
										<cfcase value="gpl">GPL</cfcase>
										<cfcase value="other">
											<cfscript>
												if(NOT len(stModulesAvaible[idx].license[idx2].name)) sLicenseName = '<!--- TODO: $$$ ---> Other';
												else sLicenseName = stModulesAvaible[idx].license[idx2].name;
												
												if(len(stModulesAvaible[idx].license[idx2].file)) sLicenseLink = '#stModulesAvaible[idx].dir#/#stModulesAvaible[idx].license[idx2].file#';
												else sLicenseLink = '#stModulesAvaible[idx].license[idx2].url#';
											</cfscript>
												<cfif len(sLicenseLink)>
													<a href="#sLicenseLink#" target="_blank">#sLicenseName#</a>
												<cfelse>#sLicenseName#</cfif>
											</cfcase>
										<cfdefaultcase><!--- TODO: $$$ ---> Unknown type (#stModulesAvaible[idx].license[idx2].type#)</cfdefaultcase>
									</cfswitch>
								</cfloop></strong>
					
					<cfif len(stModulesAvaible[idx].hint)>
						<br>&nbsp;<br>#stModulesAvaible[idx].hint#
					</cfif>
					
					<cfif NOT StructIsEmpty(stModulesAvaible[idx].dependencies)>
						<br>&nbsp;<br><strong><!--- TODO: $$$ ---> Dependencies</strong><br>
						<cfloop collection="#stModulesAvaible[idx].dependencies#" item="item">
							#item#<br>
							<cfloop collection="#stModulesAvaible[idx].dependencies[item]#" item="item2">
								<cfscript>
									sFileFolderString = '[root]';
									if(len(stModulesAvaible[idx].dependencies[item][item2].file)){
										if(left(stModulesAvaible[idx].dependencies[item][item2].file,1) NEQ '/')
											sFileFolderString = sFileFolderString & '#stModulesAvaible[idx].type#/#stModulesAvaible[idx].dir#/';
										sFileFolderString = sFileFolderString & stModulesAvaible[idx].dependencies[item][item2].file;
									}
									else if(len(stModulesAvaible[idx].dependencies[item][item2].folder)){
										if(left(stModulesAvaible[idx].dependencies[item][item2].folder,1) NEQ '/')
											sFileFolderString = sFileFolderString & '#stModulesAvaible[idx].type#/#stModulesAvaible[idx].dir#/';
										sFileFolderString = sFileFolderString & stModulesAvaible[idx].dependencies[item][item2].folder;
										if(right(stModulesAvaible[idx].dependencies[item][item2].folder,1) NEQ '/')
											sFileFolderString = sFileFolderString & '/';
									}
								</cfscript>
								#sFileFolderString#<br>
							</cfloop>
						</cfloop>
					</cfif>
					<cfif StructKeyExists(stModulesAvaible[idx].db,'dbtable')>
						<cfdump var="#stModulesAvaible[idx].db.dbtable#">
					</cfif>
				</td>
			</tr> --->
		</cfif>
	</cfloop>
	<tr>
		<td class="empty" colspan="6"><input type="button" onclick="selectAll(this.form);" value="#request.content.form_selectall#"#sDisabled#> <input type="submit" value="#request.content.form_save#"#sDisabled#></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">
