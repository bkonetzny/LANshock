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
	<div class="headline">#request.content.discussion_overview#</div>

	<div class="headline2">#request.content.discussion_list#</div>
	
	<table class="list">
	<cfloop query="qGroups">
		<tr>
			<td colspan="4" class="empty"><div class="headline2">#name#</div></td>
		</tr>
		<tr>
			<th>#request.content.board#</th>
			<th>#request.content.topic_count#</th>
			<th>#request.content.last_topic#</th>
			<th>#request.content.created_by#</th>
			<th class="empty">&nbsp;</th>
		</tr>
		<cfinvoke component="discussion" method="getBoards" returnvariable="qBoards">
			<cfinvokeargument name="group_id" value="#id#">
		</cfinvoke>
		
		<cfloop query="qBoards">
			<cfquery dbtype="query" name="qGetTopicCount">
				SELECT COUNT(id) AS records
				FROM qTopics
				WHERE type = 'discussion_board_#id#'
			</cfquery>
			<cfquery dbtype="query" name="qGetLastTopic">
				SELECT *
				FROM qTopics
				WHERE type = 'discussion_board_#id#'
				ORDER BY dt_created DESC
			</cfquery>
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.board&id=#id#&#request.session.urltoken#">#title#</a>
					<br><span class="text_light">#subtitle#</span></td>
				<td align="center">
					<cfif len(qGetTopicCount.records)>
						#qGetTopicCount.records#
					<cfelse>0</cfif></td>
				<td><cfif qGetLastTopic.recordcount>#UDF_DateTimeFormat(qGetLastTopic.dt_created)# (<a href="#myself##myfusebox.thiscircuit#.topic&id=#qGetLastTopic.id#&#request.session.urltoken#">#qGetLastTopic.title#</a>)<cfelse>&nbsp;</cfif></td>
				<td><cfif qGetLastTopic.recordcount>#GetUsernameByID(qGetLastTopic.user_id)#<cfelse>&nbsp;</cfif></td>
				<td class="empty"><a href="#myself##myfusebox.thiscircuit#.rss&boardid=#id#" class="link_extended" target="_blank">XML</a></td>
			</tr>
		</cfloop>
	</cfloop>
	</table>

	<div class="headline2">#request.content.statitics#</div>

	<table class="list">
		<tr>
			<td colspan="3" class="empty"><div class="headline2">#request.content.stats_top_topics#</div></td>
		</tr>
		<tr>
			<th>#request.content.topic#</th>
			<th>#request.content.post_count#</th>
			<th>#request.content.last_post#</th>
			<th>#request.content.created_by#</th>
		</tr>
		<cfloop query="qTopTopics">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.topic&id=#id#&#request.session.urltoken#"><cfif module NEQ myfusebox.thiscircuit><cfif StructKeyExists(stModuleConfig.types,module)><img src="#stImageDir.module#/types/#stModuleConfig.types[module].image#" title="#request.content.topic_type# #module#.#type#"><cfelse>[<span class="text_important" title="#request.content.topic_type# #module#.#type#">#UCase(Left(module,1))##UCase(Left(type,1))#</span>]</cfif> </cfif>#title#</a></td>
				<td align="center">#postcount#</td>
				<td><cfif len(dt_lastpost)>
						#UDF_DateTimeFormat(dt_lastpost)#
					<cfelse>
						#UDF_DateTimeFormat(dt_created)#
					</cfif></td>
				<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#GetUsernameByID(user_id)#</a></td>
			</tr>
		</cfloop>
		<tr>
			<td colspan="3" class="empty"><div class="headline2">#request.content.stats_last_posts#</div></td>
		</tr>
		<tr>
			<th>#request.content.topic#</th>
			<th>#request.content.post_count#</th>
			<th>#request.content.last_post#</th>
			<th>#request.content.created_by#</th>
		</tr>
		<cfloop query="qLastPosts">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.topic&id=#id#&#request.session.urltoken#"><cfif module NEQ myfusebox.thiscircuit><cfif StructKeyExists(stModuleConfig.types,module)><img src="#stImageDir.module#/types/#stModuleConfig.types[module].image#" title="#request.content.topic_type# #module#.#type#"><cfelse>[<span class="text_important" title="#request.content.topic_type# #module#.#type#">#UCase(Left(module,1))##UCase(Left(type,1))#</span>]</cfif> </cfif>#title#</a></td>
				<td align="center">#postcount#</td>
				<td><cfif len(dt_lastpost)>
						#UDF_DateTimeFormat(dt_lastpost)#
					<cfelse>
						#UDF_DateTimeFormat(dt_created)#
					</cfif></td>
				<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#GetUsernameByID(user_id)#</a></td>
			</tr>
		</cfloop>
		<tr>
			<td colspan="3" class="empty"><div class="headline2">#request.content.stats_last_topics#</div></td>
		</tr>
		<tr>
			<th>#request.content.topic#</th>
			<th>#request.content.post_count#</th>
			<th>#request.content.last_post#</th>
			<th>#request.content.created_by#</th>
		</tr>
		<cfloop query="qLastTopics">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.topic&id=#id#&#request.session.urltoken#"><cfif module NEQ myfusebox.thiscircuit><cfif StructKeyExists(stModuleConfig.types,module)><img src="#stImageDir.module#/types/#stModuleConfig.types[module].image#" title="#request.content.topic_type# #module#.#type#"><cfelse>[<span class="text_important" title="#request.content.topic_type# #module#.#type#">#UCase(Left(module,1))##UCase(Left(type,1))#</span>]</cfif> </cfif>#title#</a></td>
				<td align="center">#postcount#</td>
				<td><cfif len(dt_lastpost)>
						#UDF_DateTimeFormat(dt_lastpost)#
					<cfelse>
						#UDF_DateTimeFormat(dt_created)#
					</cfif></td>
				<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#GetUsernameByID(user_id)#</a></td>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">