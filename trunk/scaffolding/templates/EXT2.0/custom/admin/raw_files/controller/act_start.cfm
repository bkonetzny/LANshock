<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_start.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted_application" default="false">
<cfparam name="attributes.cb_application" default="false">

<cfif attributes.form_submitted_application AND attributes.cb_application>
	
	<cfinvoke component="#application.lanshock.oApplication#" method="reloadApplication"/>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" addtoken="false">

</cfif>

<cfset oSystem = CreateObject("java", "java.lang.System")>
<cfset oRuntime = CreateObject("java", "java.lang.Runtime")>
<cfset oStreamReader = CreateObject("java", "java.io.InputStreamReader")>
<cfset oStreamReader.init(oSystem.in)>
<cfset oDbDriver = CreateObject("java", "com.mysql.jdbc.Driver")>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.datasource')#" method="getVersionInformation" returnvariable="sDbVersion"/>

<cfinvoke component="#application.lanshock.oRuntime#" method="getVersion" returnvariable="stVersion"/>

<cfset sServerSoftware = cgi.server_software>
<cfset sServerSoftware = rereplacenocase(sServerSoftware,'( \()','&nbsp;(','ALL')>
<cfset sServerSoftware = rereplacenocase(sServerSoftware,' ','<br>','ALL')>

<cffunction name="byteConvert" access="public" returntype="string" output="false">
	<cfargument name="num" type="numeric" required="true">
	<cfargument name="unit" type="string" required="false" default="">
	
	<!--- 
		* Pass in a value in bytes, and this function converts it to a human-readable format of bytes, KB, MB, or GB.
		* Updated from Nat Papovich's version.
		* 01/2002 - Optional Units added by Sierra Bufe (sierra@brighterfusion.com)
		* 
		* @param size 	 Size to convert. 
		* @param unit 	 Unit to return results in.  Valid options are bytes,KB,MB,GB. 
		* @return Returns a string. 
		* @author Paul Mone (sierra@brighterfusion.compaul@ninthlink.com) 
		* @version 2.1, January 7, 2002 		
	 --->
	<cfset var iResult = 0>
	<cfset var sUnit = "">
	<cfset var iModifier = "">
		
	<cfset var stSize = StructNew()>
	<cfset stSize.bytes = 1>
	<cfset stSize.kb = 1024>
	<cfset stSize.mb = 1048576>
	<cfset stSize.gb = 1073741824>

	<cfif ListFindNoCase("bytes,KB,MB,GB",arguments.unit)>
		<!--- Check to see if unit was passed in, and if it is valid --->
		<cfset sUnit = arguments.unit>
	<cfelse>
		<!--- If not, set unit depending on the size of num --->
		<cfif arguments.num LT stSize.kb>
			<cfset sUnit = "bytes">
		<cfelseif arguments.num LT stSize.mb>
			<cfset sUnit = "KB">
		<cfelseif arguments.num LT stSize.gb>
			<cfset sUnit = "MB">
		<cfelse>
			<cfset sUnit = "GB">
		</cfif>
	</cfif>
	
	<cfif sUnit EQ "bytes">
		<cfset iModifier = stSize.bytes>
	<cfelseif sUnit EQ "KB">
		<cfset iModifier = stSize.kb>
	<cfelseif sUnit EQ "MB">
		<cfset iModifier = stSize.mb>
	<cfelse>
		<cfset iModifier = stSize.gb>
	</cfif>
		
	<!--- Find the result by dividing num by the number represented by the unit --->
	<cfset iResult = arguments.num / iModifier>
		
	<!--- Format the result --->
	<cfif iResult LT 10>
		<cfset iResult = NumberFormat(Round(iResult * 100) / 100,"0.00")>
	<cfelseif iResult LT 100>
		<cfset iResult = NumberFormat(Round(iResult * 10) / 10,"90.0")>
	<cfelse>
		<cfset iResult = Round(iResult)>
	</cfif>

	<!--- Concatenate result and unit together for the return value --->
	<cfreturn iResult & " " & sUnit>
</cffunction>

<cfsetting enablecfoutputonly="No">