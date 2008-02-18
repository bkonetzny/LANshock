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
<cfparam name="attributes.directory" default="">

<cfset fileDefault = application.lanshock.environment.abspath & attributes.directory & 'lang.default'>
<cfset langDefaults = ''>

<cfif FileExists(fileDefault)>
	<cffile action="read" file="#fileDefault#" variable="langDefaults">
	<cfset langDefaults = trim(langDefaults)>
	<cfset langFileDefault = application.lanshock.environment.abspath & attributes.directory & langDefaults>
	<cfif NOT FileExists(langFileDefault)>
		<cfset langDefaults = ''>
	</cfif>
</cfif>

<cfif NOT len(langDefaults)>
	<cflocation url="#myself##myfusebox.thiscircuit#.language_main&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif attributes.form_submitted>

	<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
		<cfinvokeargument name="rbFile" value="#langFileDefault#">
	</cfinvoke>
	
	<cfset lDefaultKeylist = StructKeyList(stRB)>
	
	<cfdirectory action="list" directory="#application.lanshock.environment.abspath##attributes.directory#" name="qDir" filter="*.properties">

	<cfloop query="qDir">
	
		<cfset langFile = application.lanshock.environment.abspath & attributes.directory & name>
	
		<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
			<cfinvokeargument name="rbFile" value="#langFile#">
		</cfinvoke>

		<cfset stNewRB = StructNew()>
		<cfloop list="#ListSort(lDefaultKeylist,'textnocase','ASC')#" index="idx">
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

		<cffile action="write" file="#langFile#" output="#newTXT#">

	</cfloop>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.language_main&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfset stFiles = StructNew()>
<cfdirectory action="list" directory="#application.lanshock.environment.abspath##attributes.directory#" name="qDir" filter="*.properties">

<cfloop query="qDir">

	<cfset variables.langFile = application.lanshock.environment.abspath & attributes.directory & name>

	<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
		<cfinvokeargument name="rbFile" value="#variables.langFile#">
	</cfinvoke>

	<cfscript>
		stFiles[name] = StructCount(stRB);
	</cfscript>
</cfloop>



<cfsetting enablecfoutputonly="No">