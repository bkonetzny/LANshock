<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
 
<cfscript>
	stOnlineUpdate = StructNew();
	stOnlineUpdate.version = '';
	stOnlineUpdate.build = '';
</cfscript>

<cfif attributes.form_submitted>
	<cfhttp url="http://update.lanshock.com/" resolveurl="no" useragent="LANshock OnlineUpdate"></cfhttp>

	<cfscript>
		xmlUpdateRAW = trim(cfhttp.filecontent);
		
		if(isXML(xmlUpdateRAW)){
			xmlUpdate = xmlParse(xmlUpdateRAW);
			stOnlineUpdate.version = xmlUpdate.lanshock.version.xmltext;
			stOnlineUpdate.build = ParseDateTime(xmlUpdate.lanshock.build.xmltext);
		}
	</cfscript>
	
</cfif>

<cfsetting enablecfoutputonly="No">