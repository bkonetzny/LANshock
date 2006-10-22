<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="generator" content="LANshock #request.lanshock.settings.version#">
	<link rel="shortcut icon" href="http://#cgi.server_name#<cfif cgi.server_port NEQ '80'>:#cgi.server_port#</cfif>#request.lanshock.environment.webpath#templates/#request.lanshock.settings.layout.template#/favicon.ico">
	<link rel="stylesheet" href="#request.lanshock.environment.webpath#templates/#request.lanshock.settings.layout.template#/styles.css" type="text/css">
	<script language="javascript" type="text/javascript" src="#request.lanshock.environment.webpath#templates/_scripts/scripts.js"></script>
	<script language="javascript" type="text/javascript" src="#request.lanshock.environment.webpath#templates/_scripts/CalendarPopup.js"></script>
	<script language="javascript" type="text/javascript" src="#request.lanshock.environment.webpath#templates/_scripts/addevent.js"></script>
	<script language="javascript" type="text/javascript" src="#request.lanshock.environment.webpath#templates/_scripts/sorttable.js"></script>
	<style type="text/css">
		.collapsed {display: none;}
		.expanded {display: block;}
		.collapsetrigger {cursor: pointer;}
	</style>
	<script language="javascript" type="text/javascript">
	<!--
		var sCollapsibleCollapseString = '#request.content.__core_utils_collapsible_collapse#';
		var sCollapsibleExpandString = '#request.content.__core_utils_collapsible_expand#';
	//-->
	</script>
	<script language="javascript" type="text/javascript" src="#request.lanshock.environment.webpath#templates/_scripts/collapsible.js"></script>
	<script language="javascript" type="text/javascript">
	<!--
		// Panel Popup
		function Panel(){window.open("#myself##request.lanshock.settings.modulePrefix.core#general.panel&#request.session.UrlToken#", "Panel", "height=500,width=220,left=20,top=20,locationbar=0,menubar=0,resizable=1,scrollbars=1,status=0");}
		
		// SendMessage Dialog (Requires a UserID)
		function SendMsg(id){window.open("#myself##request.lanshock.settings.modulePrefix.core#mail.message_dialog&user_id=" + id + "&#request.session.UrlToken#", "NewMessage", "height=300,width=300,left=340,top=20,locationbar=0,menubar=0,resizable=0,scrollbars=1,status=0");}

		// LANshock Code Popup
		function showLANshockCode(){window.open("#myself##request.lanshock.settings.modulePrefix.core#general.lanshock_code_popup&#request.session.UrlToken#", "LANshockCode", "height=450,width=600,left=20,top=20,locationbar=0,menubar=0,resizable=1,scrollbars=1,status=0");}
	//-->
	</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">