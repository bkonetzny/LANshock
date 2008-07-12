<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<cfset sModule = oMetaData.getModule()>>
<<cfif fileExists(expandPath('modules/$$sModule$$/controller/custom_settings.cfm'))>>
	<cfinclude template="custom_settings.cfm">
<</cfif>>