<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.news_id" default="0">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfinvoke component="news" method="getNews" returnvariable="qNews">
	<cfinvokeargument name="showfuture" value="true">
</cfinvoke>

<cfscript>
	qPingUrls = objectBreeze.list("news_ping_url", 'name ASC').getQuery();
</cfscript>

<cfif isNumeric(attributes.news_id) AND NOT attributes.form_submitted>

	<cfinvoke component="news" method="getNewsEntry" returnvariable="qNewsEntry">
		<cfinvokeargument name="id" value="#attributes.news_id#">
	</cfinvoke>
	
	<cfif qNewsEntry.recordcount>

		<cfparam name="attributes.title" default="#qNewsEntry.title#">
		<cfparam name="attributes.date" default="#qNewsEntry.date#">
		<cfparam name="attributes.text" default="#qNewsEntry.text#">
		<cfparam name="attributes.mp3url" default="#qNewsEntry.mp3url#">
		<cfparam name="attributes.ishtml" default="#qNewsEntry.ishtml#">
		<cfparam name="attributes.category_ids" default="#qNewsEntry.category_ids#">
	
	</cfif>

</cfif>

<cfparam name="attributes.title" default="">
<cfparam name="attributes.date" default="#now()#">
<cfparam name="attributes.text" default="">
<cfparam name="attributes.mp3url" default="">
<cfparam name="attributes.ishtml" default="0">
<cfparam name="attributes.category_ids" default="">
<cfparam name="attributes.trackback" default="">
<cfparam name="attributes.ping" default="">

<cfif attributes.form_submitted>

	<cfscript>
		attributes.date = LSParseDateTime(attributes.date & ' ' & attributes.time);

		if(NOT len(attributes.title)) ArrayAppend(aError, request.content.title);
		if(NOT len(attributes.text)) ArrayAppend(aError, request.content.text);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="news" method="setNews" returnvariable="rtNewsID">
			<cfinvokeargument name="id" value="#attributes.news_id#">
			<cfinvokeargument name="author" value="#request.session.userid#">
			<cfinvokeargument name="title" value="#attributes.title#">
			<cfinvokeargument name="date" value="#attributes.date#">
			<cfinvokeargument name="text" value="#attributes.text#">
			<cfinvokeargument name="mp3url" value="#attributes.mp3url#">
			<cfinvokeargument name="ishtml" value="#attributes.ishtml#">
			<cfinvokeargument name="category_ids" value="#attributes.category_ids#">
		</cfinvoke>
		
		<cfif len(attributes.trackback)>
			<cftry>
				<cfhttp url="#attributes.trackback#" method="post">
					<cfhttpparam name="url" value="#application.lanshock.environment.serveraddress##application.lanshock.environment.webpath##myself##myfusebox.thiscircuit#.news_details&news_id=#rtNewsID#" type="formfield">
					<cfhttpparam name="title" value="#attributes.title#" type="formfield">
					<cfhttpparam name="blog_name" value="#request.lanshock.settings.appname#" type="formfield">
					<cfhttpparam name="excerpt" value="#left(attributes.text,50)#" type="formfield">
				</cfhttp>
				<cfcatch><!--- do nothing ---></cfcatch>
			</cftry>
		</cfif>
		
		<cfif len(attributes.ping)>
			<cfset qPingUrlsToPing = objectBreeze.getByWhere("news_ping_url", 'id IN (#attributes.ping#)').getQuery()>
			<cfloop query="qPingUrlsToPing">
				<cfhttp url="#url#" method="get"></cfhttp>
			</cfloop>
		</cfif>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">