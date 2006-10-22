<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.logfile" default="">
<cfparam name="attributes.deletefile" default="">

<cfdirectory action="list" directory="#request.lanshock.environment.abspath#logs/" name="qLogs" filter="*.log" sort="name ASC">

<cfif len(attributes.deletefile) AND FileExists('#request.lanshock.environment.abspath#logs/#attributes.deletefile#')>
	<cffile action="delete" file="#request.lanshock.environment.abspath#logs/#attributes.deletefile#">
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif len(attributes.logfile) AND FileExists('#request.lanshock.environment.abspath#logs/#attributes.logfile#')>
	<cfcontent file="#request.lanshock.environment.abspath#logs/#attributes.logfile#" type="text/plain">
</cfif>

<cfsetting enablecfoutputonly="No">