<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_admin.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfinvoke component="admin" method="getAdmins" returnvariable="qAdmins"/>

<cfset stAdmins = StructNew()>

<cfloop query="qAdmins">

	<cfwddx action="wddx2cfml" input="#security#" output="stSecurity">
	
	<cfscript>
		stAdmins[name] = StructNew();
		stAdmins[name].id = id;
		stAdmins[name].admin_id = admin_id;
		stAdmins[name].security = StructNew();
	</cfscript>
	
	<cfloop collection="#stSecurity#" item="item">
			
		<cfscript>
			bRightFalse = false;
			bRightTrue = false;
		</cfscript>
	
		<cfloop collection="#stSecurity[item].areas#" item="item2">
		
			<cfscript>
				if(stSecurity[item].areas[item2]) bRightTrue = true;
				else bRightFalse = true;
			</cfscript>
		
		</cfloop>
			
		<cfscript>
			if(bRightFalse AND bRightTrue) stAdmins[name].security[item] = 0;
			else if(bRightTrue) stAdmins[name].security[item] = 1;
			else stAdmins[name].security[item] = 2;
		</cfscript>
	
	</cfloop>

</cfloop>
	
<cfsetting enablecfoutputonly="No">