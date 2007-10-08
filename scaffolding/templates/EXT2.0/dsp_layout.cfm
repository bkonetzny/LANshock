<<!---
Copyright 2006-07 Objective Internet Ltd - http://www.objectiveinternet.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->>
<cfsilent>
<!--- -->
<fusedoc fuse="dsp_layout.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		This page is a fusebox layout page.
	</responsibilities>
	<properties>
		<history author="Kevin Roche" email="kevin@objectiveinternet.com" date="$$dateFormat(now(),'dd-mmm-yyyy')$$" role="Architect" type="Create" />
		<property name="copyright" value="(c)$$year(now())$$ Objective Internet Limited." />
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision: 1.0 $" />
		<property name="lastupdated" value="$Date: $$DateFormat(now(),'yyyy/mm/dd')$$ $$ TimeFormat(now(),'HH:mm:ss')$$ $" />
		<property name="updatedby" value="$Author: kevin $" />
	</properties>
	<io>
		<in>
			<structure name="page" scope="request" >
				<string name="subtitle" />
				<string name="pageContent" />
			</structure>
		</in>
		<out>
			<string name="fuseaction" scope="formOrUrl" />
		</out>
	</io>
</fusedoc>
--->
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><cfoutput>#request.page.subtitle#</cfoutput></title>
	<script type="text/javascript" src="js/ext-2.0-alpha1/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="js/ext-2.0-alpha1/ext-all.js"></script>
	<link rel="stylesheet" type="text/css" href="js/ext-2.0-alpha1/resources/css/ext-all.css" />
	<link rel="stylesheet" type="text/css" href="js/ext-2.0-alpha1/examples/grid/grid-examples.css" />
	<style type="text/css">
        body .x-panel {
            margin-bottom:20px;
        }
        .icon-grid {
            background-image:url(js/ext-2.0-alpha1/examples/shared/icons/fam/grid.png) !important;
        }
        ##button-grid .x-panel-body {
            border:1px solid ##99bbe8;
            border-top:0 none;
        }
        .add {
            background-image:url(js/ext-2.0-alpha1/examples/shared/icons/fam/add.gif) !important;
        }
        .edit {
            background-image:url(js/ext-2.0-alpha1/examples/shared/icons/fam/cog_edit.png) !important;
        }
        .option {
            background-image:url(js/ext-2.0-alpha1/examples/shared/icons/fam/plugin.gif) !important;
        }
        .remove {
            background-image:url(js/ext-2.0-alpha1/examples/shared/icons/fam/delete.gif) !important;
        }
        .save {
            background-image:url(js/ext-2.0-alpha1/examples/shared/icons/save.gif) !important;
        }
    </style>
</head>
<body>
<cfoutput><h1 class="pagetitle">#request.page.subtitle#</h1></cfoutput>
<!--- Menu --->
<cfoutput>
<<cfoutput>>
	<<cfloop list="$$oMetaData.getLTableAliases()$$" index="thisObject" >>
	<a href="#self#?fuseaction=$$oMetaData.getDatasource()$$.$$thisObject$$_Listing">$$thisObject$$</a><</cfloop>>
<</cfoutput>>
</cfoutput>
<!--- Page --->
<cfoutput>#request.page.pageContent#</cfoutput>
</body>
</html>
