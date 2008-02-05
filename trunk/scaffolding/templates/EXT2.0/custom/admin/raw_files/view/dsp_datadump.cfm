<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_datadump.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.scope" default="">

<cfscript>
	idx = 1;
	aVars = ArrayNew(1);
	aVars[idx] = ''; idx = idx + 1;
	aVars[idx] = 'application'; idx = idx + 1;
	aVars[idx] = 'application.datasource'; idx = idx + 1;
	aVars[idx] = 'application.fusebox'; idx = idx + 1;
	aVars[idx] = 'application.lanshock'; idx = idx + 1;
	aVars[idx] = 'application.lanshock.cache'; idx = idx + 1;
	aVars[idx] = 'application.lanshock.config'; idx = idx + 1;
	aVars[idx] = 'application.lanshock.settings'; idx = idx + 1;
	aVars[idx] = 'application.lanshock.environment'; idx = idx + 1;
	aVars[idx] = 'application.module'; idx = idx + 1;
	aVars[idx] = 'variables'; idx = idx + 1;
	aVars[idx] = 'request'; idx = idx + 1;
	aVars[idx] = 'request.content'; idx = idx + 1;
	aVars[idx] = 'server'; idx = idx + 1;
	aVars[idx] = 'session';
</cfscript>

<cfoutput>
	<div class="headline">#request.content.datadump#</div>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.urltoken#" method="post">
		<div align="center">
			<select name="scope">
				<cfloop from="1" to="#ArrayLen(aVars)#" index="idx">
					<option value="#aVars[idx]#"<cfif attributes.scope EQ aVars[idx]> selected</cfif>>#aVars[idx]#</option>
				</cfloop>
			</select>
			<input type="submit" value="#request.content.form_save#">
		</div>
	</form>
</cfoutput>

<cfif len(attributes.scope) AND isDefined('#attributes.scope#')>
	<cfdump var="#evaluate(attributes.scope)#" label="#attributes.scope#">
</cfif>

<cfsetting enablecfoutputonly="No">