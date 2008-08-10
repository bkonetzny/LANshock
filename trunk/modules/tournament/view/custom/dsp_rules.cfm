<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
<h4>#request.content.rules_headline#</h4>

<cfif len(qTournament.rulefile)>
	<cfif ListLen(qTournament.rulefile,'/') EQ 2>
		<cfset sDirectory = ListFirst(qTournament.rulefile,'/')>
		<cfset sFile = ListLast(qTournament.rulefile,'/')>
	<cfelse>
		<cfset sDirectory = ''>
		<cfset sFile = qTournament.rulefile>
	</cfif>
	<cfset sFileExt = ListLast(sFile,'.')>
	<cfset sFileName = ListDeleteAt(sFile,ListLen(sFile,'.'),'.')>
	<cfset sFileUrlEncoded = sDirectory & '/' & UrlEncodedFormat(sFileName) & '.' & ListLast(sFileExt)>
	<iframe src="#application.lanshock.oHelper.UDF_Module('webStoragePathPublic')#rules/#sFileUrlEncoded#" width="100%" height="600" frameborder="0"></iframe>
<cfelse>
	#request.content.rules_norules#
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">