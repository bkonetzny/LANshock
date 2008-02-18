<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/session.cfc $
$LastChangedDate: 2006-10-22 23:59:51 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 34 $
--->

<cfcomponent>
	
	<cffunction name="load" output="false" returntype="any">
		<cfargument name="sObject" type="string" required="true">
		<cfargument name="sType" type="string" required="false" default="component">
		<cfargument name="bCache" type="boolean" required="false" default="true">
		
		<cfset oReturn = ''>
		
		<cfswitch expression="#arguments.sType#">
			<cfcase value="reactor">
				<cfset oReturn = myFusebox.getApplication().getApplicationData().reactor.createGateway(arguments.sObject)>
			</cfcase>
			<!--- arguments.sType = 'component' --->
			<cfdefaultcase>
				<cfset oReturn = CreateObject('component',arguments.sObject)>
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn oReturn>
	</cffunction>

</cfcomponent>