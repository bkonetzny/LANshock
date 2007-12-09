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
			<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&amp;#request.session.UrlToken#">#request.content.show_all_news#</a> | #request.content.categories# #stCategories[attributes.category_id].name#
		</cfif>
		<cfif len(attributes.user_id)>
			<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&amp;#request.session.UrlToken#">#request.content.show_all_news#</a> | <!--- TODO: $$$ ---> Posted by #GetUsernameByID(attributes.user_id)#
		</cfif>
	</div>
</cfif>
</cfoutput>

<cfloop query="qNews">
	<cfinvoke component="#request.lanshock.environment.componentpath#modules.comments.comments" method="getCommentsCount" returnvariable="iCommentCount">
		<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
		<cfinvokeargument name="identifier" value="news#qNews.id#">
	</cfinvoke>

	<cfinvoke component="#Application.ao__AppObj_mlanshock_news_trackback_Gateway#" method="getByFields" returnvariable="qTrackbacks">
		<cfinvokeargument name="sortByFieldList" value="date"/>
		<cfinvokeargument name="entry_id" value="#qNews.id#"/>
	</cfinvoke>

	<cfoutput>
	<div class="blogpost">
		<h4><a href="#myself##myfusebox.thiscircuit#.news_details&amp;news_id=#id#&amp;#request.session.UrlToken#">#qNews.title#</a></h4>
		<div class="postinfo">Posted by <a class="author" href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&amp;id=#author#&amp;#request.session.UrlToken#">#GetUsernameByID(author)#</a> <a class="authorposts" href="#myself##myfusebox.thiscircuit#.main&amp;user_id=#author#&amp;#request.session.UrlToken#">(all)</a> on #UDF_DateTimeFormat(date)#</div>
		<cfif len(category_ids)>
			<div class="categories">#request.content.categories# <cfloop list="#category_ids#" index="idx"><a href="#myself##myfusebox.thiscircuit#.main&amp;category_id=#idx#&amp;#request.session.UrlToken#">#stCategories[idx].name#</a><cfif idx NEQ listLast(category_ids)>, </cfif></cfloop></div>
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
		<div class="text">#ConvertText(text=text,allow_html=ishtml)#</div>
		<ul class="postoptions">
			<li class="trackback"><a href="#myself##myfusebox.thiscircuit#.trackback&amp;entry_id=#id#">#formatContentString(request.content.trackbacks,qTrackbacks.recordcount)#</a></li>
			<li class="comments"><a href="#myself##myfusebox.thiscircuit#.news_details&amp;news_id=#id#&amp;#request.session.UrlToken#">#iCommentCount# #request.content._core__comments__comments#</a></li>
			<li class="readmore"><a href="#myself##myfusebox.thiscircuit#.news_details&amp;news_id=#id#&amp;#request.session.UrlToken#"><!--- TODO: $$$ --->Read more</a></li>
		</ul>
	</div>
	</cfoutput>
</cfloop>

<cfsetting enablecfoutputonly="No">