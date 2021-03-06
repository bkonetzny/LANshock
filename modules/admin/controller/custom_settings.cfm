<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

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

<cffunction name="timeSpanConvert" access="public" returntype="string" output="false">
	<cfargument name="seconds" type="numeric" required="true">
	
	<cfset var sResult = ''>
	<cfset iBaseSeconds = arguments.seconds>
	<cfset iDays = 0>
	<cfset iHours = 0>
	<cfset iMinutes = 0>
	<cfset iSeconds = 0>
	
	<cfif iBaseSeconds GT (60*60*24)>
		<cfset iDays = int(iBaseSeconds / (60*60*24))>
	</cfif>
	
	<cfset iBaseSeconds = iBaseSeconds - (iDays * (60*60*24))>
	
	<cfif iBaseSeconds GT 60*60>
		<cfset iHours = int(iBaseSeconds / (60*60))>
	</cfif>
	
	<cfset iBaseSeconds = iBaseSeconds - (iHours * (60*60))>
	
	<cfif iBaseSeconds GT 60>
		<cfset iMinutes = int(iBaseSeconds / 60)>
	</cfif>
	
	<cfset iSeconds = iBaseSeconds - (iMinutes * (60))>
	
	<cfset sResult = NumberFormat(iDays,'00') & ':' & NumberFormat(iHours,'00') & ':' & NumberFormat(iMinutes,'00') & ':' & NumberFormat(iSeconds,'00')>

	<cfreturn sResult>
</cffunction>

<cffunction name="directoryCopy" access="public" returntype="void" output="false">
	<!---
	Copies a directory.
	
	@param source      Source directory. (Required)
	@param destination      Destination directory. (Required)
	@param nameConflict      What to do when a conflict occurs (skip, overwrite, makeunique). Defaults to overwrite. (Optional)
	@return Returns nothing.
	@author Joe Rinehart (joe.rinehart@gmail.com)
	@version 1, July 27, 2005
	--->
    <cfargument name="source" required="true" type="string">
    <cfargument name="destination" required="true" type="string">
    <cfargument name="nameconflict" required="true" default="overwrite">

    <cfset var qContents = "" />
    
    <cfif NOT directoryExists(arguments.destination)>
        <cfdirectory action="create" directory="#arguments.destination#" mode="777">
    </cfif>
    
    <cfdirectory action="list" directory="#arguments.source#" name="qContents">
	
    <cfloop query="qContents">
        <cfif qContents.type EQ "file">
            <cffile action="copy" source="#arguments.source#/#qContents.name#" destination="#arguments.destination#/#qContents.name#" nameconflict="#arguments.nameConflict#">
        <cfelseif qContents.type EQ "dir">
            <cfset directoryCopy(arguments.source & '/' & qContents.name, arguments.destination & '/' & qContents.name) />
        </cfif>
    </cfloop>
</cffunction>

<cfsetting enablecfoutputonly="No">