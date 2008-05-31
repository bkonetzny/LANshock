<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="bRequestIncludeCss" default="true">
<cfparam name="bRequestIncludeJs" default="true">
<cfparam name="bRequestIncludeExt" default="true">

<cfoutput>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<meta name="generator" content="LANshock #application.lanshock.oRuntime.getVersion().version#"/>
	<link rel="shortcut icon" href="#application.lanshock.oRuntime.getEnvironment().sServerPath#templates/#request.lanshock.settings.layout.template#/favicon.ico"/>
	<cfif bRequestIncludeCss>
		<link rel="stylesheet" href="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/#request.lanshock.settings.layout.template#/styles.css" type="text/css"/>
	</cfif>
	<cfif bRequestIncludeJs>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/lanshock.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/jquery/jquery-1.2.3.min.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext/adapter/jquery/ext-jquery-adapter.js"></script>
		<cfif bRequestIncludeExt>
			<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext/ext-all.js"></script>
			<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext/source/locale/ext-lang-#LCase(ListFirst(session.lang,'_'))#.js"></script>
			<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-ux/Ext.ux.form.DateTime.js"></script>
			<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-ux/Ext.ux.grid.RowActions.js"></script>
			<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-ux/Ext.ux.grid.Search.js"></script>
		</cfif>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/swfobject/swfobject.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/fckeditor/fckeditor.js"></script>
		<script type="text/javascript">
		<!--
			// set LANshock vars
			LANshock.setVar('self','#jsStringFormat(self)#');
			LANshock.setVar('myself','#jsStringFormat(myself)#');
			LANshock.setVar('sessionUrlToken','#jsStringFormat(urlSessionFormat(''))#');
			Ext.BLANK_IMAGE_URL = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext/resources/images/default/s.gif';
		//-->
		</script>
	</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">