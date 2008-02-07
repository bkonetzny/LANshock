<cfoutput>
	<invoke object="application.lanshock.oFactory.load('lanshock.core._utils.i18n.i18nUtil')" method="getLocalesStruct" returnvariable="stLocalesStruct"/>
	<set name="stRelated.language_custom.qData" value="##QueryNew('optionname,optionvalue')##"/>
	<loop collection="##stLocalesStruct##" item="item">
		<set name="tmp" value="##QueryAddRow(stRelated.language_custom.qData)##"/>
		<set name="tmp" value="##QuerySetCell(stRelated.language_custom.qData,'optionname',stLocalesStruct[item])##"/>
		<set name="tmp" value="##QuerySetCell(stRelated.language_custom.qData,'optionvalue',item)##"/>
	</loop>
</cfoutput>