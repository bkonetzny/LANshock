<cfsetting enablecfoutputonly="true">
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
		<div class="blogpost">
			<h4><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNews.id#&title=#UrlEncodedFormat(qNews.title)#')#">#qNews.title#</a></h4>
			<div class="postinfo">Posted by <a class="author" href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qNews.author#')#">#qNews.user_name#</a> <a class="authorposts" href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&user_id=#qNews.author#')#">(all)</a> on #session.oUser.dateTimeFormat(qNews.date,'datetime')#</div>
			<cfif qNews.qCategories.recordcount>
				<div class="categories">#request.content.categories# <cfloop query="qNews.qCategories"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&category_id=#qNews.qCategories.category_id#')#">#qNews.qCategories.news_category_name#</a><cfif qNews.qCategories.currentrow NEQ qNews.qCategories.recordcount>, </cfif></cfloop></div>
			</cfif>
			<cfif len(qNews.mp3url)>
				<div class="mediaplayer">
					<div id="mediaplayer_#qNews.id#">
						<a href="#qNews.mp3url#" target="_blank">#qNews.mp3url#</a>
					</div>
					<script type="text/javascript">
						swfobject.embedSWF("#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/flash/mediaplayer/player.swf", "mediaplayer_#qNews.id#", "290", "24", "9.0.0", "expressInstall.swf", {file: "#UrlEncodedFormat(qNews.mp3url)#"}, {}, {id: "mediaplayer_flash_#qNews.id#"});
					</script>
				</div>
			</cfif>
			<div class="text">#application.lanshock.oHelper.ConvertText(qNews.text)#</div>
			<div class="clear"></div>
			<ul class="postoptions">
				<li class="trackback"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.trackback&entry_id=#qNews.id#')#">#application.lanshock.oHelper.formatContentString(request.content.trackbacks, qNews.qTrackbacks.recordcount)#</a></li>
				<li class="comments"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNews.id#')#">#qNews.iCommentCount# #request.content._core__comments__comments#</a></li>
				<li class="readmore"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNews.id#')#"><!--- TODO: $$$ --->Read more</a></li>
			</ul>
		</div>
	</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="false">