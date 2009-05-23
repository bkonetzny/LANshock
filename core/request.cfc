<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/runtime.cfc $
$LastChangedDate: 2008-12-15 16:16:55 +0100 (Mo, 15 Dez 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 433 $
--->

<cfcomponent>
	
	<cffunction name="init" output="false" returntype="void">
		<cfset var stRuntimeEnvironment = application.lanshock.oRuntime.getEnvironment()>
		<cfset var stModules = application.lanshock.oModules.getModules()>
		<cfset var iIndex = ''>
		
		<cfset variables.aHeaderInfo = ArrayNew(1)>
		<cfset variables.aJsFiles = ArrayNew(1)>
		<cfset variables.aJsFilesNoCache = ArrayNew(1)>
		<cfset variables.aCssFiles = ArrayNew(1)>
		
		<cfset this.addHeaderInfo('<meta http-equiv="content-type" content="text/html; charset=utf-8"/>')>
		<cfset this.addHeaderInfo('<meta name="generator" content="LANshock #application.lanshock.oRuntime.getVersion().version#"/>')>
		<cfset this.addHeaderInfo('<link rel="shortcut icon" href="#stRuntimeEnvironment.sServerPath#templates/#application.lanshock.settings.layout.template#/favicon.ico"/>')>
		
		<cfset this.addCss('#stRuntimeEnvironment.sWebPath#templates/_shared/css/ext-all.css')>
		<cfset this.addCss('#stRuntimeEnvironment.sWebPath#templates/_shared/css/ext-ux.grid.RowActions.css')>
		<cfset this.addCss('#stRuntimeEnvironment.sWebPath#templates/_shared/css/uni-form.css')>
		<cfset this.addCss('#stRuntimeEnvironment.sWebPath#templates/_shared/css/lanshock.css')>
		
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/lanshock.js')>
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/jquery/jquery.min.js')>
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/ext/ext.js')>
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/ext/build/locale/ext-lang-#LCase(ListFirst(session.lang,'_'))#-min.js', false)>
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/ext/Ext.ux.form.DateTime.js')>
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/ext/Ext.ux.grid.RowActions.js')>
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/ext/Ext.ux.grid.Search.js')>
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/swfobject/swfobject.js')>
		<cfset this.addJs('#stRuntimeEnvironment.sWebPath#templates/_shared/js/fckeditor/fckeditor.js')>
		
		<!--- TODO: add caching --->
		<cfloop collection="#stModules#" item="iIndex">
			<cftry>
				<cfset application.lanshock.oFactory.load('lanshock.modules.#iIndex#.module').onRequest()>
				<cfcatch><!--- do nothing ---></cfcatch>
			</cftry>
		</cfloop>
		
		<cfset this.addCss('#stRuntimeEnvironment.sWebPath#templates/#application.lanshock.settings.layout.template#/styles.css')>
	</cffunction>
	
	<cffunction name="addHeaderInfo" output="false" returntype="void">
		<cfargument name="sHeaderInfo" type="string" required="true">
		<cfset ArrayAppend(variables.aHeaderInfo, trim(arguments.sHeaderInfo))>
	</cffunction>
	
	<cffunction name="getHeaderInfo" output="false" returntype="any">
		<cfset var sHeaderInfoCode = ''>
		<cfset var iIndex = 0>
		
		<cfsavecontent variable="sHeaderInfoCode">
			<cfloop from="1" to="#ArrayLen(variables.aHeaderInfo)#" index="iIndex"><cfoutput>#variables.aHeaderInfo[iIndex]##chr(13)##chr(10)#</cfoutput></cfloop>
		</cfsavecontent>
		
		<cfreturn trim(sHeaderInfoCode)>
	</cffunction>
	
	<cffunction name="addJs" output="false" returntype="void">
		<cfargument name="sFile" type="string" required="true">
		<cfargument name="bCache" type="string" required="false" default="true">
		
		<cfif arguments.bCache>
			<cfset ArrayAppend(variables.aJsFiles, trim(arguments.sFile))>
		<cfelse>
			<cfset ArrayAppend(variables.aJsFilesNoCache, trim(arguments.sFile))>
		</cfif>
	</cffunction>
	
	<cffunction name="getJs" output="false" returntype="string">
		<cfset var sJsCode = ''>
		<cfset var iIndex = 0>
		
		<cfsavecontent variable="sJsCode">
			<cfloop from="1" to="#ArrayLen(variables.aJsFiles)#" index="iIndex"><cfoutput><script type="text/javascript" src="#variables.aJsFiles[iIndex]#"></script>#chr(13)##chr(10)#</cfoutput></cfloop>
			<cfloop from="1" to="#ArrayLen(variables.aJsFilesNoCache)#" index="iIndex"><cfoutput><script type="text/javascript" src="#variables.aJsFilesNoCache[iIndex]#"></script>#chr(13)##chr(10)#</cfoutput></cfloop>
		</cfsavecontent>
		
		<cfsavecontent variable="sJsCode">
			<cfoutput>#sJsCode#
				<script type="text/javascript">
				<!--
					LANshock.setVars({self: '#jsStringFormat(request.myFusebox.getSelf())#', myself: '#jsStringFormat(request.myFusebox.getMyself())#', sessionUrlToken: '#jsStringFormat(urlSessionFormat(''))#', sWebPath: '#jsStringFormat(application.lanshock.oRuntime.getEnvironment().sWebPath)#'});
					Ext.BLANK_IMAGE_URL = '#jsStringFormat(application.lanshock.oRuntime.getEnvironment().sWebPath)#templates/_shared/js/ext/resources/images/default/s.gif';
				//-->
				</script>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn trim(sJsCode)>
	</cffunction>
	
	<cffunction name="addCss" output="false" returntype="void">
		<cfargument name="sFile" type="string" required="true">
		<cfset ArrayAppend(variables.aCssFiles, trim(arguments.sFile))>
	</cffunction>
	
	<cffunction name="getCss" output="false" returntype="string">
		<cfset var sCssCode = ''>
		<cfset var iIndex = 0>
		
		<cfsavecontent variable="sCssCode">
			<cfloop from="1" to="#ArrayLen(variables.aCssFiles)#" index="iIndex"><cfoutput><link rel="stylesheet" type="text/css" href="#variables.aCssFiles[iIndex]#"/>#chr(13)##chr(10)#</cfoutput></cfloop>
		</cfsavecontent>
		
		<cfreturn trim(sCssCode)>
	</cffunction>

</cfcomponent>