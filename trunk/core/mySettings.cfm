<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- create default config --->
<cfscript>
stDefaultModuleConfig = StructNew();
stDefaultModuleConfig.appname = "LANshock";
stDefaultModuleConfig.actionstring = "fuseaction";
stDefaultModuleConfig.language = "en_US";
stDefaultModuleConfig.startpage = "";
stDefaultModuleConfig.crypkey = hash(application.applicationname);
	
// Params: Layout
stDefaultModuleConfig.mailserver = StructNew();
stDefaultModuleConfig.mailserver.server = cgi.server_name;
stDefaultModuleConfig.mailserver.port = "25";
stDefaultModuleConfig.mailserver.username = "";
stDefaultModuleConfig.mailserver.password = "";
stDefaultModuleConfig.mailserver.from = "#stDefaultModuleConfig.appname# <no-reply@#cgi.server_name#>";
	
// Params: Security
stDefaultModuleConfig.security = StructNew();
stDefaultModuleConfig.security.cron_hashkey = hash(CreateUUID());
stDefaultModuleConfig.security.check_sessionhijack = true;
stDefaultModuleConfig.security.check_useraccess_module = true;

// Params: Security
stDefaultModuleConfig.sessionmanagement = StructNew();
stDefaultModuleConfig.sessionmanagement.type = "urltoken"; // urltoken | cookie
stDefaultModuleConfig.sessionmanagement.timeout = 3600; // seconds

// Params: Layout
stDefaultModuleConfig.layout = StructNew();
stDefaultModuleConfig.layout.template = "lanshock";
stDefaultModuleConfig.layout.smileyset = "_default";
stDefaultModuleConfig.layout.converttext = StructNew();
stDefaultModuleConfig.layout.converttext.escapehtml = true;
stDefaultModuleConfig.layout.converttext.pseudocode = true;
stDefaultModuleConfig.layout.avatar = StructNew();
stDefaultModuleConfig.layout.avatar.mode = "lanshock"; // lanshock | gravatar
stDefaultModuleConfig.layout.avatar.height = 80;
stDefaultModuleConfig.layout.avatar.width = 80;

// Params: Layout
stDefaultModuleConfig.cache = StructNew();
stDefaultModuleConfig.cache.languagefiles = true;
stDefaultModuleConfig.cache.circuitfiles = true;

// Params: Debug
stDefaultModuleConfig.debug = StructNew();
stDefaultModuleConfig.debug.show_plain_error = false;
stDefaultModuleConfig.debug.log_error = false;
stDefaultModuleConfig.debug.mail_error = false;
stDefaultModuleConfig.debug.error_email = "error@lanshock.com";
</cfscript>

<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="createConfig" returnvariable="stModuleConfig">
	<cfinvokeargument name="module" value="__core_runtime">
	<cfinvokeargument name="data" value="#stDefaultModuleConfig#">
	<cfinvokeargument name="version" value="0.1">
</cfinvoke>

<cfsetting enablecfoutputonly="No">