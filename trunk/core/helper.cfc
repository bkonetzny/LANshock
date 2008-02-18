<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/sessionmanager.cfc $
$LastChangedDate: 2007-12-20 23:36:46 +0100 (Do, 20 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 143 $
--->

<cfcomponent>

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
		<cfargument name="curr_module" type="string" required="false" default="">

		<cfset var myFusebox = application.lanshock.oApplication.getMyFusebox()>
		<cfset sModule = ''>
		
		<cfif NOT len(arguments.curr_module)>
			<cfset arguments.curr_module = myfusebox.thiscircuit>
		</cfif>

		<cfset sModule = right(arguments.curr_module,len(arguments.curr_module)-2)>
	
		<cfswitch expression="#arguments.info#">
			<cfcase value="webPath">
				<cfreturn application.lanshock.environment.webpath & 'modules/#sModule#/'>
			</cfcase>
			<cfcase value="webPathFull">
				<cfreturn application.lanshock.environment.webpathfull & 'modules/#sModule#/'>
			</cfcase>
			<cfcase value="absPath">
				<cfreturn application.lanshock.environment.abspath & 'modules/#sModule#/'>
			</cfcase>
			<cfcase value="storagePathSecure">
				<cfreturn application.lanshock.sStoragePath & 'secure/modules/#sModule#/'>
			</cfcase>
			<cfcase value="absStoragePathPublic">
				<cfreturn application.lanshock.sStoragePath & 'public/modules/#sModule#/'>
			</cfcase>
			<cfcase value="webStoragePathPublic">
				<cfreturn application.lanshock.environment.webpath & 'storage/public/modules/#sModule#/'>
			</cfcase>
		</cfswitch>
	
	</cffunction>

	<cffunction name="buildUrl" output="false" returntype="string">
		<cfargument name="sParameters" type="string" required="false" default="">
		<cfargument name="bFullUrl" type="boolean" required="false" default="false">
		
		<cfset var myFusebox = application.lanshock.oApplication.getMyFusebox()>
		<cfset var sReturn = myFusebox.getMyself()>
		
		<cfif find('?',myFusebox.getMyself())>
			<cfset sReturn = myFusebox.getMyself() & urlSessionFormat(arguments.sParameters)>
		<cfelse>
			<cfset sReturn = myFusebox.getMyself() & replaceList(urlSessionFormat(arguments.sParameters),'?,&,=','/,/,/')>
			<cfif right(sReturn,1) NEQ '/'>
				<cfset sReturn = sReturn & '/'>
			</cfif>
		</cfif>
		
		<cfif arguments.bFullUrl>
			<cfset sReturn = application.lanshock.environment.serveraddress & sReturn>
		</cfif>
		
		<cfreturn sReturn>
	
	</cffunction>

</cfcomponent>