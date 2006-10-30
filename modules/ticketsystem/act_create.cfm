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

<cfparam name="attributes.title" default="">
<cfparam name="attributes.problem" default="">

<cfif attributes.form_submitted>

	<cfparam name="val_error" default="">

	<cfscript>
		if(NOT len(attributes.title)) val_error = "title";
		if(NOT len(attributes.problem)) val_error = "problem";
	</cfscript>
	
	<cfif NOT len(val_error)>
	
		<cfinvoke component="tickets" method="createTicket">
			<cfinvokeargument name="userid" value="#request.session.userid#">
			<cfinvokeargument name="title" value="#attributes.title#">
			<cfinvokeargument name="problem" value="#attributes.problem#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.ticketlist&#request.session.urltoken#" addtoken="no">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">