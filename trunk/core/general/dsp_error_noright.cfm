<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.right_module" default="">
<cfparam name="attributes.right_area" default="">

<cfoutput>
<div class="headline">#request.content.righterr1#</div>
<table align="center">
	<tr>
		<td><img src="#stImageDir.module#/rights.gif" width="32" height="32" alt="" border="0"></td>
		<td>#request.content.righterr2#</td>
	</tr>
	<cfif len(attributes.right_module) AND len(attributes.right_area)>
		<cfset langSecurityContent = StructNew()>
		<cfif application.module[attributes.right_module].general.loadLanguageFile>
			<cfinvoke component="#application.lanshock.environment.componentpath#core.language" method="getLanguageStrings" returnvariable="langSecurityContent">
				<cfinvokeargument name="base" value="#langSecurityContent#">
				<cfinvokeargument name="lang" value="#request.session.lang#">
				<cfinvokeargument name="path" value="#application.module[attributes.right_module].module_path_rel#">
			</cfinvoke>
		</cfif>
		<tr>
			<td>&nbsp;</td>
			<td><strong>
					<cftry>
						#langSecurityContent['__globalmodule__name']#
						<cfcatch>#attributes.right_module#</cfcatch>
					</cftry> -> 
					<cftry>
						#langSecurityContent['__globalmodule__security__#attributes.right_area#']#
						<cfcatch>#attributes.right_area#</cfcatch>
					</cftry></strong><br>&nbsp;<br>&nbsp;<br></td>
		</tr>
	</cfif>
</cfoutput>
<cfif request.session.isAdmin>
	<cfloop list="#ListSort(StructKeyList(request.session.rights),'textnocase')#" index="item">
		<cfset langSecurityContent = StructNew()>
		<cfif application.module[item].general.loadLanguageFile>
			<cfinvoke component="#application.lanshock.environment.componentpath#core.language" method="getLanguageStrings" returnvariable="langSecurityContent">
				<cfinvokeargument name="base" value="#langSecurityContent#">
				<cfinvokeargument name="lang" value="#request.session.lang#">
				<cfinvokeargument name="path" value="#application.module[item].module_path_rel#">
			</cfinvoke>
		</cfif>
		<cfoutput>
			<tr>
				<td valign="top">
					<cftry>
						#langSecurityContent['__globalmodule__name']#
						<cfcatch>#item#</cfcatch>
					</cftry></td>
				<td valign="top"><ul>
						<cfloop list="#ListSort(StructKeyList(request.session.rights[item].areas),'textnocase')#" index="idx2">
							<li><span style="font-weight: bold; color: <cfif request.session.rights[item].areas[idx2]>##66CC00<cfelse>##CC0000</cfif>;">
								<cftry>
									#langSecurityContent['__globalmodule__security__#idx2#']#
									<cfcatch>#idx2#</cfcatch>
								</cftry></span></li>
						</cfloop>
					</ul>
				</td>
			</tr>
		</cfoutput>
	</cfloop>
</cfif>
<cfoutput>
	<tr>
		<td colspan="2"><a href="#CGI.HTTP_REFERER#" class="link_extended">#request.content.back#</a></td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">