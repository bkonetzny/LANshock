<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/user.cfc $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfcomponent>

	<cffunction name="login" output="false" returntype="boolean">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="bSaveCookie" type="boolean" required="false" default="false">
		
		<cfset var oUser = 0>
		<cfset var qUserPermissions = 0>
		<cfset var qRoles = 0>
		<cfset var qRolePermissions = 0>
		
		<cfset oUser = application.lanshock.oFactory.load('user','reactorRecord')>
		<cfset oUser.setId(arguments.id)>
		<cfset oUser.load()>
		<cfset oUser.setLogincount(oUser.getLogincount()+1)>
		<cfset oUser.setDt_lastlogin(now())>
		<cfset oUser.save()>

		<cfset application.lanshock.oLogger.writeLog('modules.user.login','Login successful for "#oUser.getName()#"')>

		<cfset qUserPermissions = QueryNew("module,name")>

		<cfset qRoles = oUser.getcore_security_rolesiterator().getQuery()>

		<cfloop query="qRoles">
	
			<cfset oRole = application.lanshock.oFactory.load('core_security_roles','reactorRecord')>
			<cfset oRole.setId(qRoles.id)>
			<cfset oRole.setModule(qRoles.module)>
			<cfset oRole.load()>
			<cfset qRolePermissions = oRole.getcore_security_permissionsiterator().getQuery()>

			<cfloop query="qRolePermissions">
		
				<cfset QueryAddRow(qUserPermissions)>
				<cfset QuerySetCell(qUserPermissions,'module',qRolePermissions.module)>
				<cfset QuerySetCell(qUserPermissions,'name',qRolePermissions.name)>
				
			</cfloop>
			
		</cfloop>

		<cfcookie name="email" value="#oUser.getEmail()#" expires="never">
		<cfif arguments.bSaveCookie>
			<cfcookie name="userid" value="#oUser.getId()#" expires="never">
			<cfcookie name="password" value="#encrypt(oUser.getPwd(),application.applicationname)#" expires="never">
		</cfif>
		
		<cfset session.oUser.setDataValue('UserLoggedIn',true)>
		<cfset session.oUser.setDataValue('UserID',oUser.getId())>
		<cfset session.oUser.setDataValue('name',oUser.getName())>
		<cfset session.oUser.setDataValue('firstname',oUser.getFirstname())>
		<cfset session.oUser.setDataValue('lastname',oUser.getLastname())>
		<cfset session.oUser.setDataValue('email',oUser.getEmail())>
		<cfset session.oUser.setDataValue('lang',oUser.getLanguage())>
		<cfset session.oUser.setDataValue('qPermissions',qUserPermissions)>

		<cfreturn true>
		
	</cffunction>

	<cffunction name="getUser" access="public" output="false" returntype="query">
		<cfargument name="id" type="numeric" required="false" default="0">
		<cfargument name="email" type="string" required="false" default="">
		<cfargument name="password" type="string" required="false" default="">

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetUser">
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

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
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

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qGetUserID">
				SELECT id
				FROM user
				WHERE email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#" maxlength="255">
			</cfquery>
			
			<cfset iUserID = qGetUserID.id>
		
		<cfelse>

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
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

	<cffunction name="checkEmail" output="false" returntype="boolean">
		<cfargument name="email" type="string" required="true">
		<cfargument name="id" type="numeric" required="false" default="0">

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qCheckFreeEmail">
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

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qCheckFreeUsername">
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

</cfcomponent>