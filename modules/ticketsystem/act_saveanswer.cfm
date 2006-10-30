<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif request.session.isAdmin>

	<cfinvoke component="tickets" method="updateTicket" argumentcollection="#attributes#">

</cfif>

<cflocation url="#myself##myfusebox.thiscircuit#.details&id=#attributes.id#&#request.session.urltoken#" addtoken="no">

<cfsetting enablecfoutputonly="No">