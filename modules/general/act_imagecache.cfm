<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/modules/general/act_online.cfm $
$LastChangedDate: 2008-07-03 22:05:44 +0200 (Do, 03 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 371 $
--->

<cfset sFilename = application.lanshock.oRuntime.getEnvironment().sStoragePath & 'public/' & url.file>

<cfif FileExists(sFilename)>
	<cfset sDestination = attributes.width & 'x' & attributes.height & '/' & url.file>
	<cfset sDestinationBase = application.lanshock.oRuntime.getEnvironment().sStoragePath & 'public/cache/images/'>
	
	<cfif NOT DirectoryExists(GetDirectoryFromPath(sDestinationBase & sDestination))>
		<cfset sDirPath = ''>
		<cfset iDirs = ListLen(sDestination, '/') - 1>
		<cfloop from="1" to="#iDirs#" index="idx">
			<cfset sDirPath = sDirPath & ListGetAt(sDestination, idx, '/') & '/'>
			<cfif NOT DirectoryExists(sDestinationBase & sDirPath)>
				<cfdirectory action="create" directory="#sDestinationBase##sDirPath#" mode="777">
			</cfif>
		</cfloop>
	</cfif>
	
	<cfset bResized = false>
	
	<cfimage action="info" structName="stImageInfo" source="#sFilename#">
	<cfif stImageInfo.width GT attributes.width>
		<cfimage action="resize" source="#sFilename#" width="#attributes.width#" destination="#sDestinationBase##sDestination#" overwrite="true">
		<cfset bResized = true>
		<cfset sFilename = sDestinationBase & sDestination>
	</cfif>
	
	<cfimage action="info" structName="stImageInfo" source="#sFilename#">
	<cfif stImageInfo.height GT attributes.height>
		<cfimage action="resize" source="#sFilename#" height="#attributes.height#" destination="#sDestinationBase##sDestination#" overwrite="true">
		<cfset bResized = true>
	</cfif>
	
	<cfif NOT bResized>
		<cffile action="copy" source="#sFilename#" destination="#sDestinationBase##sDestination#">
	</cfif>

	<cflocation url="#application.lanshock.oRuntime.getEnvironment().sWebPath#storage/public/cache/images/#sDestination#">
<cfelse>
	<cfheader statuscode="404">
</cfif>

<cfsetting enablecfoutputonly="false">