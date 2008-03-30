<cfcomponent name="entry" extends="lanshock.core._utils.rss.rssville.modules.media.media">

	<cfset variables.instance = structNew()>
	
	<cffunction name="init" access="public" output="false" returntype="lanshock.core._utils.rss.rssville.modules.media.content">
		<cfset super.init()>
		<cfset variables.instance.url="">
		<cfset variables.instance.fileSize="">
		<cfset variables.instance.type="">
		<cfset variables.instance.medium="">
		<cfset variables.instance.isDefault="">
		<cfset variables.instance.expression="">
		<cfset variables.instance.bitrate="">
		<cfset variables.instance.framerate="">
		<cfset variables.instance.samplingrate="">
		<cfset variables.instance.channels="">
		<cfset variables.instance.duration="">
		<cfset variables.instance.height="">
		<cfset variables.instance.width="">
		<cfset variables.instance.lang="">
		
		
		<cfset variables.instance.thumbnail="">
		
		<cfreturn this />
	</cffunction>

	<cffunction name="getThumbnail" access="public" output="false" returntype="string">
		<cfreturn variables.instance.thumbnail />
	</cffunction>

	<cffunction name="setThumbnail" access="public" output="false" returntype="void">
		<cfargument name="thumbnail" type="string" required="true" />
		<cfset variables.instance.thumbnail = arguments.thumbnail />
		<cfreturn />
	</cffunction>

	<cffunction name="getUrl" access="public" output="false" returntype="string">
		<cfreturn variables.instance.url />
	</cffunction>

	<cffunction name="setUrl" access="public" output="false" returntype="void">
		<cfargument name="url" type="string" required="true" />
		<cfset variables.instance.url = arguments.url />
		<cfreturn />
	</cffunction>

	<cffunction name="getMedium" access="public" output="false" returntype="string">
		<cfreturn variables.instance.medium />
	</cffunction>

	<cffunction name="setMedium" access="public" output="false" returntype="void">
		<cfargument name="medium" type="string" required="true" />
		<cfset variables.instance.medium = arguments.medium />
		<cfreturn />
	</cffunction>

	<cffunction name="generate_rss20" access="public" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS20>
		<cfset sb.append(super.generate_rss20())>
		<cfif len(getThumbnail())>
			<cfset sb.append(createXmlItem(itemValue="",itemTag='media:thumbnail url="#getThumbnail()#"',emptyTagIfBlank=true))>
		</cfif>
		<cfif len(getUrl())>
			<cfset sb.append(createXmlItem(itemValue="",itemTag='media:content url="#getUrl()#" medium="#getMedium()#"',emptyTagIfBlank=true))>
		</cfif>
		<cfreturn sb.toString() />
	</cffunction>

</cfcomponent>