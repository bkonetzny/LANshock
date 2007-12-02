<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_login.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<!--- std vars --->
<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.as_login" default="false">
<cfparam name="attributes.relocationusereferer" default="false">

<cfif request.session.userloggedin>
	<cflocation url="#myself##myfusebox.thiscircuit#.login_validation&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif attributes.relocationusereferer>
	<cfparam name="attributes.relocationurl" default="#listLast(cgi.http_referer,"/")#">
<cfelse>
	<cfparam name="attributes.relocationurl" default="">
</cfif>

<!--- form vars --->
<cfif isDefined("cookie.email")>
	<cfparam name="attributes.email" default="#cookie.email#">
	<!--- only check for userid when email is defined in cookie --->
	<cfif isDefined("cookie.userid")>
		<cfif isDefined("attributes.changeuser")>
			<cfcookie name="userid" expires="NOW">
		<cfelse>
			<cfparam name="attributes.userid" default="#cookie.userid#">
		</cfif>
	</cfif>
</cfif>
<cfparam name="attributes.email" default="">
<cfparam name="attributes.userid" default="">
<cfparam name="attributes.password" default="">

<cfscript>
	// cookie detection
	attributes.bIsCookieLogin = false;
	
	if(isDefined("cookie.email") and isDefined("cookie.password")){
		attributes.email = cookie.email;
		if(NOT len(attributes.password)){
			attributes.password = decrypt(cookie.password,request.lanshock.settings.crypkey);
			attributes.form_submitted = true;
			attributes.bIsCookieLogin = true;
		}
	}
	else if(NOT attributes.as_login AND len(attributes.password)) attributes.password = LCase(hash(attributes.password));
	
	// as login detection
	bUserAsLoginActivated = false;
	if(attributes.as_login AND isDefined("attributes.user_id") AND StructKeyExists(application.aslogin,attributes.user_id)){
		bUserAsLoginActivated = StructDelete(application.aslogin,attributes.user_id,"true");
		attributes.form_submitted = true;
	}

	// validation
	if(attributes.form_submitted AND NOT bUserAsLoginActivated){
		if(NOT len(attributes.email)) ArrayAppend(aError, request.content.error_user_wrong_email);
		if(NOT len(attributes.password)) ArrayAppend(aError, request.content.error_user_wrong_password);
	}
</cfscript>

<cfif attributes.form_submitted AND NOT ArrayLen(aError)>

	<cfinvoke component="user" method="getUser" returnvariable="qLogin">	
		<cfif bUserAsLoginActivated>
			<cfinvokeargument name="id" value="#attributes.user_id#">
		<cfelse>
			<cfinvokeargument name="email" value="#attributes.email#">
			<cfinvokeargument name="password" value="#attributes.password#">
		</cfif>
	</cfinvoke>

	<cfif NOT qLogin.recordcount>

		<cfcookie name="password" expires="NOW">
	
		<cfinvoke component="user" method="checkEmail" returnvariable="bEmailIsFree">
			<cfinvokeargument name="email" value="#attributes.email#">
		</cfinvoke>

		<cfscript>
			if(NOT bEmailIsFree) ArrayAppend(aError, request.content.error_user_password);
			else ArrayAppend(aError, request.content.error_user_notfound);
		</cfscript>

	<cfelse>
	
		<cfinvoke component="#application.lanshock.environment.componentpath#modules.admin.admin" method="getAdmins" returnvariable="qAdmins">	

		<cfif qLogin.locked>
			<cfset ArrayAppend(aError, request.content.error_user_locked)>
		</cfif>

		<cfif NOT ArrayLen(aError)>
			<cfparam name="attributes.cookie" default="false">
			
			<cfinvoke component="user" method="updateLastLogin">
				<cfinvokeargument name="id" value="#qLogin.id#">
			</cfinvoke>
			
			<!--- set cookies if this is no "as login" --->
			<cfif NOT attributes.as_login>
				<cfcookie name="userid" value="#qLogin.id#" expires="NEVER">
				<cfcookie name="email" value="#attributes.email#" expires="NEVER">
				<cfif attributes.cookie>
					<cfcookie name="password" value="#encrypt(attributes.password,request.lanshock.settings.crypkey)#" expires="NEVER">
				</cfif>
			</cfif>
		
			<cfif ListFind(ValueList(qAdmins.id),qLogin.id)>
			
				<cfinvoke component="#request.lanshock.environment.componentpath#modules.admin.admin" method="updateRights">
								
			</CFIF>
			
			<cfscript>
				// session vars
				request.session.UserLoggedIn = true;
				request.session.UserID = qLogin.id;
				if(ListFind(ValueList(qAdmins.id),qLogin.id)){
					oAdmin = CreateObject('component','#request.lanshock.environment.componentpath#modules.admin.admin');
					oAdmin.setAdminSessionRights(request.session.userid);
					request.session.isAdmin = true;
				}
				else request.session.isAdmin = false;
				
				if(listLen(qLogin.language,'_') EQ 2) request.session.lang = qLogin.language;
			</cfscript>
			
			<cffile action="append" file="#application.lanshock.environment.abspath#storage/secure/logs/core_user_login.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] user_#request.session.UserID#, #qLogin.name#">
			
			<cfif attributes.bIsCookieLogin AND len(application.lanshock.settings.startpage)>
				<cflocation url="#myself##application.lanshock.settings.startpage#&cookielogin=true&#request.session.urltoken#" addtoken="false">
			<cfelseif len(attributes.relocationurl)>
				<cfset relocationurl = "&relocationurl=" & UrlEncodedFormat(attributes.relocationurl)>
			<cfelse>
				<cfset relocationurl = "">
			</cfif>

			<cflocation url="#myself##myfusebox.thiscircuit#.login_validation#relocationurl#&#request.session.urltoken#" addtoken="false">
		</cfif>

	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">