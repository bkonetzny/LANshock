<cfset stRelated.status_custom.qData = QueryNew('optionname,optionvalue')>
<cfloop list="#stGlobalVars.statuslist#" index="idx">
	<cfset QueryAddRow(stRelated.status_custom.qData)>
	<cfset QuerySetCell(stRelated.status_custom.qData,'optionname',idx)>
	<cfset QuerySetCell(stRelated.status_custom.qData,'optionvalue',idx)>
</cfloop>

<cfset stRelated.type_custom.qData = QueryNew('optionname,optionvalue')>
<cfset QueryAddRow(stRelated.type_custom.qData)>
<cfset QuerySetCell(stRelated.type_custom.qData,'optionname',request.content.tournament_type_se)>
<cfset QuerySetCell(stRelated.type_custom.qData,'optionvalue','se')>
<cfset QueryAddRow(stRelated.type_custom.qData)>
<cfset QuerySetCell(stRelated.type_custom.qData,'optionname',request.content.tournament_type_de)>
<cfset QuerySetCell(stRelated.type_custom.qData,'optionvalue','de')>
<cfset QueryAddRow(stRelated.type_custom.qData)>
<cfset QuerySetCell(stRelated.type_custom.qData,'optionname',request.content.tournament_type_group)>
<cfset QuerySetCell(stRelated.type_custom.qData,'optionvalue','group')>
<cfset QueryAddRow(stRelated.type_custom.qData)>
<cfset QuerySetCell(stRelated.type_custom.qData,'optionname','Custom Ranking')>
<cfset QuerySetCell(stRelated.type_custom.qData,'optionvalue','customranking')>

<cfdirectory action="list" directory="#sStorageRules#" name="qRules" sort="name ASC">

<cfquery dbtype="query" name="stRelated.rulefile_custom.qData">
	SELECT name AS optionname, name AS optionvalue
	FROM qRules
	ORDER BY optionname
</cfquery>

<cfdirectory action="list" directory="#application.lanshock.oHelper.UDF_Module('absPath')#/images/icons" recurse="true" name="qIcons" sort="name ASC">

<cfquery dbtype="query" name="qIcons">
	SELECT *
	FROM qIcons
	WHERE type != 'dir'
	AND name LIKE '%.jpg'
	OR name LIKE '%.gif'
	OR name LIKE '%.png'
	ORDER BY directory
</cfquery>

<cfset stRelated.image_custom.qData = QueryNew('optionname,optionvalue')>
<cfloop query="qIcons">
	<cfset QueryAddRow(stRelated.image_custom.qData)>
	<cfset QuerySetCell(stRelated.image_custom.qData,'optionname',ListLast(qIcons.directory,'\/') & '/' & qIcons.name)>
	<cfset QuerySetCell(stRelated.image_custom.qData,'optionvalue',ListLast(qIcons.directory,'\/') & '/' & qIcons.name)>
</cfloop>

<cfquery dbtype="query" name="stRelated.image_custom.qData">
	SELECT *
	FROM stRelated.image_custom.qData
	ORDER BY optionname
</cfquery>

<cfset lColorNames = 'aliceblue,antiquewhite,aquamarine,azure,beige,blueviolet,brown,burlywood,cadetblue,chartreuse,chocolate,coral,cornflowerblue,cornsilk,crimson,darkblue,darkcyan,darkgoldenrod,darkgray,darkgreen,darkkhaki,darkmagenta,darkolivegreen,darkorange,darkorchid,darkred,darksalmon,darkseagreen,darkslateblue,darkslategray,darkturquoise,darkviolet,deeppink,deepskyblue,dimgray,dodgerblue,firebrick,floralwhite,forestgreen,gainsboro,ghostwhite,gold,goldenrod,greenyellow,honeydew,hotpink,indianred,indigo,ivory,khaki,lavender,lavenderblush,lawngreen,lemonchiffon,lightblue,lightcoral,lightcyan,lightgoldenrodyellow,lightgreen,lightgrey,lightpink,lightsalmon,lightseagreen,lightskyblue,lightslategray,lightsteelblue,lightyellow,limegreen,linen,mediumaquamarine,mediumblue,mediumorchid,mediumpurple,mediumseagreen,mediumslateblue,mediumspringgreen,mediumturquoise,mediumvioletred,midnightblue,mintcream,mistyrose,moccasin,navajowhite,oldlace,olivedrab,orange,orangered,orchid,palegoldenrod,palegreen,paleturquoise,palevioletred,papayawhip,peachpuff,peru,pink,plum,powderblue,rosybrown,royalblue,saddlebrown,salmon,sandybrown,seagreen,seashell,sienna,skyblue,slateblue,slategray,snow,springgreen,steelblue,,tan,thistle,tomato,turquoise,violet,wheat,whitesmoke,yellowgreen'>

<cfset stRelated.timetable_color_custom.qData = QueryNew('optionname,optionvalue')>
<cfloop list="#lColorNames#" index="idx">
	<cfset QueryAddRow(stRelated.timetable_color_custom.qData)>
	<cfset QuerySetCell(stRelated.timetable_color_custom.qData,'optionname',idx)>
	<cfset QuerySetCell(stRelated.timetable_color_custom.qData,'optionvalue',idx)>
</cfloop>