<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2007-12-09 10:05:43 +0100 (So, 09 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 127 $
--->>

<<cfset sModule = oMetaData.getModule()>>
<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/controller/custom_settings.cfm")>>
	<cfinclude template="custom_settings.cfm">
<</cfif>>