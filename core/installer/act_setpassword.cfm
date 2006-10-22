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
<cfparam name="attributes.password" default="false">

<cfif attributes.form_submitted>
	
	<cfif NOT FileExists(application.lanshock.config.file)>
		<cffile action="write" file="#application.lanshock.config.file#" output="" mode="777">
	</cfif>

	<cfset SetProfileString(application.lanshock.config.file,'lanshock','password',attributes.password)>

	<cflocation url="#myself##myfusebox.thiscircuit#.login&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">