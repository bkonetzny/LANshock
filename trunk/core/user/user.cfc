<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getUser" access="public" output="false" returntype="query">
		<cfargument name="id" type="numeric" required="false" default="0">
		<cfargument name="email" type="string" required="false" default="">
		<cfargument name="password" type="string" required="false" default="">

		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetUser">
			SELECT u.*, COUNT(cp.id) AS post_count
			FROM user u
			LEFT OUTER JOIN core_comments_posts cp ON u.id = cp.user_id
			WHERE 1 = 1
			<cfif len(arguments.email)>
				AND u.email = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.email#">
			</cfif>
			<cfif len(arguments.password)>
				AND u.pwd = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.password#">
			</cfif>
			<cfif arguments.id NEQ 0>
				AND u.id = <cfqueryparam  cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfif>
			GROUP BY u.id
		</cfquery>

		<cfreturn qGetUser>
		
	</cffunction>

	<cffunction name="getUserHistory" access="public" output="false" returntype="query">
		<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetUserHistory">
			SELECT *
			FROM user_history
			WHERE user_id = <cfqueryparam  cfsqltype="cf_sql_integer" value="#arguments.id#">
			ORDER BY datetime DESC
		</cfquery>

		<cfreturn qGetUserHistory>
		
	</cffunction>

	<cffunction name="setUser" access="public" output="false" returntype="numeric">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="firstname" type="string" required="true">
		<cfargument name="lastname" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<cfargument name="dt_birthdate" type="string" required="false" default="#now()#">
		<cfargument name="gender" type="numeric" required="false" default="1">
		<cfargument name="idcardnumber" type="string" required="false" default="">
		<cfargument name="profile_verified" type="numeric" required="false" default="0">
		<cfargument name="geo_lat" type="string" required="false" default="">
		<cfargument name="geo_long" type="string" required="false" default="">
		<cfargument name="language" type="string" required="false" default="">
		<cfargument name="signature" type="string" required="false" default="">
		<cfargument name="homepage" type="string" required="false" default="">
		<cfargument name="country" type="string" required="false" default="">
		<cfargument name="city" type="string" required="false" default="">
		<cfargument name="street" type="string" required="false" default="">
		<cfargument name="zip" type="string" required="false" default="">

		<cfset var iUserID = ''>

		<cfif arguments.id EQ 0>

			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO user (name,email,firstname,lastname,pwd,dt_birthdate,gender,idcardnumber,profile_verified,geo_lat,geo_long,language,signature,homepage,country,city,street,zip,dt_registered)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.name)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.email)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.firstname)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.lastname)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#LCase(hash(arguments.password))#">,
						<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.dt_birthdate#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gender#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.idcardnumber)#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.profile_verified#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.geo_lat#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.geo_long#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.language#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#HTMLEditFormat(arguments.signature)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.homepage)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.country#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.street#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.zip#">,
						#now()#)
			</cfquery>

			<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetUserID">
				SELECT id
				FROM user
				WHERE email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#" maxlength="255">
			</cfquery>
			
			<cfset iUserID = qGetUserID.id>
		
		<cfelse>

			<cfquery datasource="#request.lanshock.environment.datasource#">
				UPDATE user
				SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.name)#">,
					email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.email)#">,
					firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.firstname)#">,
					lastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.lastname)#">,
					<cfif len(arguments.password)>
						pwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LCase(hash(arguments.password))#">,
					</cfif>
					dt_birthdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.dt_birthdate#">,
					gender = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gender#">,
					idcardnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.idcardnumber)#">,
					profile_verified = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.profile_verified#">,
					geo_lat = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.geo_lat#">,
					geo_long = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.geo_long#">,
					language = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.language#">,
					signature = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#HTMLEditFormat(arguments.signature)#">,
					homepage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.homepage)#">,
					country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.country#">,
					city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city#">,
					street = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.street#">,
					zip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.zip#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
			
			<cfset iUserID = arguments.id>
		
		</cfif>
		
		<cfreturn iUserID>
		
	</cffunction>

	<cffunction name="updateStatus" access="public" output="false" returntype="boolean">
		<cfargument name="id" type="numeric" required="true">		
		<cfargument name="locked" type="string" required="false" default="">

		<cfquery datasource="#request.lanshock.environment.datasource#">
			UPDATE user
			SET id = id
				<cfif isNumeric(arguments.locked)>
					,locked = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.locked#">
				</cfif>
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="updateLastLogin" access="public" output="false" returntype="boolean">
		<cfargument name="id" type="string" required="true">

		<cfquery datasource="#request.lanshock.environment.datasource#">
			UPDATE user
			SET dt_lastlogin = #now()#,
				logincount = logincount + 1
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="createUser" output="false" returntype="numeric">
		<cfargument name="name" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="firstname" type="string" required="true">
		<cfargument name="lastname" type="string" required="true">
		<cfargument name="password" type="string" required="true">

		<cfquery datasource="#request.lanshock.environment.datasource#" name="qUserRegister">
			INSERT INTO user (name,email,firstname,lastname,pwd,dt_registered)
			VALUES (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.name#" maxlength="255">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#" maxlength="255">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.firstname#" maxlength="255">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lastname#" maxlength="255">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#LCase(hash(arguments.password))#" maxlength="255">,
					#now()#)
		</cfquery>

		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetUserID">
			SELECT id
			FROM user
			WHERE name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.name#" maxlength="255">
			AND email =	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#" maxlength="255">
			AND firstname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.firstname#" maxlength="255">
			AND lastname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lastname#" maxlength="255">
			AND pwd = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#LCase(hash(arguments.password))#" maxlength="255">
		</cfquery>
		
		<cfif qGetUserID.recordcount>
			<cfreturn qGetUserID.id>
		<cfelse>
			<cfreturn 0>
		</cfif>
		
	</cffunction>

	<cffunction name="checkEmail" output="false" returntype="boolean">
		<cfargument name="email" type="string" required="true">
		<cfargument name="id" type="numeric" required="false" default="0">

		<cfquery datasource="#request.lanshock.environment.datasource#" name="qCheckFreeEmail">
			SELECT id
			FROM user
			WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
			<cfif arguments.id NEQ 0>
				AND id != <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfif>
		</cfquery>
		
		<cfif qCheckFreeEmail.recordcount>
			<cfreturn false>
		<cfelse>
			<cfreturn true>
		</cfif>
		
	</cffunction>

	<cffunction name="checkUsername" output="false" returntype="boolean">
		<cfargument name="username" type="string" required="true">
		<cfargument name="id" type="numeric" required="false" default="0">

		<cfquery datasource="#request.lanshock.environment.datasource#" name="qCheckFreeUsername">
			SELECT id
			FROM user
			WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
			<cfif arguments.id NEQ 0>
				AND id != <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfif>
		</cfquery>
		
		<cfif qCheckFreeUsername.recordcount>
			<cfreturn false>
		<cfelse>
			<cfreturn true>
		</cfif>
		
	</cffunction>

	<cffunction name="getAdminIDs" output="false" returntype="string">

		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetAdminIDs">
			SELECT user
			FROM admin
		</cfquery>
		
		<cfreturn ValueList(qGetAdminIDs.user)>
		
	</cffunction>

	<cffunction name="updateHistory" access="public" output="false" returntype="boolean">
		<cfargument name="userid" type="numeric" required="true">
		<cfargument name="status" type="string" required="true">

		<cfquery datasource="#application.lanshock.environment.datasource#">
			INSERT INTO user_history (user_id,admin_id,status,datetime)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#request.session.userid#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#">,
					#now()#)
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

</cfcomponent>