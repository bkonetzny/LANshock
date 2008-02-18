<cfoutput>
	<invoke object="application.lanshock.oFactory.load('lanshock.core._utils.i18n.i18nUtil')" method="getLocalesStruct" returnvariable="stLocalesStruct"/>
	<set name="stRelated.language_custom.qData" value="##QueryNew('optionname,optionvalue')##"/>
	<loop collection="##stLocalesStruct##" item="item">
		<set name="tmp" value="##QueryAddRow(stRelated.language_custom.qData)##"/>
		<set name="tmp" value="##QuerySetCell(stRelated.language_custom.qData,'optionname',stLocalesStruct[item])##"/>
		<set name="tmp" value="##QuerySetCell(stRelated.language_custom.qData,'optionvalue',item)##"/>
	</loop>
	
	<set name="stRelated.gender_custom.qData" value="##QueryNew('optionname,optionvalue')##"/>
	<set name="tmp" value="##QueryAddRow(stRelated.gender_custom.qData)##"/>
	<set name="tmp" value="##QuerySetCell(stRelated.gender_custom.qData,'optionname','male')##"/>
	<set name="tmp" value="##QuerySetCell(stRelated.gender_custom.qData,'optionvalue',1)##"/>
	<set name="tmp" value="##QueryAddRow(stRelated.gender_custom.qData)##"/>
	<set name="tmp" value="##QuerySetCell(stRelated.gender_custom.qData,'optionname','female')##"/>
	<set name="tmp" value="##QuerySetCell(stRelated.gender_custom.qData,'optionvalue',0)##"/>
</cfoutput>