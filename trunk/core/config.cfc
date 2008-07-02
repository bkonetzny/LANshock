<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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