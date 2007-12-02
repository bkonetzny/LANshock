<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_onlineupdate.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
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