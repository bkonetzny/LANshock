<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/runtime.cfc $
$LastChangedDate: 2008-12-15 16:16:55 +0100 (Mo, 15 Dez 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 433 $
--->

<cfcomponent extends="lanshock.core.module">
	
	<cffunction name="onRequest" output="false" returntype="void">
		<cfset application.lanshock.oRequest.addCss('#application.lanshock.oRuntime.getEnvironment().sWebPath#modules/blog/view/_shared/css/styles.css')>
		<cfset application.lanshock.oRequest.addHeaderInfo('<link rel="alternate" type="application/rss+xml" title="#request.lanshock.settings.appname# - Blog - RSS" href="#application.lanshock.oHelper.buildUrl("blog.rss")#" />')>
	</cffunction>

</cfcomponent>