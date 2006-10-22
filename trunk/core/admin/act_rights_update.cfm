<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stSecurityNew = StructNew()>
<cfloop collection="#attributes#" item="item">

	<cfif ListFirst(item,'_') EQ 'security'>
	
		<cfscript>
			sCurrentModule = ListDeleteAt(item,1,'_');
			stSecurityNew[sCurrentModule] = StructNew();
			stSecurityNew[sCurrentModule].areas = StructNew();
		</cfscript>
		
		<cfloop list="#attributes[item]#" index="idx">
			<cfset stSecurityNew[sCurrentModule].areas[idx] = true>
		</cfloop>
	
	</cfif>

</cfloop>

<cfinvoke component="admin" method="setAdminRights">
	<cfinvokeargument name="userid" value="#attributes.userid#">
	<cfinvokeargument name="security" value="#stSecurityNew#">
	<cfinvokeargument name="lastchange_by" value="#request.session.userid#">
</cfinvoke>

<cflocation url="#myself##myfusebox.thiscircuit#.admin&#request.session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">