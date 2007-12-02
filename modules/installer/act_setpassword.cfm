<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/act_setpassword.cfm $
$LastChangedDate: 2006-10-23 00:39:57 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 51 $
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