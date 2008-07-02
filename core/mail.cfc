<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<cfcomponent>

	<cffunction name="sendEmail" access="public" returntype="void" output="false">
		<cfargument name="subject" type="string" required="true">
		<cfargument name="to" type="string" required="true">
		<cfargument name="body" type="string" required="true">
		<cfargument name="from" type="string" required="false" default="#application.lanshock.settings.mailserver.from#">
		<cfargument name="failto" type="string" required="false" default="#arguments.from#">

		<cfset application.lanshock.oLogger.writeLog('core.mail','Sending mail from "#arguments.from#" to "#arguments.to#", subject: "#arguments.subject#"','info')>

		<cfmail type="text/html"
				subject="#arguments.subject#"
				from="#arguments.from#"
				to="#arguments.to#"
				failto="#arguments.failto#"
				server="#application.lanshock.settings.mailserver.server#"
				port="#application.lanshock.settings.mailserver.port#"
				username="#application.lanshock.settings.mailserver.username#"
				password="#application.lanshock.settings.mailserver.password#">
			#arguments.body#
		</cfmail>
		
	</cffunction>

</cfcomponent>