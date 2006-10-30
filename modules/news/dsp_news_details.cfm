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
<table width="100%">
	<tr>
		<td><span class="headline">#request.content.news_headline#</span></td>
	</tr>
	<cfloop query="qNewsEntry">
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.main&#request.session.UrlToken#"><div class="headline2">#title#</div></a></td>
		</tr>
		<tr>
			<td class="text_small">
				<table width="100%" cellspacing="0">
					<tr>
						<td class="alternate"><strong>#UDF_DateTimeFormat(date)#</strong></td>
						<td class="alternate" align="right">#stComments.recordcount# #request.content._core__comments__comments#</td>
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
			<td><span class="text_small"><!--- TODO: $$$ ---> Posted by <a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#author#&#request.session.UrlToken#">#GetUsernameByID(author)#</a></span></td>
		</tr>
		<tr>
			<td><span class="text_small">#request.content.categories# <cfloop list="#category_ids#" index="idx"><a href="#myself##myfusebox.thiscircuit#.main&category_id=#idx#&#request.session.UrlToken#">#stCategories[idx].name#</a><cfif idx NEQ listLast(category_ids)>, </cfif></cfloop></span></td>
		</tr>
		<tr>
			<td><span class="text_small">#formatContentString(request.content.trackbacks,qTrackbacks.recordcount)# <span class="text_light">#application.lanshock.environment.serveraddress##application.lanshock.environment.webpath##myself##myfusebox.thiscircuit#.trackback&entry_id=#id#</span></span></td>
		</tr>
		<tr>
			<td><img src="#stImageDir.general#/spacer.gif" width="1" height="50" alt="" border="0"></td>
		</tr>
	</cfloop>
	</table>
	
	<cfif qTrackbacks.recordcount>
		<span class="headline2">#request.content.headline_trackbacks#</span>
		
		<table class="vlist">
		<cfloop query="qTrackbacks">
			<cfif NOT len(blog_name)>
				<cfset name = url>
			<cfelse>
				<cfset name = blog_name>
			</cfif>
			<tr>
				<th>#UDF_DateTimeFormat(date)#</th>
				<td><a href="#url#" title="#text#" target="_blank">#name#</a></td>
				<td>#text#</td>
			</tr>
		</cfloop>
		</table>
	</cfif>
	
	#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">