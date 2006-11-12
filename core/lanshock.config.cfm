<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="url.reinitapp" default="false">
<cfparam name="reinitapp" default="false">

<cfif url.reinitapp OR NOT isDefined("application.lanshock") OR NOT isStruct(application.lanshock) OR NOT isDefined("application.lanshock.config.complete") OR NOT application.lanshock.config.complete>
	<cfset reinitapp = true>
</cfif>

<cfif reinitapp OR NOT application.lanshock.config.configinitialized>
	<cfscript>
		if(reinitapp){
			StructDelete(application,'lanshock');
			StructDelete(application,'module');
			StructDelete(application,'fusebox');
		
			// default values
			application.lanshock = StructNew();
			application.lanshock.settings = StructNew();
			application.lanshock.environment = StructNew();
			application.lanshock.config = StructNew();
			application.lanshock.config.modulesinitialized = false;
			application.lanshock.config.datasourceinitialized = false;
		}
		
		application.lanshock.environment.abspath = left(GetDirectoryFromPath(GetCurrentTemplatePath()),len(GetDirectoryFromPath(GetCurrentTemplatePath()))-5); // 5 = "/core"
		application.lanshock.environment.storagepath = application.lanshock.environment.abspath & 'storage/';
		application.lanshock.environment.webpath = listDeleteAt(cgi.script_name, ListLen(cgi.script_name,"/"), "/") & "/";
		if(cgi.server_port_secure) application.lanshock.environment.serveraddress = 'https://';
		else application.lanshock.environment.serveraddress = 'http://';	
		if(cgi.server_port EQ '80') application.lanshock.environment.serveraddress = application.lanshock.environment.serveraddress & cgi.server_name;
		else application.lanshock.environment.serveraddress = application.lanshock.environment.serveraddress & cgi.server_name & ':' & cgi.server_port;
		application.lanshock.environment.webpathfull = application.lanshock.environment.serveraddress & application.lanshock.environment.webpath;
		application.lanshock.environment.datasource = '';
		application.lanshock.environment.datasource_type = '';
		
		// config info
		application.lanshock.config.dtCreated = now();
		application.lanshock.config.file = '#application.lanshock.environment.abspath#config/config.ini.cfm';
		application.lanshock.config.avaible = FileExists(application.lanshock.config.file);
		application.lanshock.config.configinitialized = true;
		application.lanshock.config.complete = false;
		if(application.lanshock.config.avaible){
			application.lanshock.config.complete = true;
			application.lanshock.config.stConfig = GetProfileSections(application.lanshock.config.file);
			
			for(idx=1;idx LTE listlen(application.lanshock.config.stConfig.lanshock);idx = idx + 1){
				application.lanshock.config.stConfig[ListGetAt(application.lanshock.config.stConfig.lanshock,idx)] = GetProfileString(application.lanshock.config.file,'lanshock',ListGetAt(application.lanshock.config.stConfig.lanshock,idx));
			}
			
			if(StructKeyExists(application.lanshock.config.stConfig,'password'))
				application.lanshock.settings.password = application.lanshock.config.stConfig.password;
			else {
				application.lanshock.config.complete = false;
			}
			
			if(StructKeyExists(application.lanshock.config.stConfig,'datasource'))
				application.lanshock.environment.datasource = application.lanshock.config.stConfig.datasource;
			else {
				application.lanshock.environment.datasource = '';
				application.lanshock.config.complete = false;
			}
			
			if(StructKeyExists(application.lanshock.config.stConfig,'datasource_type'))
				application.lanshock.environment.datasource_type = application.lanshock.config.stConfig.datasource_type;
			else {
				application.lanshock.environment.datasource_type = '';
				application.lanshock.config.complete = false;
			}
		}
		else application.lanshock.config.stConfig = StructNew();
		
		application.lanshock.settings.version = request.lanshock_version;
		application.lanshock.settings.version_build = request.lanshock_build;
		
		application.lanshock.settings.modulePrefix = StructNew();
		application.lanshock.settings.modulePrefix.core = "c_"; // LANshock Core Alias
		application.lanshock.settings.modulePrefix.module = "m_"; // LANshock Module Alias
		
		application.lanshock.environment.componentpath = 'lanshock.';

		try{
			CreateObject("component","#application.lanshock.environment.componentpath#core._utils._component_detector");
		}
		catch(any excpt){
			stMappings = getMappingFromPath('#application.lanshock.environment.abspath#core/_utils/_component_detector.cfc');
			if(stMappings.success){
				if(len(stMappings.sMapping)-len('core._utils.') GT 0){
					application.lanshock.environment.componentpath = left(stMappings.sMapping,len(stMappings.sMapping)-len('core._utils.'));
				}
				else application.lanshock.environment.componentpath = '';
			}
			
			try{
				CreateObject("component","#application.lanshock.environment.componentpath#core._utils._component_detector");
			}
			catch(any excpt){
				StructDelete(application.lanshock.environment,'componentpath');
			}
		}
	</cfscript>

</cfif>

<cfinclude template="mySettings.cfm">
<cfset StructMerge(application.lanshock.settings,stModuleConfig)>

<cfif reinitapp>

	<cfif NOT StructKeyExists(application.lanshock.environment, 'componentpath')>
		<cfthrow message="Invalid Component Path" detail="Auto-Detection of the LANshock Mapping hasn't been successfull. Please add a Mapping, pointing to the LANshock Root, in 'ColdFusion Administrator -> Mappings'.">
	</cfif>
	
	<cfif NOT application.lanshock.config.complete>
		<cfif NOT cgi.query_string CONTAINS "=#application.lanshock.settings.modulePrefix.core#installer">
			<cflocation url="#self#?fuseaction=#application.lanshock.settings.modulePrefix.core#installer.main" addtoken="true">
		</cfif>
	</cfif>
	
	<cfif len(application.lanshock.environment.datasource) AND len(application.lanshock.environment.datasource_type)>
		<cfset application.objectBreeze = createObject("component", "#application.lanshock.environment.componentpath#core._utils.objectbreeze.objectBreeze").init(application.lanshock.environment.datasource_type, application.lanshock.environment.datasource) />
		<cfset variables.objectBreeze = application.objectBreeze />
	</cfif>

</cfif>

<cfif len(application.lanshock.settings.layout.smileyset) AND (
		NOT StructKeyExists(application.lanshock.settings.layout,'smileyset_data')
		OR ListLast(application.lanshock.settings.layout.smileyset_data.path_web,'/') NEQ application.lanshock.settings.layout.smileyset)>
	<cfinvoke component="#application.lanshock.environment.componentpath#core.smileyset" method="getSmileySet" returnvariable="application.lanshock.settings.layout.smileyset_data">
</cfif>

<cfscript>
	// copy application vars to request scope
	request.lanshock = application.lanshock;
	// define content variable for language strings
	request.content = StructNew();
	
	// aliases
	stImageDir = StructNew();
	if(DirectoryExists(request.lanshock.environment.abspath & 'templates/' & request.lanshock.settings.layout.template & '/images/_general'))
		stImageDir.general = request.lanshock.environment.webpath & 'templates/' & request.lanshock.settings.layout.template & '/images/_general';
	else stImageDir.general = request.lanshock.environment.webpath & 'core/general/images/_general';
	stImageDir.template = request.lanshock.environment.webpath & 'templates/' & request.lanshock.settings.layout.template & '/images';
	
	if(StructKeyExists(application,'objectbreeze')) variables.objectbreeze = application.objectbreeze;
</cfscript>

</cfsilent><cfsetting enablecfoutputonly="No">