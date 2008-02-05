<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_rights_update.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
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
	<cfinvokeargument name="lastchange_by" value="#session.userid#">
</cfinvoke>

<cflocation url="#myself##myfusebox.thiscircuit#.admin&#session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">