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
<<!--- Set the name of the datasource, This is used to create the names of directories and circuits --->>
<<cfset DatasourceName = oMetaData.getDatasource()>>
<<!--- Get the alias first table --->>
<<cfset lTables = ListFirst(oMetaData.getLTableAliases())>>
<<cfset sModule = oMetaData.getModule()>>
<<cfoutput>>
<?xml version="1.0" encoding="UTF-8"?> 
<fusebox> 
	<circuits>
		<!-- There is a model, view and controller circuit for each database. -->
		<!-- Only the controller has an XML file the others are called implicitly. -->
		<circuit alias="m_$$sModule$$" path="modules/$$sModule$$/model/" parent="" />
		<circuit alias="v_$$sModule$$" path="modules/$$sModule$$/view/" parent="" />
		<circuit alias="c_$$sModule$$" path="modules/$$sModule$$/controller/" parent="" />
		<circuit alias="udfs" path="core/_utils/udf/" parent="" />
	</circuits>
	<parameters>
		<parameter name="debug" value="true" />
		<parameter name="fuseactionVariable" value="fuseaction" />
		<parameter name="mode" value="development-full-load" />
		<parameter name="defaultFuseaction" value="c_$$sModule$$.$$lTables$$_Listing" />
		<parameter name="precedenceFormOrUrl" value="form" />
		<parameter name="password" value="scaffold" />
		<parameter name="scriptFileDelimiter" value="cfm" />
		<parameter name="maskedFileDelimiters" value="htm,cfm,cfml,php,php4,asp,aspx" />
		<parameter name="characterEncoding" value="utf-8" />
		<parameter name="allowImplicitCircuits" value="true" />
	</parameters>
	<classes>
		<class alias="Reactor" type="component" classpath="Reactor.reactorFactory"/> 
	</classes>
	<globalfuseactions>
		<appinit>
			<do action="m_$$sModule$$.Initialise" />
		</appinit>
		<preprocess>
			<do action="m_$$sModule$$.ReInitialise"/>
		</preprocess>
		<postprocess/>
	</globalfuseactions>
	<plugins>
		<phase name="preProcess"/>
		<phase name="preFuseaction"/>
		<phase name="postFuseaction"/>
		<phase name="postProcess"/>
		<phase name="processError"/>
		<phase name="fuseactionException"/>
	</plugins>
</fusebox>
<</cfoutput>>
