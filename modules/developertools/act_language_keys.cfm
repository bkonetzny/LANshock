<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.file" default="">
<cfparam name="attributes.directory" default="">

<cfset attributes.langFile = application.lanshock.environment.abspath & attributes.directory & attributes.file>

<cfif len(attributes.file) AND (NOT len(attributes.langFile) OR NOT FileExists(attributes.langFile))>
	<cflocation url="#myself##myfusebox.thiscircuit#.language_main&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif attributes.form_submitted>
	
	<cfif len(attributes.file)>

		<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
			<cfinvokeargument name="rbFile" value="#attributes.langFile#">
		</cfinvoke>

		<cfset stNewRB = StructNew()>
		<cfloop list="#ListSort(attributes.lang_keys,'textnocase','ASC',chr(13))#" delimiters="#chr(13)#" index="idx">
			<cfset currentKey = trim(Lcase(idx))>
			<cfif len(currentKey)>
				<cfparam name="stRB['#currentKey#']" default="">
				<cfset stNewRB[currentKey] = stRB[currentKey]>
			</cfif>
		</cfloop>

		<cfset newTXT = '## generated by: LANshock Developer Tools' & chr(13) & '## generated at: #now()#' & chr(13) & '## please do not modify this file yourself - use the developer tools for changes' & chr(13)>
		<cfloop list="#ListSort(StructKeyList(stNewRB),'textnocase')#" index="idx">
			<cfset newTXT = newTXT & Lcase(idx) & '=' & stNewRB[idx] & chr(13)>
		</cfloop>

	<cfelseif len(attributes.directory)>
	
		<cfset newTXT = '## generated by: LANshock Developer Tools' & chr(13) & '## generated at: #now()#' & chr(13) & '## please do not modify this file yourself - use the developer tools for changes' & chr(13)>
		<cfloop list="#ListSort(attributes.lang_keys,'textnocase','ASC',chr(13))#" index="idx">
			<cfset newTXT = newTXT & Lcase(idx) & '=' & chr(13)>
		</cfloop>
		<cfset attributes.langFile = application.lanshock.environment.abspath & attributes.directory & 'lang.#attributes.newLanguage#.properties'>

	</cfif>

	<cffile action="write" file="#attributes.langFile#" output="#newTXT#">

	<cflocation url="#myself##myfusebox.thiscircuit#.language_editor&directory=#UrlEncodedFormat(attributes.directory)#&file=#listlast(attributes.langFile,'\/')#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfset attributes.langFileDefault = ''>

<cfif len(attributes.file)>

	<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
		<cfinvokeargument name="rbFile" value="#attributes.langFile#">
	</cfinvoke>
	
	<cfset sKeys = ''>
	<cfloop list="#ListSort(StructKeyList(stRB),'textnocase')#" index="idx">
		<cfset sKeys = sKeys & Lcase(idx) & chr(13)>
	</cfloop>
	
	<cfparam name="attributes.lang_keys" default="#sKeys#">

<cfelse>

	<cfset fileDefault = application.lanshock.environment.abspath & attributes.directory & 'lang.default'>
	
	<cfif FileExists(fileDefault)>
		<cffile action="read" file="#fileDefault#" variable="langDefaults">
		<cfset attributes.langFileDefault = application.lanshock.environment.abspath & attributes.directory & langDefaults>
	</cfif>
		
	<cfif len(attributes.langFileDefault)>
		<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
			<cfinvokeargument name="rbFile" value="#attributes.langFileDefault#">
		</cfinvoke>
		
		<cfset sKeys = ''>
		<cfloop list="#ListSort(StructKeyList(stRB),'textnocase')#" index="idx">
			<cfset sKeys = sKeys & Lcase(idx) & chr(13)>
		</cfloop>
		
		<cfparam name="attributes.lang_keys" default="#sKeys#">
	<cfelse>
		<cfparam name="attributes.lang_keys" default="sample_key_one#chr(13)#sample_key_two#chr(13)#sample_key_three">
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">