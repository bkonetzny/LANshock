<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
 
<cfif attributes.form_submitted>
	<cfscript>
		if(attributes.password EQ application.lanshock.settings.password) request.session.lanshock_installer = now();
		else if(StructKeyExists(request.session,'lanshock_installer')) StructDelete(request.session,lanshock_installer);
	</cfscript>

	<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.UrlToken#" addtoken="No">
</cfif>

<cfsetting enablecfoutputonly="No">