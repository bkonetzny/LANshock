<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/blog/raw_files/controller/act_rss.cfm $
$LastChangedDate: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 205 $
--->

<cfparam name="attributes.id" default="">

<cfif NOT len(attributes.id) OR NOT isNumeric(attributes.id)>
	<cfset qGalleries = application.lanshock.oFactory.load('gallery','reactorGateway').getByFields(visible=1)>
	
	<cfquery dbtype="query" name="qLatestGallery" maxrows="1">
		SELECT id
		FROM qGalleries
		ORDER BY dt_created DESC
	</cfquery>
	
	<cfset attributes.id = qLatestGallery.id>
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getItemlist" returnvariable="qItemlist">
	<cfinvokeargument name="gallery_id" value="#attributes.id#">
</cfinvoke>

<cfset syndFeed = application.lanshock.oFactory.load(sObject='lanshock.core._utils.rss.rssville.feed',bCache=false).init()>
<cfset syndFeed.setTitle(qGallery.title & ' - ' & application.lanshock.settings.appname & ' Media RSS')>
<cfset syndFeed.setDescription(application.lanshock.settings.appname)>
<cfset syndFeed.setAuthor(application.lanshock.settings.appname)>
<cfset syndFeed.setLink(application.lanshock.oRuntime.getEnvironment().sServerPath)>
<cfset syndFeed.setCopyright('Copyright ' & year(now()) & ' by ' & application.lanshock.settings.appname)>

<cfset mediaFeed = application.lanshock.oFactory.load(sObject='lanshock.core._utils.rss.rssville.modules.media.feed',bCache=false).init()>
<cfset syndFeed.addModule(mediaFeed)>

<cfloop query="qItemlist">
	<cfset entry = application.lanshock.oFactory.load(sObject='lanshock.core._utils.rss.rssville.entry',bCache=false).init()>
	<cfset entry.setTitle(qItemlist.title)>
	<cfset entry.setDescriptionSimple(qItemlist.text)>
	<cfset entry.setLink(application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.item&id=#qItemlist.id#&gallery_id=#qGallery.id#',true))>
	<cfset entry.setPubDate(qItemlist.dt_created)>
	
	<cfset mediaContent = application.lanshock.oFactory.load(sObject='lanshock.core._utils.rss.rssville.modules.media.content',bCache=false).init()>
	<cfset mediaContent.setMedium("image")>
	
	<cfif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/tn/#qItemlist.filename#')>
		<cfset mediaContent.setThumbnail("#application.lanshock.oHelper.UDF_Module('webStoragePathPublicFull')#galleries/#qGallery.id#/tn/#qItemlist.filename#")>
	<cfelseif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/#stDefaultModuleConfig.tn.max_width#x#stDefaultModuleConfig.tn.max_height#/#qItemlist.filename#')>
		<cfset mediaContent.setThumbnail("#application.lanshock.oHelper.UDF_Module('webStoragePathPublicFull')#galleries/#qGallery.id#/#stDefaultModuleConfig.tn.max_width#x#stDefaultModuleConfig.tn.max_height#/#qItemlist.filename#")>
	</cfif>
	
	<cfif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/#qItemlist.filename#')>
		<cfset mediaContent.setUrl("#application.lanshock.oHelper.UDF_Module('webStoragePathPublicFull')#galleries/#qGallery.id#/#qItemlist.filename#")>
	<cfelseif fileExists(application.lanshock.oHelper.UDF_Module('absStoragePathPublic') & 'galleries/#qGallery.id#/#stDefaultModuleConfig.item.max_width#x#stDefaultModuleConfig.item.max_height#/#qItemlist.filename#')>
		<cfset mediaContent.setUrl("#application.lanshock.oHelper.UDF_Module('webStoragePathPublicFull')#galleries/#qGallery.id#/#stDefaultModuleConfig.item.max_width#x#stDefaultModuleConfig.item.max_height#/#qItemlist.filename#")>
	</cfif>
	
	<cfset entry.addModule(mediaContent)>
	
	<cfset syndFeed.addEntry(entry)>
</cfloop>

<cfset sRSS = syndFeed.generate(syndFeed.FEED_TYPE_RSS20)>

<cfsetting enablecfoutputonly="No">