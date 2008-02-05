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
<<cfset sModule = oMetaData.getModule()>>
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

<cfsavecontent variable="sHtmlHead">
	<cfoutput>
		<script type="text/javascript" src="#request.lanshock.environment.webpath#templates/_shared/js/ext-2.0/adapter/jquery/ext-jquery-adapter.js"></script>
		<script type="text/javascript" src="#request.lanshock.environment.webpath#templates/_shared/js/ext-2.0/ext-all.js"></script>
		<script type="text/javascript" src="#request.lanshock.environment.webpath#templates/_shared/js/ext-2.0/source/locale/ext-lang-#LCase(ListFirst(session.lang,'_'))#.js"></script>
	</cfoutput>
</cfsavecontent>

<cfhtmlhead text="#sHtmlHead#">

<cfoutput>
	<cfif StructKeyExists(request,'page') AND StructKeyExists(request.page,'objectName')>
		<h3>#request.content['__globalmodule__navigation__#request.page.objectName#_Listing']#</h3>
	</cfif>
	<cfif StructKeyExists(request,'page') AND StructKeyExists(request.page,'pageContent')>
		#request.page.pageContent#
	</cfif>
</cfoutput>