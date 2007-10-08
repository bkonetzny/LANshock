<<!--- Set the name of the datasource, This is used to create the names of directories and circuits --->>
<<cfset datasourceName = oMetaData.getDatasource()>>

<<cfoutput>>
<!-- Controller -->
<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" >
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
	</prefuseaction>
	
	<postfuseaction>
		<if condition="isDefined('request.layout') AND request.layout EQ 'json'">
			<true>
				<set name="_fba.debug" value="false"/>
				<include circuit="v$$datasourceName$$" template="dsp_layout_json" />
			</true>
		</if>
		<if condition="isDefined('request.layout') AND request.layout EQ 'none'">
			<true>
				<set name="_fba.debug" value="false"/>
			</true>
		</if>
		<if condition="NOT isDefined('request.layout') OR (isDefined('request.layout') AND request.layout EQ 'default')">
			<true>
				<include circuit="v$$datasourceName$$" template="dsp_layout" />
			</true>
		</if>
	</postfuseaction>

</circuit>
<</cfoutput>>
