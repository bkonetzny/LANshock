<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/mySettings.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.blog.model.cfc.news')#" method="getCategories" returnvariable="stCategories">

<cfsetting enablecfoutputonly="No">