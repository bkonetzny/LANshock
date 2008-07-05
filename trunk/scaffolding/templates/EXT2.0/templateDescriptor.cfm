<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>	
	stFileData = structNew();
	stFileData.templateFile = "info.xml";
	stFileData.outputFile = "info.xml";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "dsp_layout_json";
	stFileData.outputFile = "dsp_layout_json";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/view/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

	stFileData = structNew();
	stFileData.templateFile = "dsp_list_";
	stFileData.outputFile = "dsp_list_";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/view/list/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "dsp_form_";
	stFileData.outputFile = "dsp_form_";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/view/form/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "lang";
	stFileData.outputFile = "lang";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/i18n/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "properties";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
//Controller: circuit.xml.cfm
	stFileData = structNew();
	stFileData.templateFile = "circuit.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "listing.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "form.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "act_json_filter";
	stFileData.outputFile = "act_json_filter";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "act_form_";
	stFileData.outputFile = "act_form_";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/form/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "act_form_loadrelated_";
	stFileData.outputFile = "act_form_loadrelated_";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/form/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_save.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "act_action_save_";
	stFileData.outputFile = "act_action_save_";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/form/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_delete.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "settings";
	stFileData.outputFile = "settings";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.suffix = "cfm";
	stFileData.useAliasInName = "false";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "main";
	stFileData.outputFile = "main";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/controller/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.suffix = "cfm";
	stFileData.useAliasInName = "false";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
//Model:
	stFileData = structNew();
	stFileData.templateFile = "gateway";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/model/Gateway/";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "gatewayCustom";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#modules/$tablename$/model/Gateway/";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript>