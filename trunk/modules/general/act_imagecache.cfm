<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/modules/general/act_online.cfm $
$LastChangedDate: 2008-07-03 22:05:44 +0200 (Do, 03 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 371 $
--->

<cfparam name="url.file" default="">
<cfparam name="url.width" default="">
<cfparam name="url.height" default="">
<cfparam name="url.method" default="_scale">
<cfparam name="url.profile" default="">

<cfset sFilename = application.lanshock.oRuntime.getEnvironment().sStoragePath & 'public/' & url.file>

<cfif FileExists(sFilename)>
	<cfset attributes.file = url.file>
	<cfset attributes.width = url.width>
	<cfset attributes.height = url.height>
	<cfset attributes.method = url.method>
	<cfset attributes.profile = url.profile>
	
	<cfif NOT len(attributes.profile)>
		<cfset sDestination = attributes.width & 'x' & attributes.height & attributes.method & '/' & attributes.file>
	<cfelse>
		<cfset sDestination = attributes.profile & '/' & attributes.file>
	</cfif>
	
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
	
	<cfset bModified = false>
	
	<cfimage source="#sFilename#" name="oCfImage">
	
	<cfif NOT len(attributes.profile)>
		<cfswitch expression="#attributes.method#">
			<cfcase value="_crop">
				<cfset ImageCrop(oCfImage, 0, 0, attributes.width, attributes.height)>
			</cfcase>
			<cfcase value="_resize">
				<cfset ImageResize(oCfImage, attributes.width, attributes.height)>
			</cfcase>
			<cfdefaultcase><!--- _scale --->
				<cfset ImageScaleToFit(oCfImage, attributes.width, attributes.height)>
			</cfdefaultcase>
		</cfswitch>
	<cfelse>
		<cfswitch expression="#attributes.profile#">
			<cfcase value="keyvisual">
				<cfset ImageScaleToFit(oCfImage, 400, '')>
				<cfset ImageCrop(oCfImage, 0, 0, 400, 160)>
			</cfcase>
		</cfswitch>
	</cfif>
	
	<cfimage action="write" destination="#sDestinationBase##sDestination#" source="#oCfImage#" overwrite="true">
		
	<cflocation url="#application.lanshock.oRuntime.getEnvironment().sWebPath#storage/public/cache/images/#sDestination#">
<cfelse>
	<cfoutput>File #url.file# not found.</cfoutput>
	<cfheader statuscode="404">
</cfif>

<cfsetting enablecfoutputonly="false">