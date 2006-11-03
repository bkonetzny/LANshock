<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="LANshock User" version="1.4.0.0" date="2006-03-06" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="true"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="login" reqstatus="notloggedin"/>
		<item action="userdetails"/>
		<item action="logout"/>
	</navigation>
	
	<dependencies>
		<filesystem folder="avatar"/>
	</dependencies>
	
	<security>
		<area name="history"/>
	</security>
	
	<database>
		<table name="user">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="email" type="varchar" len="255" null="false" default=""/>
			<field name="pwd" type="varchar" len="255" null="false" default=""/>
			<field name="firstname" type="varchar" len="255" null="false" default=""/>
			<field name="lastname" type="varchar" len="255" null="false" default=""/>
			<field name="gender" type="boolean" null="false" default="0"/>
			<field name="idcardnumber" type="varchar" len="255" null="false" default=""/>
			<field name="profile_verified" type="boolean" null="false" default="0"/>
			<field name="signature" type="text" null="true" default="NULL"/>
			<field name="homepage" type="varchar" len="255" null="false" default=""/>
			<field name="locked" type="integer" len="1" null="false" default="0"/>
			<field name="notice" type="text" null="true" default="NULL"/>
			<field name="preferences" type="text" null="true" default="NULL"/>
			<field name="additional_data" type="text" null="true" default="NULL"/>
			<field name="dt_birthdate" type="datetime" null="true" default="NULL"/>
			<field name="dt_lastlogin" type="datetime" null="true" default="NULL"/>
			<field name="dt_registered" type="datetime" null="true" default="NULL"/>
			<field name="logincount" type="integer" len="11" null="false" default="0"/>
			<field name="language" type="varchar" len="5" null="false" default=""/>
			<field name="geo_lat" type="varchar" len="255" null="false" default=""/>
			<field name="geo_long" type="varchar" len="255" null="false" default=""/>
			<field name="country" type="varchar" len="255" null="false" default=""/>
			<field name="city" type="varchar" len="255" null="false" default=""/>
			<field name="street" type="varchar" len="255" null="false" default=""/>
			<field name="zip" type="varchar" len="255" null="false" default=""/>
			<field name="reset_password_key" type="varchar" len="255" null="false" default=""/>
			<field name="password_level" type="varchar" len="6" null="false" default="none"/>
			<index name="id" value=""/>
		</table>
		<table name="user_history">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="admin_id" type="integer" len="11" null="false" default="0"/>
			<field name="status" type="varchar" len="255" null="false" default=""/>
			<field name="datetime" type="datetime" null="true" default="NULL"/>
			<index name="id" value=""/>
		</table>
		<table name="user_deleted">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="old_id" type="integer" len="11" null="false" default="0"/>
			<field name="name" type="varchar" len="255" default="NULL"/>
			<field name="email" type="varchar" len="255" default="NULL"/>
			<field name="firstname" type="varchar" len="255" default="NULL"/>
			<field name="lastname" type="varchar" len="255" default="NULL"/>
			<field name="dt_deleted" type="datetime" null="true" default="NULL"/>
			<field name="full_data" type="text" null="false" default=""/>
			<index name="id" value=""/>
		</table>
	</database>

</module>