<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="ConvertText" output="false" returntype="string">
		<cfargument name="text" type="string" required="false" default="">
		
		<cfset var sConvertedText = ' ' & arguments.text & ' '>
		
		<cfif len(trim(sConvertedText)) AND NOT findNoCase('<',sConvertedText)>
			<cfinclude template="_utils/_pseudocode.cfm">
		</cfif>

		<cfset sConvertedText = trim(sConvertedText)>
		
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
	
			<cfif len(application.lanshock.oRuntime.getEnvironment().sDatasource)>
				<!--- Cache Query for 10 minutes --->
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="stLocal.qUsernames" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
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
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qUserdatas" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
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
					<cfif isNumeric(arguments.userid) AND FileExists("#application.lanshock.oRuntime.getEnvironment().sStoragePath#public/modules/user/avatars/#arguments.userid#.png")>
						<cfset stLocal.sResult = '<img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#storage/public/modules/user/avatars/#arguments.userid#.png" title="#getUsernameById(arguments.userid)#" alt="#getUsernameById(arguments.userid)#" />'>
					<cfelse>
						<cfset stLocal.sResult = '<img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/lanshock/profile.png" title="#getUsernameById(arguments.userid)#" alt="#getUsernameById(arguments.userid)#" />'>
					</cfif>
				</cfdefaultcase>
			</cfswitch>
		</cfif>
	
		<cfreturn stLocal.sResult>
	</cffunction>

	<cffunction name="UDF_Module" output="false" returntype="string">
		<cfargument name="info" type="string" required="false" default="">
		<cfargument name="curr_module" type="string" required="false" default="">

		<cfset var myFusebox = application.lanshock.oApplication.getMyFusebox()>
		<cfset var sModule = ''>
		
		<cfif NOT len(arguments.curr_module)>
			<cfset arguments.curr_module = myfusebox.thiscircuit>
		</cfif>

		<cfset sModule = arguments.curr_module>
		<cfif ListFirst(sModule,'_') EQ 'c'>
			<cfset sModule = right(sModule,len(sModule)-2)>
		</cfif>
	
		<cfswitch expression="#arguments.info#">
			<cfcase value="webPath">
				<cfreturn application.lanshock.oRuntime.getEnvironment().sWebPath & 'modules/#sModule#/'>
			</cfcase>
			<cfcase value="webPathFull">
				<cfreturn application.lanshock.oRuntime.getEnvironment().sServerPath & 'modules/#sModule#/'>
			</cfcase>
			<cfcase value="absPath">
				<cfreturn application.lanshock.oRuntime.getEnvironment().sBasePath & 'modules/#sModule#/'>
			</cfcase>
			<cfcase value="storagePathTemp">
				<cfreturn application.lanshock.oRuntime.getEnvironment().sStoragePath & 'tmp/'>
			</cfcase>
			<cfcase value="storagePathSecure">
				<cfreturn application.lanshock.oRuntime.getEnvironment().sStoragePath & 'secure/modules/#sModule#/'>
			</cfcase>
			<cfcase value="absStoragePathPublic">
				<cfreturn application.lanshock.oRuntime.getEnvironment().sStoragePath & 'public/modules/#sModule#/'>
			</cfcase>
			<cfcase value="webStoragePathPublic">
				<cfreturn application.lanshock.oRuntime.getEnvironment().sWebPath & 'storage/public/modules/#sModule#/'>
			</cfcase>
			<cfcase value="webStoragePathPublicFull">
				<cfreturn application.lanshock.oRuntime.getEnvironment().sServerPath & 'storage/public/modules/#sModule#/'>
			</cfcase>
		</cfswitch>
	
	</cffunction>

	<cffunction name="buildUrl" output="false" returntype="string">
		<cfargument name="sParameters" type="string" required="false" default="">
		<cfargument name="bFullUrl" type="boolean" required="false" default="false">
		<cfargument name="bForceMode" type="string" required="false" default="">
		
		<cfset var myFusebox = application.lanshock.oApplication.getMyFusebox()>
		<cfset var sReturn = myFusebox.getMyself()>
		<cfset var bEnableSES = true>
		<cfset var sMode = 'ses'>
		
		<cfif (NOT len(arguments.bForceMode) AND find('?',myFusebox.getMyself())) OR (len(arguments.bForceMode) AND arguments.bForceMode EQ 'classic')>
			<cfset sMode = 'classic'>
		</cfif>
		
		<cfif sMode EQ 'classic'>
			<cfif NOT find('?',myFusebox.getMyself())>
				<cfset sReturn = urlSessionFormat(application.lanshock.oRuntime.getEnvironment().sWebPath & 'index.cfm?fuseaction=' & arguments.sParameters)>
			<cfelse>
				<cfset sReturn = myFusebox.getMyself() & urlSessionFormat(arguments.sParameters)>
			</cfif>
		<cfelse>
			<cfset sReturn = myFusebox.getMyself() & replaceList(urlSessionFormat(arguments.sParameters),'?,&,=','/,/,/')>
			<cfif right(sReturn,1) NEQ '/'>
				<cfset sReturn = sReturn & '/'>
			</cfif>
		</cfif>
		
		<cfif arguments.bFullUrl>
			<cfset sReturn = application.lanshock.oRuntime.getEnvironment().sServerAddress & sReturn>
		</cfif>
		
		<cfif bEnableSES>
			<cfset sReturn = replaceNoCase(sReturn,'index.cfm/fuseaction/','','ONE')>
		</cfif>
		
		<cfreturn sReturn>
	
	</cffunction>
	
	<cffunction name="notificationBox" output="false" returntype="string">
		<cfargument name="sHeadline" type="string" required="false" default="">
		<cfargument name="aItems" type="any" required="false" default="">
		<cfargument name="sType" type="string" required="false" default="info">
		<cfargument name="sMode" type="string" required="false" default="input" hint="global|input|both">
		
		<cfset var sReturn = ''>
		<cfset var sReturnBuffer = ''>
		<cfset var idx = 0>
		<cfset var idx2 = 0>
		<cfset var sClass = ''>
		<cfset var aNotifications = ArrayNew(1)>
		<cfset var aItemsParsed = ArrayNew(1)>
		
		<cfif arguments.sMode EQ 'global' AND session.oUser.existsCustomDataValue('notification_sHeadline')>
			<cfset bShowNotifications = true>
			<cfset arguments.sHeadline = session.oUser.getCustomDataValue('notification_sHeadline')>
			<cfset arguments.aItems = session.oUser.getCustomDataValue('notification_aItems')>
			<cfset arguments.sType = session.oUser.getCustomDataValue('notification_sType','info')>
			<cfset session.oUser.deleteCustomDataValue('notification_sHeadline')>
			<cfset session.oUser.deleteCustomDataValue('notification_aItems')>
			<cfset session.oUser.deleteCustomDataValue('notification_sType')>
		</cfif>
		
		<cfif len(arguments.sHeadline)>
			<cfset aNotifications[1] = StructNew()>
			<cfset aNotifications[1].sHeadline = arguments.sHeadline>
			<cfif isArray(arguments.aItems) OR isSimpleValue(arguments.aItems) AND len(arguments.aItems)>
				<cfif isSimpleValue(arguments.aItems)>
					<cfset ArrayAppend(aItemsParsed,arguments.aItems)>
					<cfset aNotifications[1].aItems = aItemsParsed>
				<cfelse>
					<cfset aNotifications[1].aItems = arguments.aItems>
				</cfif>
			</cfif>
			<cfset aNotifications[1].sType = arguments.sType>
		</cfif>
		
		<cfif ArrayLen(aNotifications)>
		
			<cfloop from="1" to="#ArrayLen(aNotifications)#" index="idx">
		
				<cfswitch expression="#aNotifications[idx].sType#">
					<cfcase value="info"><cfset sClass = ' notificationInfo'></cfcase>
					<cfcase value="success"><cfset sClass = ' notificationSuccess'></cfcase>
					<cfcase value="warn"><cfset sClass = ' notificationWarn'></cfcase>
					<cfcase value="error"><cfset sClass = ' notificationError'></cfcase>
				</cfswitch>
				
				<cfsavecontent variable="sReturnBuffer">
					<cfoutput>
					<div class="notificationBox#sClass#">
						<h3>#aNotifications[idx].sHeadline#</h3>
						<cfif StructKeyExists(aNotifications[idx],'aItems')>
							<ul>
								<cfloop from="1" to="#ArrayLen(aNotifications[idx].aItems)#" index="idx2">
									<li>#aNotifications[idx].aItems[idx2]#</li>
								</cfloop>
							</ul>
						</cfif>
					</div>
					</cfoutput>
				</cfsavecontent>
				<cfset sReturn = sReturn & sReturnBuffer>

			</cfloop>
		
		</cfif>
		
		<cfreturn sReturn>
	
	</cffunction>

</cfcomponent>