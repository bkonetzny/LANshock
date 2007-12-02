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
	aVars[idx] = 'Application'; idx = idx + 1;
	aVars[idx] = 'Application.Datasource'; idx = idx + 1;
	aVars[idx] = 'Application.Fusebox'; idx = idx + 1;
	aVars[idx] = 'Application.LANshock'; idx = idx + 1;
	aVars[idx] = 'Application.LANshock.Cache'; idx = idx + 1;
	aVars[idx] = 'Application.LANshock.Config'; idx = idx + 1;
	aVars[idx] = 'Application.LANshock.Settings'; idx = idx + 1;
	aVars[idx] = 'Application.LANshock.Environment'; idx = idx + 1;
	aVars[idx] = 'Application.Module'; idx = idx + 1;
	aVars[idx] = 'Application.ObjectBreeze'; idx = idx + 1;
	aVars[idx] = 'Application.Sessions'; idx = idx + 1;
	aVars[idx] = 'Variables'; idx = idx + 1;
	aVars[idx] = 'Variables.Attributes'; idx = idx + 1;
	aVars[idx] = 'Variables.myFusebox'; idx = idx + 1;
	aVars[idx] = 'Variables.myFusebox.Version'; idx = idx + 1;
	aVars[idx] = 'Request'; idx = idx + 1;
	aVars[idx] = 'Request.Content'; idx = idx + 1;
	aVars[idx] = 'Server'; idx = idx + 1;
	aVars[idx] = 'Session';
</cfscript>

<cfoutput>
	<div class="headline">#request.content.datadump#</div>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
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