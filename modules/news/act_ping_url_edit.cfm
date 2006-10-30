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
<cfparam name="attributes.ping_id" default="0">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfscript>
	qPingUrls = objectBreeze.list("news_ping_url", 'name ASC').getQuery();
	
	oObPingUrl = objectBreeze.objectCreate("news_ping_url");
	oObPingUrl.read(attributes.ping_id);
</cfscript>

<cfloop list="#oObPingUrl.getPropertyNames()#" index="idx">
	<cfparam name="attributes[idx]" default="#oObPingUrl.getProperty(idx)#">
</cfloop>

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT len(attributes.name)) ArrayAppend(aError, '<!--- TODO: $$$ ---> Name');
		if(NOT len(attributes.url)) ArrayAppend(aError, '<!--- TODO: $$$ ---> URL');
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
		
		<cfscript>
			oObPingUrl.setProperty('name',attributes.name);
			oObPingUrl.setProperty('url',attributes.url);
			oObPingUrl.commit();
		</cfscript>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">