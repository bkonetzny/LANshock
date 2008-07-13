<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
	<h3>#request.content.news_headline#</h3>
	
	<cfif len(attributes.category_id) OR len(attributes.user_id)>
		<div class="postfilter">
			<cfif len(attributes.category_id)>
				
				<cfset stFilter = StructNew()>
				<cfset stFilter.stFields.id = StructNew()>
				<cfset stFilter.stFields.id.mode = 'isEqual'>
				<cfset stFilter.stFields.id.value = attributes.category_id>
				
				<cfinvoke component="#application.lanshock.oFactory.load('news_category','reactorGateway')#" method="getRecords" returnvariable="qCategory">
					<cfinvokeargument name="stFilter" value="#stFilter#">
				</cfinvoke>
				
				<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#">#request.content.show_all_news#</a> | #request.content.categories# #qCategory.name#
			</cfif>
			<cfif len(attributes.user_id)>
				<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#">#request.content.show_all_news#</a> | <!--- TODO: $$$ ---> Posted by #application.lanshock.oHelper.GetUsernameByID(attributes.user_id)#
			</cfif>
		</div>
	</cfif>
	
	<cfloop query="qNews">
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="getCommentsCount" returnvariable="iCommentCount">
			<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
			<cfinvokeargument name="identifier" value="news#qNews.id#">
		</cfinvoke>

		<cfset stFilter = StructNew()>
		<cfset stFilter.lSortFields = "date|DESC">
		<cfset stFilter.stFields.entry_id = StructNew()>
		<cfset stFilter.stFields.entry_id.mode = 'isEqual'>
		<cfset stFilter.stFields.entry_id.value = qNews.id>

		<cfinvoke component="#application.lanshock.oFactory.load('news_trackback','reactorGateway')#" method="getRecords" returnvariable="qTrackbacks">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>

		<cfset stFilter = StructNew()>
		<cfset stFilter.lSortFields = "news_category|name|ASC">
		<cfset stFilter.stJoins = StructNew()>
		<cfset stFilter.stJoins.news_category = "name">
		<cfset stFilter.stFields.entry_id = StructNew()>
		<cfset stFilter.stFields.entry_id.mode = 'isEqual'>
		<cfset stFilter.stFields.entry_id.value = qNews.id>

		<cfinvoke component="#application.lanshock.oFactory.load('news_entry_category','reactorGateway')#" method="getRecords" returnvariable="qCategories">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
	
		<div class="blogpost">
			<h4><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNews.id#&title=#UrlEncodedFormat(qNews.title)#')#">#qNews.title#</a></h4>
			<div class="postinfo">Posted by <a class="author" href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qNews.author#')#">#qNews.user_name#</a> <a class="authorposts" href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&user_id=#qNews.author#')#">(all)</a> on #session.oUser.dateTimeFormat(qNews.date,'datetime')#</div>
			<cfif qCategories.recordcount>
				<div class="categories">#request.content.categories# <cfloop query="qCategories"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&category_id=#qCategories.category_id#')#">#qCategories.news_category_name#</a><cfif qCategories.currentrow NEQ qCategories.recordcount>, </cfif></cfloop></div>
			</cfif>
			<cfif len(qNews.mp3url)>
				<div class="mediaplayer">
					<script type="text/javascript">
						var flashvars = {
							file: "#UrlEncodedFormat(qNews.mp3url)#"
						};
						var params = {
							menu: "false"
						};
						var attributes = {
							id: "mediaplayer_flash_#qNews.id#",
							name: "myDynamicContent"
						};
						swfobject.embedSWF("#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/flash/jw_media_player/mediaplayer.swf", "mediaplayer_#qNews.id#", "290", "24", "9.0.0", "expressInstall.swf", flashvars, params, attributes);
					</script>
					<div id="mediaplayer_#qNews.id#">
						<a href="#qNews.mp3url#" target="_blank">#qNews.mp3url#</a>
					</div>
				</div>
			</cfif>
			<div class="text">#application.lanshock.oHelper.ConvertText(qNews.text)#</div>
			<ul class="postoptions">
				<li class="trackback"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.trackback&entry_id=#qNews.id#')#">#application.lanshock.oHelper.formatContentString(request.content.trackbacks,qTrackbacks.recordcount)#</a></li>
				<li class="comments"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNews.id#')#">#iCommentCount# #request.content._core__comments__comments#</a></li>
				<li class="readmore"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNews.id#')#"><!--- TODO: $$$ --->Read more</a></li>
			</ul>
		</div>
	</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="No">