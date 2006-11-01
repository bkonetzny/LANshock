<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">

<cfparam name="attributes.id" default="0">

<cfinvoke component="tournaments" method="getTournaments" returnvariable="qTournaments">

<cfquery name="qGetCurrentSelection" dbtype="query">
	SELECT * FROM qTournaments WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.id#">
</cfquery>

<cfif qGetCurrentSelection.recordcount>
	<cfparam name="attributes.name" default="#qGetCurrentSelection.name#">
	<cfparam name="attributes.status" default="#qGetCurrentSelection.status#">
	<cfparam name="attributes.export_league" default="#qGetCurrentSelection.export_league#">
	<cfparam name="attributes.export_league_data" default="#qGetCurrentSelection.export_league_data#">
	<cfparam name="attributes.maxteams" default="#qGetCurrentSelection.maxteams#">
	<cfparam name="attributes.type" default="#qGetCurrentSelection.type#">
	<cfparam name="attributes.groupid" default="#qGetCurrentSelection.groupid#">
	<cfparam name="attributes.teamsize" default="#qGetCurrentSelection.teamsize#">
	<cfparam name="attributes.teamsubstitute" default="#qGetCurrentSelection.teamsubstitute#">
	<cfparam name="attributes.rulefile" default="#qGetCurrentSelection.rulefile#">
	<cfparam name="attributes.image" default="#qGetCurrentSelection.image#">
	<cfparam name="attributes.coins" default="#qGetCurrentSelection.coins#">
	<cfparam name="attributes.matchcount" default="#qGetCurrentSelection.matchcount#">
	<cfparam name="attributes.matchtime" default="#qGetCurrentSelection.matchtime#">
	<cfparam name="attributes.pausetime" default="#qGetCurrentSelection.pausetime#">
	<cfparam name="attributes.starttime_day" default="#day(qGetCurrentSelection.starttime)#">
	<cfparam name="attributes.starttime_month" default="#month(qGetCurrentSelection.starttime)#">
	<cfparam name="attributes.starttime_year" default="#year(qGetCurrentSelection.starttime)#">
	<cfparam name="attributes.starttime_hour" default="#hour(qGetCurrentSelection.starttime)#">
	<cfparam name="attributes.starttime_minute" default="#minute(qGetCurrentSelection.starttime)#">
	<cfparam name="attributes.endtime_day" default="#day(qGetCurrentSelection.endtime)#">
	<cfparam name="attributes.endtime_month" default="#month(qGetCurrentSelection.endtime)#">
	<cfparam name="attributes.endtime_year" default="#year(qGetCurrentSelection.endtime)#">
	<cfparam name="attributes.endtime_hour" default="#hour(qGetCurrentSelection.endtime)#">
	<cfparam name="attributes.endtime_minute" default="#minute(qGetCurrentSelection.endtime)#">
	<cfparam name="attributes.timetable_color" default="#qGetCurrentSelection.timetable_color#">
	<cfparam name="attributes.ladminids" default="#qGetCurrentSelection.ladminids#">
	<cfparam name="attributes.infotext" default="#qGetCurrentSelection.infotext#">
</cfif>

<cfparam name="attributes.name" default="">
<cfparam name="attributes.status" default="signup">
<cfparam name="attributes.export_league" default="">
<cfparam name="attributes.export_league_data" default="">
<cfparam name="attributes.maxteams" default="128">
<cfparam name="attributes.type" default="de">
<cfparam name="attributes.groupid" default="de">
<cfparam name="attributes.teamsize" default="4">
<cfparam name="attributes.teamsubstitute" default="0">
<cfparam name="attributes.rulefile" default="">
<cfparam name="attributes.image" default="">
<cfparam name="attributes.coins" default="2">
<cfparam name="attributes.matchcount" default="2">
<cfparam name="attributes.matchtime" default="30">
<cfparam name="attributes.pausetime" default="10">
<cfparam name="attributes.starttime_day" default="#day(now())#">
<cfparam name="attributes.starttime_month" default="#month(now())#">
<cfparam name="attributes.starttime_year" default="#year(now())#">
<cfparam name="attributes.starttime_hour" default="#hour(now())#">
<cfparam name="attributes.starttime_minute" default="#minute(now())#">
<cfparam name="attributes.endtime_day" default="#day(now())#">
<cfparam name="attributes.endtime_month" default="#month(now())#">
<cfparam name="attributes.endtime_year" default="#year(now())#">
<cfparam name="attributes.endtime_hour" default="#hour(now())#">
<cfparam name="attributes.endtime_minute" default="#minute(now())#">
<cfparam name="attributes.timetable_color" default="red">
<cfparam name="attributes.ladminids" default="">
<cfparam name="attributes.infotext" default="">

<cfif attributes.form_submitted>

	<cfscript>
		// validation
		if(NOT len(attributes.name)) ArrayAppend(aError, request.content.error_tournament_name);
		if(NOT isNumeric(attributes.teamsize) OR attributes.teamsize LTE 0) ArrayAppend(aError, request.content.error_tournament_teamsize);
		if(NOT isNumeric(attributes.teamsubstitute) OR attributes.teamsubstitute LT 0) ArrayAppend(aError, request.content.error_tournament_teamsubstitute);
		if(NOT isNumeric(attributes.matchcount) OR attributes.matchcount LTE 0) ArrayAppend(aError, request.content.error_tournament_matchcount);
		if(NOT isNumeric(attributes.matchtime) OR attributes.matchtime LTE 0) ArrayAppend(aError, request.content.error_tournament_matchtime);
		if(NOT isNumeric(attributes.pausetime) OR attributes.pausetime LT 0) ArrayAppend(aError, request.content.error_tournament_pausetime);
		if(NOT isNumeric(attributes.coins) OR attributes.coins LT 0) ArrayAppend(aError, request.content.error_tournament_coins);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfinvoke component="tournaments" method="setTournament">
			<cfinvokeargument name="id" value="#attributes.id#">
			<cfinvokeargument name="name" value="#attributes.name#">
			<cfinvokeargument name="maxteams" value="#attributes.maxteams#">
			<cfinvokeargument name="type" value="#attributes.type#">
			<cfinvokeargument name="export_league" value="#attributes.export_league#">
			<cfinvokeargument name="export_league_data" value="#attributes.export_league_data#">
			<cfinvokeargument name="groupid" value="#attributes.groupid#">
			<cfinvokeargument name="teamsize" value="#attributes.teamsize#">
			<cfinvokeargument name="teamsubstitute" value="#attributes.teamsubstitute#">
			<cfinvokeargument name="rulefile" value="#attributes.rulefile#">
			<cfinvokeargument name="image" value="#attributes.image#">
			<cfinvokeargument name="coins" value="#attributes.coins#">
			<cfinvokeargument name="matchcount" value="#attributes.matchcount#">
			<cfinvokeargument name="matchtime" value="#attributes.matchtime#">
			<cfinvokeargument name="pausetime" value="#attributes.pausetime#">
			<cfinvokeargument name="starttime_day" value="#attributes.starttime_day#">
			<cfinvokeargument name="starttime_month" value="#attributes.starttime_month#">
			<cfinvokeargument name="starttime_year" value="#attributes.starttime_year#">
			<cfinvokeargument name="starttime_hour" value="#attributes.starttime_hour#">
			<cfinvokeargument name="starttime_minute" value="#attributes.starttime_minute#">
			<cfinvokeargument name="endtime_day" value="#attributes.endtime_day#">
			<cfinvokeargument name="endtime_month" value="#attributes.endtime_month#">
			<cfinvokeargument name="endtime_year" value="#attributes.endtime_year#">
			<cfinvokeargument name="endtime_hour" value="#attributes.endtime_hour#">
			<cfinvokeargument name="endtime_minute" value="#attributes.endtime_minute#">
			<cfinvokeargument name="timetable_color" value="#attributes.timetable_color#">
			<cfinvokeargument name="ladminids" value="#attributes.ladminids#">
			<cfinvokeargument name="infotext" value="#attributes.infotext#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.tournaments_edit&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfinvoke component="tournaments" method="getGroups" returnvariable="qGroups">

<cfinvoke component="#application.lanshock.environment.componentpath#core.admin.admin" method="getAdmins" returnvariable="qAdmins">

<cfif attributes.export_league EQ 'wwcl'>

	<cfset stWWCLgameini = StructNew()>

	<cfif FileExists(UDF_Module('absPath') & '/export/wwcl/gameini.xml')>
		<cffile action="READ" file="#UDF_Module('absPath')#/export/wwcl/gameini.xml" variable="gameini">
		<cfscript>
			stGameIni = XMLParse(gameini);
		</cfscript> 
		<cfloop from="1" to="#ArrayLen(stGameIni.wwclgameini.game)#" index="idx">
			<cfscript>
				stWWCLgameini[stGameIni.wwclgameini.game[idx].id.xmltext] = StructNew();
				stWWCLgameini[stGameIni.wwclgameini.game[idx].id.xmltext].name = stGameIni.wwclgameini.game[idx].name.xmltext;
				stWWCLgameini[stGameIni.wwclgameini.game[idx].id.xmltext].type = stGameIni.wwclgameini.game[idx].type.xmltext;
			</cfscript>
		</cfloop>
	</cfif>

</cfif>

<cfdirectory action="LIST" directory="#UDF_Module('absPath')#/rules" name="qRules" sort="name ASC">

<cfdirectory action="LIST" directory="#UDF_Module('absPath')#/icons" name="qIcons" sort="name ASC">

<cfset lColorNames = 'aliceblue,antiquewhite,aquamarine,azure,beige,blueviolet,brown,burlywood,cadetblue,chartreuse,chocolate,coral,cornflowerblue,cornsilk,crimson,darkblue,darkcyan,darkgoldenrod,darkgray,darkgreen,darkkhaki,darkmagenta,darkolivegreen,darkorange,darkorchid,darkred,darksalmon,darkseagreen,darkslateblue,darkslategray,darkturquoise,darkviolet,deeppink,deepskyblue,dimgray,dodgerblue,firebrick,floralwhite,forestgreen,gainsboro,ghostwhite,gold,goldenrod,greenyellow,honeydew,hotpink,indianred,indigo,ivory,khaki,lavender,lavenderblush,lawngreen,lemonchiffon,lightblue,lightcoral,lightcyan,lightgoldenrodyellow,lightgreen,lightgrey,lightpink,lightsalmon,lightseagreen,lightskyblue,lightslategray,lightsteelblue,lightyellow,limegreen,linen,mediumaquamarine,mediumblue,mediumorchid,mediumpurple,mediumseagreen,mediumslateblue,mediumspringgreen,mediumturquoise,mediumvioletred,midnightblue,mintcream,mistyrose,moccasin,navajowhite,oldlace,olivedrab,orange,orangered,orchid,palegoldenrod,palegreen,paleturquoise,palevioletred,papayawhip,peachpuff,peru,pink,plum,powderblue,rosybrown,royalblue,saddlebrown,salmon,sandybrown,seagreen,seashell,sienna,skyblue,slateblue,slategray,snow,springgreen,steelblue,,tan,thistle,tomato,turquoise,violet,wheat,whitesmoke,yellowgreen'>

<cfsetting enablecfoutputonly="No">