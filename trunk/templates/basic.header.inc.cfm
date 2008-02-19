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
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<meta name="generator" content="LANshock #request.lanshock.settings.version#"/>
	<link rel="shortcut icon" href="http://#cgi.server_name#<cfif cgi.server_port NEQ '80'>:#cgi.server_port#</cfif>#request.lanshock.environment.webpath#templates/#request.lanshock.settings.layout.template#/favicon.ico"/>
	<link rel="stylesheet" href="#request.lanshock.environment.webpath#templates/#request.lanshock.settings.layout.template#/styles.css" type="text/css"/>
	<script type="text/javascript" src="#request.lanshock.environment.webpath#templates/_shared/js/lanshock.js"></script>
	<script type="text/javascript" src="#request.lanshock.environment.webpath#templates/_shared/js/jquery/jquery-1.2.3.min.js"></script>
	<script type="text/javascript" src="#request.lanshock.environment.webpath#templates/_shared/js/swfobject/swfobject.js"></script>
	<script type="text/javascript" src="#request.lanshock.environment.webpath#templates/_shared/js/fckeditor/fckeditor.js"></script>
	<script type="text/javascript">
	<!--
		// set LANshock vars
		LANshock.setVar('self','#jsStringFormat(self)#');
		LANshock.setVar('myself','#jsStringFormat(myself)#');
		LANshock.setVar('sessionUrlToken','#jsStringFormat(session.urlToken)#');
	//-->
	</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">