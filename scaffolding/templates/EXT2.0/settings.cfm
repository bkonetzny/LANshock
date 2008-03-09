<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<cfset sModule = oMetaData.getModule()>>
<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/controller/custom_settings.cfm")>>
	<cfinclude template="custom_settings.cfm">
<</cfif>>