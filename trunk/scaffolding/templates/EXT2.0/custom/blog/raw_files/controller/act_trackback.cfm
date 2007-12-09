<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/act_trackback.cfm $
$LastChangedDate: 2007-07-08 12:12:25 +0200 (So, 08 Jul 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 94 $
--->

<cfparam name="attributes.blog_name" default="">
<cfparam name="attributes.title" default="">
<cfparam name="attributes.excerpt" default="">
<cfparam name="attributes.url" default="">

<cfparam name="attributes.entry_id" default="">
<cfparam name="aError" default="#ArrayNew(1)#">

<!--- <cfscript>
	if(NOT len(attributes.url)) ArrayAppend(aError, '<!-- TODO: $$$ --> URL required.');
	if(NOT len(attributes.entry_id) OR NOT isNumeric(attributes.entry_id)) ArrayAppend(aError, '<!-- TODO: $$$ --> No Entry defined.');
</cfscript> --->

<!--- due to comment spam, disable trackbacks until a secure way is found --->
<cfset ArrayAppend(aError, 'Trackbacks are disabled.')>

<cfif NOT ArrayLen(aError)>
	<cfscript>
		oObTrackback = objectBreeze.objectCreate("news_trackback");
		oObTrackback.setProperty('entry_id',attributes.entry_id);
		oObTrackback.setProperty('blog_name',attributes.blog_name);
		oObTrackback.setProperty('title',attributes.title);
		oObTrackback.setProperty('text',attributes.excerpt);
		oObTrackback.setProperty('url',attributes.url);
		oObTrackback.setProperty('date',now());
		oObTrackback.commit();
	</cfscript>
	
	<cfxml variable="sXmlResponse">
		<response>
		<error>0</error>
		</response>
	</cfxml>
<cfelse>
	<cfxml variable="sXmlResponse">
		<cfoutput>
		<response>
		<error>1</error>
		<message><cfloop from="1" to="#ArrayLen(aError)#" index="idx">#aError[idx]# </cfloop></message>
		</response>
		</cfoutput>
	</cfxml>
</cfif>

<cfsetting enablecfoutputonly="No">