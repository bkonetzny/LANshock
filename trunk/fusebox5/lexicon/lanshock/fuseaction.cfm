<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/_tournament_header.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfscript>
	if (fb_.verbInfo.executionMode is "start") {

		fb_appendLine('<!--- lanshock:fuseaction --->');
		fb_appendLine("<cfif NOT StructKeyExists(myfusebox.getCurrentFuseaction().getCustomAttributes('lanshock'),'includedCircuit') OR (isBoolean(myfusebox.getCurrentFuseaction().getCustomAttributes('lanshock').includedCircuit) AND NOT myfusebox.getCurrentFuseaction().getCustomAttributes('lanshock').includedCircuit)>");

	} else {
		
		fb_appendLine('</cfif>');
		fb_appendLine('<!--- /lanshock:fuseaction --->');
		
	}
</cfscript>