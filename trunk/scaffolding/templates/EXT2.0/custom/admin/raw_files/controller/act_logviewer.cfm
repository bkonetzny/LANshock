<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_logviewer.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.logfile" default="">
<cfparam name="attributes.deletefile" default="">

<cfdirectory action="list" directory="#request.lanshock.environment.abspath#logs/" name="qLogs" filter="*.log" sort="name ASC">

<cfif len(attributes.deletefile) AND FileExists('#request.lanshock.environment.abspath#logs/#attributes.deletefile#')>
	<cffile action="delete" file="#request.lanshock.environment.abspath#logs/#attributes.deletefile#">
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.urltoken#" addtoken="false">
</cfif>

<cfif len(attributes.logfile) AND FileExists('#request.lanshock.environment.abspath#logs/#attributes.logfile#')>
	<cfcontent file="#request.lanshock.environment.abspath#logs/#attributes.logfile#" type="text/plain">
</cfif>

<cfsetting enablecfoutputonly="No">