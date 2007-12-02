<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_core_config.post.inc.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<!--- set config --->
<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="setConfig">
	<cfinvokeargument name="module" value="__core_runtime">
	<cfinvokeargument name="data" value="#stModuleConfigNew#">
</cfinvoke>
	
<cflocation url="#myself##myfusebox.thiscircuit#.core_config&#request.session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">