<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	Panel = StructNew();
</cfscript>

<cfloop collection="#application.module#" item="idx">
	<cfif StructKeyExists(application.module[idx],"panels")>
		<cfloop collection="#application.module[idx].panels#" item="uuidPanel">
			<cfif (application.module[idx].panels[uuidPanel].bUser AND request.session.userloggedin) OR (application.module[idx].panels[uuidPanel].bAdmin AND request.session.isAdmin)>
				<cfscript>
					Panel[uuidPanel] = StructNew();
					Panel[uuidPanel].name = application.module[idx].panels[uuidPanel].name;
					Panel[uuidPanel].module = idx;
					Panel[uuidPanel].action = application.module[idx].panels[uuidPanel].action;
					Panel[uuidPanel].height = application.module[idx].panels[uuidPanel].height;
				</cfscript>
			</cfif>
		</cfloop>
	</cfif>
</cfloop>

<cfparam name="request.session.panel" default="#StructNew()#">
<cfparam name="request.session.panel.active" default="buddylist">
<cfif NOT StructKeyExists(panel, request.session.panel.active)>
	<cfset request.session.panel.active = 'buddylist'>
</cfif>
<cfparam name="attributes.showpanel" default="">

<cfif len(attributes.showpanel)>
	<cfset request.session.panel.active = attributes.showpanel>
</cfif>

<cfloop collection="#panel#" item="idx">
	<cfscript>
		request.session.panel[idx] = StructNew();
		request.session.panel[idx].status = 'show';
		request.session.panel[idx].name = panel[idx].name;
		if(request.session.panel.active EQ panel[idx].name) request.session.panel.active = idx;
	</cfscript>
</cfloop>

<cfif isDefined("attributes.panelid") AND isDefined("attributes.panelstatus")>
	<cfset request.session.panel[attributes.panelid].status = attributes.panelstatus>
</cfif>

<cfsetting enablecfoutputonly="No">