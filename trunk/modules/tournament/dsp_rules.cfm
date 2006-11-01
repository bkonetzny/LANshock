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
<div class="headline2">#request.content.rules_headline#</div>

<cfif len(qTournament.rulefile)>
	<cfscript>
		if(ListLen(qTournament.rulefile,'/') EQ 2){
			sDirectory = ListFirst(qTournament.rulefile,'/');
			sFile = ListLast(qTournament.rulefile,'/');
		}
		else{
			sDirectory = '';
			sFile = qTournament.rulefile;
		}
		sFileExt = ListLast(sFile,'.');
		sFileName = ListDeleteAt(sFile,ListLen(sFile,'.'),'.');
		sFileUrlEncoded = sDirectory & '/' & UrlEncodedFormat(sFileName) & '.' & ListLast(sFileExt);
	</cfscript>
	<iframe src="#UDF_Module('webPath')#rules/#sFileUrlEncoded#" width="100%" height="600" frameborder="0"></iframe>
<cfelse>
#request.content.rules_norules#
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">