<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/news.cfc $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfcomponent>

	<cffunction name="getNews" access="remote" returntype="query" output="false">
		<cfargument name="category_id" type="numeric" required="false" default="0">
		<cfargument name="user_id" type="numeric" required="false" default="0">
		<cfargument name="records" type="numeric" required="false" default="0">
		<cfargument name="showfuture" type="boolean" required="false" default="false">
		
		<cfset var stLocal = StructNew()>
		<cfset stLocal.aCategoryIDs = ArrayNew(1)>
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qNews">
			SELECT ne.*
			FROM news_entry ne
			<cfif arguments.category_id NEQ 0>
				INNER JOIN news_entry_category ec ON ne.id = ec.entry_id
				WHERE ec.category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.category_id#">
			<cfelse>
				WHERE 1 = 1
			</cfif>
			<cfif NOT arguments.showfuture>
				AND ne.date <= #now()#
			</cfif>
			<cfif arguments.user_id NEQ 0>
				AND ne.author = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
			</cfif>
			ORDER BY ne.date DESC
			<cfif arguments.records NEQ 0>
				LIMIT #arguments.records#
			</cfif>
		</cfquery>
	
		<cfloop query="qNews">
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qNewsCategory">
				SELECT category_id
				FROM news_entry_category
				WHERE entry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
			</cfquery>
			
			<cfset ArrayAppend(stLocal.aCategoryIDs,ValueList(qNewsCategory.category_id))>
		</cfloop>

		<cfset QueryAddColumn(qNews,'category_ids',stLocal.aCategoryIDs)>
		
		<cfreturn qNews>
		
	</cffunction>

	<cffunction name="getNewsEntry" access="remote" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="true">
		
		<cfset var aCategoryIDs = ArrayNew(1)>
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qNews">
			SELECT *
			FROM news_entry
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
	
		<cfloop query="qNews">
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qNewsCategory">
				SELECT category_id
				FROM news_entry_category
				WHERE entry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
			</cfquery>
			
			<cfset ArrayAppend(aCategoryIDs,ValueList(qNewsCategory.category_id))>
		</cfloop>

		<cfset QueryAddColumn(qNews,'category_ids',aCategoryIDs)>
		
		<cfreturn qNews>
		
	</cffunction>

	<cffunction name="setNews" access="remote" returntype="boolean" output="false">
		<cfargument name="id" type="numeric" required="false" default="0">
		<cfargument name="author" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="date" type="string" required="false" default="#now()#">
		<cfargument name="text" type="string" required="true">
		<cfargument name="mp3url" type="string" required="false" default="">
		<cfargument name="ishtml" type="string" required="false" default="0">
		<cfargument name="category_ids" type="string" required="false" default="">
		
		<cfset var rtNewsID = 0>

		<cfif arguments.id EQ 0>

			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO news_entry (author,title,text,date,mp3url,ishtml)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.author#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">,
						<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.date#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mp3url#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ishtml#">)
			</cfquery>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetNewsID">
				SELECT id
				FROM news_entry
				WHERE title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">
				ORDER BY id DESC
			</cfquery>
			
			<cfif qGetNewsID.recordcount>
				<cfset rtNewsID = qGetNewsID.id>
			</cfif>
		
		<cfelse>
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
				UPDATE news_entry
				SET author = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.author#">,
					title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
					date = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.date#">,
					text = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">,
					mp3url = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mp3url#">,
					ishtml = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ishtml#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		
			<cfset rtNewsID = arguments.id>
		
		</cfif>
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE
			FROM news_entry_category
			WHERE entry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#rtNewsID#">
		</cfquery>
		
		<cfloop list="#arguments.category_ids#" index="idx">

			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO news_entry_category (entry_id, category_id)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#rtNewsID#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#idx#">)
			</cfquery>
			
		</cfloop>
		
		<cfreturn rtNewsID>
		
	</cffunction>

	<cffunction name="deleteNews" access="remote" returntype="boolean" output="false">
		<cfargument name="id" type="numeric" required="true">
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE
			FROM news_entry_category
			WHERE entry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE
			FROM news_entry
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="getCategories" access="remote" returntype="struct" output="false">
		
		<cfset var stCategories = StructNew()>
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetCategories">
			SELECT c.*, COUNT(ce.category_id) AS entrys
			FROM news_category c
			LEFT OUTER JOIN news_entry_category ce ON c.id = ce.category_id
			GROUP BY c.id
			ORDER BY c.name
		</cfquery>
		
		<cfloop query="qGetCategories">
			<cfscript>
				stCategories[id] = StructNew();
				stCategories[id].name = name;
				stCategories[id].entrys = entrys;
			</cfscript>
		</cfloop>
		
		<cfreturn stCategories>
		
	</cffunction>

	<cffunction name="setCategory" access="remote" returntype="boolean" output="false">
		<cfargument name="id" type="numeric" required="false" default="0">
		<cfargument name="name" type="string" required="true">

		<cfif arguments.id EQ 0>

			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO news_category (name)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">)
			</cfquery>
		
		<cfelse>
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
				UPDATE news_category
				SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>
	
	<cffunction name="generateRSS" access="remote" returntype="string" output="false">
		<cfargument name="mode" type="string" required="false" default="short" hint="If mode=short, show EXCERPT chars of entries. Otherwise, show all.">
		<cfargument name="excerpt" type="numeric" required="false" default="250" hint="If mode=short, this how many chars to show.">
		
		<cfset var articles = "">
		<cfset var z = getTimeZoneInfo()>
		<cfset var header = "">
		<cfset var channel = "">
		<cfset var items = "">
		<cfset var dateStr = "">
		<cfset var rssStr = "">
		
		<cfinvoke component="news" method="getNews" returnvariable="qNews">
		
		<cfsavecontent variable="header">
		<cfoutput>
<?xml version="1.0" encoding="utf-8"?>

<rdf:RDF 
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns##"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns="http://purl.org/rss/1.0/"
>
		</cfoutput>
		</cfsavecontent>

		<cfsavecontent variable="channel">
		<cfoutput>
<channel rdf:about="#cgi.server_name#:#cgi.server_port##request.lanshock.environment.webpath#">
	<title>#xmlFormat(request.lanshock.settings.appname)# <cfif arguments.mode EQ 'short'>#xmlFormat(request.content.rss_feed_short)#<cfelse>#xmlFormat(request.content.rss_feed_full)#</cfif></title>
	<description>#xmlFormat(request.lanshock.settings.appname)# <cfif arguments.mode EQ 'short'>#xmlFormat(request.content.rss_feed_short)#<cfelse>#xmlFormat(request.content.rss_feed_full)#</cfif></description>
	<link>http://#cgi.server_name#:#cgi.server_port##request.lanshock.environment.webpath##request.varScope.myself##request.varScope.myfusebox.thiscircuit#.main</link>
	
	<items>
		<rdf:Seq>
			<cfloop query="qNews">
			<rdf:li rdf:resource="http://#cgi.server_name#:#cgi.server_port##request.lanshock.environment.webpath##request.varScope.myself##request.varScope.myfusebox.thiscircuit#.news_details&amp;news_id=#id#" />
			</cfloop>
		</rdf:Seq>
	</items>

</channel>
		</cfoutput>
		</cfsavecontent>

		<cfsavecontent variable="items">
		<cfloop query="qNews">
		<cfset dateStr = dateFormat(date,"yyyy-mm-dd")>
		<cfset dateStr = dateStr & "T" & timeFormat(date,"HH:mm:ss") & "-" & numberFormat(z.utcHourOffset,"00") & ":00">
		<cfoutput>
<item rdf:about="http://#cgi.server_name#:#cgi.server_port##request.lanshock.environment.webpath##request.varScope.myself##request.varScope.myfusebox.thiscircuit#.news_details&amp;news_id=#id#">
	<title>#xmlFormat(title)#</title>
	<description><cfif arguments.mode EQ 'short' AND len(text) GT arguments.excerpt>#xmlFormat(left(text,arguments.excerpt))#...<cfelse>#xmlFormat(text)#</cfif></description>
	<link>http://#cgi.server_name#:#cgi.server_port##request.lanshock.environment.webpath##request.varScope.myself##request.varScope.myfusebox.thiscircuit#.news_details&amp;news_id=#id#</link>
	<dc:date>#dateStr#</dc:date>
	<dc:subject><cfif arguments.mode EQ 'short'>#xmlFormat(request.content.rss_feed_short)#<cfelse>#xmlFormat(request.content.rss_feed_full)#</cfif></dc:subject>
</item>
		</cfoutput>
	 	</cfloop>
		</cfsavecontent>

		<cfset rssStr = trim(header & channel & items & "</rdf:RDF>")>
		
		<cfreturn rssStr>
		
	</cffunction>

</cfcomponent>