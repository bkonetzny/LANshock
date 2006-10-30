<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- create default config --->
<cfscript>
	stDefaultModuleConfig = StructNew();
	stDefaultModuleConfig.types = StructNew();
	stDefaultModuleConfig.types.m_gallery = StructNew();
	stDefaultModuleConfig.types.m_gallery.image = "picture.gif";
	stDefaultModuleConfig.types.m_news = StructNew();
	stDefaultModuleConfig.types.m_news.image = "article.gif";
</cfscript>

<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="createConfig" returnvariable="stModuleConfig">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="data" value="#stDefaultModuleConfig#">
	<cfinvokeargument name="version" value="1">
</cfinvoke>

<cfsetting enablecfoutputonly="No">