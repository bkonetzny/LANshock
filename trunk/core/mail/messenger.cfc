<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getMessage" access="public" returntype="query" output="false">
		<cfargument name="user_id" required="true" type="numeric">
		<cfargument name="id" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qMessage">
			SELECT m.*, u.name AS buddyname, u.id AS buddyid
			FROM core_mail_message m, user u
			WHERE m.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" maxlength="11">
			AND(
				m.user_id_to = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
				OR m.user_id_from = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
			)
			AND m.user_id_from = u.id
		</cfquery>
		
		<cfif qMessage.recordcount AND qMessage.isnew AND qMessage.user_id_to EQ arguments.user_id>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE core_mail_message
				SET isnew = 0
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" maxlength="11">
			</cfquery>

		</cfif>
		
		<cfreturn qMessage>
		
	</cffunction>

	<cffunction name="getMessages" access="public" returntype="query" output="false">
		<cfargument name="user_id" required="true" type="numeric">
		<cfargument name="mailtype" required="false" type="boolean" default="0">
		<cfargument name="newonly" required="false" type="boolean" default="0">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qMessages">
			SELECT m.*, u.name AS buddyname
			FROM core_mail_message m, user u
			<cfif NOT arguments.mailtype>
				WHERE m.user_id_to = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
				AND m.user_id_from = u.id
			<cfelse>
				WHERE m.user_id_from = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
				AND m.user_id_to = u.id
			</cfif>
			<cfif arguments.newonly>
				AND isnew = 1
			</cfif>
			ORDER BY m.datetime DESC
		</cfquery>
		
		<cfreturn qMessages>
		
	</cffunction>

	<cffunction name="getNewMessagesByBuddyID" access="public" returntype="query" output="false">
		<cfargument name="user_id_to" required="true" type="numeric">
		<cfargument name="user_id_from" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qNewMessagesByBuddyID">
			SELECT *
			FROM core_mail_message
			WHERE user_id_to = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id_to#" maxlength="11">
			AND user_id_from = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id_from#" maxlength="11">
			AND isnew = 1
		</cfquery>

		<cfif qNewMessagesByBuddyID.recordcount>
			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE core_mail_message
				SET isnew = 0
				WHERE id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qNewMessagesByBuddyID.id)#" maxlength="11" list="true">)
			</cfquery>
		</cfif>
		
		<cfreturn qNewMessagesByBuddyID>
		
	</cffunction>

	<cffunction name="sendMessage" access="public" returntype="boolean" output="false">
		<cfargument name="user_id_from" required="true" type="numeric">
		<cfargument name="user_id_to" required="true" type="numeric">
		<cfargument name="title" required="true" type="string">
		<cfargument name="text" required="true" type="string">

		<cfquery datasource="#application.lanshock.environment.datasource#">
			INSERT INTO core_mail_message (user_id_from, user_id_to, title, text, datetime, isnew)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id_from#" maxlength="11">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id_to#" maxlength="11">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#" maxlength="255">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.text#">,
					#now()#,
					1)
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="deleteMessages" access="public" returntype="boolean" output="false">
		<cfargument name="user_id" required="true" type="numeric">
		<cfargument name="messageids" required="true" type="string">

		<cfloop list="#arguments.messageids#" index="idx">

			<cfif isNumeric(idx) AND idx GT 0>

				<cfquery datasource="#application.lanshock.environment.datasource#" name="qMessages">
					DELETE FROM core_mail_message
					WHERE user_id_to = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
					AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#idx#" maxlength="11">
				</cfquery>
			
			</cfif>
		
		</cfloop>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="getBuddylist" access="public" returntype="query" output="false">
		<cfargument name="user_id" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qBuddyIDs">
			SELECT buddy_user_ids, order_by
			FROM core_mail_buddylist
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
		</cfquery>

		<cfif qBuddyIDs.recordcount AND ListLen(qBuddyIDs.buddy_user_ids)>
			<cfquery datasource="#application.lanshock.environment.datasource#" name="qGetUsers">
				SELECT id, #qBuddyIDs.order_by# AS buddyname
				FROM user
				WHERE id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qBuddyIDs.buddy_user_ids)#" maxlength="11" list="true">)
				ORDER BY #qBuddyIDs.order_by#
			</cfquery>
		
			<cfreturn qGetUsers>
		<cfelse>
			<cfreturn QueryNew('id')>
		</cfif>
		
	</cffunction>

	<cffunction name="getNewMessagesBuddyIDs" access="public" returntype="query" output="false">
		<cfargument name="user_id" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qNewMessagesBuddyIDs">
			SELECT user_id_from, COUNT(id) AS messages
			FROM core_mail_message
			WHERE user_id_to = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
			AND isnew = 1
			GROUP BY user_id_from
		</cfquery>
		
		<cfreturn qNewMessagesBuddyIDs>
		
	</cffunction>

	<cffunction name="addBuddy" access="public" returntype="boolean" output="false">
		<cfargument name="user_id" required="true" type="numeric">
		<cfargument name="buddy_id" required="true" type="numeric">
		
		<cfset var lNewBuddyList = ''>

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qBuddyIDs">
			SELECT buddy_user_ids
			FROM core_mail_buddylist
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
		</cfquery>
		
		<cfif qBuddyIDs.recordcount>
			<cfif NOT ListFind(qBuddyIDs.buddy_user_ids,arguments.buddy_id)>
				<cfset lNewBuddyList = ListAppend(qBuddyIDs.buddy_user_ids,arguments.buddy_id)>
		
				<cfquery datasource="#application.lanshock.environment.datasource#" name="qBuddyIDs">
					UPDATE core_mail_buddylist
					SET buddy_user_ids = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#lNewBuddyList#">
					WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
				</cfquery>
			</cfif>
		<cfelse>
			<cfset lNewBuddyList = arguments.buddy_id>
	
			<cfquery datasource="#application.lanshock.environment.datasource#" name="qBuddyIDs">
				INSERT INTO core_mail_buddylist (user_id, buddy_user_ids)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#lNewBuddyList#">)
			</cfquery>
		</cfif>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="removeBuddy" access="public" returntype="boolean" output="false">
		<cfargument name="user_id" required="true" type="numeric">
		<cfargument name="buddy_id" required="true" type="numeric">
		
		<cfset var lNewBuddyList = ''>

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qBuddyIDs">
			SELECT buddy_user_ids
			FROM core_mail_buddylist
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
		</cfquery>
		
		<cfif qBuddyIDs.recordcount>
			<cfif ListFind(qBuddyIDs.buddy_user_ids,arguments.buddy_id)>
				<cfset lNewBuddyList = ListDeleteAt(qBuddyIDs.buddy_user_ids,ListFind(qBuddyIDs.buddy_user_ids,arguments.buddy_id))>
		
				<cfquery datasource="#application.lanshock.environment.datasource#" name="qBuddyIDs">
					UPDATE core_mail_buddylist
					SET buddy_user_ids = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#lNewBuddyList#">
					WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
				</cfquery>
			</cfif>
		</cfif>
		
		<cfreturn true>
		
	</cffunction>
	
	<cffunction name="getWebmailAccounts" access="public" returntype="query" output="false">
		<cfargument name="user_id" required="true" type="numeric">
		<cfargument name="id" required="false" type="numeric" default="0">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qWebmailAccounts">
			SELECT *
			FROM core_mail_webmail
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
			<cfif arguments.id NEQ 0>
				AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" maxlength="11">
			</cfif>
		</cfquery>
		
		<cfreturn qWebmailAccounts>
		
	</cffunction>

</cfcomponent>