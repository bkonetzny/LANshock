<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/dsp_news_details.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfoutput>
<h3>#request.content.news_headline#</h3>

<cfloop query="qNewsEntry">
	<div class="blogpost">
		<h4><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNewsEntry.id#')#">#qNewsEntry.title#</a></h4>
		<div class="postinfo"><!--- TODO: $$$ --->Posted by <a class="author" href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qNewsEntry.author#')#">#application.lanshock.oHelper.GetUsernameByID(author)#</a> <a class="authorposts" href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&user_id=#qNewsEntry.author#')#">(all)</a> on #session.oUser.DateTimeFormat(qNewsEntry.date)#</div>
		<cfif len(qNewsEntry.category_ids)>
			<div class="categories">#request.content.categories# <cfloop list="#qNewsEntry.category_ids#" index="idx"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news&category_id=#idx#')#">#stCategories[idx].name#</a><cfif idx NEQ listLast(qNewsEntry.category_ids)>, </cfif></cfloop></div>
		</cfif>
		<cfif len(qNewsEntry.mp3url)>
			<div class="mediaplayer">
				<script type="text/javascript">
					var flashvars = {
						soundFile: "#UrlEncodedFormat(qNewsEntry.mp3url)#"
					};
					var params = {
						menu: "false"
					};
					var attributes = {
						id: "mediaplayer_flash_#qNewsEntry.id#",
						name: "myDynamicContent"
					};
					swfobject.embedSWF("#UDF_Module('webPath')#audio-player/player.swf", "mediaplayer_#qNewsEntry.id#", "290", "24", "9.0.0", "expressInstall.swf", flashvars, params, attributes);
				</script>
				<div id="mediaplayer_#qNewsEntry.id#">
					<a href="#qNewsEntry.mp3url#">#qNewsEntry.mp3url#</a>
				</div>
			</div>
		</cfif>
		<div class="text">#application.lanshock.oHelper.ConvertText(text=qNewsEntry.text,allow_html=qNewsEntry.ishtml)#</div>
	</div>
</cfloop>

<cfif qTrackbacks.recordcount>
	<h4>#request.content.headline_trackbacks#</h4>
	
	<table class="vlist">
	<cfloop query="qTrackbacks">
		<cfif NOT len(qTrackbacks.blog_name)>
			<cfset name = qTrackbacks.url>
		<cfelse>
			<cfset name = qTrackbacks.blog_name>
		</cfif>
		<tr>
			<th>#session.oUser.DateTimeFormat(qTrackbacks.date)#</th>
			<td><a href="#qTrackbacks.url#" title="#qTrackbacks.text#" target="_blank">#name#</a></td>
			<td>#qTrackbacks.text#</td>
		</tr>
	</cfloop>
	</table>
</cfif>

#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">