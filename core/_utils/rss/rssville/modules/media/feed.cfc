<cfcomponent name="feed" extends="lanshock.core._utils.rss.rssville.modules.media.media"><!--- lanshock.core._utils.rss.rssville.module --->

	<cfset variables.instance = structNew()>
	
	<cffunction name="init" access="public" output="false" returntype="lanshock.core._utils.rss.rssville.modules.media.feed">
		<cfset super.init()>
		<cfreturn this />
	</cffunction>

	<cffunction name="generateHeader_rss20" access="public" output="false" returntype="any">
		<cfreturn " xmlns:media=""http://search.yahoo.com/mrss/""">
	</cffunction>
</cfcomponent>