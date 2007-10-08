<cfscript>
	sDirectory = "udf/";

	stFileData = structNew();
	stFileData.templateFile = sDirectory & "udf_appendParam";
	stFileData.outputFile = "udf_appendParam";
	stFileData.MVCpath = "#destinationFilePath#udfs/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript>