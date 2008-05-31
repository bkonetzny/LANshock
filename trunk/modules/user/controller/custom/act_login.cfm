<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_login.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.loginmode" default="password">
<cfparam name="attributes.relocationusereferer" default="false">

<cfif session.oUser.isLoggedIn()>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#" addtoken="false">
</cfif>

<cfif StructKeyExists(attributes,"openid.mode")>
	<cfset attributes.loginmode = "openidauth">
	<cfset attributes.form_submitted = true>
</cfif>

<cfif NOT ListFind("password,openid,openidauth",attributes.loginmode)>
	<cfset attributes.loginmode = "password">
</cfif>

<cfif attributes.relocationusereferer>
	<cfparam name="attributes.relocationurl" default="#listLast(cgi.http_referer,"/")#">
<cfelse>
	<cfparam name="attributes.relocationurl" default="">
</cfif>

<!--- form vars --->
<cfparam name="attributes.email" default="">
<cfif StructKeyExists(cookie,'email') AND NOT len(attributes.email)>
	<cfset attributes.email = cookie.email>
	<!--- only check for userid when email is defined in cookie --->
	<cfif isDefined("cookie.userid")>
		<cfif isDefined("attributes.changeuser")>
			<cfcookie name="userid" expires="now">
		<cfelse>
			<cfparam name="attributes.userid" default="#cookie.userid#">
		</cfif>
	</cfif>
</cfif>

<cfif isDefined("cookie.email") AND attributes.email NEQ cookie.email>
	<cfcookie name="userid" expires="now">
	<cfcookie name="email" expires="now">
	<cfcookie name="password" expires="now">
	<cfset StructDelete(cookie,'userid')>
	<cfset StructDelete(cookie,'email')>
	<cfset StructDelete(cookie,'password')>
</cfif>

<cfparam name="attributes.userid" default="">
<cfparam name="attributes.password" default="">
<cfparam name="attributes.bSaveCookie" default="false">

<cfset bIsCookieLogin = false>

<cfif attributes.loginmode EQ "password">

	<!--- cookie detection --->
	<cfif isDefined("cookie.email") AND isDefined("cookie.password")>
		<cfset bIsCookieLogin = true>
		<cfset attributes.form_submitted = true>
		<cfset attributes.email = cookie.email>
		<cfset attributes.password = decrypt(cookie.password,application.applicationname)>
	<cfelseif len(attributes.password)>
		<cfset attributes.password = LCase(hash(attributes.password))>
	</cfif>

	<!--- validation --->
	<cfif attributes.form_submitted>
		<cfif NOT len(attributes.email)>
			<cfset ArrayAppend(aError, request.content.error_user_wrong_email)>
		</cfif>
		<cfif NOT len(attributes.password)>
			<cfset ArrayAppend(aError, request.content.error_user_wrong_password)>
		</cfif>
	</cfif>

<cfelseif attributes.loginmode EQ "openid">

	<!--- validation --->
	<cfif attributes.form_submitted>
		<cfif NOT len(attributes.openid_url)>
			<cfset ArrayAppend(aError, "$$$ Please enter an OpenID url")>
		</cfif>
	</cfif>

<cfelseif attributes.loginmode EQ "openidauth">

	<!--- validation --->
	<cfif session.oUser.existsCustomDataValue('openid')>

		<cfset oConsumer = application.lanshock.oFactory.load('lanshock.core._utils.openid.OpenIDConsumer')>

		<cfset OpenID = Duplicate(session.oUser.getCustomDataValue('openid'))>

		<cfif attributes['openid.mode'] eq "id_res">

			<cfif StructKeyExists(OpenID,"nonce") and StructKeyExists(attributes,"nonce") and OpenID['nonce'] eq URLDecode(attributes['nonce'])>

				<cfif OpenID['mode'] eq "dumb" or OpenID['assoc_handle'] eq "">
					<cfset OpenID['assoc_handle'] = attributes['openid.assoc_handle']>
				</cfif>

				<cfif (OpenID['mode'] eq "smart" and oConsumer.isValidSignature(OpenID,attributes)) or oConsumer.isValidHandle(OpenID,attributes)>
					<!--- <cfset ArrayAppend(aError,"$$$ OpenID identity has been successfully authorized")> --->
				<cfelse>
					<cfset ArrayAppend(aError,"$$$ OpenID invalid authorization")>
				</cfif>

			<cfelse>
				<cfset ArrayAppend(aError,"$$$ OpenID reply attack has been detected")>
			</cfif>

		<cfelseif attributes['openid.mode'] eq "cancel">
			<cfset ArrayAppend(aError,"$$$ OpenID denied by user")>
		</cfif>

	<cfelse>
		<cfset ArrayAppend(aError,"$$$ OpenID session has expired")>
	</cfif>

</cfif>

<cfif attributes.form_submitted AND NOT ArrayLen(aError)>

	<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getByFields" returnvariable="qUser">
		<cfif attributes.loginmode EQ "password">
			<cfinvokeargument name="email" value="#attributes.email#">
			<cfinvokeargument name="pwd" value="#attributes.password#">
		<cfelseif attributes.loginmode EQ "openid">
			<cfinvokeargument name="openid_url" value="#attributes.openid_url#">
		<cfelseif attributes.loginmode EQ "openidauth">
			<cfinvokeargument name="openid_url" value="#OpenID['openid.user_identity']#">
		</cfif>
	</cfinvoke>
	
	<cfif NOT qUser.recordcount>

		<cfcookie name="password" expires="now">
		
		<cfif attributes.loginmode EQ "password">
			<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getByFields" returnvariable="qEmailCheck">
				<cfinvokeargument name="email" value="#attributes.email#">
			</cfinvoke>
	
			<cfif qEmailCheck.recordcount>
				<cfset ArrayAppend(aError, request.content.error_user_password)>
				<cfset application.lanshock.oLogger.writeLog('modules.user.login','Login failed for "#attributes.email#": Wrong password','warn')>
			<cfelse>
				<cfset ArrayAppend(aError, request.content.error_user_notfound)>
				<cfset application.lanshock.oLogger.writeLog('modules.user.login','Login failed for "#attributes.email#": User not found','warn')>
			</cfif>
		<cfelseif attributes.loginmode EQ "openid">
			<cfset ArrayAppend(aError, "$$$ OpenID not found")>
			<cfset application.lanshock.oLogger.writeLog('modules.user.login','Login failed for OpenID "#attributes.openid_url#": No user with specified OpenID','warn')>
		</cfif>

	<cfelse>
	
		<cfif attributes.loginmode EQ "openid">
			
			<!--- Create CFC instance --->
			<cfset oConsumer = application.lanshock.oFactory.load('lanshock.core._utils.openid.OpenIDConsumer')>
		
			<!--- OpenID variables --->
			<cfset OpenID = StructNew()>
		
			<!--- Nonce for reply attack detection --->
			<cfset OpenID['nonce'] = CreateUUID()>
		
			<!--- Mandatory OpenID request parameters --->
			<cfset OpenID['openid.user_identity'] = attributes.openid_url>
			<cfset OpenID['openid.identity'] = oConsumer.normalizeURL(attributes.openid_url)>
			<cfset OpenID['openid.return_to'] = application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&nonce=#OpenID['nonce']#',true,'classic')>
		
			<!--- Optional OpenID request parameters --->
			<cfset OpenID['openid.trust_root'] = application.lanshock.oRuntime.getEnvironment().sServerPath>
			<cfset OpenID['openid.sreg.required'] = "email,fullname">
			<cfset OpenID['openid.sreg.optional'] = "dob,gender,postcode,country,language,timezone">
			<cfset OpenID['openid.sreg.policy_url'] = application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.openid_policy',true)>
		
			<!--- Discover OpenID server --->
			<cfset Results = oConsumer.discoverOpenIDServer(OpenID)>
	
			<cfif Results['status']>
		
				<!--- Identity Provider (IdP) server --->
				<cfset OpenID['openid_server'] = Results['server']>
		
				<!--- In case delegation is set --->
				<cfif StructKeyExists(Results,"identity")>
					<cfset OpenID['openid.identity'] = Results['identity']>
				</cfif>
		
				<!--- Establish a shared secret between Consumer and Identity Provider --->
				<cfset Results = oConsumer.getAssociate(OpenID)>
		
				<cfif Results['status']>
		
					<cfset OpenID['mode'] = "smart">
		
					<!--- Save all returned keys for further use --->
					<cfloop item="sKey" collection="#Results#">
						<cfif sKey neq "status">
							<cfset OpenID[sKey] = Results[sKey]>
						</cfif>
					</cfloop>
		
				<cfelse>
		
					<cfset OpenID['mode'] = "dumb">
					<cfset OpenID['assoc_handle'] = "">
		
				</cfif>
		
				<!--- Uncomment next two lines if you want to test 'dumb' mode only --->
				<!--- Railo: smart-mode doesn't seem to work --->
				<cfset OpenID['mode'] = "dumb">
				<cfset OpenID['assoc_handle'] = "">
				
				<!--- Save working variables to session scope, could be only 'assoc_handle' and 'mac_key' --->
				<cfset session.oUser.setCustomDataValue('openid',duplicate(OpenID))>
		
				<!--- Redirect user-agent to IdP server for request processing --->
				<cfset oConsumer.doRedirect(OpenID) />
		
			<cfelse>
				<cfset ArrayAppend(aError, "$$$ Can't connect to OpenID server.")>
			</cfif>
		</cfif>

		<cfif qUser.status NEQ 'confirmed'>
			<cfswitch expression="#qUser.status#">
				<!--- <cfcase value="new">
					<cfset ArrayAppend(aError,  "$$$ Your user is not yet confirmed.")>
					<cfset application.lanshock.oLogger.writeLog('modules.user.login','Login failed for "#qUser.name#": User is not yet confirmed','warn')>
				</cfcase> --->
				<cfcase value="locked">
					<cfset ArrayAppend(aError, request.content.error_user_locked)>
					<cfset application.lanshock.oLogger.writeLog('modules.user.login','Login failed for "#qUser.name#": User is locked','warn')>
				</cfcase>
			</cfswitch>
		</cfif>
	
		<cfif NOT ArrayLen(aError)>
			<cfset application.lanshock.oLogger.writeLog('modules.user.login','Login successful for "#qUser.name#"')>
		
			<cfset oUser = application.lanshock.oFactory.load('user','reactorRecord')>
			<cfset oUser.setId(qUser.id)>
			<cfset oUser.load()>
			<cfset oUser.setLogincount(oUser.getLogincount()+1)>
			<cfset oUser.setDt_lastlogin(now())>
			<cfset oUser.save()>

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
			<cfif attributes.bSaveCookie>
				<cfcookie name="userid" value="#oUser.getId()#" expires="never">
				<cfcookie name="password" value="#encrypt(attributes.password,application.applicationname)#" expires="never">
			</cfif>
			
			<cfset session.oUser.setDataValue('UserLoggedIn',true)>
			<cfset session.oUser.setDataValue('UserID',oUser.getId())>
			<cfset session.oUser.setDataValue('name',oUser.getName())>
			<cfset session.oUser.setDataValue('firstname',oUser.getFirstname())>
			<cfset session.oUser.setDataValue('lastname',oUser.getLastname())>
			<cfset session.oUser.setDataValue('email',oUser.getEmail())>
			<cfset session.oUser.setDataValue('lang',oUser.getLanguage())>
			<cfset session.oUser.setDataValue('qPermissions',qUserPermissions)>
			
			<cfset sRelocateUrl = application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')>
			<cfif bIsCookieLogin AND len(application.lanshock.settings.startpage)>
				<cfset sRelocateUrl = application.lanshock.oHelper.buildUrl('#application.lanshock.settings.startpage#')>
			<cfelseif len(attributes.relocationurl)>
				<cfset sRelocateUrl = application.lanshock.oHelper.buildUrl('#attributes.relocationurl#')>
			</cfif>
			
			<cflocation url="#sRelocateUrl#" addtoken="false">
		</cfif>

	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">