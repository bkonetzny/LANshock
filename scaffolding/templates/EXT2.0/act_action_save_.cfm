<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<cfset stFields.aTable = oMetaData.getFieldsFromXML(objectName)>>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<cfset aManyToMany = oMetaData.getRelationshipsFromXML(objectName,"manyToMany")>>
<<cfset sModule = oMetaData.getModule()>>

<<cfoutput>>
	<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>

	<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/controller/form/act_action_save_prevalidation_$$objectName$$.cfm")>>
		<cfinclude template="act_action_save_prevalidation_$$objectName$$.cfm">
	<</cfif>>

	<<cfloop from="1" to="$$ArrayLen(stFields['aTable'])$$" index="i">>
		<<cfmodule template="../templates/EXT2.0/rowtypes/rowtype.cfm" rowtype="$$stFields['aTable'][i].formType$$" method="validation_pre">>
	<</cfloop>>

	<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/controller/form/act_action_save_postvalidation_$$objectName$$.cfm")>>
		<cfinclude template="act_action_save_postvalidation_$$objectName$$.cfm">
	<</cfif>>

	<cfparam name="attributes.$$objectName$$_id" default="0">
	<cfset o$$objectName$$ = application.lanshock.oFactory.load('$$objectName$$','reactorRecord')>

	<cfif variables.mode EQ 'insert'>
		<<cfloop list="$$lFields$$" index="thisField">><<cfif NOT ListFindNoCase(lPKFields,thisField)>>
		<cfset o$$objectName$$.set$$thisField$$(attributes.$$thisField$$)><</cfif>><</cfloop>>
	<cfelse>
		<<cfloop list="$$lFields$$" index="thisField">>
		<cfset o$$objectName$$.set$$thisField$$(attributes.$$thisField$$)><</cfloop>>
	</cfif>
	
	<cfset o$$objectName$$.validate()>
	<cfif o$$objectName$$.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	<<cfloop from="1" to="$$ArrayLen(aManyToMany)$$" index="i">>
	<cfif NOT bHasErrors>
		<cfset o$$aManyToMany[i].name$$iterator = o$$objectName$$.get$$aManyToMany[i].name$$iterator()>
		<cfset o$$aManyToMany[i].name$$iterator.deleteAll()>
		<cfif StructKeyExists(attributes,'$$aManyToMany[i].name$$')>
			<cfloop list="#attributes.$$aManyToMany[i].name$$#" index="idx">
				<cfset o$$aManyToMany[i].name$$iterator.add($$aManyToMany[i].links[1].to$$ = o$$objectName$$.get$$lPKFields$$(), $$aManyToMany[i].links[1].name$$ = idx)>
			</cfloop>
		</cfif>
		<cfset o$$aManyToMany[i].name$$iterator.validate()>
		<cfif o$$aManyToMany[i].name$$iterator.hasErrors()>
			<cfset bHasErrors = true>
		</cfif>
	</cfif>
	<</cfloop>>

	<cfif NOT bHasErrors>
		<cfset o$$objectName$$.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_$$objectName$$.cfm">
		<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/controller/form/act_form_loadrelated_custom_$$objectName$$.cfm")>>
			<cfinclude template="act_form_loadrelated_custom_$$objectName$$.cfm">
		<</cfif>>

		<cfset aReactorErrors = o$$objectName$$._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = o$$objectName$$._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_$$objectName$$.cfm">
		</cfsavecontent>
	</cfif>
<</cfoutput>>