<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_mailing.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.mailserver_usedefault" default="true">
<cfparam name="attributes.mailserver_server" default="#cgi.server_name#">
<cfparam name="attributes.mailserver_port" default="25">
<cfparam name="attributes.mailserver_username" default="username">
<cfparam name="attributes.mailserver_password" default="password">
<cfparam name="attributes.email_from" default="webmaster@#cgi.server_name#">
<cfparam name="attributes.subject" default="">
<cfparam name="attributes.body_plain" default="">
<cfparam name="attributes.body_html" default="">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT isEmail(attributes.email_from)) ArrayAppend(aError, request.content.mailing_email_from);
		if(NOT len(trim(attributes.subject))) ArrayAppend(aError, request.content.mailing_subject);
		if(NOT len(trim(attributes.body_plain)) AND NOT len(trim(attributes.body_html))) ArrayAppend(aError, request.content.mailing_body_plain);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="qUsers">
			SELECT name, firstname, lastname, email
			FROM user
		</cfquery>
		
		<cfloop query="qUsers">
			
			<cfif isEmail(email)>
				
				<cfscript>
					current_body_plain = attributes.body_plain;
					current_body_plain = replacenocase(current_body_plain,'##username##',name,'ALL');
					current_body_plain = replacenocase(current_body_plain,'##firstname##',firstname,'ALL');
					current_body_plain = replacenocase(current_body_plain,'##lastname##',lastname,'ALL');
					current_body_plain = replacenocase(current_body_plain,'##email##',email,'ALL');
					current_body_html = attributes.body_html;
					current_body_html = replacenocase(current_body_html,'##username##',name,'ALL');
					current_body_html = replacenocase(current_body_html,'##firstname##',firstname,'ALL');
					current_body_html = replacenocase(current_body_html,'##lastname##',lastname,'ALL');
					current_body_html = replacenocase(current_body_html,'##email##',email,'ALL');
				</cfscript>
				
				<cfoutput>
					<hr>
						von: #attributes.email_from#<br>
						an: #email#<br>
						<br>
						current_body_plain:<br>
						#current_body_plain#<br>
						<br>
						current_body_html:<br>
						#current_body_html#<br>
						<br>
					<hr>
				</cfoutput>
				
				<cfif attributes.mailserver_usedefault>
	
					<!--- <cfmail from="#attributes.email_from#" to="#email#" subject="#attributes.subject#">
						<cfif len(trim(attributes.body_plain))>
							<cfmailpart type="plain">
								#current_body_plain#
							</cfmailpart>
						</cfif>
						<cfif len(trim(attributes.body_html))>
							<cfmailpart type="html">
								#current_body_html#
							</cfmailpart>
						</cfif>
					</cfmail> --->

				<cfelse>
					
					<!--- <cfmail from="#attributes.email_from#" to="#email#" subject="#attributes.subject#" server="#attributes.mailserver_server#" port="#attributes.mailserver_port#" username="#attributes.mailserver_username#" password="#attributes.mailserver_password#">
						<cfif len(trim(attributes.body_plain))>
							<cfmailpart type="plain">
								#current_body_plain#
							</cfmailpart>
						</cfif>
						<cfif len(trim(attributes.body_html))>
							<cfmailpart type="html">
								#current_body_html#
							</cfmailpart>
						</cfif>
					</cfmail> --->
		
				</cfif>
			
			</cfif>
		
		</cfloop>
	
	</cfif>

</cfif>
	
<cfsetting enablecfoutputonly="No">