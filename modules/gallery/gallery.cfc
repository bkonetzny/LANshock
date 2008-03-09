<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getGallerylist" access="public" returntype="query" output="false">
		<cfargument name="showVisibleOnly" type="boolean" required="false" default="true">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGallerylist">
			SELECT g.*, COUNT(i.id) AS itemcount
			FROM gallery g
			LEFT OUTER JOIN gallery_item i ON g.id = i.gallery_id
			<cfif arguments.showVisibleOnly>
				WHERE g.visible = 1
			</cfif>
			GROUP BY g.id
			ORDER BY g.dt_created DESC
		</cfquery>
		
		<cfreturn qGallerylist>
		
	</cffunction>
	
	<cffunction name="getItemlist" access="public" returntype="query" output="false">
		<cfargument name="gallery_id" type="numeric" required="yes">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qItemlist">
			SELECT *
			FROM gallery_item
			WHERE gallery_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#">
			ORDER BY id
		</cfquery>
		
		<cfreturn qItemlist>
		
	</cffunction>

	<cffunction name="setItem" access="public" returntype="numeric" output="false">
		<cfargument name="id" type="numeric" required="false" default="0">
		<cfargument name="gallery_id" type="numeric" required="true">
		<cfargument name="title" type="string" required="false" default="">
		<cfargument name="text" type="string" required="false" default="">
		<cfargument name="file" type="string" required="false" default="">
		<cfargument name="settings" type="struct" required="true">

		<cfset var uuid = ''>
		<cfset var item = ''>
		<cfset var tn = ''>
		<cfset var image = ''>
		<cfset var item_id = ''>
		<cfset var metadata = ''>
		<cfset var bCopyFile = false>

		<cfif arguments.id EQ 0>
			<cfset uuid = '#CreateUUID()#.jpg'>
		<cfelse>
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetUUID">
				SELECT filename, metadata
				FROM gallery_item
				WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.id#">
			</cfquery>
			<cfset uuid = qGetUUID.filename>
			<cfset metadata = qGetUUID.metadata>
		</cfif>
		
		<cfif len(arguments.file)>
		
			<cfset item = '#arguments.settings.files.storage##arguments.gallery_id#/#uuid#'>
			<cfset tn = '#arguments.settings.files.storage##arguments.gallery_id#/tn/#uuid#'>
			<cfset image = ''>
			<cfset metadata = ''>
			
			<cfif NOT DirectoryExists('#arguments.settings.files.storage##arguments.gallery_id#/')>
				<cfdirectory action="create" directory="#arguments.settings.files.storage##arguments.gallery_id#/" mode="777">
			</cfif>
			
			<cfif NOT DirectoryExists('#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.item.max_width#x#arguments.settings.item.max_height#/')>
				<cfdirectory action="create" directory="#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.item.max_width#x#arguments.settings.item.max_height#/" mode="777">
			</cfif>
			
			<cfif NOT DirectoryExists('#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.tn.max_width#x#arguments.settings.tn.max_height#/')>
				<cfdirectory action="create" directory="#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.tn.max_width#x#arguments.settings.tn.max_height#/" mode="777">
			</cfif>
			
			<cfset oImage = createObject("component","#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.image.image")>
			
			<cfset oImage.setOption('defaultJpegCompression','100')>
			<cfset oImage.setOption('tempDirectory',arguments.settings.files.tmp)>
			
			<cfset stImageInfo = oImage.getImageInfo('',arguments.file)>
			
			<cfset oImage.resize('',arguments.file,'#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.item.max_width#x#arguments.settings.item.max_height#/#uuid#',arguments.settings.item.max_width,arguments.settings.item.max_height,true)>
			<cfset oImage.resize('',arguments.file,'#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.tn.max_width#x#arguments.settings.tn.max_height#/#uuid#',arguments.settings.tn.max_width,arguments.settings.tn.max_height,true)>
			
			<cfif stImageInfo.metadata.recordcount>
				<cfwddx action="cfml2wddx" input="#stImageInfo.metadata#" output="metadata">
			</cfif>
			
		</cfif>

		<cfif arguments.id EQ 0>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO gallery_item (gallery_id, title, text, filename, dt_created, metadata)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
						#now()#,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#metadata#">)
			</cfquery>
			
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetID">
				SELECT id
				FROM gallery_item
				WHERE filename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
			</cfquery>
			
			<cfset item_id = qGetID.id>
			
		<cfelse>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE gallery_item
				SET gallery_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#">,
					title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
					text = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">,
					filename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
					metadata = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#metadata#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
			
			<cfset item_id = arguments.id>
		
		</cfif>
			
		<cfreturn item_id>
		
	</cffunction>
	
	<cffunction name="getItem" access="public" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="yes">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qItem">
			SELECT *
			FROM gallery_item
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qItem>
		
	</cffunction>
	
	<cffunction name="deleteItem" access="public" returntype="boolean" output="false">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="gallery_id" type="numeric" required="true">
		<cfargument name="settings" type="struct" required="true">

		<cfinvoke method="getItem" returnvariable="qItem">
			<cfinvokeargument name="id" value="#arguments.id#">
		</cfinvoke>
			
		<cfif FileExists('#arguments.settings.files.storage##qItem.gallery_id#/#qItem.filename#')>
			<cffile action="delete" file="#arguments.settings.files.storage##qItem.gallery_id#/#qItem.filename#">
		</cfif>
			
		<cfif FileExists('#arguments.settings.files.storage##qItem.gallery_id#/tn/#qItem.filename#')>
			<cffile action="delete" file="#arguments.settings.files.storage##qItem.gallery_id#/tn/#qItem.filename#">
		</cfif>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qItem">
			DELETE
			FROM gallery_item
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
	
		<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="deleteTopic">
			<cfinvokeargument name="module" value="#request.varScope.myfusebox.thiscircuit#">
			<cfinvokeargument name="identifier" value="gallery_item_#arguments.id#">
		</cfinvoke>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="setGallery" access="public" returntype="numeric" output="false">
		<cfargument name="id" type="numeric" required="false" default="0">
		<cfargument name="title" type="string" required="yes">
		<cfargument name="date" type="date" required="false" default="#now()#">
		<cfargument name="text" type="string" required="yes">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="visible" type="numeric" required="false" default="1">
		<cfargument name="tn" type="string" required="false" default="">

		<cfif arguments.id EQ 0>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO gallery (title, text, user_id, visible,dt_created,tn)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">,
						<cfqueryparam cfsqltype="cf_sql_tinyint" value="#arguments.visible#">,
						<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.date#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tn#">)
			</cfquery>
			
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetID">
				SELECT id
				FROM gallery
				WHERE title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">
				AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
				ORDER BY id DESC
			</cfquery>
			
			<cfreturn qGetID.id>
			
		<cfelse>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE gallery
				SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
					text = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">,
					user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">,
					visible = <cfqueryparam cfsqltype="cf_sql_tinyint" value="#arguments.visible#">,
					tn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tn#">,
					dt_created = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.date#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
			
			<cfreturn arguments.id>
		
		</cfif>
		
	</cffunction>
	
	<cffunction name="getGallery" access="public" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="yes">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qItemlist">
			SELECT *
			FROM gallery
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qItemlist>
		
	</cffunction>
	
	<cffunction name="deleteGallery" access="public" returntype="boolean" output="false">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="settings" type="struct" required="true">

		<cfinvoke method="getItemList" returnvariable="qItemList">
			<cfinvokeargument name="gallery_id" value="#arguments.id#">
		</cfinvoke>
		
		<cfloop query="qItemList">
			<cfinvoke method="deleteItem">
				<cfinvokeargument name="id" value="#qItemList.id[currentrow]#">
				<cfinvokeargument name="gallery_id" value="#arguments.id#">
				<cfinvokeargument name="settings" value="#arguments.settings#">
			</cfinvoke>
		</cfloop>
			
		<cfif DirectoryExists('#arguments.settings.files.storage##arguments.id#/tn/')>
			<cfdirectory action="delete" directory="#arguments.settings.files.storage##arguments.id#/tn/">
		</cfif>
			
		<cfif DirectoryExists('#arguments.settings.files.storage##arguments.id#')>
			<cfdirectory action="delete" directory="#arguments.settings.files.storage##arguments.id#">
		</cfif>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE
			FROM gallery
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

</cfcomponent>