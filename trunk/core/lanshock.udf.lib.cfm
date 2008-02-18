<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinclude template="_utils/udf/_isbif.cfm">

<cfif NOT isBIF('GetLocaleDisplayName()')>
	<cfinclude template="_utils/udf/_getlocaledisplayname.cfm">
</cfif>

<cffunction name="UDF_getNavigation" output="false" returntype="struct">
	
	<cfset var stNav = StructNew()>
	<cfset var langNavigation = ''>
	
	<cfif isDefined("Application.Module") AND isStruct(Application.Module) AND NOT StructIsEmpty(Application.Module)>
		<!--- Loop over existing Modules --->
		<cfloop list="#ListSort(StructKeyList(Application.Module),'TEXT','ASC')#" index="idx">
		
			<cfif application.module[idx].general.createCircuit>

				<cfset langNavigation = StructNew()>
	
				<cfif application.module[idx].general.loadLanguageFile>
					<cfinvoke component="#application.lanshock.environment.componentpath#core.language" method="getLanguageStrings" returnvariable="langNavigation">
						<cfinvokeargument name="base" value="#langNavigation#">
						<cfinvokeargument name="lang" value="#session.lang#">
						<cfinvokeargument name="path" value="#application.module[idx].module_path_rel#">
					</cfinvoke>
				</cfif>
	
				<cfscript>				
					stNav[idx] = StructNew();
					stNav[idx].action = 'main';
					stNav[idx].sub = StructNew();
					stNav[idx].type = Application.Module[idx].type;
					stNav[idx].reqlogin = Application.Module[idx].general.reqLogin;
					typeKey = stNav[idx].type;
					moduleKey = idx;
					if(stNav[idx].type EQ 'module') typeKey = 'modules';
					else if(stNav[idx].type EQ 'core') moduleKey = ListDeleteAt(idx,1,'_');
					
					if(StructKeyExists(langNavigation,'__globalmodule__name')) stNav[idx].name = langNavigation['__globalmodule__name'];
					else stNav[idx].name = Application.Module[idx].name;
				</cfscript>
	
				<!--- Get Navigation Entrys --->
				<cfif NOT StructIsEmpty(Application.Module[idx].navigation)>
					
					<cfscript>
						// Create Module Navigation
						lNavItems = ListSort(StructKeyList(Application.Module[idx].navigation),'numeric','ASC');
					</cfscript>
	
					<cfloop list="#lNavItems#" index="idx2">
						<cfscript>
							// Check if Item should show
							if(Application.Module[idx].navigation[idx2].reqstatus EQ 'admin' AND session.isAdmin
								 OR Application.Module[idx].navigation[idx2].reqstatus EQ 'notloggedin' AND NOT session.userloggedin
								 OR Application.Module[idx].navigation[idx2].reqstatus EQ 'loggedin' AND session.userloggedin
								 OR NOT len(Application.Module[idx].navigation[idx2].reqstatus)){
								stNav[idx].sub[idx2] = StructNew();
								stNav[idx].sub[idx2].action = Application.Module[idx].navigation[idx2].action;
								stNav[idx].sub[idx2].reqstatus = Application.Module[idx].navigation[idx2].reqstatus;
								
								if(StructKeyExists(langNavigation,'__globalmodule__navigation__#Application.Module[idx].navigation[idx2].action#')) stNav[idx].sub[idx2].name = langNavigation['__globalmodule__navigation__#Application.Module[idx].navigation[idx2].action#'];
								else stNav[idx].sub[idx2].name = stNav[idx].sub[idx2].action;
							}
						</cfscript>
					</cfloop>
				</cfif>
			</cfif>
		</cfloop>
	</cfif>

	<cfreturn stNav>
	
</cffunction>
	
<cffunction name="ConvertText" output="false" returntype="string">
	<cfargument name="text" type="string" required="true">
	<cfargument name="allow_audio" type="boolean" required="false" default="true">
	<cfargument name="allow_video" type="boolean" required="false" default="true">
	<cfargument name="allow_img" type="boolean" required="false" default="true">
	<cfargument name="allow_url" type="boolean" required="false" default="true">
	<cfargument name="allow_html" type="boolean" required="false" default="false">
	
	<cfset var sConvertedText = arguments.text>
	
	<cfinclude template="_utils/converttext.cfm">
	
	<cfreturn sConvertedText>
	
</cffunction>

<cffunction name="formatContentString" output="false" returntype="string">
	<cfargument name="string" required="true" type="string">
	<cfargument name="values" required="true">
	
	<cfset var i = 0>
	<cfset var tmpStr = arguments.string>

	<cfif isArray(arguments.values)>
		<cfloop index="i" from="1" to="#arrayLen(arguments.values)#">
			<cfset tmpStr=replace(tmpStr,"{#i#}",arguments.values[i],"ALL")>
		</cfloop>
	<cfelse>
		<cfset tmpStr=replace(tmpStr,"{1}",arguments.values,"ALL")>
	</cfif>

	<cfreturn tmpStr>

</cffunction>

<cffunction name="getUsernameById" output="false" returntype="string">
	<cfargument name="userid" type="numeric" required="true">
	
	<cfset var stLocal = StructNew()>

	<cfif arguments.userid EQ 0>
		<cfset stLocal.sReturn = "#request.content.__core_utils_user_guest#">
	<cfelse>

		<cfif len(request.lanshock.environment.datasource)>
			<!--- Cache Query for 10 minutes --->
			<cfquery datasource="#request.lanshock.environment.datasource#" name="stLocal.qUsernames" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
				SELECT id, name
				FROM user
			</cfquery>
		
			<cfquery result="test" dbtype="query" name="stLocal.qUsername">
				SELECT name
				FROM stLocal.qUsernames
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			</cfquery>
			
			<cfif stLocal.qUsername.recordcount>
				<cfset stLocal.sReturn = stLocal.qUsername.name>			
			<cfelse>
				<cfset stLocal.sReturn = "#request.content.error_unknownuser# (#arguments.userid#)">
			</cfif>
		<cfelse>
			<cfset stLocal.sReturn = "#request.content.error_unknownuser# (#arguments.userid#)">
		</cfif>
	
	</cfif>
	
	<cfreturn stLocal.sReturn>
	
</cffunction>

<cffunction name="getUserdataById" output="false" returntype="query">
	<cfargument name="userid" type="numeric" required="true">

	<!--- Cache Query for 2 minutes --->
	<cfquery datasource="#request.lanshock.environment.datasource#" name="qUserdatas" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
		SELECT *
		FROM user
	</cfquery>

	<cfquery name="qUserdata" dbtype="query">
		SELECT *
		FROM qUserdatas
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
	</cfquery>

	<cfreturn qUserdata>
</cffunction>

<cffunction name="UserShowAvatar" output="false" returntype="string">
	<cfargument name="userid" type="string" required="false">
	<cfargument name="mode" type="string" required="false" default="#application.lanshock.settings.layout.avatar.mode#">
	
	<cfset var stLocal = StructNew()>
	<cfset stLocal.sResult = ''>
	
	<cfif isNumeric(arguments.userid)>
		<cfswitch expression="#arguments.mode#">
			<cfcase value="gravatar">
				<cfset stLocal.userdata = getUserdataById(arguments.userid)>
				<cfset stLocal.sResult = '<img src="http://www.gravatar.com/avatar.php?gravatar_id=#Hash(stLocal.userdata.email)#&amp;rating=R&amp;" title="#getUsernameById(arguments.userid)#''s Gravatar" alt="#getUsernameById(arguments.userid)#''s Gravatar" />'>
			</cfcase>
			<cfdefaultcase> <!--- value="lanshock" --->
				<cfif isNumeric(arguments.userid)>
					<cfif FileExists("#request.lanshock.environment.abspath#core/user/avatar/#arguments.userid#.png")>
						<cfset stLocal.sResult = '<img src="#request.lanshock.environment.webpath#core/user/avatar/#arguments.userid#.png" title="#getUsernameById(arguments.userid)#" alt="#getUsernameById(arguments.userid)#" />'>
					<cfelseif FileExists("#request.lanshock.environment.abspath#core/user/avatar/#arguments.userid#")>
						<cfset stLocal.sResult = '<img src="#request.lanshock.environment.webpath#core/user/avatar/#arguments.userid#" title="#getUsernameById(arguments.userid)#" alt="#getUsernameById(arguments.userid)#" />'>
					</cfif>
				</cfif>
			</cfdefaultcase>
		</cfswitch>
	</cfif>

	<cfreturn stLocal.sResult>
</cffunction>

<cffunction name="UDF_DateTimeFormat" output="false" returntype="string">
	<cfargument name="datetime" type="string" required="true">
	
	<cfset var dt_datetime = arguments.datetime>
	
	<cfif isDate(dt_datetime) AND NOT LsIsDate(dt_datetime)>
		<cfset dt_datetime = ParseDateTime(dt_datetime)>
	</cfif>
	<cftry>
		<cfreturn LSDateFormat(dt_datetime) & " " & LSTimeFormat(dt_datetime)>
		<cfcatch><cfreturn ''></cfcatch>
	</cftry>
</cffunction>

<cffunction name="UDF_Module" output="false" returntype="string">
	<cfargument name="info" type="string" required="false" default="">
	<cfargument name="curr_module" type="string" required="false" default="#myfusebox.thiscircuit#">

	<cfswitch expression="#arguments.info#">
		<cfcase value="webPath">
			<cfreturn application.module[arguments.curr_module].module_path_web>
		</cfcase>
		<cfcase value="webPathFull">
			<cfreturn application.lanshock.environment.webpathfull & application.module[arguments.curr_module].module_path_rel>
		</cfcase>
		<cfcase value="absPath">
			<cfreturn application.module[arguments.curr_module].module_path_abs>
		</cfcase>
		<cfdefaultcase>
			<cfreturn myfusebox.thiscircuit>
		</cfdefaultcase>
	</cfswitch>

</cffunction>

<cffunction name="UDF_SecurityCheck" returntype="any" output="false">
	<cfargument name="area" type="string" required="true" default="">
	<cfargument name="module" type="string" required="false" default="">
	<cfargument name="returntype" type="string" required="false" default="relocate">
	
	<cfscript>
		var bResult = true;
		var oAdmin = '';
	
		if(NOT len(trim(arguments.module))) arguments.module = myfusebox.thiscircuit;

		if(session.isAdmin AND NOT StructKeyExists(session, 'rights')){
			oAdmin = CreateObject('component','#request.lanshock.environment.componentpath#core.admin.admin');
			oAdmin.setAdminSessionRights(session.userid);
		}
		
		if(NOT session.isAdmin) bResult = false;

		if(NOT StructKeyExists(session, 'rights') OR 
			NOT isStruct(session.rights) OR
			NOT StructKeyExists(session.rights,arguments.module) OR  
			NOT StructKeyExists(session.rights[arguments.module], 'areas') OR 
			NOT StructKeyExists(session.rights[arguments.module].areas, arguments.area))
			 bResult = false;
		else bResult = session.rights[arguments.module].areas[arguments.area];
	</cfscript>
	
	<cfif arguments.returntype EQ 'boolean'>
		<cfreturn bResult>
	<cfelse>
		<!--- default: relocate --->
		<cfif NOT bResult> 
			<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#general.noright&right_module=#arguments.module#&right_area=#arguments.area#&#session.urltoken#" addtoken="false"> 
		</cfif>
	</cfif>

</cffunction>

</cfsilent><cfsetting enablecfoutputonly="No">