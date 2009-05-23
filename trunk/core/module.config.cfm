<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
stConfig = StructNew();

stConfig.settings = StructNew();
stConfig.settings.appname = "LANshock";
stConfig.settings.language = "en_US";
stConfig.settings.startpage = "";
stConfig.settings.google_maps_key = "";
	
stConfig.settings.mailserver = StructNew();
stConfig.settings.mailserver.server = cgi.server_name;
stConfig.settings.mailserver.port = "25";
stConfig.settings.mailserver.username = "";
stConfig.settings.mailserver.password = "";
stConfig.settings.mailserver.from = "#stConfig.settings.appname# <no-reply@#cgi.server_name#>";

stConfig.settings.layout = StructNew();
stConfig.settings.layout.template = "lanshock";
stConfig.settings.layout.smileyset = "_default";
stConfig.settings.layout.avatar = StructNew();
stConfig.settings.layout.avatar.mode = "lanshock"; // lanshock | gravatar
</cfscript>

<cfparam name="application.lanshock.settings.google_maps_key" default="">

<cfsetting enablecfoutputonly="false">