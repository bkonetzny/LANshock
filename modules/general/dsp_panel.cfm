<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_panel.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfhtmlhead text='<title>Panel</title>'>
<cfhtmlhead text='<meta http-equiv="Refresh" content="60">'>

<cfoutput>
<table style="width: 100%; height: 100%;" cellpadding="2" cellspacing="0">
	<tr>
		<td colspan="2" align="center"><em>#UDF_DateTimeFormat(now())#</em></td>
	</tr>
	<tr class="cellBg_02">
		<cfif StructCount(panel) GT 1>
			<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
			<td>
				<select name="showpanel" onChange="submit();">
					<cfloop collection="#panel#" item="idx">
						<option value="#idx#"<cfif idx EQ request.session.panel.active> selected</cfif>>#panel[idx].name#</option>
					</cfloop>
				</select>
				<noscript><input type="submit" value="Open"></noscript>
			</td>
		<cfelse>
			<td>#panel[idx].name#</td>
		</cfif>
		</form>
		<td align="right"><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#"><img src="#stImageDir.general#/refresh.gif" alt=""></a></td>
	</tr>
	<tr height="100%">
		<td colspan="2">
			<iframe src="#myself##panel[request.session.panel.active].module#.#panel[request.session.panel.active].action#&#request.session.urltoken#" name="#request.session.panel.active#" width="100%" marginwidth="0" height="100%" scrolling="auto" frameborder="0"></iframe>
		</td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">