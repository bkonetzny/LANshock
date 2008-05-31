<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_display_content_content.cfm,v $" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I display a single content_content record from an object, a structure, a query or from attributes scope.
	</responsibilities>
	<properties>
		<history author="Kevin Roche" email="kevin@objectiveinternet.com" date="14-May-2008" role="Architect" type="Create" />
		<property name="copyright" value="(c)2008 Objective Internet Limited." />
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision: 205 $" />
		<property name="lastupdated" value="$Date: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) 2008/05/14 23:46:44 $" />
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
			
			<object name="ocontent_content" comments="The record object to be displayed." optional="Yes" />
			
			<structure name="stcontent_content" comments="Not used if ocontent_content is provided." optional="Yes" >
				
				<integer name="id" />
				<string name="title" />
				<string name="content" />
				<integer name="user_id" />
				<datetime name="dtcreated" />
				<datetime name="dtchanged" />
				<integer name="bactive" />
				<string name="codename" />
				
				<integer name="id" />
				<string name="name" />
				<string name="email" />
				<string name="pwd" />
				<string name="firstname" />
				<string name="lastname" />
				<integer name="gender" />
				<string name="status" />
				<string name="signature" />
				<string name="homepage" />
				<string name="internal_note" />
				<datetime name="dt_birthdate" />
				<datetime name="dt_lastlogin" />
				<datetime name="dt_registered" />
				<string name="language" />
				<string name="country" />
				<string name="city" />
				<string name="street" />
				<string name="zip" />
				<integer name="logincount" />
				<string name="reset_password_key" />
				<string name="openid_url" />
				<string name="geo_latlong" />
			</structure>
			
			<number name="_recordNumber" precision="Integer" scope="variables"/>
			<recordset name="qcontent_content" primaryKeys="id" scope="variables" optional="Yes" comments="Recordset containing content_content records " >
				<integer name="id" />
				<string name="title" />
				<string name="content" />
				<integer name="user_id" />
				<datetime name="dtcreated" />
				<datetime name="dtchanged" />
				<integer name="bactive" />
				<string name="codename" />
				
				<integer name="id" />
				<string name="name" />
				<string name="email" />
				<string name="pwd" />
				<string name="firstname" />
				<string name="lastname" />
				<integer name="gender" />
				<string name="status" />
				<string name="signature" />
				<string name="homepage" />
				<string name="internal_note" />
				<datetime name="dt_birthdate" />
				<datetime name="dt_lastlogin" />
				<datetime name="dt_registered" />
				<string name="language" />
				<string name="country" />
				<string name="city" />
				<string name="street" />
				<string name="zip" />
				<integer name="logincount" />
				<string name="reset_password_key" />
				<string name="openid_url" />
				<string name="geo_latlong" />
				
			</recordset>
			
			<integer name="id" scope="attributes" optional="Yes" comments="Not used if ocontent_content, stcontent_content or qcontent_content is provided." />
			<string name="title" scope="attributes" optional="Yes" comments="Not used if ocontent_content, stcontent_content or qcontent_content is provided." />
			<string name="content" scope="attributes" optional="Yes" comments="Not used if ocontent_content, stcontent_content or qcontent_content is provided." />
			<integer name="user_id" scope="attributes" optional="Yes" comments="Not used if ocontent_content, stcontent_content or qcontent_content is provided." />
			<datetime name="dtcreated" scope="attributes" optional="Yes" comments="Not used if ocontent_content, stcontent_content or qcontent_content is provided." />
			<datetime name="dtchanged" scope="attributes" optional="Yes" comments="Not used if ocontent_content, stcontent_content or qcontent_content is provided." />
			<integer name="bactive" scope="attributes" optional="Yes" comments="Not used if ocontent_content, stcontent_content or qcontent_content is provided." />
			<string name="codename" scope="attributes" optional="Yes" comments="Not used if ocontent_content, stcontent_content or qcontent_content is provided." />
			
			<string name="name" />
			<string name="email" />
			<string name="pwd" />
			<string name="firstname" />
			<string name="lastname" />
			<numeric name="gender" />
			<string name="status" />
			<string name="signature" />
			<string name="homepage" />
			<string name="internal_note" />
			<date name="dt_birthdate" />
			<date name="dt_lastlogin" />
			<date name="dt_registered" />
			<string name="language" />
			<string name="country" />
			<string name="city" />
			<string name="street" />
			<string name="zip" />
			<numeric name="logincount" />
			<string name="reset_password_key" />
			<string name="openid_url" />
			<string name="geo_latlong" />
				
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
<cfset stJoinedFields["id"] = "user">
<cfset stJoinedFields["name"] = "user">
<cfset stJoinedFields["email"] = "user">
<cfset stJoinedFields["pwd"] = "user">
<cfset stJoinedFields["firstname"] = "user">
<cfset stJoinedFields["lastname"] = "user">
<cfset stJoinedFields["gender"] = "user">
<cfset stJoinedFields["status"] = "user">
<cfset stJoinedFields["signature"] = "user">
<cfset stJoinedFields["homepage"] = "user">
<cfset stJoinedFields["internal_note"] = "user">
<cfset stJoinedFields["dt_birthdate"] = "user">
<cfset stJoinedFields["dt_lastlogin"] = "user">
<cfset stJoinedFields["dt_registered"] = "user">
<cfset stJoinedFields["language"] = "user">
<cfset stJoinedFields["country"] = "user">
<cfset stJoinedFields["city"] = "user">
<cfset stJoinedFields["street"] = "user">
<cfset stJoinedFields["zip"] = "user">
<cfset stJoinedFields["logincount"] = "user">
<cfset stJoinedFields["reset_password_key"] = "user">
<cfset stJoinedFields["openid_url"] = "user">
<cfset stJoinedFields["geo_latlong"] = "user">
<!--- Set the complete list of Local Variables which can be used to populate the display. --->
<!--- The sequence can be rearranged to display the fields required in any order. --->
<cfparam name="variables.fieldlist" default="id,title,content,user_id,dtcreated,dtchanged,bactive,codename,id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,language,country,city,street,zip,logincount,reset_password_key,openid_url,geo_latlong">
<cfset _joinedFieldlist="id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,language,country,city,street,zip,logincount,reset_password_key,openid_url,geo_latlong">
<cfif isDefined("ocontent_content")>
	<!--- Get variables from the object. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfif ListFindNoCase(_joinedFieldlist,thisField)>
			<cfset setvariable("variables.#thisField#", evaluate("ocontent_content.get" & stJoinedFields[thisField] & "().get" & thisField & "()"))>
		<cfelse>
			<cfset setvariable("variables.#thisField#", evaluate("ocontent_content.get" & thisField & "()"))>
		</cfif>
	</cfloop>
<cfelseif isDefined("stcontent_content")>
	<!--- Copy variables from the structure. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfset setvariable("variables.#thisField#", stcontent_content[thisField])>
	</cfloop>
<cfelseif isDefined("qcontent_content")>
	<cfparam name="_recordNumber" default="1">
	<!--- Copy variables from the query. --->
	<cfloop list="#fieldlist#" index="thisField">
		<cfset setvariable("variables.#thisField#", qcontent_content[thisField][_recordNumber])>
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
	<table width="590" border="0" cellpadding="2" cellspacing="2" summary="This table shows details of a single content_content record." class="">
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
						#NumberFormat(variables.id,"9")#
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
			<cfcase value="content">
				<tr>
				  <cfif ListFindNocase(highlightfields,'content')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Content
					</th>
					<td>
						#Trim(variables.content)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="user_id">
				<tr>
				  <cfif ListFindNocase(highlightfields,'user_id')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						User id
					</th>
					<td>
						#NumberFormat(variables.user_id,"9.99")#
					</td>
				</tr>
			</cfcase>
			<cfcase value="dtcreated">
				<tr>
				  <cfif ListFindNocase(highlightfields,'dtcreated')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Dtcreated
					</th>
					<td>
						#LSDateFormat(variables.dtcreated)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="dtchanged">
				<tr>
				  <cfif ListFindNocase(highlightfields,'dtchanged')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Dtchanged
					</th>
					<td>
						#LSDateFormat(variables.dtchanged)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="bactive">
				<tr>
				  <cfif ListFindNocase(highlightfields,'bactive')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Bactive
					</th>
					<td>
						#NumberFormat(variables.bactive,"9")#
					</td>
				</tr>
			</cfcase>
			<cfcase value="codename">
				<tr>
				  <cfif ListFindNocase(highlightfields,'codename')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Codename
					</th>
					<td>
						#Trim(variables.codename)#
					</td>
				</tr>
			</cfcase>
			
			<cfcase value="name">
				<tr>
				  <cfif ListFindNocase(highlightfields,'name')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Name
					</th>
					<td>
						#Trim(variables.name)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="email">
				<tr>
				  <cfif ListFindNocase(highlightfields,'email')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Email
					</th>
					<td>
						#Trim(variables.email)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="pwd">
				<tr>
				  <cfif ListFindNocase(highlightfields,'pwd')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Pwd
					</th>
					<td>
						#Trim(variables.pwd)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="firstname">
				<tr>
				  <cfif ListFindNocase(highlightfields,'firstname')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Firstname
					</th>
					<td>
						#Trim(variables.firstname)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="lastname">
				<tr>
				  <cfif ListFindNocase(highlightfields,'lastname')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Lastname
					</th>
					<td>
						#Trim(variables.lastname)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="gender">
				<tr>
				  <cfif ListFindNocase(highlightfields,'gender')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Gender
					</th>
					<td>
						#NumberFormat(variables.gender,"9.99")#
					</td>
				</tr>
			</cfcase>
			<cfcase value="status">
				<tr>
				  <cfif ListFindNocase(highlightfields,'status')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Status
					</th>
					<td>
						#Trim(variables.status)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="signature">
				<tr>
				  <cfif ListFindNocase(highlightfields,'signature')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Signature
					</th>
					<td>
						#Trim(variables.signature)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="homepage">
				<tr>
				  <cfif ListFindNocase(highlightfields,'homepage')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Homepage
					</th>
					<td>
						#Trim(variables.homepage)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="internal_note">
				<tr>
				  <cfif ListFindNocase(highlightfields,'internal_note')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						internal_note
					</th>
					<td>
						#Trim(variables.internal_note)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="dt_birthdate">
				<tr>
				  <cfif ListFindNocase(highlightfields,'dt_birthdate')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Dt birthdate
					</th>
					<td>
						#Trim(variables.dt_birthdate)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="dt_lastlogin">
				<tr>
				  <cfif ListFindNocase(highlightfields,'dt_lastlogin')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Dt lastlogin
					</th>
					<td>
						#Trim(variables.dt_lastlogin)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="dt_registered">
				<tr>
				  <cfif ListFindNocase(highlightfields,'dt_registered')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Dt registered
					</th>
					<td>
						#Trim(variables.dt_registered)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="language">
				<tr>
				  <cfif ListFindNocase(highlightfields,'language')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Language
					</th>
					<td>
						#Trim(variables.language)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="country">
				<tr>
				  <cfif ListFindNocase(highlightfields,'country')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Country
					</th>
					<td>
						#Trim(variables.country)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="city">
				<tr>
				  <cfif ListFindNocase(highlightfields,'city')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						City
					</th>
					<td>
						#Trim(variables.city)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="street">
				<tr>
				  <cfif ListFindNocase(highlightfields,'street')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Street
					</th>
					<td>
						#Trim(variables.street)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="zip">
				<tr>
				  <cfif ListFindNocase(highlightfields,'zip')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Zip
					</th>
					<td>
						#Trim(variables.zip)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="logincount">
				<tr>
				  <cfif ListFindNocase(highlightfields,'logincount')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Logincount
					</th>
					<td>
						#NumberFormat(variables.logincount,"9.99")#
					</td>
				</tr>
			</cfcase>
			<cfcase value="reset_password_key">
				<tr>
				  <cfif ListFindNocase(highlightfields,'reset_password_key')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Reset password key
					</th>
					<td>
						#Trim(variables.reset_password_key)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="openid_url">
				<tr>
				  <cfif ListFindNocase(highlightfields,'openid_url')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Openid url
					</th>
					<td>
						#Trim(variables.openid_url)#
					</td>
				</tr>
			</cfcase>
			<cfcase value="geo_latlong">
				<tr>
				  <cfif ListFindNocase(highlightfields,'geo_latlong')>
					<th align="left" class="highlight">
				  <cfelse>
					<th align="left" class="standard">
				  </cfif>
						Geo latlong
					</th>
					<td>
						#Trim(variables.geo_latlong)#
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
