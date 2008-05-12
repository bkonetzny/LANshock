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
	<h3>#request.content.discussion_overview#</h3>

	<cfloop query="qGroups">
		<cfif NOT len(qGroups.permission)
			OR (len(qGroups.permission) AND session.oUser.checkPermissions(ListLast(qGroups.permission,'.'),ListFirst(qGroups.permission,'.')))>
				
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="getBoards" returnvariable="qBoards">
				<cfinvokeargument name="group_id" value="#qGroups.id#">
			</cfinvoke>
	
			<cfif qBoards.recordcount>
				<h4><cfif len(qGroups.permission)><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/lock.png" alt="" /> </cfif>#qGroups.name#</h4>
				<table>
					<tr>
						<th>#request.content.board#</th>
						<th>#request.content.topic_count#</th>
						<th>#request.content.last_topic#</th>
						<th class="empty">&nbsp;</th>
					</tr>
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
							ORDER BY dt_lastpost DESC
						</cfquery>
						<tr>
							<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.board&id=#qBoards.id#')#">#qBoards.title#</a>
								<br/><span class="text_light">#qBoards.subtitle#</span></td>
							<td align="center">#qGetTopicCount.records#</td>
							<td>#session.oUser.DateTimeFormat(qGetLastTopic.dt_lastpost)#<br/>
								<a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qGetLastTopic.user_id_lastpost#')#">#application.lanshock.oHelper.GetUsernameByID(qGetLastTopic.user_id_lastpost)#</a>
								</td>
							<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.rss&boardid=#qBoards.id#')#" target="_blank"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/feed.png" alt="<!--- $$$ ---> RSS" /></a></td>
						</tr>
					</cfloop>
				</table>
			</cfif>
		</cfif>
	</cfloop>

	<h3>#request.content.statitics#</h3>
	
	<div style="width: 45%; float: left;">
		<h4>#request.content.stats_top_topics#</h4>
		<table>
			<tr>
				<th colspan="2">#request.content.topic#</th>
				<th>#request.content.post_count#</th>
			</tr>
			<cfloop query="qTopTopics">
				<tr>
					<td><cfif StructKeyExists(stModuleConfig.types,qTopTopics.module)><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/#stModuleConfig.types[qTopTopics.module].image#" title="#request.content.topic_type# #qTopTopics.module#.#qTopTopics.type#"></cfif></td>
					<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.topic&id=#qTopTopics.id#')#">#qTopTopics.title#</a></td>
					<td align="center">#qTopTopics.postcount#</td>
				</tr>
			</cfloop>
		</table>
	</div>
	
	<div style="width: 45%; float: right;">
		<h4>#request.content.stats_last_posts#</h4>
		<table>
			<tr>
				<th colspan="2">#request.content.topic#</th>
			</tr>
			<cfloop query="qLastPosts">
				<tr>
					<td><cfif StructKeyExists(stModuleConfig.types,qLastPosts.module)><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/#stModuleConfig.types[qLastPosts.module].image#" title="#request.content.topic_type# #qLastPosts.module#.#qLastPosts.type#"></cfif></td>
					<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.topic&id=#qLastPosts.id#')#">#qLastPosts.title#</a>
						<br/>#request.content.last_post#: #session.oUser.DateTimeFormat(qLastPosts.dt_lastpost)#
						<br/><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qLastPosts.user_id_lastpost#')#">#application.lanshock.oHelper.GetUsernameByID(qLastPosts.user_id_lastpost)#</a>
					</td>
				</tr>
			</cfloop>
		</table>
	</div>
	
	<div class="clearer"></div>
</cfoutput>

<cfsetting enablecfoutputonly="No">