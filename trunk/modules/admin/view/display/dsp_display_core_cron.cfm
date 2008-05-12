<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_display_core_cron.cfm,v $" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I display a single core_cron record from an object, a structure, a query or from attributes scope.
	</responsibilities>
	<properties>
		<history author="Kevin Roche" email="kevin@objectiveinternet.com" date="12-Mar-2008" role="Architect" type="Create" />
		<property name="copyright" value="(c)2008 Objective Internet Limited." />
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision: 205 $" />
		<property name="lastupdated" value="$Date: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) 2008/03/12 14:09:10 $" />
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
			
			<object name="ocore_cron" comments="The record object to be displayed." optional="Yes" />
			
			<structure name="stcore_cron" comments="Not used if ocore_cron is provided." optional="Yes" >
				
				<integer name="executions" />
				<integer name="id" />
				<datetime name="lastrun_dt" />
				<integer name="active" />
				<string name="action" />
				<string name="module" />
				<string name="result" />
				<string name="run" />
				<integer name="lastrun_time" />
				
			</structure>
			
			<number name="_recordNumber" precision="Integer" scope="variables"/>
			<recordset name="qcore_cron" primaryKeys="id" scope="variables" optional="Yes" comments="Recordset containing core_cron records " >
				<integer name="executions" />
				<integer name="id" />
				<datetime name="lastrun_dt" />
				<integer name="active" />
				<string name="action" />
				<string name="module" />
				<string name="result" />
				<string name="run" />
				<integer name="lastrun_time" />
				
				
			</recordset>
			
			<integer name="executions" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			<integer name="id" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			<datetime name="lastrun_dt" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			<integer name="active" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			<string name="action" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			<string name="module" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			<string name="result" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			<string name="run" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			<integer name="lastrun_time" scope="attributes" optional="Yes" comments="Not used if ocore_cron, stcore_cron or qcore_cron is provided." />
			
				
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
<cfparam name="variables.fieldlist" default="executions,id,lastrun_dt,active,action,module,result,run,lastrun_time,">
<cfset _joinedFieldlist="">
<cfif isDefined("ocore_cron")>
	<!--- Get variables from the object. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfif ListFindNoCase(_joinedFieldlist,thisField)>
			<cfset setvariable("variables.#thisField#", evaluate("ocore_cron.get" & stJoinedFields[thisField] & "().get" & thisField & "()"))>
		<cfelse>
			<cfset setvariable("variables.#thisField#", evaluate("ocore_cron.get" & thisField & "()"))>
		</cfif>
	</cfloop>
<cfelseif isDefined("stcore_cron")>
	<!--- Copy variables from the structure. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfset setvariable("variables.#thisField#", stcore_cron[thisField])>
	</cfloop>
<cfelseif isDefined("qcore_cron")>
	<cfparam name="_recordNumber" default="1">
	<!--- Copy variables from the query. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfset setvariable("variables.#thisField#", qcore_cron[thisField][_recordNumber])>
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
	<table width="590" border="0" cellpadding="2" cellspacing="2" summary="This table shows details of a single core_cron record." class="">
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
		    
			<cfcase value="executions">
				<tr>
				  <cfif ListFindNocase(highlightfields,'executions')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Executions
					</th>
					<td>
						#NumberFormat(variables.executions,"9.99")#
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
			<cfcase value="lastrun_dt">
				<tr>
				  <cfif ListFindNocase(highlightfields,'lastrun_dt')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Lastrun dt
					</th>
					<td>
						#Trim(variables.lastrun_dt)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="active">
				<tr>
				  <cfif ListFindNocase(highlightfields,'active')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Active
					</th>
					<td>
						#NumberFormat(variables.active,"9.99")#
					</td>
				</tr>
			</cfcase>
			<cfcase value="action">
				<tr>
				  <cfif ListFindNocase(highlightfields,'action')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Action
					</th>
					<td>
						#Trim(variables.action)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="module">
				<tr>
				  <cfif ListFindNocase(highlightfields,'module')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Module
					</th>
					<td>
						#Trim(variables.module)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="result">
				<tr>
				  <cfif ListFindNocase(highlightfields,'result')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Result
					</th>
					<td>
						#Trim(variables.result)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="run">
				<tr>
				  <cfif ListFindNocase(highlightfields,'run')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Run
					</th>
					<td>
						#Trim(variables.run)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="lastrun_time">
				<tr>
				  <cfif ListFindNocase(highlightfields,'lastrun_time')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Lastrun time
					</th>
					<td>
						#NumberFormat(variables.lastrun_time,"9.99")#
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
