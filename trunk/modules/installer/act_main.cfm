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
<cfparam name="attributes.form_action" default="">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfparam name="attributes.bConfigSaved" default="false">
<cfparam name="bUserSaved" default="false">
<cfparam name="attributes.root_email" default="">
<cfparam name="attributes.root_password" default="">

<cfparam name="attributes.password" default="#stRuntimeConfig.lanshock.password#">
<cfif StructKeyExists(stRuntimeConfig.lanshock,'datasource')>
	<cfparam name="attributes.datasource" default="#stRuntimeConfig.lanshock.datasource#">
<cfelse>
	<cfparam name="attributes.datasource" default="">
</cfif>
<cfif StructKeyExists(stRuntimeConfig.lanshock,'datasource_type')>
	<cfparam name="attributes.datasource_type" default="#stRuntimeConfig.lanshock.datasource_type#">
<cfelse>
	<cfparam name="attributes.datasource_type" default="">
</cfif>

<cfif attributes.form_submitted>

	<cfif attributes.form_action EQ 'config'>

		<cfif NOT len(attributes.datasource)>
			<cfset ArrayAppend(aError,"datasource")>
		</cfif>
		<cfif NOT len(attributes.datasource_type)>
			<cfset ArrayAppend(aError,"datasource_type")>
		</cfif>
	
		<cfif NOT ArrayLen(aError)>
	
			<cfset stRuntimeConfig.lanshock.password = attributes.password>
			<cfset stRuntimeConfig.lanshock.datasource = attributes.datasource>
			<cfset stRuntimeConfig.lanshock.datasource_type = attributes.datasource_type>
			
			<cfset application.lanshock.oRuntime.setRuntimeConfig(stRuntimeConfig)>
			
			<cfinvoke component="#application.lanshock.oModules#" method="loadInstalledModules"/>
			
			<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&bConfigSaved=1')#" addtoken="false">
	
		</cfif>
	
	<cfelseif attributes.form_action EQ 'user'>
	
		<cfif len(attributes.root_email) AND len(attributes.root_password)>

			<cfquery name="qCheckEmail" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				SELECT id
				FROM user
				WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.root_email#">
			</cfquery>
		
			<cfif NOT qCheckEmail.recordcount>
				
				<cfset oUser = application.lanshock.oFactory.load('user','reactorRecord')>
				
				<cfset oUser.setName('root')>
				<cfset oUser.setFirstname('LANshock')>
				<cfset oUser.setLastname('Administrator')>
				<cfset oUser.setEmail(attributes.root_email)>
				<cfset oUser.setPwd(hash(attributes.root_password))>
				<cfset oUser.setGender(1)>
				<cfset oUser.setDt_registered(now())>
				<cfset oUser.setLanguage('de_DE')>
				<cfset oUser.save()>
				
				<cfset qRoles = application.lanshock.oFactory.load('core_security_users_roles_rel','reactorGateway').getRelOptions(sRelTable='core_security_roles')>
				
				<cfloop query="qRoles">
					<cfset oUser.getCore_security_users_roles_reliterator().add().setRole_id(qRoles.optionvalue)>
					<cfset oUser.getCore_security_users_roles_reliterator().add().setUser_id(oUser.getID())>
					<cfset oUser.getCore_security_users_roles_reliterator().add().save()>
				</cfloop>
				<cfset oUser.save()>	
				
				<cfset bUserSaved = true>
			
			<cfelse>
			
				<cfset ArrayAppend(aError,"user_email_duplicate")>
		
			</cfif>
		
		</cfif>
		
	</cfif>
	
</cfif>

<!--- get all avaible datasources --->
<cftry>
	<cfobject type="java" action="create" name="factory" class="coldfusion.server.ServiceFactory">
	<cfset lDatasources = StructKeyList(factory.getDataSourceService().getdatasources())>
	<cfcatch>
		<cfset lDatasources = ''>
	</cfcatch>
</cftry>
<cfset lDatasources = LCase(lDatasources)>
<cfset lDatasourcesTypes = 'mysql'>

<cfset stStatusDb = application.lanshock.oFactory.load('lanshock.modules.installer.installer').checkDbConnection()>
<cfset stStatusUser = application.lanshock.oFactory.load('lanshock.modules.installer.installer').checkUserAccounts()>

<cfsetting enablecfoutputonly="No">