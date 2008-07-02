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
		
		if(fb_.verbInfo.attributes.type EQ 'style')
			fb_appendLine('<cfhtmlhead text="<style type=""text/css"">#fb_.verbInfo.attributes.content#</style>">');
		else
			fb_appendLine('<cfhtmlhead text="#fb_.verbInfo.attributes.content#">');

	} else {
		
		// do nothing
		
	}
</cfscript>