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
		
		fb_appendLine('<cfinvoke component="##application.lanshock.environment.componentpath##core.language" method="getLanguageStrings" returnvariable="#fb_.verbInfo.attributes.returnvariable#">');
		fb_appendLine('<cfinvokeargument name="base" value="###fb_.verbInfo.attributes.returnvariable###">');
		fb_appendLine('<cfinvokeargument name="lang" value="##request.session.lang##">');
		fb_appendLine('<cfinvokeargument name="path" value="##application.module[myfusebox.thiscircuit].module_path_rel##">');
		fb_appendLine('</cfinvoke>');

	} else {
		
		// do nothing
		
	}
</cfscript>