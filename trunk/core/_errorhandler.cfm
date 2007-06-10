<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stGlobalCfcatch = cfcatch>

<cftry>
	<cfset logfile = "#application.lanshock.environment.abspath#/logs/error.log">

	<cfif FileExists(logfile)>
		<cffile action="READ" file="#logfile#" variable="errorWDDX">
		<cfwddx action="WDDX2CFML" input="#errorWDDX#" output="error">
		<cfset ArrayAppend(error, cfcatch)>	
		<cfwddx action="CFML2WDDX" input="#error#" output="errorWDDX">
		<cffile action="WRITE" file="#logfile#" output="#errorWDDX#">
	<cfelse>
		<cfscript>
			error = ArrayNew(1);
			error[1] = cfcatch;
		</cfscript>
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

<cfinclude template="_errorhandlerrelocator.cfm">

<cfoutput><cfcontent reset="true"><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>LANshock - Error Occurred While Processing Request</title>
	<meta name="generator" content="LANshock">
	<style type="text/css" media="all">
		th, td{ font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; }
		.headline{ font-size: 20px; }
		.sub01{ font-style: italic; line-height: 30px; padding-left: 10px; font-size: 12px; }
		.sub02{ line-height: 10px; padding-left: 30px; }
		.b_r{ border-right: 1px dotted gray; }
		.b_t{ border-top: 1px dotted gray; }
	</style>
</head>
<body style="background-color: ##CCCCCC">
	<table style="border: 1px solid gray; background-color: ffffff; width: 90%" align="center">
		<tr>
			<td><img src="core/lanshock.gif"></td>
			<td class="headline">Error Occurred While Processing Request</span></td>
		</tr>
		<tr>
			<td colspan="2" class="sub01">LANshock Version:</td>
		</tr>
		<tr>
			<td colspan="2" class="sub02">#request.lanshock_version# (#request.lanshock_build#)</td>
		</tr>
		<tr>
			<td colspan="2" class="sub01">ColdFusion Version:</td>
		</tr>
		<tr>
			<td colspan="2" class="sub02">#server.coldfusion.productversion#</td>
		</tr>
		<tr>
			<td colspan="2" class="sub01">Message:</td>
		</tr>
		<tr>
			<td colspan="2" class="sub02">#stGlobalCfcatch.message#</td>
		</tr>
		<tr>
			<td colspan="2" class="sub01">Detail:</td>
		</tr>
		<tr>
			<td colspan="2" class="sub02">#stGlobalCfcatch.detail#</td>
		</tr>
		<tr>
			<td colspan="2" class="sub01">Type:</td>
		</tr>
		<tr>
			<td colspan="2" class="sub02">#stGlobalCfcatch.type#</td>
		</tr>
		<tr>
			<td colspan="2" class="sub01">Error-Status:</td>
		</tr>
		<tr>
			<td colspan="2" class="sub02"><cfif bLogged>This Error has been logged to 'logs/error.log'.<cfelse>This Error has <strong>NOT</strong> been logged to 'logs/error.log'.</cfif></td>
		</tr>
		<tr>
			<td colspan="2" class="sub01">TagContext:</td>
		</tr>
		<tr>
			<td colspan="2" class="sub02">
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
								<td class="b_t b_r">#stGlobalCfcatch.tagcontext[idx].type#</td>
								<td class="b_t b_r" align="right">#stGlobalCfcatch.tagcontext[idx].line#</td>
								<td class="b_t b_r" align="right">#stGlobalCfcatch.tagcontext[idx].column#</td>
								<td class="b_t">#stGlobalCfcatch.tagcontext[idx].template#</td>
							</tr>
						</cfloop>
					</table>
					<cfcatch><em>Unknown</em></cfcatch>
				</cftry></td>
		</tr>
	</table>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="No">