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
stRuntimeConfig = getRuntimeConfig();

stConfig = StructNew();
stConfig.settings = StructNew();
stConfig.settings.appname = "LANshock";
stConfig.settings.language = "en_US";
stConfig.settings.startpage = "";
stConfig.settings.crypkey = hash(application.applicationname);
	
stConfig.settings.mailserver = StructNew();
stConfig.settings.mailserver.server = cgi.server_name;
stConfig.settings.mailserver.port = "25";
stConfig.settings.mailserver.username = "";
stConfig.settings.mailserver.password = "";
stConfig.settings.mailserver.from = "#stConfig.settings.appname# <no-reply@#cgi.server_name#>";
	
stConfig.settings.security = StructNew();
stConfig.settings.security.cron_hashkey = hash(CreateUUID());
stConfig.settings.security.check_sessionhijack = true;
stConfig.settings.security.check_useraccess_module = true;

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

stConfig.settings.debug = StructNew();
stConfig.settings.debug.show_plain_error = false;
stConfig.settings.debug.log_error = false;
stConfig.settings.debug.mail_error = false;
stConfig.settings.debug.error_email = "error@lanshock.com";

stConfig.settings.version = request.lanshock_version;
stConfig.settings.version_build = request.lanshock_build;

stConfig.settings.modulePrefix = StructNew();
stConfig.settings.modulePrefix.core = "c_"; // LANshock Core Alias
stConfig.settings.modulePrefix.module = "c_"; // LANshock Module Alias

stConfig.environment = StructNew();
stConfig.environment.abspath = left(GetDirectoryFromPath(GetCurrentTemplatePath()),len(GetDirectoryFromPath(GetCurrentTemplatePath()))-5); // 5 = "/core"
stConfig.environment.storagepath = stConfig.environment.abspath & 'storage/';
stConfig.environment.webpath = listDeleteAt(cgi.script_name, ListLen(cgi.script_name,"/"), "/") & "/";
if(cgi.server_port_secure) stConfig.environment.serveraddress = 'https://';
else stConfig.environment.serveraddress = 'http://';	
if(cgi.server_port EQ '80') stConfig.environment.serveraddress = stConfig.environment.serveraddress & cgi.server_name;
else stConfig.environment.serveraddress = stConfig.environment.serveraddress & cgi.server_name & ':' & cgi.server_port;
stConfig.environment.webpathfull = stConfig.environment.serveraddress & stConfig.environment.webpath;
stConfig.environment.datasource = stRuntimeConfig.lanshock.datasource;
stConfig.environment.datasource_type = stRuntimeConfig.lanshock.datasource_type;
stConfig.environment.componentpath = 'lanshock.';
stConfig.environment.mapping = '/';

try{
	CreateObject("component","#stConfig.environment.componentpath#core._utils._component_detector");
}
catch(any excpt){
	stMappings = getMappingFromPath('#stConfig.environment.abspath#core/_utils/_component_detector.cfc');
	if(stMappings.success){
		if(len(stMappings.sMapping)-len('core._utils.') GT 0){
			stConfig.environment.componentpath = left(stMappings.sMapping,len(stMappings.sMapping)-len('core._utils.'));
		}
		else stConfig.environment.componentpath = '';
	}
	
	try{
		CreateObject("component","#stConfig.environment.componentpath#core._utils._component_detector");
	}
	catch(any excpt){
		StructDelete(stConfig.environment,'componentpath');
	}
}
stConfig.environment.mapping = '/' & replace(stConfig.environment.componentpath,'.','/');
</cfscript>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.configmanager')#" method="createConfig" returnvariable="stConfig">
	<cfinvokeargument name="module" value="__core_runtime">
	<cfinvokeargument name="data" value="#stConfig#">
	<cfinvokeargument name="version" value="2.0b">
</cfinvoke>

<cfsetting enablecfoutputonly="No">