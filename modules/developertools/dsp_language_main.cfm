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
<div class="headline">Language-File Editor</div>

<form action="#myself##myfusebox.thiscircuit#.language_refreshcache&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#" method="post">
<div align="center"><input type="submit" value="REFRESH LANGUAGE-CACHE"></div>
</form>

<table width="100%" cellpadding="10">
	<tr>
		<td valign="top">
			<table cellpadding="5">
				<cfloop list="#ListSort(StructKeyList(stDirs),'textnocase')#" index="idx0">
					<tr>
						<td colspan="2"><a name="level0_#idx0#"></a><div class="headline2">#idx0#</div></td>
					</tr>
					<cfloop list="#ListSort(StructKeyList(stDirs[idx0]),'textnocase')#" index="idx1">
						<tr>
							<td nowrap><a<cfif attributes.directory EQ '#idx0#/#idx1#/'> style="font-weight: bold;"</cfif> href="#myself##myfusebox.thiscircuit#.language_main&directory=#UrlEncodedFormat('#idx0#/#idx1#/')#&#request.session.urltoken#">#idx1#</a></td>
							<td nowrap align="right"><em<cfif attributes.directory EQ '#idx0#/#idx1#/'> style="font-weight: bold;"</cfif>>#StructCount(stDirs[idx0][idx1])# Files</em></td>
						</tr>
					</cfloop>
				</cfloop>
			</table>
		</td>
		<td valign="top">
			<table cellpadding="5" align="center" width="100%">
				<tr>
					<td><div class="headline2">#attributes.directory#</div></td>
				</tr>
				<tr>
					<td><a href="#myself##myfusebox.thiscircuit#.language_keys&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#" class="link_extended">New Language File</a> | 
						<a href="#myself##myfusebox.thiscircuit#.language_keys_comparison&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#" class="link_extended">Key Comparison</a> | </td>
				</tr>
				<tr>
					<td>&nbsp;<br>&nbsp;<br></td>
				</tr>
				<cfloop list="#ListSort(StructKeyList(stDirs[attributes.selection1][attributes.selection2]),'textnocase')#" index="idx2">
					<tr>
						<td><a href="#myself##myfusebox.thiscircuit#.language_editor&directory=#UrlEncodedFormat(attributes.directory)#&file=#idx2#&#request.session.urltoken#" title="#idx2#" class="link_extended">#stLocales[ListGetAt(idx2,2,'.')]#<cfif stDirs[attributes.selection1][attributes.selection2][idx2].default> <em><strong>(Default)</strong></em></cfif></a>
							<br><span style="color: gray;">#stDirs[attributes.selection1][attributes.selection2][idx2].size# Bytes, #UDF_DateTimeFormat(stDirs[attributes.selection1][attributes.selection2][idx2].date)#</span>
							<br><a href="#myself##myfusebox.thiscircuit#.language_download&directory=#UrlEncodedFormat(attributes.directory)#&file=#idx2#&#request.session.urltoken#" target="_blank">Download</a>
							 | <a href="#myself##myfusebox.thiscircuit#.language_editor&directory=#UrlEncodedFormat(attributes.directory)#&file=#idx2#&#request.session.urltoken#">Edit Strings</a>
							<cfif UDF_SecurityCheck(area='languagefiles_admin',returntype='boolean')>
								 | <a href="#myself##myfusebox.thiscircuit#.language_keys&directory=#UrlEncodedFormat(attributes.directory)#&file=#idx2#&#request.session.urltoken#">Edit Keys</a>
								<cfif NOT stDirs[attributes.selection1][attributes.selection2][idx2].default>
								 | <a href="#myself##myfusebox.thiscircuit#.language_delete&directory=#UrlEncodedFormat(attributes.directory)#&file=#idx2#&#request.session.urltoken#">Delete</a>
								 | <a href="#myself##myfusebox.thiscircuit#.language_default&directory=#UrlEncodedFormat(attributes.directory)#&file=#idx2#&#request.session.urltoken#">Set as Default</a>
								</cfif>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</table>
		</td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">