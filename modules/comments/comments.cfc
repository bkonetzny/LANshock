<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/comments/comments.cfc $
$LastChangedDate: 2006-10-23 00:24:29 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 46 $
--->

<cfcomponent>

	<cffunction name="getCommentsPanel" access="public" returntype="struct" output="false">
		<cfargument name="module" required="true" type="string">
		<cfargument name="identifier" required="true" type="string">
		<cfargument name="linktosource" required="false" type="string" default="">
		<cfargument name="type" required="false" type="string" default="***unknown_type***">
		<cfargument name="topic_title" required="false" type="string" default="">
		
		<cfset var uuidFormName = 'form#replacenocase(CreateUUID(),'-','','ALL')#'>
		<cfset var qGetTopicID = 0>
		<cfset var qComments = 0>
		<cfset var enableDisableComments = ''>
		<cfset var addComment = ''>
		<cfset var htmlComments = ''>
		<cfset var stComments = StructNew()>
	
		<cfquery name="qGetTopicID" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			SELECT id, isclosed
			FROM core_comments_topics
			WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
			AND identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">
		</cfquery>
		
		<cfhtmlhead text="<style>@import url('#application.lanshock.oRuntime.getEnvironment().sWebPath#modules/comments/style.css');</style>">
		
		<cfif session.oUser.checkPermissions('comments-manage','comments')>
			<cfsavecontent variable="enableDisableComments">
				<cfif qGetTopicID.recordcount>
					<cfoutput>
						<div align="center">
							<form action="#application.lanshock.oHelper.buildUrl('comments.comments_enable_disable')#" method="post">
								<input type="hidden" name="topic_id" value="#qGetTopicID.id#"/>
								<input type="hidden" name="mode" value="#abs(qGetTopicID.isclosed-1)#"/>
								<cfif qGetTopicID.isclosed>
									<input type="submit" value="#request.content._core__comments__enablecomments#"/>
								<cfelse>
									<input type="submit" value="#request.content._core__comments__disablecomments#"/>
								</cfif>
							</form>
						</div>
					</cfoutput>
				</cfif>
			</cfsavecontent>
		</cfif>
		
		<cfif NOT (qGetTopicID.recordcount AND qGetTopicID.isclosed)>
			<cfsavecontent variable="addComment">
				<cfif session.oUser.isLoggedIn()>
					<cfoutput>
						<form action="#application.lanshock.oHelper.buildUrl('comments.comment_edit')#" method="post" class="uniForm" onSubmit="return validateCommentsForm('#uuidFormName#','#jsStringFormat(request.content._core__comments__required_hint)#');">
							<div class="hidden">
								<input type="hidden" name="form_submitted" value="true"/>
								<input type="hidden" name="id" value="0"/>
								<cfif qGetTopicID.recordcount>
									<input type="hidden" name="topic_id" value="#qGetTopicID.id#"/>
								<cfelse>
									<input type="hidden" name="topic_id" value="0"/>
									<input type="hidden" name="parent_id" value="0"/>
									<input type="hidden" name="module" value="#arguments.module#"/>
									<input type="hidden" name="identifier" value="#arguments.identifier#"/>
									<input type="hidden" name="linktosource" value="#arguments.linktosource#"/>
									<input type="hidden" name="type" value="#arguments.type#"/>
								</cfif>
							</div>
							
							<fieldset class="inlineLabels">
								<legend>#request.content._core__comments__addcomment#</legend>
								
								<div class="ctrlHolder">
									<label for="#uuidFormName#title"><em>*</em> #request.content._core__comments__title#</label>
									<input type="text" class="textInput" name="title" id="#uuidFormName#title" value="#HtmlEditFormat(arguments.topic_title)#"/>
								</div>
								
								<div class="ctrlHolder">
									<label for="#uuidFormName#text"><em>*</em> #request.content._core__comments__text#</label>
									<textarea name="text" id="text"></textarea>
									<script type="text/javascript">
									<!--
										var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
										var oFCKeditor#uuidFormName# = new FCKeditor('text');
										oFCKeditor#uuidFormName#.BasePath = sBasePath + "fckeditor/";
										oFCKeditor#uuidFormName#.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
										oFCKeditor#uuidFormName#.ToolbarSet = 'Minimum';
										oFCKeditor#uuidFormName#.ReplaceTextarea();
									//-->
									</script>
								</div>
								
								<div class="ctrlHolder">
									<div>
										<label for="appendsignature" class="inlineLabel"><input type="checkbox" name="appendsignature" id="appendsignature" value="true" checked="checked"/> #request.content._core__comments__appendsignature#</label>
									</div>
								</div>

							</fieldset>
							<div class="buttonHolder">
								<button type="submit" class="submitButton">#request.content._core__comments__addcomment#</button>
							</div>
						</form>
					</cfoutput>
				<cfelse>
					<cfoutput>
						<h4>#request.content._core__comments__addcomment#</h4>
						<a href="#application.lanshock.oHelper.buildUrl('user.login&relocationusereferer=true')#">#request.content._core__comments__login_hint#</a>
					</cfoutput>
				</cfif>
			</cfsavecontent>
		</cfif>
		
		<cfif qGetTopicID.recordcount>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qComments">
				SELECT *
				FROM core_comments_posts
				WHERE topic_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qGetTopicID.id#">
				ORDER BY dt_created
			</cfquery>
		
			<cfsavecontent variable="htmlComments">
				<cfoutput>				
				<h4>#request.content._core__comments__comments#</h4>
				#enableDisableComments#
				<cfif qComments.recordcount>
					<cfloop query="qComments">
						<div class="commententry">
							<div class="commententrycount">#qComments.currentrow#</div>
							<div class="commententrydatetime">#session.oUser.DateTimeFormat(qComments.dt_created)#</div>
							<div class="commententryauthor"><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qComments.user_id#')#">#application.lanshock.oHelper.getUsernameById(qComments.user_id)#</a></div>
							<cfif session.oUser.getDataValue('userid') EQ qComments.user_id OR session.oUser.checkPermissions('comments-manage','comments')>
								<div class="commententryoptions">
									<a href="#application.lanshock.oHelper.buildUrl('comments.comment_delete&id=#qComments.id#')#">
										<img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/delete.png"/>
									</a>
								</div>
							</cfif>
							<div class="commententryauthorimg"><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qComments.user_id#')#">#application.lanshock.oHelper.UserShowAvatar(qComments.user_id)#</a></div>
							<div class="commententrytitle">#qComments.title#</div>
							<div class="commententrytext">#qComments.text#<!--- #application.lanshock.oHelper.ConvertText(qComments.text)#<br><br> ---></div>
							<div class="clearer"></div>
						</div>
					</cfloop>
				<cfelse>
					#request.content._core__comments__nocommentsavaible#
				</cfif>
				#enableDisableComments#
				<cfif NOT qGetTopicID.isclosed>
					#addComment#
				</cfif>
				</cfoutput>
			</cfsavecontent>

		<cfelse>

			<cfset qComments = QueryNew('id')>
			<cfset htmlComments = addComment>

		</cfif>
		
		<cfset stComments.recordcount = qComments.recordcount>
		<cfset stComments.query = qComments>
		<cfset stComments.html = htmlComments>
		
		<cfreturn stComments>
		
	</cffunction>

	<cffunction name="getCommentsCount" access="public" returntype="numeric" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="module" required="false" type="string" default="">
		<cfargument name="identifier" required="false" type="string" default="">
		
		<cfset var qPostCount = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qPostCount">
			SELECT COUNT(p.id) AS postcount
			FROM core_comments_topics t
			LEFT OUTER JOIN core_comments_posts p ON t.id = p.topic_id
			<cfif arguments.id NEQ 0>
				WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			<cfelse>
				WHERE t.module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
				AND t.identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">
			</cfif>
			GROUP BY t.id
		</cfquery>
		
		<cfif qPostCount.recordcount>
			<cfreturn qPostCount.postcount>
		<cfelse>
			<cfreturn 0>
		</cfif>
		
	</cffunction>

	<cffunction name="getCommentCountStruct" access="public" returntype="query" output="false">
		<cfargument name="module" required="true" type="string">
		
		<cfset var qCommentsCount = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qCommentsCount">
			SELECT t.*, COUNT(p.id) AS postcount
			FROM core_comments_topics t
			LEFT OUTER JOIN core_comments_posts p ON t.id = p.topic_id
			WHERE t.module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
			GROUP BY t.id
		</cfquery>
		
		<cfreturn qCommentsCount>
		
	</cffunction>

	<cffunction name="getLatestComments" access="public" returntype="query" output="false">
		<cfargument name="records" required="false" type="numeric" default="10">
		
		<cfset var qLatestComments = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qLatestComments">
			SELECT p.*, t.module, t.identifier, t.linktosource, t.type
			FROM core_comments_posts p
			LEFT OUTER JOIN core_comments_topics t ON t.id = p.topic_id
			GROUP BY p.id
			ORDER BY p.dt_created DESC
			LIMIT #arguments.records#
		</cfquery>
		
		<cfreturn qLatestComments>
		
	</cffunction>

	<cffunction name="getTopic" access="public" returntype="query" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="module" required="false" type="string" default="">
		<cfargument name="identifier" required="false" type="string" default="">
		
		<cfset var qTopic = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTopic">
			SELECT t.*, p.title, p.text, COUNT(p.id) AS postcount, MAX(p.dt_created) AS dt_lastpost
			FROM core_comments_topics t
			LEFT OUTER JOIN core_comments_posts p ON t.id = p.topic_id
			<cfif arguments.id NEQ 0>
				WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			<cfelse>
				WHERE t.module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
				AND t.identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">
			</cfif>
			GROUP BY t.id
		</cfquery>
		
		<cfreturn qTopic>
		
	</cffunction>

	<cffunction name="getTopics" access="public" returntype="query" output="false">
		<cfargument name="type" required="false" type="string" default="">
		<cfargument name="search" required="false" type="string" default="">
		
		<cfset var qGetTopics = 0>
		<cfset var idx = ''>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetTopics">
			SELECT t.*, p.title, p.text
			FROM core_comments_topics t
			LEFT OUTER JOIN core_comments_posts p ON t.id = p.topic_id
			<cfif len(arguments.type)>
				WHERE t.type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.type#">
			</cfif>
			<cfif len(arguments.search)>
				<cfif len(arguments.type)>AND<cfelse>WHERE</cfif> (
				<cfloop list="#arguments.search#" delimiters=" " index="idx">
					p.title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(idx)#%">
					OR p.text LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(idx)#%">
				</cfloop>
				)
			</cfif>
			GROUP BY t.id
			ORDER BY t.dt_lastpost DESC
		</cfquery>
		
		<cfreturn qGetTopics>
		
	</cffunction>
	
	<cffunction name="updateTopicData" returntype="boolean" output="false">
		<cfargument name="id" required="false" type="numeric">
		
		<cfset var qLastPostInfo = 0>
		<cfset var qPostcount = 0>
		<cfset var idx = ''>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qLastPostInfo">
			SELECT *
			FROM  core_comments_posts
			WHERE topic_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			ORDER BY dt_created DESC
			LIMIT 1
		</cfquery>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qPostcount">
			SELECT COUNT(id) AS postcount
			FROM  core_comments_posts
			WHERE topic_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			UPDATE core_comments_topics
			SET postcount = <cfqueryparam cfsqltype="cf_sql_integer" value="#qPostcount.postcount#">
				<cfif qLastPostInfo.recordcount>
					,dt_lastpost = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#qLastPostInfo.dt_created#">
					,user_id_lastpost = <cfqueryparam cfsqltype="cf_sql_integer" value="#qLastPostInfo.user_id#">
				<cfelse>
					,dt_lastpost = NULL
					,user_id_lastpost = NULL
				</cfif>
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="setTopic" access="public" returntype="numeric" output="false">
		<cfargument name="module" required="true" type="string">
		<cfargument name="identifier" required="true" type="string">
		<cfargument name="linktosource" required="false" type="string">
		<cfargument name="type" required="true" type="string">
		<cfargument name="user_id" required="true" type="numeric">
		
		<cfset var qGetTopicID = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetTopicID">
			SELECT id
			FROM core_comments_topics
			WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
			AND identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">
		</cfquery>
		
		<cfif NOT qGetTopicID.recordcount>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO core_comments_topics (module, identifier, linktosource, type, dt_created, user_id_created, dt_lastpost, user_id_lastpost, postcount)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.linktosource#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.type#">,
						#now()#,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">,
						#now()#,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">,
						1)
			</cfquery>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetTopicID">
				SELECT id
				FROM core_comments_topics
				WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
				AND identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">
			</cfquery>
		
		</cfif>
		
		<cfreturn qGetTopicID.id>
		
	</cffunction>

	<cffunction name="setTopicEnableDisable" access="public" returntype="boolean" output="false">
		<cfargument name="topic_id" required="true" type="numeric">
		<cfargument name="mode" required="true" type="numeric">
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			UPDATE core_comments_topics
			SET isclosed = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.mode#">
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topic_id#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="deleteTopic" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="module" required="false" type="string" default="">
		<cfargument name="identifier" required="false" type="string" default="">
		
		<cfset var iTopicID = arguments.id>
		
		<cfif arguments.id EQ 0>
			<cfinvoke method="getTopic" returnvariable="qTopic">
				<cfinvokeargument name="module" value="#arguments.module#">
				<cfinvokeargument name="identifier" value="#arguments.identifier#">
			</cfinvoke>
			<cfset iTopicID = qTopic.id>
		</cfif>
		
		<cfif isNumeric(iTopicID)>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				DELETE
				FROM core_comments_posts
				WHERE topic_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#iTopicID#">
			</cfquery>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				DELETE
				FROM core_comments_topics
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#iTopicID#">
			</cfquery>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="setPost" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="topic_id" required="true" type="numeric">
		<cfargument name="parent_id" required="false" type="numeric" default="0">
		<cfargument name="title" required="true" type="string">
		<cfargument name="text" required="true" type="string">
		<cfargument name="user_id" required="true" type="numeric">
		<cfargument name="appendsignature" required="false" type="boolean" default="true">
		
		<cfset var qGetPostData = 0>
		<cfset var qUserdata = 0>
		<cfset var newtext = trim(arguments.text)>
	
		<cfif arguments.id NEQ 0>
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetPostData">
				SELECT id, user_id
				FROM core_comments_posts
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
				AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
			</cfquery>
		</cfif>
		
		<cfif arguments.id NEQ 0 AND qGetPostData.recordcount>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE core_comments_posts
				SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.title)#">,
					text = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#newtext#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>

		<cfelse>
		
			<cfif arguments.appendsignature>
			
				<cfset qUserdata = application.lanshock.oHelper.GetUserDataByID(arguments.user_id)>
				<cfset newtext = newtext & '<br/><br/><span class="user_signature">' & trim(qUserdata.signature) & '</span>'>
			
			</cfif>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO core_comments_posts (topic_id, parent_id, title, text, user_id, dt_created)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topic_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.parent_id#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.title)#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#newtext#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">,
						#now()#)
			</cfquery>

		</cfif>
	
		<cfset updateTopicData(arguments.topic_id)>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="deletePost" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="user_id" required="true" type="numeric">
		
		<cfset var getPostData = 0>
		<cfset var qTopic = 0>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="getPostData">
			SELECT topic_id
			FROM core_comments_posts
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
		</cfquery>
		
		<cfif getPostData.recordcount>
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				DELETE 
				FROM core_comments_posts
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
				AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
			</cfquery>
			
			<cfinvoke method="getTopic" returnvariable="qTopic">
				<cfinvokeargument name="id" value="#getPostData.topic_id#">
			</cfinvoke>
			
			<cfif qTopic.recordcount AND qTopic.postcount EQ 0>
				<cfinvoke method="deleteTopic">
					<cfinvokeargument name="id" value="#qTopic.id#">
				</cfinvoke>
			</cfif>
	
			<cfset updateTopicData(getPostData.topic_id)>
		</cfif>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="getModuleTypes" access="public" returntype="struct" output="false">
	
		<cfset var qGetModule = 0>
		<cfset var qGetTypes = 0>
		<cfset var stModules = StructNew()>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetModule">
			SELECT module
			FROM core_comments_topics
			GROUP BY module
		</cfquery>
		
		<cfloop query="qGetModule">
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetTypes">
				SELECT type, COUNT(id) AS posts
				FROM core_comments_topics
				WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qGetModule.module#">
				GROUP BY type
			</cfquery>
			
			<cfset stModules[qGetModule.module] = StructNew()>
			
			<cfloop query="qGetTypes">
				<cfset stModules[qGetModule.module][qGetTypes.type] = qGetTypes.posts>
			</cfloop>
			
		</cfloop>
		
		<cfreturn stModules>
		
	</cffunction>

	<cffunction name="getPostCountByUserID" access="public" returntype="numeric" output="false">
		<cfargument name="id" required="true" type="numeric">
		
		<cfset var qPostCount = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qPostCount">
			SELECT COUNT(id) AS postcount
			FROM core_comments_posts
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qPostCount.postcount>
		
	</cffunction>

</cfcomponent>