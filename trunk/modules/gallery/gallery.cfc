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
		
		<cfset var qGallerylist = 0>
	
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
		<cfargument name="gallery_id" type="numeric" required="true">
		
		<cfset var qItemlist = 0>
	
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
		<cfargument name="bUploadFile" type="boolean" required="false" default="false">
		<cfargument name="settings" type="struct" required="true">

		<cfset var iItemID = ''>
		<cfset var sItemFilename = ''>
		<cfset var qGetUUID = 0>
		<cfset var qGetID = 0>
		<cfset var wddxMetadata = ''>

		<cfif arguments.id NEQ 0>
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetUUID">
				SELECT filename, metadata
				FROM gallery_item
				WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.id#">
			</cfquery>
			<cfset sItemFilename = qGetUUID.filename>
			<cfset wddxMetadata = qGetUUID.metadata>
		</cfif>
		
		<cfif arguments.bUploadFile OR len(arguments.file)>
		
			<cfif NOT DirectoryExists(arguments.settings.files.storage)>
				<cfdirectory action="create" directory="#arguments.settings.files.storage#" mode="777">
			</cfif>
		
			<cfif NOT DirectoryExists("#arguments.settings.files.storage##arguments.gallery_id#/")>
				<cfdirectory action="create" directory="#arguments.settings.files.storage##arguments.gallery_id#/" mode="777">
			</cfif>
		
			<cfif NOT DirectoryExists("#arguments.settings.files.storage##arguments.gallery_id#/original/")>
				<cfdirectory action="create" directory="#arguments.settings.files.storage##arguments.gallery_id#/original/" mode="777">
			</cfif>
			
			<cfif NOT DirectoryExists('#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.item.max_width#x#arguments.settings.item.max_height#/')>
				<cfdirectory action="create" directory="#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.item.max_width#x#arguments.settings.item.max_height#/" mode="777">
			</cfif>
			
			<cfif NOT DirectoryExists('#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.tn.max_width#x#arguments.settings.tn.max_height#/')>
				<cfdirectory action="create" directory="#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.tn.max_width#x#arguments.settings.tn.max_height#/" mode="777">
			</cfif>

			<cfset uuidFile = '#arguments.settings.files.storage##arguments.gallery_id#/original/#CreateUUID()#.jpg'>
			<cfif arguments.bUploadFile>
				<cffile action="upload" filefield="form.file" destination="#uuidFile#" mode="777">
			<cfelseif len(arguments.file)>
				<cffile action="copy" source="#arguments.file#" destination="#uuidFile#" mode="777">
				<cfset sItemFilename = GetFileFromPath(uuidFile)>
			</cfif>
			
			<cfset oImage = createObject("component","#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.image.image")>
			
			<cfset oImage.setOption('defaultJpegCompression','100')>
			<cfset oImage.setOption('tempDirectory',application.lanshock.oHelper.UDF_Module('storagePathTemp'))>
			
			<cfset stImageInfo = oImage.getImageInfo('',uuidFile)>
			
			<cfset oImage.resize('',uuidFile,'#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.item.max_width#x#arguments.settings.item.max_height#/#sItemFilename#',arguments.settings.item.max_width,arguments.settings.item.max_height,true)>
			<cfset oImage.resize('',uuidFile,'#arguments.settings.files.storage##arguments.gallery_id#/#arguments.settings.tn.max_width#x#arguments.settings.tn.max_height#/#sItemFilename#',arguments.settings.tn.max_width,arguments.settings.tn.max_height,true)>
			
			<cfset oImage = ''>
			
			<cfif stImageInfo.metadata.recordcount>
				<cfwddx action="cfml2wddx" input="#stImageInfo.metadata#" output="wddxMetadata">
			</cfif>
			
		</cfif>

		<cfif arguments.id EQ 0>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO gallery_item (gallery_id, title, text, filename, dt_created, metadata)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#sItemFilename#">,
						#now()#,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#wddxMetadata#">)
			</cfquery>
			
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetID">
				SELECT id
				FROM gallery_item
				WHERE filename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sItemFilename#">
			</cfquery>
			
			<cfset iItemID = qGetID.id>
			
		<cfelse>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE gallery_item
				SET gallery_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#">,
					title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
					text = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">
					<cfif arguments.bUploadFile OR len(arguments.file)>
						,filename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sItemFilename#">
						,metadata = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#wddxMetadata#">
					</cfif>
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
			
			<cfset iItemID = arguments.id>
		
		</cfif>
			
		<cfreturn iItemID>
		
	</cffunction>
	
	<cffunction name="getItem" access="public" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="true">
		
		<cfset var qItem = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qItem">
			SELECT *
			FROM gallery_item
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qItem>
		
	</cffunction>

	<cffunction name="getItemPartners" access="public" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="gallery_id" type="numeric" required="true">
		
		<cfset var qItemPartners = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qItemPartners">
			SELECT id, title, filename FROM (
				SELECT id, title, filename
				FROM gallery_item
				WHERE gallery_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#">
				AND id < <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
				ORDER BY id DESC
				LIMIT 5
			) qPrev
			UNION
			SELECT id, title, filename FROM (
				SELECT id, title, filename
				FROM gallery_item
				WHERE gallery_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#">
				AND id > <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
				ORDER BY id
				LIMIT 5
			) qNext
			ORDER BY id
		</cfquery>
		
		<cfreturn qItemPartners>
		
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
			
		<cfif FileExists('#arguments.settings.files.storage##qItem.gallery_id#/#arguments.settings.item.max_width#x#arguments.settings.item.max_height#/#qItem.filename#')>
			<cffile action="delete" file="#arguments.settings.files.storage##qItem.gallery_id#/#arguments.settings.item.max_width#x#arguments.settings.item.max_height#/#qItem.filename#">
		</cfif>
			
		<cfif FileExists('#arguments.settings.files.storage##qItem.gallery_id#/#arguments.settings.tn.max_width#x#arguments.settings.tn.max_height#/#qItem.filename#')>
			<cffile action="delete" file="#arguments.settings.files.storage##qItem.gallery_id#/#arguments.settings.tn.max_width#x#arguments.settings.tn.max_height#/#qItem.filename#">
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
			<cfinvokeargument name="module" value="#application.lanshock.oApplication.getMyFusebox().thiscircuit#">
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
		
		<cfset var qGalleryFiles = 0>

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