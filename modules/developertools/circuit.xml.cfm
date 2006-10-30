<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit access="public">

	<fuseaction name="main">
		<do action="language_main"/>
	</fuseaction>

	<!-- Show Language Chooser -->
	<fuseaction name="language_main">
		<include template="act_language_main.cfm"/>
		<include template="dsp_language_main.cfm"/>
	</fuseaction>

	<!-- Show Language Chooser -->
	<fuseaction name="sql_converter">
		<include template="act_sql_converter.cfm"/>
		<include template="dsp_sql_converter.cfm"/>
	</fuseaction>

	<!-- Show Language Chooser -->
	<fuseaction name="language_download">
		<include template="act_language_download.cfm"/>
	</fuseaction>

	<!-- Show Language Roles -->
	<fuseaction name="language_roles">
		<set name="check" value="#UDF_SecurityCheck(area='languagefiles_admin')#"/>
		<include template="act_language_roles.cfm"/>
		<include template="dsp_language_roles.cfm"/>
	</fuseaction>

	<!-- Show Language Editor -->
	<fuseaction name="language_editor">
		<include template="act_language_editor.cfm"/>
		<include template="dsp_language_editor.cfm"/>
	</fuseaction>

	<!-- Show Language Keys -->
	<fuseaction name="language_keys">
		<set name="check" value="#UDF_SecurityCheck(area='languagefiles_admin')#"/>
		<include template="act_language_keys.cfm"/>
		<include template="dsp_language_keys.cfm"/>
	</fuseaction>

	<!-- Show Key Comparison -->
	<fuseaction name="language_keys_comparison">
		<set name="check" value="#UDF_SecurityCheck(area='languagefiles_admin')#"/>
		<include template="act_language_keys_comparison.cfm"/>
		<include template="dsp_language_keys_comparison.cfm"/>
	</fuseaction>

	<!-- Set Language Defaults -->
	<fuseaction name="language_default">
		<set name="check" value="#UDF_SecurityCheck(area='languagefiles_admin')#"/>
		<include template="act_language_default.cfm"/>
	</fuseaction>

	<!-- Show Delete Language-File -->
	<fuseaction name="language_delete">
		<set name="check" value="#UDF_SecurityCheck(area='languagefiles_admin')#"/>
		<include template="act_language_delete.cfm"/>
	</fuseaction>

	<!-- Refresh Language-Cache -->
	<fuseaction name="language_refreshcache">
		<include template="act_language_refreshcache.cfm"/>
	</fuseaction>

</circuit>