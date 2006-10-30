<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="Developer Tools" version="0.2.0.0" date="2006-07-16" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="true"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="language_main"/>
		<item action="language_roles"/>
		<item action="sql_converter"/>
	</navigation>
	
	<security>
		<area name="languagefiles_admin"/>
		<area name="languagefiles_roles"/>
	</security>
	
	<database>
		<table name="developertools_languagefiles_roles">
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="language" type="varchar" len="255" null="false" default=""/>
			<index name="user_id,language" value=""/>
		</table>
		<table name="developertools_languagefiles_log">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="directory" type="varchar" len="255" null="false" default=""/>
			<field name="file" type="varchar" len="255" null="false" default=""/>
			<field name="content" type="text" null="false" default=""/>
			<field name="dt_changed" type="datetime" null="false" default="0000-00-00 00:00:00"/>
			<index name="id" value=""/>
		</table>
	</database>

</module>