<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="tournaments" method="removeGroup">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cflocation url="#myself##myfusebox.thiscircuit#.groups_edit&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">