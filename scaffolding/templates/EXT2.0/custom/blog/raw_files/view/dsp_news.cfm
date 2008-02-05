<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/dsp_news.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfoutput>
<h3>#request.content.news_headline#</h3>

<cfif len(attributes.category_id) OR len(attributes.user_id)>
	<div class="postfilter">
		<cfif len(attributes.category_id)>
			<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#">#request.content.show_all_news#</a> | #request.content.categories# #stCategories[attributes.category_id].name#
		</cfif>
		<cfif len(attributes.user_id)>
			<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#">#request.content.show_all_news#</a> | <!--- TODO: $$$ ---> Posted by #GetUsernameByID(attributes.user_id)#
		</cfif>
	</div>
</cfif>
</cfoutput>

<cfloop query="qNews">
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="getCommentsCount" returnvariable="iCommentCount">
		<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
		<cfinvokeargument name="identifier" value="news#qNews.id#">
	</cfinvoke>

	<cfinvoke component="#application.lanshock.oFactory.load('news_trackback','reactorGateway')#" method="getByFields" returnvariable="qTrackbacks">
		<cfinvokeargument name="sortByFieldList" value="date"/>
		<cfinvokeargument name="entry_id" value="#qNews.id#"/>
	</cfinvoke>

	<cfoutput>
	<div class="blogpost">
		<h4><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#id#&title=#UrlEncodedFormat(qNews.title)#')#">#qNews.title#</a></h4>
		<div class="postinfo">Posted by <a class="author" href="#application.lanshock.oHelper.buildUrl('c_user.userdetails&id=#author#')#">#application.lanshock.oHelper.GetUsernameByID(author)#</a> <a class="authorposts" href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&user_id=#author#')#">(all)</a> on #session.oUser.dateTimeFormat(date,'datetime')#</div>
		<cfif len(category_ids)>
			<div class="categories">#request.content.categories# <cfloop list="#category_ids#" index="idx"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&category_id=#idx#')#">#stCategories[idx].name#</a><cfif idx NEQ listLast(category_ids)>, </cfif></cfloop></div>
		</cfif>
		<cfif len(mp3url)>
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
					swfobject.embedSWF("#request.lanshock.environment.webpath#templates/_shared/flash/jw_media_player/mediaplayer.swf", "mediaplayer_#qNews.id#", "290", "24", "9.0.0", "expressInstall.swf", flashvars, params, attributes);
				</script>
				<div id="mediaplayer_#qNews.id#">
					<a href="#qNews.mp3url#" target="_blank">#qNews.mp3url#</a>
				</div>
			</div>
		</cfif>
		<div class="text">#application.lanshock.oHelper.ConvertText(text=text,allow_html=ishtml)#</div>
		<ul class="postoptions">
			<li class="trackback"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.trackback&entry_id=#id#')#">#application.lanshock.oHelper.formatContentString(request.content.trackbacks,qTrackbacks.recordcount)#</a></li>
			<li class="comments"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#id#')#">#iCommentCount# #request.content._core__comments__comments#</a></li>
			<li class="readmore"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#id#')#"><!--- TODO: $$$ --->Read more</a></li>
		</ul>
	</div>
	</cfoutput>
</cfloop>

<cfsetting enablecfoutputonly="No">