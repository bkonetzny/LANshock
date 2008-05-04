<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stGlobalCfcatch = arguments.exception>

<cftry>
	<cfset logfile = "#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/error.log">

	<cfif FileExists(logfile)>
		<cffile action="READ" file="#logfile#" variable="errorWDDX">
		<cfwddx action="WDDX2CFML" input="#errorWDDX#" output="error">
		<cfset ArrayAppend(error, stGlobalCfcatch)>	
		<cfwddx action="CFML2WDDX" input="#error#" output="errorWDDX">
		<cffile action="WRITE" file="#logfile#" output="#errorWDDX#">
	<cfelse>
		<cfset error = ArrayNew(1)>
		<cfset error[1] = stGlobalCfcatch>
		<cfwddx action="CFML2WDDX" input="#error#" output="errorWDDX">
		<cffile action="WRITE" file="#logfile#" output="#errorWDDX#">
	</cfif>
	<cfset bLogged = true>
	
	<cfcatch>
		<cfset bLogged = false>
		<cftry>
			<cffile action="copy" source="#logfile#" destination="#logfile#.backup" nameconflict="makeunique">
			<cffile action="delete" file="#logfile#">
			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
	</cfcatch>
</cftry>

<cfoutput><cftry><cfcontent reset="true"><cfcatch></cfcatch></cftry><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>LANshock - Error Occurred While Processing Request</title>
	<meta name="generator" content="LANshock">
	<style type="text/css" media="all">
		*{font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;}
		body{background-color: ##CCCCCC;}
		##errorwrapper{border: 1px solid gray;padding: 20px;margin:0 50px 0 50px;background-color: ffffff;}
		h1{font-size: 20px;}
		th{text-align:left;}
		ul,li{list-style:none;margin:0;}
		.sub01{font-style: italic;line-height: 30px;padding-left: 10px;font-size: 12px;}
		.sub02{line-height: 10px;padding-left: 30px;padding-bottom: 10px;}
		.b_r{border-right: 1px dotted gray;}
		.b_t{border-top: 1px dotted gray;}
	</style>
</head>
<body>
	<div id="errorwrapper">
		<h1>Error Occurred While Processing Request</h1>
		<ul>
			<cfif StructKeyExists(request,'lanshock_version') AND StructKeyExists(request,'lanshock_build')>
				<li class="sub01">LANshock Version:</li>
				<li class="sub02">#request.lanshock_version# (#request.lanshock_build#)</li>
			</cfif>
			<li class="sub01">ColdFusion Version:</li>
			<li class="sub02">#server.coldfusion.productversion#</li>
			<li class="sub01">Message:</li>
			<li class="sub02">#stGlobalCfcatch.message#</li>
			<li class="sub01">Detail:</li>
			<li class="sub02">#stGlobalCfcatch.detail#</li>
			<li class="sub01">Type:</li>
			<li class="sub02">#stGlobalCfcatch.type#</li>
			<li class="sub01">TagContext:</li>
			<li class="sub02">
				<cftry>
					<table cellpadding="10">
						<tr>
							<th class="b_r">Type:</th>
							<th class="b_r">Line:</th>
							<th class="b_r">Column:</th>
							<th>Template:</th>
						</tr>
						<cfloop from="1" to="#ArrayLen(stGlobalCfcatch.tagcontext)#" index="idx">
							<tr>
								<td class="b_t b_r" rowspan="2" valign="top">#stGlobalCfcatch.tagcontext[idx].type#</td>
								<td class="b_t b_r" rowspan="2" valign="top" align="right">#stGlobalCfcatch.tagcontext[idx].line#</td>
								<td class="b_t b_r" rowspan="2" valign="top" align="right">#stGlobalCfcatch.tagcontext[idx].column#</td>
								<td class="b_t">#stGlobalCfcatch.tagcontext[idx].template#</td>
							</tr>
							<tr>
								<td class="b_t">#stGlobalCfcatch.tagcontext[idx].codeprinthtml#</td>
							</tr>
						</cfloop>
					</table>
					<cfcatch><em>Unknown</em></cfcatch>
				</cftry>
			</li>
		</ul>
	</div>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="No">