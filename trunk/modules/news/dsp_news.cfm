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
<div class="headline">#request.content.news_headline#</div>

<cfif len(attributes.category_id)>
	<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#">#request.content.show_all_news#</a> | #request.content.categories# #stCategories[attributes.category_id].name#
</cfif>

<cfif len(attributes.user_id)>
	<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#">#request.content.show_all_news#</a> | <!--- TODO: $$$ ---> Posted by #GetUsernameByID(attributes.user_id)#
</cfif>

<table width="100%">
	<cfloop query="qNews">
		<cfinvoke component="#request.lanshock.environment.componentpath#core.comments.comments" method="getCommentsCount" returnvariable="iCommentCount">
			<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
			<cfinvokeargument name="identifier" value="news#id#">
		</cfinvoke>
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.news_details&news_id=#id#&#request.session.UrlToken#"><div class="headline2">#title#</div></a></td>
		</tr>
		<tr>
			<td class="text_small">
				<table width="100%" cellspacing="0">
					<tr>
						<td class="alternate"><strong>#UDF_DateTimeFormat(date)#</strong></td>
						<td class="alternate" align="right"><a href="#myself##myfusebox.thiscircuit#.news_details&news_id=#id#&#request.session.UrlToken#">#iCommentCount# #request.content._core__comments__comments#</a></td>
					</tr>
				</table>
			</td>
		</tr>
		<cfif len(mp3url)>
			<tr>
				<td><img src="#stImageDir.general#/spacer.gif" width="1" height="10" alt="" border="0"></td>
			</tr>
			<tr>
				<td><object data="#UDF_Module('webPath')#audio-player/player.swf?soundFile=#UrlEncodedFormat(mp3url)#&amp;playerID=1&amp;bg=0xf8f8f8&amp;leftbg=0xeeeeee&amp;lefticon=0x666666&amp;rightbg=0xcccccc&amp;rightbghover=0x999999&amp;righticon=0x666666&amp;righticonhover=0xFFFFFF&amp;text=0x666666&amp;slider=0x666666&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0x9FFFB8" type="application/x-shockwave-flash" width="290" height="24" id="audioplayer1">
						<param name="movie" value="#UDF_Module('webPath')#audio-player/player.swf?soundFile=#UrlEncodedFormat(mp3url)#&amp;playerID=1&amp;bg=0xf8f8f8&amp;leftbg=0xeeeeee&amp;lefticon=0x666666&amp;rightbg=0xcccccc&amp;rightbghover=0x999999&amp;righticon=0x666666&amp;righticonhover=0xFFFFFF&amp;text=0x666666&amp;slider=0x666666&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0x9FFFB8" />
						<param name="quality" value="high" />
						<param name="menu" value="false" />
						<param name="wmode" value="transparent" />
						<a href="#mp3url#">#mp3url#</a>
					</object></td>
			</tr>
		</cfif>
		<tr>
			<td><img src="#stImageDir.general#/spacer.gif" width="1" height="10" alt="" border="0"></td>
		</tr>
		<tr>
			<td>#ConvertText(text=text,allow_html=ishtml)#<br>&nbsp;</td>
		</tr>
		<tr>
			<td><span class="text_small"><!--- TODO: $$$ ---> Posted by <a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#author#&#request.session.UrlToken#">#GetUsernameByID(author)#</a> <a href="#myself##myfusebox.thiscircuit#.main&user_id=#author#&#request.session.UrlToken#"><!--- TODO: $$$ ---> Show all Entries of this User</a></span></td>
		</tr>
		<tr>
			<td><span class="text_small">#request.content.categories# <cfloop list="#category_ids#" index="idx"><a href="#myself##myfusebox.thiscircuit#.main&category_id=#idx#&#request.session.UrlToken#">#stCategories[idx].name#</a><cfif idx NEQ listLast(category_ids)>, </cfif></cfloop></span></td>
		</tr>
		<cfset qTrackbacks = objectBreeze.getByWhere("news_trackback",'entry_id = #id#','date DESC').getQuery()>
		<tr>
			<td><span class="text_small">#formatContentString(request.content.trackbacks,qTrackbacks.recordcount)# <span class="text_light">#application.lanshock.environment.serveraddress##application.lanshock.environment.webpath##myself##myfusebox.thiscircuit#.trackback&entry_id=#id#</span></span></td>
		</tr>
		<tr>
			<td><img src="#stImageDir.general#/spacer.gif" width="1" height="30" alt="" border="0"></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">