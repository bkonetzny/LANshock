<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_system_check.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="stEvents" default="#StructNew()#">
<cfparam name="iWarnings" default="0">

<cfif attributes.form_submitted>

	<!--- get Modules --->
	<cfinvoke component="#application.lanshock.oModules#" method="getModulesByType" returnvariable="stModules">
		<cfinvokeargument name="type" value="module">
	</cfinvoke>
	
	<!--- get Core Modules --->
	<cfinvoke component="#application.lanshock.oModules#" method="getModulesByType" returnvariable="stCoreModules">
		<cfinvokeargument name="type" value="core">
	</cfinvoke>
	
	<cfscript>
		if(isDefined("application.module")) lModulesInstalled = StructKeyList(application.module);
	
		StructAppend(stModules, stCoreModules, "true");
	</cfscript>
	
	<cfloop collection="#stModules#" item="idx">
		<cfif NOT listFind(lModulesInstalled,idx)>
			<cfset StructDelete(stModules,idx)>
		</cfif>
	</cfloop>
	
	<!--- Get Details for all Modules --->
	<cfinvoke component="#application.lanshock.oModules#" method="getModuleSettings" returnvariable="stModulesAvaible">
		<cfinvokeargument name="stModules" value="#stModules#">
	</cfinvoke>
	
	<cfloop collection="#stModulesAvaible#" item="idx">
	
		<cfif StructKeyExists(stModulesAvaible[idx],'dependencies') AND NOT StructIsEmpty(stModulesAvaible[idx].dependencies)>
		
			<cfloop collection="#stModulesAvaible[idx].dependencies#" item="idx2">
				
				<cfscript>
					stEventDetails = StructNew();
					stEventDetails.module = stModulesAvaible[idx].name;
					stEventDetails.type = idx2;
					stEventDetails.subtype = '';
					stEventDetails.message = '';
					stEventDetails.details = '';
					stEventDetails.status = '';
				</cfscript>
		
				<cfswitch expression="#idx2#">
					
					<cfcase value="filesystem">
					
						<cfloop collection="#stModulesAvaible[idx].dependencies[idx2]#" item="idx3">
							
							<cfscript>
								sCurrentFile = '';
								sCurrentFolder = '';
							</cfscript>
						
							<cfif len(stModulesAvaible[idx].dependencies[idx2][idx3].file)>
								<cfscript>
									sCurrentFile = stModulesAvaible[idx].dependencies[idx2][idx3].file;
									
									stEventDetails.status = true;
									
									if(left(sCurrentFile,1) EQ '/') sCurrentFile = application.lanshock.environment.abspath & right(sCurrentFile,len(sCurrentFile)-1);
									else sCurrentFile = stModulesAvaible[idx].module_path_abs & sCurrentFile;
									
									sFileContent = '';
									sFileReadable = true;
								</cfscript>
								
								<cftry>
									<cffile action="read" file="#sCurrentFile#" variable="sFileContent">
									<cfset stEventDetails.details = stEventDetails.details & 'read:true; '>
									<cfcatch>
										<cfset stEventDetails.details = stEventDetails.details & 'read:false; '>
										<cfset stEventDetails.status = false>
										<cfset sFileReadable = false>
									</cfcatch>
								</cftry>
								
								<cfif sFileReadable>
									<cftry>
										<cffile action="delete" file="#sCurrentFile#">
										<cfset stEventDetails.details = stEventDetails.details & 'delete:true; '>
										<cfcatch>
											<cfset stEventDetails.details = stEventDetails.details & 'delete:false; '>
											<cfset stEventDetails.status = false>
										</cfcatch>
									</cftry>
									
									<cftry>
										<cffile action="write" file="#sCurrentFile#" output="#trim(sFileContent)#">
										<cfset stEventDetails.details = stEventDetails.details & 'write:true; '>
										<cfcatch>
											<cfset stEventDetails.details = stEventDetails.details & 'write:false; '>
											<cfset stEventDetails.status = false>
										</cfcatch>
									</cftry>
								<cfelse>
									<cfset stEventDetails.details = stEventDetails.details & 'delete:skipped; '>
									<cfset stEventDetails.details = stEventDetails.details & 'write:skipped; '>
								</cfif>
								
								<cfscript>
									stEventDetails.subtype = 'file';
									stEventDetails.message = '"#sCurrentFile#"';
									stEvents[CreateUUID()] = stEventDetails;
									if(NOT stEventDetails.status) iWarnings = iWarnings + 1;
								</cfscript>
							<cfelseif len(stModulesAvaible[idx].dependencies[idx2][idx3].folder)>
								<cfscript>
									sCurrentFolder = stModulesAvaible[idx].dependencies[idx2][idx3].folder;
									
									stEventDetails.status = true;
									
									if(left(sCurrentFolder,1) EQ '/') sCurrentFolder = application.lanshock.environment.abspath & right(sCurrentFolder,len(sCurrentFolder)-1);
									else sCurrentFolder = stModulesAvaible[idx].module_path_abs & sCurrentFolder;
									
									if(right(sCurrentFolder,1) NEQ '/') sCurrentFolder = sCurrentFolder & '/';
									
									sTmpFile = '#sCurrentFolder##createUUID()#.tmp';
								</cfscript>
								
								<cftry>
									<cfdirectory action="list" directory="#sCurrentFolder#" name="qDirectory">
									<cfset stEventDetails.details = stEventDetails.details & 'read:true; '>
									<cfcatch>
										<cfset stEventDetails.details = stEventDetails.details & 'read:false; '>
										<cfset stEventDetails.status = false>
									</cfcatch>
								</cftry>
				
								<cftry>
									<cffile action="write" file="#sTmpFile#" output="">
									<cfset stEventDetails.details = stEventDetails.details & 'write:true; '>
									<cfcatch>
										<cfset stEventDetails.details = stEventDetails.details & 'write:false; '>
										<cfset stEventDetails.status = false>
									</cfcatch>
								</cftry>
								
								<cftry>
									<cffile action="delete" file="#sTmpFile#">
									<cfset stEventDetails.details = stEventDetails.details & 'delete:true; '>
									<cfcatch>
										<cfset stEventDetails.details = stEventDetails.details & 'delete:false; '>
										<cfset stEventDetails.status = false>
										<cfset stEventDetails.error = cfcatch>
									</cfcatch>
								</cftry>
								
								<cfscript>
									stEventDetails.subtype = 'folder';
									stEventDetails.message = '"#sCurrentFolder#"';
									stEvents[CreateUUID()] = stEventDetails;
									if(NOT stEventDetails.status) iWarnings = iWarnings + 1;
								</cfscript>
							</cfif>
						
						</cfloop>
					
					</cfcase>
					
					<cfdefaultcase>
						<cfscript>
							stEventDetails.message = 'unknown dependency "#idx2#"';
							stEventDetails.status = false;
							stEvents[CreateUUID()] = stEventDetails;
							if(NOT stEventDetails.status) iWarnings = iWarnings + 1;
						</cfscript>
					</cfdefaultcase>
					
				</cfswitch>
			
			</cfloop>
		
		</cfif>
	
	</cfloop>

</cfif>

<cfsetting enablecfoutputonly="No">