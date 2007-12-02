<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/act_config.cfm $
$LastChangedDate: 2007-06-17 20:36:36 +0200 (So, 17 Jun 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 89 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.bConfigSaved" default="false">

<cfparam name="attributes.password" default="#application.lanshock.settings.password#">
<cfparam name="attributes.index_file" default="index.cfm">
<cfparam name="attributes.datasource" default="#application.lanshock.environment.datasource#">
<cfparam name="attributes.datasource_type" default="#application.lanshock.environment.datasource_type#">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT len(attributes.datasource)) ArrayAppend(aError,"datasource");
		if(NOT len(attributes.datasource_type)) ArrayAppend(aError,"datasource_type");
	</cfscript>

	<cfif NOT ArrayLen(aError)>

		<cfif len(attributes.password)>
			<cfset SetProfileString(application.lanshock.config.file,'lanshock','password',attributes.password)>
		</cfif>
		<cfset SetProfileString(application.lanshock.config.file,'lanshock','datasource',attributes.datasource)>
		<cfset SetProfileString(application.lanshock.config.file,'lanshock','datasource_type',attributes.datasource_type)>
		
		<cfscript>		
			// Refresh LANshock Application Vars
			application.lanshock.config.runable = false;
			application.lanshock.config.complete = false;
			application.lanshock.config.modulesinitialized = false;
			application.lanshock.config.datasourceinitialized = false;
		</cfscript>

		<cfinvoke component="#application.lanshock.environment.componentpath#modules.admin.setup" method="initCoreModules"/>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&bConfigSaved=1&#request.session.urltoken#" addtoken="false">

	</cfif>
	
</cfif>

<cfsetting enablecfoutputonly="No">