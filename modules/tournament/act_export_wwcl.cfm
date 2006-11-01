<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.wwcl_updategameini" default="false">

<cfif attributes.wwcl_updategameini>
	<cfhttp url="http://www.wwcl.net/download/xml_submit/gameini.xml" method="GET" path="#UDF_Module('absPath')#/export/wwcl/" file="gameini.xml" resolveurl="false"></cfhttp>
</cfif>

<cfif FileExists(UDF_Module('absPath') & '/export/wwcl/gameini.xml')>
	<cfscript>
		stExportData.WWCL.bGameini = true;
	</cfscript>
	<cfdirectory action="LIST" directory="#UDF_Module('absPath')#/export/wwcl/" filter="gameini.xml" name="gameini_file">
	<cffile action="READ" file="#UDF_Module('absPath')#/export/wwcl/gameini.xml" variable="gameini">
	<cfscript>
		stGameIni = XMLParse(gameini);
		stExportData.WWCL.bGameiniDate = gameini_file.datelastmodified;
		stExportData.WWCL.bGameiniData = StructNew();
	</cfscript>
	<cfloop from="1" to="#ArrayLen(stGameIni.wwclgameini.game)#" index="idx">
		<cfscript>
			stExportData.WWCL.bGameiniData[stGameIni.wwclgameini.game[idx].id.xmltext] = StructNew();
			stExportData.WWCL.bGameiniData[stGameIni.wwclgameini.game[idx].id.xmltext].name = stGameIni.wwclgameini.game[idx].name.xmltext;
			stExportData.WWCL.bGameiniData[stGameIni.wwclgameini.game[idx].id.xmltext].type = stGameIni.wwclgameini.game[idx].type.xmltext;
		</cfscript>
	</cfloop>
<cfelse>
	<cfscript>
		stExportData.WWCL.bGameini = false;
	</cfscript>
</cfif>

<cfsetting enablecfoutputonly="No">