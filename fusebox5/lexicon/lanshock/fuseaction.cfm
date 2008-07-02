<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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