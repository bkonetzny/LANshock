<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="Gallery" version="2.0.0.0 beta" date="2006-08-20" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="general_settings" permissions="config"/>
	</navigation>
	
	<dependencies>
		<filesystem folder="galleries"/>
	</dependencies>
	
	<security>
		<area name="configure"/>
		<area name="edit"/>
		<area name="delete"/>
		<permissions list="config,edit-self,edit-all,delete-self,delete-all"/>
		<role name="Gallery Admin" permissions="config,edit-self,edit-all,delete-self,delete-all"/>
		<role name="Gallery User" permissions="edit-self,delete-self"/>
	</security>
	
	<database>
		<table name="gallery">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" null="false" default=""/>
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="visible" type="boolean" null="false" default="1"/>
			<field name="dt_created" type="datetime" null="false" default="0000-00-00 00:00:00"/>
			<field name="tn" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
			<fk field="user_id" mapping="user.id"/>
			<index name="IDX_visible" fields="visible"/>
		</table>
		<table name="gallery_item">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="gallery_id" type="integer" len="11" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" null="false" default=""/>
			<field name="filename" type="varchar" len="255" null="false" default=""/>
			<field name="dt_created" type="datetime" null="false" default="0000-00-00 00:00:00"/>
			<field name="metadata" type="text" null="false" default=""/>
			<pk fields="id"/>
			<fk field="gallery_id" mapping="gallery.id"/>
		</table>
	</database>

</module>