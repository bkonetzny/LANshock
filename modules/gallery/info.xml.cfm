<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="Gallery" version="1.0.3.0" date="2006-08-20" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="general_settings" reqstatus="admin"/>
	</navigation>
	
	<dependencies>
		<filesystem folder="galleries"/>
	</dependencies>
	
	<security>
		<area name="configure"/>
		<area name="edit"/>
		<area name="delete"/>
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
			<index name="id" value=""/>
		</table>
		<table name="gallery_item">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="gallery_id" type="integer" len="11" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" null="false" default=""/>
			<field name="filename" type="varchar" len="255" null="false" default=""/>
			<field name="dt_created" type="datetime" null="false" default="0000-00-00 00:00:00"/>
			<field name="metadata" type="text" null="false" default=""/>
			<index name="id" value=""/>
		</table>
	</database>

</module>