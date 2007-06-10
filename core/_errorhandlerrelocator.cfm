<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfswitch expression="#stGlobalCfcatch.type#">
	<!--- TODO: relocation --->
	<cfcase value="fusebox.undefinedFuseaction">
		<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#general.error&type=#UrlEncodedFormat(stGlobalCfcatch.type)#&message=#UrlEncodedFormat(stGlobalCfcatch.message)#&#request.session.urltoken#" addtoken="false">
	</cfcase>
</cfswitch>

<cfsetting enablecfoutputonly="No">