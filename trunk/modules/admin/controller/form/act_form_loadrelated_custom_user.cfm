<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core._utils.i18n.i18nUtil')#" method="getLocalesStruct" returnvariable="stLocalesStruct">
<cfset stRelated.language_custom.qData = QueryNew('optionname,optionvalue')>
<cfloop collection="#stLocalesStruct#" item="item">
	<cfset QueryAddRow(stRelated.language_custom.qData)>
	<cfset QuerySetCell(stRelated.language_custom.qData,'optionname',stLocalesStruct[item])>
	<cfset QuerySetCell(stRelated.language_custom.qData,'optionvalue',item)>
</cfloop>

<cfset stRelated.status_custom.qData = QueryNew('optionname,optionvalue')>
<cfset QueryAddRow(stRelated.status_custom.qData)>
<cfset QuerySetCell(stRelated.status_custom.qData,'optionname','new')>
<cfset QuerySetCell(stRelated.status_custom.qData,'optionvalue','new')>
<cfset QueryAddRow(stRelated.status_custom.qData)>
<cfset QuerySetCell(stRelated.status_custom.qData,'optionname','verified')>
<cfset QuerySetCell(stRelated.status_custom.qData,'optionvalue','verified')>
<cfset QueryAddRow(stRelated.status_custom.qData)>
<cfset QuerySetCell(stRelated.status_custom.qData,'optionname','confirmed')>
<cfset QuerySetCell(stRelated.status_custom.qData,'optionvalue','confirmed')>

<cfset stRelated.gender_custom.qData = QueryNew('optionname,optionvalue')>
<cfset QueryAddRow(stRelated.gender_custom.qData)>
<cfset QuerySetCell(stRelated.gender_custom.qData,'optionname','male')>
<cfset QuerySetCell(stRelated.gender_custom.qData,'optionvalue',1)>
<cfset QueryAddRow(stRelated.gender_custom.qData)>
<cfset QuerySetCell(stRelated.gender_custom.qData,'optionname','female')>
<cfset QuerySetCell(stRelated.gender_custom.qData,'optionvalue',0)>