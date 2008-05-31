<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_display_news_trackback.cfm,v $" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I display a single news_trackback record from an object, a structure, a query or from attributes scope.
	</responsibilities>
	<properties>
		<history author="Kevin Roche" email="kevin@objectiveinternet.com" date="06-May-2008" role="Architect" type="Create" />
		<property name="copyright" value="(c)2008 Objective Internet Limited." />
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision: 205 $" />
		<property name="lastupdated" value="$Date: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) 2008/05/06 21:06:00 $" />
		<property name="updatedby" value="$Author: majestixs $" />
	</properties>
	<io>
		<in>
			<string name="self" scope="request" optional="Yes" />
			<string name="XFA.list" scope="variables" optional="Yes" />
			<string name="XFA.edit" scope="variables" optional="Yes" />
			<string name="XFA.delete" scope="variables" optional="Yes" />
			<string name="XFA.continue" scope="variables" optional="Yes" />
			
			<list name="fieldlist" scope="variables" optional="Yes" comments="Controls the fields displayed and the sequence of the display." />
			
			<object name="onews_trackback" comments="The record object to be displayed." optional="Yes" />
			
			<structure name="stnews_trackback" comments="Not used if onews_trackback is provided." optional="Yes" >
				
				<string name="blog_name" />
				<datetime name="date" />
				<integer name="entry_id" />
				<integer name="id" />
				<string name="text" />
				<string name="title" />
				<string name="url" />
				
			</structure>
			
			<number name="_recordNumber" precision="Integer" scope="variables"/>
			<recordset name="qnews_trackback" primaryKeys="id" scope="variables" optional="Yes" comments="Recordset containing news_trackback records " >
				<string name="blog_name" />
				<datetime name="date" />
				<integer name="entry_id" />
				<integer name="id" />
				<string name="text" />
				<string name="title" />
				<string name="url" />
				
				
			</recordset>
			
			<string name="blog_name" scope="attributes" optional="Yes" comments="Not used if onews_trackback, stnews_trackback or qnews_trackback is provided." />
			<datetime name="date" scope="attributes" optional="Yes" comments="Not used if onews_trackback, stnews_trackback or qnews_trackback is provided." />
			<integer name="entry_id" scope="attributes" optional="Yes" comments="Not used if onews_trackback, stnews_trackback or qnews_trackback is provided." />
			<integer name="id" scope="attributes" optional="Yes" comments="Not used if onews_trackback, stnews_trackback or qnews_trackback is provided." />
			<string name="text" scope="attributes" optional="Yes" comments="Not used if onews_trackback, stnews_trackback or qnews_trackback is provided." />
			<string name="title" scope="attributes" optional="Yes" comments="Not used if onews_trackback, stnews_trackback or qnews_trackback is provided." />
			<string name="url" scope="attributes" optional="Yes" comments="Not used if onews_trackback, stnews_trackback or qnews_trackback is provided." />
			
				
			<array name="aErrors" scope="variables" optional="Yes" Created by Reactor Validation. Present when an error has been found with server validation and passes back from action." >
				<structure>
					<string name="field" />
					<string name="type" />
					<string name="message" />
				</structure>
			</array>
		</in>
		<out>
		</out>
	</io>
</fusedoc>
--->
<!--- Set up the URL parameters so that we can return to the same page in the list. --->
<cfparam name="attributes._StartRow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listsortByFieldList" default="">
<cfparam name="request.searchSafe" default="false">
<cfset pageParams = appendParam("","_listsortByFieldList",attributes._listsortByFieldList)>
<cfset pageParams = appendParam(pageParams,"_Maxrows",attributes._Maxrows)>
<cfset pageParams = appendParam(pageParams,"_StartRow",attributes._Startrow)>
<cfset editParams = appendParam(pageParams,"id",attributes.id)>
<cfset stJoinedFields = StructNew()>
<!--- Set the complete list of Local Variables which can be used to populate the display. --->
<!--- The sequence can be rearranged to display the fields required in any order. --->
<cfparam name="variables.fieldlist" default="blog_name,date,entry_id,id,text,title,url,">
<cfset _joinedFieldlist="">
<cfif isDefined("onews_trackback")>
	<!--- Get variables from the object. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfif ListFindNoCase(_joinedFieldlist,thisField)>
			<cfset setvariable("variables.#thisField#", evaluate("onews_trackback.get" & stJoinedFields[thisField] & "().get" & thisField & "()"))>
		<cfelse>
			<cfset setvariable("variables.#thisField#", evaluate("onews_trackback.get" & thisField & "()"))>
		</cfif>
	</cfloop>
<cfelseif isDefined("stnews_trackback")>
	<!--- Copy variables from the structure. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfset setvariable("variables.#thisField#", stnews_trackback[thisField])>
	</cfloop>
<cfelseif isDefined("qnews_trackback")>
	<cfparam name="_recordNumber" default="1">
	<!--- Copy variables from the query. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfset setvariable("variables.#thisField#", qnews_trackback[thisField][_recordNumber])>
	</cfloop>
<cfelse>
	<!--- Copy variables from attributes scope. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfset setvariable("variables.#thisField#", attributes[thisField])>
	</cfloop>
</cfif>
</cfsilent>
<!--- Work out which fields to report as errors if any. --->
<cfset highlightfields = "">
<cfset aErrorMessages = arrayNew(1)>
<cfif isDefined("valid") AND ArrayLen(aErrors) GT 0 >
	<cfloop index="i" from="1" to="#arrayLen(aErrors)#">
		<cfset errorfield = ListGetAt(aErrors[i],2,".")>
		<cfif ListFindNoCase(fieldlist,errorfield)>
			<!--- Set fields to highlight --->
			<cfset highlightfields = ListAppend(highlightfields, errorfield)>
			<!--- Add to error messages --->
			<cfset ArrayAppend(aErrorMessages,aTranslatedErrors[i])>
		</cfif>
	</cfloop>
</cfif>
<!--- Start of the form --->
<cfoutput>
	<table width="590" border="0" cellpadding="2" cellspacing="2" summary="This table shows details of a single news_trackback record." class="">
		<!--- Show any Error Messages --->
		<!--- Errors from the validation. --->
		<cfif isDefined("valid") AND ArrayLen(aErrorMessages) GT 0 >
			<tr>
				<td colspan="2">
				<p class="standard">The following invalid entries were found, please 
				<a href="#self#?fuseaction=#XFA.edit#&Fuseaction_Id=#Fuseaction_Id#">go back and correct them</a> and resubmit.</p>
				<ul>
					<cfloop index="i" from="1" to="#arrayLen(aErrorMessages)#">
						<li class="highlight">#aErrorMessages[i]#</li>
					</cfloop>
				</ul>
				</td>
			</tr>
		</cfif>
		
		<cfloop list="#fieldlist#" index="thisField">
		  <cfswitch expression="#thisField#">
		    
			<cfcase value="blog_name">
				<tr>
				  <cfif ListFindNocase(highlightfields,'blog_name')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Blog name
					</th>
					<td>
						#Trim(variables.blog_name)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="date">
				<tr>
				  <cfif ListFindNocase(highlightfields,'date')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Date
					</th>
					<td>
						#Trim(variables.date)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="entry_id">
				<tr>
				  <cfif ListFindNocase(highlightfields,'entry_id')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Entry id
					</th>
					<td>
						#NumberFormat(variables.entry_id,"9.99")#
					</td>
				</tr>
			</cfcase>
			<cfcase value="id">
				<tr>
				  <cfif ListFindNocase(highlightfields,'id')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Id
					</th>
					<td>
						#NumberFormat(variables.id,"9.99")#
					</td>
				</tr>
			</cfcase>
			<cfcase value="text">
				<tr>
				  <cfif ListFindNocase(highlightfields,'text')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Text
					</th>
					<td>
						#Trim(variables.text)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="title">
				<tr>
				  <cfif ListFindNocase(highlightfields,'title')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Title
					</th>
					<td>
						#Trim(variables.title)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="url">
				<tr>
				  <cfif ListFindNocase(highlightfields,'url')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Url
					</th>
					<td>
						#Trim(variables.url)#
					</td>
				</tr>
			</cfcase>
			
		  </cfswitch>
		</cfloop>
		<cfif isDefined("XFA.list") OR isDefined("XFA.edit") OR isDefined("XFA.delete") OR isDefined("XFA.continue")>
		<tr>
			<td colspan="2">
				&nbsp;
			</th>
		</tr>
		</tr>
			<td align="left" colspan="2">
				<cfif isDefined("XFA.list")>[<a href="#self##appendParam(pageParams,"fuseaction",XFA.list)#">List</a>]</cfif>
				<cfif isDefined("XFA.edit")>[<a href="#self##appendParam(editParams,"fuseaction",XFA.edit)#">Edit</a>]</cfif>
				<cfif isDefined("XFA.delete")>[<a href="#self##appendParam(editParams,"fuseaction",XFA.delete)#">Delete</a>]</cfif>
				<cfif isDefined("XFA.continue")>[<a href="#self##appendParam(editParams,"fuseaction",XFA.continue)#">Continue</a>]</cfif>
			</td>
		</tr>
		</cfif>
	</table>
</cfoutput>