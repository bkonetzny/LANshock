<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="news" method="deleteNews">
	<cfinvokeargument name="id" value="#attributes.news_id#">
</cfinvoke>
	
<cflocation url="#myself##myfusebox.thiscircuit#.news_edit&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">

