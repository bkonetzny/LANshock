<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.rootaccount_saved" default="false">

<cfparam name="attributes.root_email" default="">
<cfparam name="attributes.root_password" default="">

<cfif attributes.form_submitted AND len(attributes.root_email) AND len(attributes.root_password)>

	<cfinvoke component="#application.lanshock.environment.componentpath#core.user.user" method="checkEmail" returnvariable="bEmailIsFree">
		<cfinvokeargument name="email" value="#attributes.root_email#">
	</cfinvoke>

	<cfif bEmailIsFree>
	
		<cfscript>
			args = StructNew();
			args.id = 0;
			args.name = 'root';
			args.firstname = 'root';
			args.lastname = 'root';
			args.email = attributes.root_email;
			args.password = attributes.root_password;
		</cfscript>
	
		<cfinvoke component="#application.lanshock.environment.componentpath#core.user.user" method="setUser" argumentcollection="#args#" returnvariable="iUserID">

		<cfquery datasource="#application.lanshock.environment.datasource#">
			INSERT INTO admin (user, security)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#iUserID#">,
					'globaladmin')
		</cfquery>
		
		<cfset attributes.rootaccount_saved = true>

	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">