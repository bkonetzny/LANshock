<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	stSmileySet = application.lanshock.settings.layout.smileyset_data;
	sPreCode = ' <img src="#stSmileySet.path_web#';
	sPostCode = '/> ';	
</cfscript>
	
<cfloop list="#stSmileySet.lSmileys#" index="idx">

	<cfset tmpIdx = idx>

	<cfif application.lanshock.settings.layout.converttext.escapehtml>
		<cfset tmpIdx = replaceList(tmpIdx, '<,>', '&lt;,&gt;')>
	</cfif>
	
	<cfscript>
		sConvertedText = Replace(sConvertedText, ' #tmpIdx# ', sPreCode & stSmileySet.smiley2[idx] & '" alt="#tmpIdx#" title="#tmpIdx#"' & sPostCode, 'all');
		sConvertedText = Replace(sConvertedText, '#tmpIdx# ', sPreCode & stSmileySet.smiley2[idx] & '" alt="#tmpIdx#" title="#tmpIdx#"' & sPostCode, 'all');
		sConvertedText = Replace(sConvertedText, ' #tmpIdx#', sPreCode & stSmileySet.smiley2[idx] & '" alt="#tmpIdx#" title="#tmpIdx#"' & sPostCode, 'all');
	</cfscript>

</cfloop>

<cfsetting enablecfoutputonly="No">