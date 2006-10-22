<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cfinclude template="../lanshock.udf.lib.cfm">

	<cffunction name="getCommentsPanel" access="public" returntype="struct" output="false">
		<cfargument name="module" required="true" type="string">
		<cfargument name="identifier" required="true" type="string">
		<cfargument name="linktosource" required="false" type="string" default="">
		<cfargument name="type" required="false" type="string" default="***unknown_type***">
		<cfargument name="topic_title" required="false" type="string" default="">
		
		<cfset uuidFormName = 'form#replacenocase(CreateUUID(),'-','','ALL')#'>
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetTopicID">
			SELECT id, isclosed
			FROM core_comments_topics
			WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
			AND identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">
		</cfquery>
		
		<cfif request.session.isAdmin>
			<cfsavecontent variable="enableDisableComments">
				<cfif qGetTopicID.recordcount>
					<cfoutput>
						<div align="center">
							<form action="#request.varScope.myself##request.lanshock.settings.modulePrefix.core#comments.comments_enable_disable&#request.session.UrlToken#" method="post">
							<input type="hidden" name="topic_id" value="#qGetTopicID.id#">
							<input type="hidden" name="mode" value="#abs(qGetTopicID.isclosed-1)#">
							<cfif qGetTopicID.isclosed>
								<input type="submit" value="#request.content._core__comments__enablecomments#">
							<cfelse>
								<input type="submit" value="#request.content._core__comments__disablecomments#">
							</cfif>
							</form>
						</div>
					</cfoutput>
				</cfif>
			</cfsavecontent>
		</cfif>
		
		<cfif NOT (qGetTopicID.recordcount AND qGetTopicID.isclosed)>
			<cfsavecontent variable="addComment">
				<cfif request.session.UserLoggedIn>
					<cfoutput>
						<div class="headline2">#request.content._core__comments__addcomment#</div>
	
						<script language="javascript" type="text/javascript">
							<!--
								function validateCommentsForm(){
									if(document.#uuidFormName#.title.value == '' || document.#uuidFormName#.text.value == '' ){
										document.getElementById('hint#uuidFormName#').innerHTML='<span class="text_important">#request.content._core__comments__required_hint#</span>';
										return false;
									}
									else return true;
								}
							//-->
						</script>
						
						<table width="100%" cellpadding="3">
							<form action="#request.varScope.myself##request.lanshock.settings.modulePrefix.core#comments.comment_edit&#request.session.UrlToken#" id="#uuidFormName#" name="#uuidFormName#" method="post" onSubmit="return validateCommentsForm();">
							<input type="hidden" name="form_submitted" value="true">
							<input type="hidden" name="id" value="0">
							<cfif qGetTopicID.recordcount>
								<input type="hidden" name="topic_id" value="#qGetTopicID.id#">
							<cfelse>
								<input type="hidden" name="topic_id" value="0">
								<input type="hidden" name="parent_id" value="0">
								<input type="hidden" name="module" value="#arguments.module#">
								<input type="hidden" name="identifier" value="#arguments.identifier#">
								<input type="hidden" name="linktosource" value="#arguments.linktosource#">
								<input type="hidden" name="type" value="#arguments.type#">
							</cfif>
							<tr>
								<td>&nbsp;</td>
								<td><div id="hint#uuidFormName#"><span class="text_small text_light">#request.content._core__comments__required_hint#</span></div></td>
							</tr>
							<tr>
								<td>#request.content._core__comments__title#</td>
								<td><input type="text" name="title" style="width: 90%" value="#arguments.topic_title#"></input></td>
							</tr>
							<tr>
								<td valign="top">#request.content._core__comments__text#</td>
								<td valign="top">[<strong>b</strong>] [<em>i</em>] [<u>u</u>] [<a href="javascript:showLANshockCode()">url</a>] <a href="javascript:showLANshockCode();">#request.content._core__comments__lanshockcode#</a><br>
									<textarea name="text" style="width: 90%; height: 150px;"></textarea></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td><input type="checkbox" name="appendsignature" id="appendsignature" value="true" checked> <label for="appendsignature">#request.content._core__comments__appendsignature#</label></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td><input type="Submit" value="#request.content._core__comments__addcomment#"></td>
							</tr>
							</form>
						</table>
					</cfoutput>
				<cfelse>
					<cfoutput>
						<div class="headline2">#request.content._core__comments__addcomment#</div>
						<a href="#request.varScope.myself##request.lanshock.settings.modulePrefix.core#user.login&relocationusereferer=true&#request.session.UrlToken#">#request.content._core__comments__login_hint#</a>
					</cfoutput>
				</cfif>
			</cfsavecontent>
		</cfif>
		
		<cfif qGetTopicID.recordcount>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qComments">
				SELECT *
				FROM core_comments_posts
				WHERE topic_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qGetTopicID.id#">
				ORDER BY dt_created
			</cfquery>
		
			<cfsavecontent variable="htmlComments">
				<cfoutput>				
				<div class="headline2">#request.content._core__comments__comments#</div>
				
				<cfif request.session.isAdmin>
					#enableDisableComments#
				</cfif>
				
				<cfif qComments.recordcount>
					<table width="100%" cellpadding="3">
						<cfloop query="qComments">
							<tr>
								<td colspan="2" align="right"><span class="text_small text_light">#currentrow#</span></td>
							</tr>
							<tr>
								<td class="alternate" nowrap>#UDF_DateTimeFormat(dt_created)#</td>
								<td class="alternate" width="100%">
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td valign="top">#title#</td>
											<td valign="top" align="right">
												<cfif request.session.userid EQ user_id>
													<a href="#request.varScope.myself##request.lanshock.settings.modulePrefix.core#comments.comment_delete&id=#id#&#request.session.UrlToken#">
														<img src="#request.varScope.stImageDir.general#/btn_delete.gif">
													</a>
												</cfif>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td valign="top" class="alternate" align="center"><a href="#request.varScope.myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#getUsernameById(user_id)#<br>#UserShowAvatar(user_id)#</a></td>
								<td valign="top">#ConvertText(text)#</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
						</cfloop>
					</table>
				<cfelse>
					#request.content._core__comments__nocommentsavaible#
				</cfif>
				
				<cfif request.session.isAdmin>
					#enableDisableComments#
				</cfif>
				
				<cfif NOT qGetTopicID.isclosed>
					#addComment#
				</cfif>
				</cfoutput>
			</cfsavecontent>

		<cfelse>

			<cfset qComments = QueryNew('id')>
			<cfset htmlComments = addComment>

		</cfif>
		
		<cfscript>
			stComments = StructNew();
			stComments.recordcount = qComments.recordcount;
			stComments.query = qComments;
			stComments.html = htmlComments;
		</cfscript>
		
		<cfreturn stComments>
		
	</cffunction>




	<cffunction name="getCommentsCount" access="public" returntype="numeric" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="module" required="false" type="string" default="">
		<cfargument name="identifier" required="false" type="string" default="">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qPostCount">
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
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qCommentsCount">
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
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qLatestComments">
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
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTopic">
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




	<cffunction name="getTopics" access="public" returntype="query" output="true">
		<cfargument name="type" required="false" type="string" default="">
		<cfargument name="search" required="false" type="string" default="">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetTopics">
			SELECT t.*, p.title, p.text, p.user_id, COUNT(p.id) AS postcount, MAX(p.dt_created) AS dt_lastpost
			FROM core_comments_topics t
			LEFT OUTER JOIN core_comments_posts p ON t.id = p.topic_id
			WHERE 1=1
			<cfif len(arguments.type)>
				AND t.type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.type#">
			</cfif>
			<cfif len(arguments.search)>
				AND (
				<cfloop list="#arguments.search#" delimiters=" " index="idx">
					p.title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(idx)#%">
					OR p.text LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(idx)#%">
				</cfloop>
				)
			</cfif>
			GROUP BY t.id
			ORDER BY dt_lastpost DESC, t.dt_created DESC
		</cfquery>
		
		<cfreturn qGetTopics>
		
	</cffunction>




	<cffunction name="setTopic" access="public" returntype="numeric" output="false">
		<cfargument name="module" required="true" type="string">
		<cfargument name="identifier" required="true" type="string">
		<cfargument name="linktosource" required="false" type="string">
		<cfargument name="type" required="true" type="string">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetTopicID">
			SELECT id
			FROM core_comments_topics
			WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
			AND identifier = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">
		</cfquery>
		
		<cfif NOT qGetTopicID.recordcount>
	
			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO core_comments_topics (module, identifier, linktosource, type, dt_created)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identifier#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.linktosource#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.type#">,
						#now()#)
			</cfquery>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetTopicID">
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
	
		<cfquery datasource="#request.lanshock.environment.datasource#">
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
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
				DELETE
				FROM core_comments_posts
				WHERE topic_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#iTopicID#">
			</cfquery>
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
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
		
		<cfset var newtext = trim(arguments.text)>
	
		<cfif arguments.id NEQ 0>
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetPostData">
				SELECT id, user_id
				FROM core_comments_posts
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
				AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
			</cfquery>
		</cfif>
		
		<cfif arguments.id NEQ 0 AND qGetPostData.recordcount>
	
			<cfquery datasource="#request.lanshock.environment.datasource#">
				UPDATE core_comments_posts
				SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.title)#">,
					text = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#newtext#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>

		<cfelse>
		
			<cfif arguments.appendsignature>
			
				<cfset qUserdata = GetUserDataByID(arguments.user_id)>
				<cfset newtext = newtext & chr(13) & chr(10) & chr(13) & chr(10) & trim(qUserdata.signature)>
			
			</cfif>
	
			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO core_comments_posts (topic_id, parent_id, title, text, user_id, dt_created)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topic_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.parent_id#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.title)#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#newtext#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">,
						#now()#)
			</cfquery>

		</cfif>
		
		<cfreturn true>
		
	</cffunction>




	<cffunction name="deletePost" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="user_id" required="true" type="numeric">
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="getPostData">
			SELECT topic_id
			FROM core_comments_posts
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
		</cfquery>
		
		<cfif getPostData.recordcount>
			<cfquery datasource="#request.lanshock.environment.datasource#">
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
		</cfif>
		
		<cfreturn true>
		
	</cffunction>




	<cffunction name="getModuleTypes" access="public" returntype="struct" output="false">
	
		<cfset var stModules = StructNew()>
		<cfset var sModule = ''>
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetModule">
			SELECT module
			FROM core_comments_topics
			GROUP BY module
		</cfquery>
		
		<cfloop query="qGetModule">
		
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetTypes">
				SELECT type, COUNT(id) AS posts
				FROM core_comments_topics
				WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#module#">
				GROUP BY type
			</cfquery>
			
			<cfset sModule = module>
			<cfset stModules[sModule] = StructNew()>
			
			<cfloop query="qGetTypes">
			
				<cfset stModules[sModule][type] = posts>
			
			</cfloop>
			
		</cfloop>
		
		<cfreturn stModules>
		
	</cffunction>




</cfcomponent>