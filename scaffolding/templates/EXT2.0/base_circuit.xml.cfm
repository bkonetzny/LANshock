<<!--- Set the name of the datasource, This is used to create the names of directories and circuits --->>
<<cfset datasourceName = oMetaData.getDatasource()>>
<<cfset sModule = oMetaData.getModule()>>

<<cfoutput>>
<!-- Controller -->
<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:lanshock="lanshock/">
<!--
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
-->
	<prefuseaction>
		<set name="request.page" value="#structNew()#"/>
		<lanshock:i18n load="modules/$$sModule$$/i18n/lang.properties" returnvariable="request.content"/>
		<include circuit="c_$$sModule$$" template="settings" />
	</prefuseaction>
	
	<postfuseaction>
		<if condition="isDefined('request.layout') AND request.layout EQ 'json'">
			<true>
				<if condition="request.layout EQ 'json'">
					<true>
						<set name="_fba.debug" value="false"/>
						<include circuit="v_$$sModule$$" template="dsp_layout_json" />
					</true>
					<false>
						<if condition="request.layout EQ 'none'">
							<true>
								<set name="_fba.debug" value="false"/>
							</true>
							<false>
								<if condition="request.layout EQ 'admin')">
									<true>
										<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/view/styles.css")>>
											<lanshock:htmlhead type="style" content="@import url('#request.lanshock.environment.webpath#modules/$$sModule$$/view/styles.css');"/>
										<</cfif>>
										<include circuit="v_$$sModule$$" template="dsp_layout" />
									</true>
								</if>
							</false>
						</if>
					</false>
				</if>
			</true>
		</if>
	</postfuseaction>

	<fuseaction name="main" access="public">
		<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/controller/circuit_main.xml.cfm")>>
			<<cfoutput>>
			<<cfinclude template="../templates/EXT2.0/custom/$$sModule$$/controller/circuit_main.xml.cfm">>
			<</cfoutput>>
		<<cfelse>>
			<include circuit="c_$$sModule$$" template="main" />
		<</cfif>>
	</fuseaction>
	
	<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/controller/circuit.xml.cfm")>>
		<<cfoutput>>
		<<cfinclude template="../templates/EXT2.0/custom/$$sModule$$/controller/circuit.xml.cfm">>
		<</cfoutput>>
	<</cfif>>

</circuit>
<</cfoutput>>