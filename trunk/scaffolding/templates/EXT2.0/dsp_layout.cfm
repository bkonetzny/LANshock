<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<cfset sModule = oMetaData.getModule()>>

<cfsavecontent variable="sHtmlHead">
	<cfoutput>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0/adapter/jquery/ext-jquery-adapter.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0/ext-all.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0/source/locale/ext-lang-#LCase(ListFirst(session.lang,'_'))#.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/menu/EditableItem.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/menu/RangeMenu.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/grid/GridFilters.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/form/DateTime.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/grid/filter/Filter.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/grid/filter/StringFilter.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/grid/filter/DateFilter.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/grid/filter/ListFilter.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/grid/filter/NumericFilter.js"></script>
		<script type="text/javascript" src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0-ux/grid/filter/BooleanFilter.js"></script>
		<script type="text/javascript">Ext.BLANK_IMAGE_URL = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/ext-2.0/resources/images/default/s.gif';</script>
	</cfoutput>
</cfsavecontent>

<cfhtmlhead text="#sHtmlHead#">

<cfoutput>
	<cfif StructKeyExists(request,'page') AND StructKeyExists(request.page,'objectName')>
		<h3>#request.content['__globalmodule__navigation__#request.page.objectName#_Listing']#</h3>
	</cfif>
	<cfif StructKeyExists(request,'page') AND StructKeyExists(request.page,'pageContent')>
		#request.page.pageContent#
	</cfif>
</cfoutput>