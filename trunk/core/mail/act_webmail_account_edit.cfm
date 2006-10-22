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
<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.id" default="">

<cfscript>
	oObAccount = objectBreeze.objectCreate("core_mail_webmail");
	if(isNumeric(attributes.id)) oObAccount.read(attributes.id);
</cfscript>

<cfloop list="#oObAccount.getPropertyNames()#" index="idx">
	<cfparam name="attributes[idx]" default="#oObAccount.getProperty(idx)#">
</cfloop>

<cfif NOT len(attributes.port)>
	<cfset attributes.port = 110>
</cfif>

<cfif NOT len(attributes.isactive)>
	<cfset attributes.isactive = 0>
</cfif>

<cfif attributes.form_submitted>

	<cfif NOT ArrayLen(aError)>
	
		<cfloop list="#oObAccount.getPropertyNames()#" index="idx">
			<cfif StructKeyExists(attributes,idx)>
				<cfset oObAccount.setProperty(idx,attributes[idx])>
			</cfif>
		</cfloop>
		<cfset oObAccount.setProperty('user_id',request.session.userid)>

		<cfset oObAccount.commit()>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.webmail&#request.session.urltoken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">