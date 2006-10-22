<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfswitch expression="#cfcatch.type#">
	<!--- TODO: relocation --->
	<cfcase value="fusebox.undefinedFuseaction">
		<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#general.error&type=#UrlEncodedFormat(cfcatch.type)#&message=#UrlEncodedFormat(cfcatch.message)#&#request.session.urltoken#" addtoken="false">
	</cfcase>
</cfswitch>

<cfsetting enablecfoutputonly="No">