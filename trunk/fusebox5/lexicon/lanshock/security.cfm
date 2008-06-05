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
		
		fb_appendLine('<cfif NOT session.oUser.checkPermissions(area=''#fb_.verbInfo.attributes.area#'')>');
		fb_appendLine('<cflocation url="##application.lanshock.oHelper.buildUrl(''general.noright&right_module=##myfusebox.thiscircuit##&right_area=#fb_.verbInfo.attributes.area#'')##" addtoken="false">');
		fb_appendLine('</cfif>');

	} else {
		
		// do nothing
		
	}
</cfscript>