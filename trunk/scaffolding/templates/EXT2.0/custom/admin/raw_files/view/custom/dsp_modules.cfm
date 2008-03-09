<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_modules.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<script type="text/javascript">
<!--
	function selectAll(formObj){
		for (var i=0;i < formObj.length;i++){
			fldObj = formObj.elements[i];
			if (fldObj.type == 'checkbox' && fldObj.name != '_setup') fldObj.checked = true;
		}
	}
//-->
</script>

<h3>#request.content.modules#</h3>

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

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
<input type="hidden" name="form_submitted" value="true"/>
<input type="hidden" name="mode" value="uninstall"/>
<h4><!--- TODO: $$$ --->Installed</h4>
<table>
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.name#</th>
		<th>#request.content.version#</th>
		<th>#request.content.date#</th>
		<th>#request.content.directory#</th>
		<th>$$$ Options</th>
	</tr>
	<cfloop collection="#stModulesInstalled#" item="idx">
		<tr>
			<td<!---  rowspan="2" ---> valign="top" align="center"><cfif NOT ListFindNoCase(lCoreModules,idx)><input type="checkbox" name="lmodules" value="#idx#" id="module_#idx#"/><cfelse>&nbsp;</cfif></td>
			<td><label for="module_#idx#">#stModulesInstalled[idx].info.name#</label></td>
			<td align="center">#stModulesInstalled[idx].info.version#</td>
			<td align="center">#session.oUser.dateTimeFormat(stModulesInstalled[idx].info.date,'date')#</td>
			<td>#idx#/</td>
			<td><cfif NOT ListFindNoCase(lCoreModules,idx)><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#">$$$ Uninstall</a></cfif></td>
		</tr>
		<tr style="display: none;">
			<td class="empty text_light text_small" colspan="4">
				<!--- TODO: $$$ ---> Type: <strong>#stModulesInstalled[idx].general.type#</strong>
				<br>
				#request.content.author# <strong>#stModulesInstalled[idx].info.author#</strong>
				<br>
				<!--- TODO: $$$ ---> Url #stModulesInstalled[idx].info.url#
				<br>

				<cfif len(stModulesInstalled[idx].info.hint)>
					<br>&nbsp;<br>#stModulesInstalled[idx].info.hint#
				</cfif>
				
				<cfif StructKeyExists(stModulesInstalled[idx],'dependencies') AND NOT StructIsEmpty(stModulesInstalled[idx].dependencies)>
					<br>&nbsp;<br><strong><!--- TODO: $$$ ---> Dependencies</strong><br>
					<cfloop collection="#stModulesInstalled[idx].dependencies#" item="item">
						#item#<br>
						<cfloop collection="#stModulesInstalled[idx].dependencies[item]#" item="item2">
							<cfscript>
								sFileFolderString = '[root]';
								if(len(stModulesInstalled[idx].dependencies[item][item2].file)){
									if(left(stModulesInstalled[idx].dependencies[item][item2].file,1) NEQ '/')
										sFileFolderString = sFileFolderString & '#stModulesInstalled[idx].type#/#stModulesInstalled[idx].dir#/';
									sFileFolderString = sFileFolderString & stModulesInstalled[idx].dependencies[item][item2].file;
								}
								else if(len(stModulesInstalled[idx].dependencies[item][item2].folder)){
									if(left(stModulesInstalled[idx].dependencies[item][item2].folder,1) NEQ '/')
										sFileFolderString = sFileFolderString & '#stModulesInstalled[idx].type#/#stModulesInstalled[idx].dir#/';
									sFileFolderString = sFileFolderString & stModulesInstalled[idx].dependencies[item][item2].folder;
									if(right(stModulesInstalled[idx].dependencies[item][item2].folder,1) NEQ '/')
										sFileFolderString = sFileFolderString & '/';
								}
							</cfscript>
							#sFileFolderString#<br>
						</cfloop>
					</cfloop>
				</cfif>
			</td>
		</tr>
	</cfloop>
	<tr>
		<td class="empty" colspan="6"><input type="button" onclick="selectAll(this.form);" value="#request.content.form_selectall#"> <input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>

<!--- <h4><!--- TODO: $$$ --->Loaded</h4>
<table>
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.name#</th>
		<th>#request.content.version#</th>
		<th>#request.content.date#</th>
		<th>#request.content.directory#</th>
	</tr>
	<cfloop collection="#stModulesLoaded#" item="idx">
		<tr>
			<td<!---  rowspan="2" ---> valign="top" align="center"><input type="checkbox" name="lmodules" value="#idx#" id="module_#idx#" checked="checked" disabled="disabled"/></td>
			<td><label for="module_#idx#">#stModulesLoaded[idx].info.name#</label></td>
			<td align="center">#stModulesLoaded[idx].info.version#</td>
			<td align="center">#session.oUser.dateTimeFormat(stModulesLoaded[idx].info.date)#</td>
			<td>#idx#/</td>
		</tr>
		<tr style="display: none;">
			<td class="empty text_light text_small" colspan="4">
				<!--- TODO: $$$ ---> Type: <strong>#stModulesLoaded[idx].general.type#</strong>
				<br>
				#request.content.author# <strong>#stModulesLoaded[idx].info.author#</strong>
				<br>
				<!--- TODO: $$$ ---> Url #stModulesLoaded[idx].info.url#
				<br>

				<cfif len(stModulesLoaded[idx].info.hint)>
					<br>&nbsp;<br>#stModulesLoaded[idx].info.hint#
				</cfif>
				
				<cfif StructKeyExists(stModulesLoaded[idx],'dependencies') AND NOT StructIsEmpty(stModulesLoaded[idx].dependencies)>
					<br>&nbsp;<br><strong><!--- TODO: $$$ ---> Dependencies</strong><br>
					<cfloop collection="#stModulesLoaded[idx].dependencies#" item="item">
						#item#<br>
						<cfloop collection="#stModulesLoaded[idx].dependencies[item]#" item="item2">
							<cfscript>
								sFileFolderString = '[root]';
								if(len(stModulesLoaded[idx].dependencies[item][item2].file)){
									if(left(stModulesLoaded[idx].dependencies[item][item2].file,1) NEQ '/')
										sFileFolderString = sFileFolderString & '#stModulesLoaded[idx].type#/#stModulesLoaded[idx].dir#/';
									sFileFolderString = sFileFolderString & stModulesLoaded[idx].dependencies[item][item2].file;
								}
								else if(len(stModulesLoaded[idx].dependencies[item][item2].folder)){
									if(left(stModulesLoaded[idx].dependencies[item][item2].folder,1) NEQ '/')
										sFileFolderString = sFileFolderString & '#stModulesLoaded[idx].type#/#stModulesLoaded[idx].dir#/';
									sFileFolderString = sFileFolderString & stModulesLoaded[idx].dependencies[item][item2].folder;
									if(right(stModulesLoaded[idx].dependencies[item][item2].folder,1) NEQ '/')
										sFileFolderString = sFileFolderString & '/';
								}
							</cfscript>
							#sFileFolderString#<br>
						</cfloop>
					</cfloop>
				</cfif>
			</td>
		</tr>
	</cfloop>
	<tr>
		<td class="empty" colspan="6"><input type="button" onclick="selectAll(this.form);" value="#request.content.form_selectall#"#sDisabled#> <input type="submit" value="#request.content.form_save#"#sDisabled#></td>
	</tr>
	</form>
</table> --->

<h4><!--- TODO: $$$ --->Filesystem</h4>

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
<input type="hidden" name="form_submitted" value="true"/>
<input type="hidden" name="mode" value="install"/>
<table>
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.name#</th>
		<th>#request.content.version#</th>
		<th>#request.content.date#</th>
		<th>#request.content.directory#</th>
		<th>$$$ Options</th>
	</tr>
	<cfloop collection="#stModulesFilesystem#" item="idx">
		<cfif stModulesFilesystem[idx].status>
			<tr>
				<td<!---  rowspan="2" ---> valign="top" align="center"><input type="checkbox" name="lmodules" value="#idx#" id="module_#idx#"/></td>
				<td><label for="module_#idx#">#stModulesFilesystem[idx].data.info.name#</label></td>
				<td align="center">#stModulesFilesystem[idx].data.info.version#</td>
				<td align="center">#session.oUser.dateTimeFormat(stModulesFilesystem[idx].data.info.date,'date')#</td>
				<td>#idx#/</td>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#">$$$ Install</a></td>
			</tr>
			<tr style="display: none;">
				<td class="empty text_light text_small" colspan="4">
					<!--- TODO: $$$ ---> Type: <strong>#stModulesFilesystem[idx].data.general.type#</strong>
					<br>
					#request.content.author# <strong>#stModulesFilesystem[idx].data.info.author#</strong>
					<br>
					<!--- TODO: $$$ ---> Url #stModulesFilesystem[idx].data.info.url#
					<br>
	
					<cfif len(stModulesFilesystem[idx].data.info.hint)>
						<br>&nbsp;<br>#stModulesFilesystem[idx].data.info.hint#
					</cfif>
					
					<cfif StructKeyExists(stModulesFilesystem[idx].data,'dependencies') AND NOT StructIsEmpty(stModulesFilesystem[idx].data.dependencies)>
						<br>&nbsp;<br><strong><!--- TODO: $$$ ---> Dependencies</strong><br>
						<cfloop collection="#stModulesFilesystem[idx].data.dependencies#" item="item">
							#item#<br>
							<cfloop collection="#stModulesFilesystem[idx].data.dependencies[item]#" item="item2">
								<cfscript>
									sFileFolderString = '[root]';
									if(len(stModulesFilesystem[idx].data.dependencies[item][item2].file)){
										if(left(stModulesFilesystem[idx].data.dependencies[item][item2].file,1) NEQ '/')
											sFileFolderString = sFileFolderString & '#stModulesFilesystem[idx].data.type#/#stModulesFilesystem[idx].dir#/';
										sFileFolderString = sFileFolderString & stModulesFilesystem[idx].dependencies[item][item2].file;
									}
									else if(len(stModulesFilesystem[idx].data.dependencies[item][item2].folder)){
										if(left(stModulesFilesystem[idx].data.dependencies[item][item2].folder,1) NEQ '/')
											sFileFolderString = sFileFolderString & '#stModulesFilesystem[idx].data.type#/#stModulesFilesystem[idx].dir#/';
										sFileFolderString = sFileFolderString & stModulesFilesystem[idx].data.dependencies[item][item2].folder;
										if(right(stModulesFilesystem[idx].data.dependencies[item][item2].folder,1) NEQ '/')
											sFileFolderString = sFileFolderString & '/';
									}
								</cfscript>
								#sFileFolderString#<br>
							</cfloop>
						</cfloop>
					</cfif>
				</td>
			</tr>
		</cfif>
	</cfloop>
	<cfloop collection="#stModulesFilesystem#" item="idx">
		<cfif NOT stModulesFilesystem[idx].status>
			<tr>
				<td valign="top" align="center"><input type="checkbox" disabled="disabled"/></td>
				<td colspan="3">#stModulesFilesystem[idx].data.message#: #stModulesFilesystem[idx].data.detail#</td>
				<td>#idx#/</td>
				<td><a href="##" onclick="$('##module_#idx#_debug').toggle();return false;">$$$ Info</a></td>
			</tr>
			<tr id="module_#idx#_debug" style="display: none;">
				<td>&nbsp;</td>
				<td colspan="5">#stModulesFilesystem[idx].data.tagcontext[1].template#<br/>#stModulesFilesystem[idx].data.tagcontext[1].codeprinthtml#</td>
			</tr>
		</cfif>
	</cfloop>
	<tr>
		<td class="empty" colspan="6"><input type="button" onclick="selectAll(this.form);" value="#request.content.form_selectall#"> <input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>

<!--- <h4>#request.content.core#</h4>
<table>
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
				<td rowspan="2" valign="top" align="center"><input type="checkbox" checked="checked" disabled="disabled"></td>
				<td><label for="#stModulesAvaible[idx].dir#">#stModulesAvaible[idx].name#</label></td>
				<cfif NOT StructKeyExists(stModulesInstalled,idx)>
					<cfparam name="stModulesInstalled['#idx#']" default="#StructNew()#">
					<cfparam name="stModulesInstalled['#idx#'].version" default="#stModulesAvaible[idx].version#">
				</cfif>
				<td align="center"><cfif stModulesInstalled[#idx#].version NEQ stModulesAvaible[idx].version><span class="text_important">#stModulesInstalled[idx].version# -&gt; #stModulesAvaible[idx].version#</span><cfelse>#stModulesAvaible[idx].version#</cfif></td>
				<td align="center"><cftry>#LSDateFormat(stModulesAvaible[idx].date)#<cfcatch>#LSDateFormat(ParseDateTime('#stModulesAvaible[idx].date# 00:00:00'))#<!--- for BlueDragon 6.2 ---></cfcatch></cftry></td>
				<td>#stModulesAvaible[idx].dir#/</td>
			</tr>
			<tr>
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
			</tr>
		</cfif>
	</cfloop>
</table>

<h4>#request.content.modules#</h4>
<table>
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.name#</th>
		<th>#request.content.version#</th>
		<th>#request.content.date#</th>
		<th>#request.content.directory#</th>
	</tr>
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
	<input type="hidden" name="form_submitted" value="true"/>
	<cfloop list="#ArrayToList(StructSort(stModulesAvaible,'textnocase','ASC','name'))#" index="idx">
		<cfif stModulesAvaible[idx].type EQ "core">
			<input type="hidden" name="lmodules" value="#stModulesAvaible[idx].dir#"/>
		</cfif>
	</cfloop>
	<cfloop list="#ArrayToList(StructSort(stModulesAvaible,'textnocase','ASC','name'))#" index="idx">
		<cfif stModulesAvaible[idx].type EQ "module">
			<tr>
				<td rowspan="2" valign="top" align="center"><input type="checkbox" name="lmodules" value="#stModulesAvaible[idx].dir#" id="#stModulesAvaible[idx].dir#"<cfif ListFindNoCase(lModulesInstalled, idx)> checked="checked"</cfif>#sDisabled#></td>
				<td><label for="#stModulesAvaible[idx].dir#">#stModulesAvaible[idx].name#</label></td>
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
			<tr>
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
			</tr>
		</cfif>
	</cfloop>
	<tr>
		<td class="empty" colspan="6"><input type="button" onclick="selectAll(this.form);" value="#request.content.form_selectall#"#sDisabled#> <input type="submit" value="#request.content.form_save#"#sDisabled#></td>
	</tr>
	</form>
</table> --->
</cfoutput>

<cfsetting enablecfoutputonly="No">