<cfscript>
	sDirectory = "utils/";

	stFileData = structNew();
	stFileData.templateFile = sDirectory & "json";
	stFileData.outputFile = "json";
	stFileData.MVCpath = "#destinationFilePath#lib/utils/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript>