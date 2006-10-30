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
<cfparam name="attributes.category_id" default="0">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfif attributes.category_id NEQ 0>

	<cfparam name="attributes.name" default="#stCategories[attributes.category_id].name#">

</cfif>

<cfparam name="attributes.name" default="">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT len(attributes.name)) ArrayAppend(aError, request.content.title);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="news" method="setCategory">
			<cfinvokeargument name="id" value="#attributes.category_id#">
			<cfinvokeargument name="name" value="#attributes.name#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">