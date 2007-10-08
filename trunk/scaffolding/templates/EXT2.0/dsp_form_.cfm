<!---
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
--->
<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<!--- Generate a list of the joined fields --->>
<<cfset lJoinedFields = oMetaData.getJoinedFieldListFromXML(objectName)>>
<<cfset lAllFields = ListAppend(lFields,lJoinedFields)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Get an array of joinedfields --->>
<<cfset aJoinedFields = oMetaData.getJoinedFieldsFromXML(objectName)>>
<<cfoutput>>

<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_form_$$objectName$$.cfm,v $" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		This page is a form that allows inserts and updates of $$objectName$$ records.
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
			<string name="self" scope="variables" optional="Yes" />
			<string name="XFA.save" scope="variables" optional="Yes" />
			<string name="XFA.cancel" scope="variables" optional="Yes" />
			
			<list name="fieldlist" scope="variables" optional="Yes" comments="Controls the fields displayed and the sequence of the display." />
			
			<number name="_Startrow" scope="attributes" optional="Yes" default="1">
			<number name="_Maxrows" scope="attributes" optional="Yes" default="10">
			<string name="_listSortByFieldList" scope="variables" optional="Yes" default="">
			<string name="searchSafe" scope="request" optional="Yes" default="false">
			
			<array name="aErrors" scope="variables" optional="Yes" Created by Reactor Validation. Present when an error has been found with server validation and passes back from action." >
				<structure>
					<string name="field" />
					<string name="type" />
					<string name="message" />
				</structure>
			</array>
			
			<string name="standardThClass" scope="variables" optional="Yes" default="standard" />
			<string name="highlightThClass" scope="variables" optional="Yes" default="highlight" />
			<string name="standardTdClass" scope="variables" optional="Yes" default="standard" />
			
			<object name="o$$objectName$$" scope="variables"  />
		</in>
		<out>
			<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><$$aFields[i].fuseDocType$$ name="$$aFields[i].alias$$" />
			<</cfloop>>
		</out>
	</io>
</fusedoc>
--->
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- This parameter specifies if we are to use Search Safe URLs or not --->
<cfparam name="request.searchSafe" default="false">
<!--- Set some defaults for the table display classes --->
<cfparam name="standardThClass" default="standard" />
<cfparam name="highlightThClass" default="highlight" />
<cfparam name="standardTdClass" default="standard" />
<!--- Error reporting --->
<cfparam name="highlightfields" default="" />
<cfparam name="aErrorMessages" default="#arrayNew(1)#" />
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- Specify the list of fields to be displayed --->
<cfparam name="fieldlist" default="$$lFields$$" />
<!--- The object being edited or added --->
<cfparam name="o$$objectName$$">
</cfsilent>

<cfoutput>
<!--- Javascript to validate the entries --->
<script language="JavaScript">
<!--
	function reset(myform){
		myform.reset();
	};

	function save(myform, XFA){
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><<cfif aFields[i].required AND NOT structKeyExists(aFields[i],"primaryKeySeq")>>
		if(myform.$$aFields[i].alias$$.value == ""){
			alert("Please enter the $$aFields[i].label$$");
			return false;
		}<</cfif>><</cfloop>>
		document.getElementById("btnSave").disabled=true;
		myform.fuseaction.value = XFA;
		myform.submit();
	};
//-->
</script>

<!--- Start of the form --->
<form name="frmAddEdit" onsubmit="" action="#self#" method="post">		
	<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
	<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
	<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />
	
	<table border="0" cellpadding="2" cellspacing="2" 
		summary="This table shows details of a Fuseaction record." class="">
		
		<!--- Show any Error Messages --->
		<cfif isDefined("aErrorMessages") AND ArrayLen(aErrorMessages) GT 0 >
			<tr>
				<td colspan="2">
				<p class="#variables.standardTdClass#">The following invalid entries were found, please correct them and resubmit.</p>
				<ul>
					<cfloop index="i" from="1" to="#arrayLen(aErrorMessages)#">
						<li class="#variables.highlightThClass#">#aErrorMessages[i]#</li>
					</cfloop>
				</ul>
				</td>
			</tr>
		</cfif>
		
		<!--- Show the form fields --->
		<cfloop list="#fieldlist#" index="thisField">
			<cfswitch expression="#thisField#">
				<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
				<cfcase value="$$aFields[i].alias$$">
					<<cfif ListFindNoCase(lPKFields,aFields[i].alias)>><cfif mode is "edit">
					<!--- Primary Key --->
					<tr>
						<th width="80" align="left" <cfif ListFindNocase(highlightfields,'$$aFields[i].alias$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif>>
							$$aFields[i].label$$
						</th>
						<td>
							#$$Format("o$$objectName$$.get$$aFields[i].alias$$()","$$aFields[i].format$$")$$#
						</td>
					</tr>
					</cfif>
					<input type="hidden" name="$$aFields[i].alias$$" value="#o$$objectName$$.get$$aFields[i].alias$$()#" />
					<<cfelseif aFields[i].formType IS "Dropdown">>
					<!--- a dropdown list --->
					<tr>
						<th width="80" align="left" <cfif ListFindNocase(highlightfields,'$$aFields[i].alias$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif>>
							$$aFields[i].label$$
						</th>
						<td>
							<select name="$$aFields[i].alias$$" id="$$aFields[i].alias$$" size="1">
								<option value=""></option>
								<<cfsilent>><<cfset optionValues = ListWrap(oMetaData.getPKListFromXML(aFields[i].parent),"#q$$aFields[i].parent$$.","#","_")>><</cfsilent>>
								<cfloop query="q$$aFields[i].parent$$">
									<option value="$$optionValues$$" <cfif o$$objectName$$.get$$aFields[i].alias$$() EQ "$$optionValues$$">selected="selected"</cfif> ><<cfloop list="$$lJoinedFields$$" index="thisField">>#q$$aFields[i].parent$$.$$thisField$$#<</cfloop>></option>
								</cfloop>
							</select>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Radio">>
					<!--- radio buttons --->
					<tr>
						<th width="80" align="left" <cfif ListFindNocase(highlightfields,'$$aFields[i].alias$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif>>
							$$aFields[i].label$$
						</th>
						<td>
							<<cfsilent>><<cfset optionValues = ListWrap(oMetaData.getPKListFromXML(aFields[i].parent),"#q$$aFields[i].parent$$.","#","_")>><</cfsilent>>
							<cfloop query="q$$aFields[i].parent$$">
								<input name="$$aFields[i].alias$$" id="$$aFields[i].alias$$_$$optionValues$$" value="$$optionValues$$" <cfif o$$objectName$$.get$$aFields[i].alias$$() EQ "$$optionValues$$">checked="checked"</cfif> /><<cfloop list="$$lJoinedFields$$" index="thisField">>#q$$aFields[i].parent$$.$$thisField$$#<</cfloop>><br />
							</cfloop>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Checkbox">>
					<!--- checkbox --->
					<tr>
						<th width="80" align="left" <cfif ListFindNocase(highlightfields,'$$aFields[i].alias$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<input name="$$aFields[i].alias$$" id="$$aFields[i].alias$$" value="1" <cfif o$$objectName$$.get$$aFields[i].alias$$()>checked="checked"</cfif> /><br />
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Textarea">>
					<!--- a Textarea --->
					<tr>
						<th width="80" align="left" <cfif ListFindNocase(highlightfields,'$$aFields[i].alias$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<textarea name="$$aFields[i].alias$$" id="$$aFields[i].alias$$" cols="$$ListFirst(aFields[i].size,"x")$$" rows="$$ListLast(aFields[i].size,"x")$$"<!--- maxlength="$$aFields[i].maxlength$$" ---> >#$$Format("o$$objectName$$.get$$aFields[i].alias$$()","$$aFields[i].format$$")$$#</textarea>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Hidden">>
						<input type="hidden" name="$$aFields[i].alias$$" value="#o$$objectName$$.get$$aFields[i].alias$$()#" />
					<<cfelseif aFields[i].formType IS "Display">>
					<!--- a hidden field --->
					<tr>
						<th width="80" align="left" <cfif ListFindNocase(highlightfields,'$$aFields[i].alias$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<input type="Hidden" name="$$aFields[i].alias$$" id="$$aFields[i].alias$$" value="#$$Format("o$$objectName$$.get$$aFields[i].alias$$()","$$aFields[i].format$$")$$#" />
						</td>
					</tr>
					<<cfelse>> 
					<!--- default text box --->
					<tr>
						<th width="80" align="left" <cfif ListFindNocase(highlightfields,'$$aFields[i].alias$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<input type="Text" name="$$aFields[i].alias$$" id="$$aFields[i].alias$$" size="$$aFields[i].size$$" <<cfif structKeyExists(aFields[i],"maxlength")>>maxlength="$$aFields[i].maxlength$$"<</cfif>> value="#$$Format("o$$objectName$$.get$$aFields[i].alias$$()","$$aFields[i].format$$")$$#" />
						</td>
					</tr>
					<</cfif>>
				</cfcase><</cfloop>>
			</cfswitch>
		</cfloop>
		<tr>
			<td colspan="2">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<cfset sortParams = appendParam("","_listSortByFieldList",attributes._listSortByFieldList)>
				<cfset sortParams = appendParam(sortParams,"_Maxrows",attributes._Maxrows)>
				<cfset sortParams = appendParam(sortParams,"_StartRow",attributes._Startrow)>
				<cfset sortParams = appendParam(sortParams,"fuseaction",XFA.cancel)>
				<input type="button" value="Save" id="btnSave" onclick="Javascript:save(this.form,'#XFA.Save#')" />
				<input type="button" value="Reset" id="btnReset" onclick="Javascript:reset(this.form)" />
				<input type="button" value="Cancel" id="btnCancel" onclick="Javascript:location.href='#self##sortParams#'" />
				<input type="hidden" name="fuseaction" value="#XFA.save#" />
			</td>
		</tr>
	</table>
	</form>
</cfoutput>
<</cfoutput>>

