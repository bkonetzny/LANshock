<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfquery datasource="#application.lanshock.environment.datasource#" result="stResultSet">
	#PreserveSingleQuotes(stLocal.sSqlCode)#
</cfquery>

<cffile action="append" file="#application.lanshock.environment.abspath#logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #stLocal.mode#, #application.lanshock.environment.datasource#.#stLocal.tablename#">
<cffile action="append" file="#application.lanshock.environment.abspath#logs/core_setup_datasource_sql.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #stLocal.mode#, #application.lanshock.environment.datasource#.#stLocal.tablename#, #trim(stResultSet.sql)#">

<cfsetting enablecfoutputonly="No">