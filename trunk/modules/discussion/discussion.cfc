<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getGroups" access="remote" returntype="query" output="false">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGroups">
			SELECT *
			FROM discussion_group
			ORDER BY name
		</cfquery>
		
		<cfreturn qGroups>
		
	</cffunction>

	<cffunction name="getGroup" access="remote" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="true">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGroup">
			SELECT *
			FROM discussion_group
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qGroup>
		
	</cffunction>

	<cffunction name="setGroup" access="remote" returntype="boolean" output="false">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="permission" type="string" required="false" default="">

		<cfif arguments.id EQ 0>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO discussion_group (name,permission)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.permission#">)
			</cfquery>
		
		<cfelse>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE discussion_group
				SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">,
					permission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.permission#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="getBoards" access="remote" returntype="query" output="false">
		<cfargument name="group_id" type="numeric" required="true">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qBoards">
			SELECT *
			FROM discussion_board
			WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.group_id#">
			ORDER BY title
		</cfquery>
		
		<cfreturn qBoards>
		
	</cffunction>

	<cffunction name="getBoard" access="remote" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="true">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qBoard">
			SELECT *
			FROM discussion_board
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qBoard>
		
	</cffunction>

	<cffunction name="setBoard" access="remote" returntype="boolean" output="false">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="subtitle" type="string" required="true">
		<cfargument name="group_id" type="numeric" required="true">

		<cfif arguments.id EQ 0>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO discussion_board (title, subtitle, group_id)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.subtitle#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.group_id#">)
			</cfquery>
		
		<cfelse>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE discussion_board
				SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">,
					subtitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.subtitle#">,
					group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.group_id#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>
	
	<cffunction name="generateRSS" access="remote" returntype="string" output="false">
		<cfargument name="mode" type="string" required="false" default="short" hint="If mode=short, show EXCERPT chars of entries. Otherwise, show all.">
		<cfargument name="excerpt" type="numeric" required="false" default="250" hint="If mode=short, this how many chars to show.">
		<cfargument name="params" type="struct" required="false" default="#structNew()#" hint="Passed to getEntries. Note, maxEntries can't be bigger than 15.">
		<cfargument name="boardid" type="numeric" required="true">
		
		<cfset var articles = "">
		<cfset var z = getTimeZoneInfo()>
		<cfset var header = "">
		<cfset var channel = "">
		<cfset var items = "">
		<cfset var dateStr = "">
		<cfset var rssStr = "">

		<cfinvoke method="getBoard" returnvariable="qBoard">
			<cfinvokeargument name="id" value="#arguments.boardid#">
		</cfinvoke>
		
		<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getTopics" returnvariable="qTopics">
			<cfinvokeargument name="type" value="discussion_board_#arguments.boardid#">
		</cfinvoke>
		
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
<channel rdf:about="#cgi.server_name#:#cgi.server_port##application.lanshock.oRuntime.getEnvironment().sWebPath#">
	<title>#xmlFormat(request.lanshock.settings.appname)# (#xmlFormat(qBoard.title)#)</title>
	<description>#xmlFormat(qBoard.title)#<cfif len(qBoard.subtitle)> - #xmlFormat(qBoard.subtitle)#</cfif></description>
	<link>http://#cgi.server_name#:#cgi.server_port##application.lanshock.oRuntime.getEnvironment().sWebPath##request.varScope.myself##request.varScope.myfusebox.thiscircuit#.board&amp;id=#qBoard.id#</link>
	
	<items>
		<rdf:Seq>
			<cfloop query="qTopics">
			<rdf:li rdf:resource="http://#cgi.server_name#:#cgi.server_port##application.lanshock.oRuntime.getEnvironment().sWebPath##request.varScope.myself##request.varScope.myfusebox.thiscircuit#.topic&amp;id=#id#" />
			</cfloop>
		</rdf:Seq>
	</items>

</channel>
		</cfoutput>
		</cfsavecontent>

		<cfsavecontent variable="items">
		<cfloop query="qTopics">
		<cfif len(dt_lastpost)>
			<cfset dtPost = dt_lastpost>
		<cfelse>
			<cfset dtPost = dt_created>
		</cfif>
		<cfset dateStr = dateFormat(dtPost,"yyyy-mm-dd")>
		<cfset dateStr = dateStr & "T" & timeFormat(dtPost,"HH:mm:ss") & "-" & numberFormat(z.utcHourOffset,"00") & ":00">
		<cfoutput>
<item rdf:about="http://#cgi.server_name#:#cgi.server_port##application.lanshock.oRuntime.getEnvironment().sWebPath##request.varScope.myself##request.varScope.myfusebox.thiscircuit#.topic&amp;id=#id#">
	<title>#xmlFormat(title)#</title>
	<description>#xmlFormat(text)#</description>
	<link>http://#cgi.server_name#:#cgi.server_port##application.lanshock.oRuntime.getEnvironment().sWebPath##request.varScope.myself##request.varScope.myfusebox.thiscircuit#.topic&amp;id=#id#</link>
	<dc:date>#dateStr#</dc:date>
	<dc:subject>#xmlFormat(qBoard.title)#</dc:subject>
</item>
		</cfoutput>
	 	</cfloop>
		</cfsavecontent>

		<cfset rssStr = trim(header & channel & items & "</rdf:RDF>")>
		
		<cfreturn rssStr>
		
	</cffunction>

</cfcomponent>