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
		
		fb_appendLine('<cfinvoke component="##application.lanshock.oLanguage##" method="loadProperties" returnvariable="#fb_.verbInfo.attributes.returnvariable#">');
		fb_appendLine('<cfinvokeargument name="base" value="###fb_.verbInfo.attributes.returnvariable###">');
		fb_appendLine('<cfinvokeargument name="lang" value="##session.lang##">');
		fb_appendLine('<cfinvokeargument name="file" value="#fb_.verbInfo.attributes.load#">');
		fb_appendLine('</cfinvoke>');

	} else {
		
		// do nothing
		
	}
</cfscript>