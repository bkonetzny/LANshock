<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->
<module name="Content Module" version="2.0.0.0" date="2008-07-14" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="content_content_listing" permissions="content_content"/>
	</navigation>
	
	<security>
		<permissions list="content_content"/>
		<role name="Content Admin" permissions="content_content"/>
	</security>
	
	<database>
		<table name="content_content">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="codename" type="varchar" len="255" null="false" special=""/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="content" type="text" null="false" default=""/>
			<field name="user_id" type="integer" len="11" default="0"/>
			<field name="dtcreated" type="datetime" null="true" default="NULL"/>
			<field name="dtchanged" type="datetime" null="true" default="NULL"/>
			<field name="bactive" type="boolean" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="user_id" mapping="user.id" type="manyToOne"/>
			<index name="IDX_codename" fields="codename"/>
			<index name="IDX_bactive" fields="bactive"/>
		</table>
	</database>
	
	<special>
		<scaffolding>
			<table name="content_content">
				<list fields="id,title,user_id,dtchanged,bactive,codename" sortDefault="title ASC"/>
				<form fields="id,title,content,bactive,codename">
					<field name="content" formType="FckEditor"/>
				</form>
			</table>
		</scaffolding>
	</special>
</module>