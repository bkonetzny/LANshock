<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	request.ShowLayout = 'full';
	
	plugin = myFusebox.plugins[myFusebox.thisPlugin];
	plugin.ShowLayout = request.ShowLayout;
	plugin.layoutFile = "../templates/#application.lanshock.settings.layout.template#/layoutHeader.cfm";
	
	// check if an fuseaction has an <set name="ShowLayout" value="[full|basic|none]"> in it
	tmpFuseboxVars = duplicate(application.fusebox.circuits[myfusebox.thiscircuit].fuseactions[myfusebox.thisfuseaction].xml.xmlchildren);
	
	// set ArrrayLen once - otherwise it's evaluated in every loop
	iArrayLen = ArrayLen(tmpFuseboxVars);
</cfscript>

<cfloop from="1" to="#iArrayLen#" index="idx">
	<cfscript>
		if(StructKeyExists(tmpFuseboxVars[idx].xmlattributes, "name") AND tmpFuseboxVars[idx].xmlattributes.name EQ "ShowLayout"){
			plugin.ShowLayout = tmpFuseboxVars[idx].xmlattributes.value;
			request.ShowLayout = plugin.ShowLayout;
		}
	</cfscript>
</cfloop>

</cfsilent>

<cfswitch expression="#plugin.ShowLayout#">

	<!--- Show Full HTML Layout --->
	<cfdefaultcase>

		<!--- Cookie-Detection only if Sites with Layout are requested to exclude Sites like Stylesheets --->
		<cfif NOT request.session.UserLoggedIn>
			<!--- if Cookie exists relocate to Login --->
			<cfif isDefined("cookie.email") AND len(cookie.email) AND isDefined("cookie.password") AND len(cookie.password) AND myfusebox.thiscircuit NEQ "#request.lanshock.settings.modulePrefix.core#user" AND myfusebox.thisfuseaction NEQ "login">
				<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.login&#request.session.UrlToken#" addtoken="false">
			</cfif>
		</cfif>
	
		<cfinclude template="#plugin.layoutFile#">
	
	</cfdefaultcase>

	<!--- Show Only Basic HTML Layout --->
	<cfcase value="basic">
	
		<cfinclude template="../templates/basic.header.cfm">
	
	</cfcase>

	<!--- Show Only Generated Content --->
	<cfcase value="none">
		<!--- Do Nothing --->
	</cfcase>
</cfswitch>

<cfsetting enablecfoutputonly="No">