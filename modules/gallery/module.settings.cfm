<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/gallery/mySettings.cfm $
$LastChangedDate: 2006-10-30 23:40:53 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 64 $
--->

<cfscript>
	stConfig = StructNew();
	stConfig.iVersion = "1.0";
	stConfig.stSettings = StructNew();
	stConfig.stSettings.item = StructNew();
	stConfig.stSettings.item.max_width = 640;
	stConfig.stSettings.item.max_height = 640;
	stConfig.stSettings.tn = StructNew();
	stConfig.stSettings.tn.max_width = 160;
	stConfig.stSettings.tn.max_height = 120;
	stConfig.stSettings.items_per_col = 4;
</cfscript>

<cfsetting enablecfoutputonly="No">