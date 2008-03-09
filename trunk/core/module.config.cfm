<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/mySettings.cfm $
$LastChangedDate: 2008-02-19 00:10:20 +0100 (Di, 19 Feb 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 163 $
--->

<cfscript>
stConfig = StructNew();

stConfig.settings = StructNew();
stConfig.settings.appname = "LANshock";
stConfig.settings.language = "en_US";
stConfig.settings.startpage = "";
	
stConfig.settings.mailserver = StructNew();
stConfig.settings.mailserver.server = cgi.server_name;
stConfig.settings.mailserver.port = "25";
stConfig.settings.mailserver.username = "";
stConfig.settings.mailserver.password = "";
stConfig.settings.mailserver.from = "#stConfig.settings.appname# <no-reply@#cgi.server_name#>";

stConfig.settings.layout = StructNew();
stConfig.settings.layout.template = "lanshock";
stConfig.settings.layout.smileyset = "_default";
stConfig.settings.layout.converttext = StructNew();
stConfig.settings.layout.converttext.escapehtml = true;
stConfig.settings.layout.converttext.pseudocode = true;
stConfig.settings.layout.avatar = StructNew();
stConfig.settings.layout.avatar.mode = "lanshock"; // lanshock | gravatar
stConfig.settings.layout.avatar.height = 80;
stConfig.settings.layout.avatar.width = 80;
</cfscript>

<cfsetting enablecfoutputonly="No">