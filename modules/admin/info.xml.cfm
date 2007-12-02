<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/info.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<module name="LANshock Administration" version="1.0.0.0" date="2006-06-01" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="true"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="start" reqstatus="admin"/>
		<item action="core_config" reqstatus="admin"/>
		<item action="modules" reqstatus="admin"/>
		<item action="cron" reqstatus="admin"/>
		<item action="admin" reqstatus="admin"/>
		<item action="userlist" reqstatus="admin"/>
		<item action="roleslist" reqstatus="admin"/>
		<item action="import" reqstatus="admin"/>
		<item action="maintenance" reqstatus="admin"/>
		<!-- <item action="mailing" reqstatus="admin"/> -->
	</navigation>
	
	<dependencies>
		<filesystem folder="/config"/>
	</dependencies>
	
	<security>
		<area name="setrights"/>
		<area name="guest"/>
		<area name="mailing"/>
	</security>
	
	<cron>
		<task action="cron_dbbackup" run="0 0 * * *"/>
	</cron>
	
	<database>
		<table name="admin">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="user" type="integer" len="11" null="false" default="0"/>
			<field name="lastchange_userid" type="integer" len="11" null="false" default="0"/>
			<field name="lastchange_dt" type="datetime" null="true" default="NULL"/>
			<field name="security" type="text" null="false" default=""/>
			<pk fields="id"/>
		</table>
		<table name="core_configmanager">
			<field name="module" type="varchar" len="255" null="false" default=""/>
			<field name="version" type="varchar" len="255" null="false" default=""/>
			<field name="data" type="text" null="false" default=""/>
			<field name="dtlastchanged" type="datetime" null="true" default="NULL"/>
			<pk fields="module"/>
		</table>
		<table name="core_security_roles">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
		</table>
		<table name="core_security_permissions">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
		</table>
		<table name="core_security_roles_permissions_rel">
			<field name="role_id" type="integer" len="11" null="false"/>
			<field name="permission_id" type="integer" len="11" null="false"/>
			<pk fields="role_id,permission_id"/>
			<fk field="role_id" mapping="core_security_roles"/>
			<fk field="permission_id" mapping="core_security_permissions"/>
		</table>
	</database>

</module>