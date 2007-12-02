<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_showmodulrights.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->
 
<cfoutput>
<script language="JavaScript">
	<!--
		function selectAll(formObj){
			for (var i=0;i < formObj.length;i++){
				fldObj = formObj.elements[i];
				if (fldObj.type == 'checkbox') fldObj.checked = true;
			}
		}
	//-->
</script>
<div class="headline">#request.content.changeadminrights_headline#</div><br>
&nbsp;<br>
#request.content.changeadminrights_adminname# <strong>#GetUsernameByID(attributes.userid)#</strong><br>
#request.content.changeadminrights_lastchange# <cfif isDate(stSecurity.lastchange_dt)>#UDF_DateTimeFormat(stSecurity.lastchange_dt)#</cfif><br>
#request.content.changeadminrights_lastchange_by# <cfif len(stSecurity.lastchange_userid)>#GetUsernameByID(stSecurity.lastchange_userid)#</cfif>
<table>
	<form action="#myself##myfusebox.thiscircuit#.rights_update&#request.session.UrlToken#" method="post">
	<input type="hidden" name="userid" value="#attributes.userid#">
	<tr>
		<td>
			<table cellpadding="5">
				<cfloop list="#ListSort(StructKeyList(stSecurity.rights),'textnocase','ASC')#" index="Currmodul">
					<cfset langSecurityContent = StructNew()>
					<cfif application.module[currmodul].general.loadLanguageFile>
						<cfinvoke component="#application.lanshock.environment.componentpath#core.language" method="getLanguageStrings" returnvariable="langSecurityContent">
							<cfinvokeargument name="base" value="#langSecurityContent#">
							<cfinvokeargument name="lang" value="#request.session.lang#">
							<cfinvokeargument name="path" value="#application.module[currmodul].module_path_rel#">
						</cfinvoke>
					</cfif>
					<tr>
						<td colspan="3"><div class="headline2">
							<cftry>
								#langSecurityContent['__globalmodule__name']#
								<cfcatch>#UCase(Currmodul)#</cfcatch>
							</cftry></div>
						</td>
					</tr>
					<cfset counter = 0>
					<cfloop list="#ListSort(StructKeyList(stSecurity.rights[Currmodul].areas),'textnocase')#" index="Area">
						<tr>
							<td>
								<cfif stSecurity.rights[Currmodul].areas[Area]>
									<img src="#stImageDir.general#/status_led_green.gif" alt="">
								<cfelse>
									<img src="#stImageDir.general#/status_led_red.gif" alt="">
								</cfif>
							</td>
							<td><input id="#CurrModul#:#Area#" type="Checkbox" name="security_#CurrModul#" value="#Area#"<CFif stSecurity.rights[Currmodul].areas[Area]> checked</CFIF>> 
								<label for="#CurrModul#:#Area#">
									<strong>#stModule[Currmodul].securityareas[Area]#</strong>
								</label>
							</td>
							<td><cftry>
									<label for="#CurrModul#:#Area#">#langSecurityContent['__globalmodule__security__#Area#']#</label>
									<cfcatch>&nbsp;</cfcatch>
								</cftry>
							</td>
						</tr>
					</cfloop>
				</cfloop>
			</table>
		</td>
	</tr>
	<tr>
		<td><input type="button" onclick="selectAll(this.form);" value="#request.content.form_selectall#">&nbsp;<input type="Submit" name="Set" value="#request.content.form_save#"></td>
	</tr>
	</form>
	<tr>
		<td><a href="#myself##myfusebox.thiscircuit#.admin&#request.session.UrlToken#"class="link_extended">#request.content.back#</a></td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">