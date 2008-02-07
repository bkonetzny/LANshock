<?xml version="1.0" encoding="UTF-8"?>
<module name="LANshock Administration" version="2.0.0.0" date="2008-01-19" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
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
		<!-- <item action="core_configmanager_Listing" reqstatus="admin"/> -->
		<!-- <item action="core_modules_Listing" reqstatus="admin"/> -->
		<item action="core_navigation_Listing" reqstatus="admin"/>
		<!-- <item action="core_security_permissions_Listing" reqstatus="admin"/> -->
		<item action="core_security_roles_Listing" reqstatus="admin"/>
		<!-- <item action="core_security_roles_permissions_rel_Listing" reqstatus="admin"/> -->
		<item action="core_security_users_roles_rel_Listing" reqstatus="admin"/>
		<item action="user_Listing" reqstatus="admin"/>
	</navigation>
	
	<dependencies>
		<filesystem folder="/config"/>
	</dependencies>
	
	<security>
		<area name="setrights"/>
		<area name="guest"/>
		<area name="mailing"/>
		<area name="core_configmanager"/>
		<area name="core_modules"/>
		<area name="core_navigation"/>
		<area name="core_security_permissions"/>
		<area name="core_security_roles"/>
		<area name="core_security_roles_permissions_rel"/>
		<permissions list="setrights,guest,mailing,core_configmanager,core_modules,core_navigation,core_security_permissions,core_security_roles,core_security_roles_permissions_rel"/>
		<role name="LANshock Admin" permissions="setrights,guest,mailing,core_configmanager,core_modules,core_navigation,core_security_permissions,core_security_roles,core_security_roles_permissions_rel"/>
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
			<field name="module" type="varchar" len="255" null="true" default="NULL"/>
			<pk fields="id"/>
		</table>
		<table name="core_security_permissions">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="module" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
		</table>
		<table name="core_security_roles_permissions_rel">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="role_id" type="integer" len="11" null="false"/>
			<field name="permission_id" type="integer" len="11" null="false"/>
			<pk fields="id"/>
			<fk field="role_id" mapping="core_security_roles"/>
			<fk field="permission_id" mapping="core_security_permissions"/>
		</table>
		<table name="core_security_users_roles_rel">
			<field name="user_id" type="integer" len="11" null="false"/>
			<field name="role_id" type="integer" len="11" null="false"/>
			<pk fields="user_id,role_id"/>
			<fk field="user_id" mapping="user.id"/>
			<fk field="role_id" mapping="core_security_roles"/>
		</table>
		<table name="core_modules">
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="version" type="varchar" len="255" null="false" default=""/>
			<field name="date" type="datetime" null="true" default="NULL"/>
			<field name="folder" type="varchar" len="255" null="false" default=""/>
			<pk fields="folder"/>
		</table>
		<table name="core_navigation">
			<field name="module" type="varchar" len="255" null="false" default=""/>
			<field name="action" type="varchar" len="255" null="false" default=""/>
			<field name="level" type="integer" len="11" null="false" default="1"/>
			<field name="sortorder" type="integer" len="11" null="false" default="1"/>
			<field name="permissions" type="varchar" len="255" null="false" default=""/>
			<pk fields="module,action"/>
		</table>
	</database>
	
	<special>
		<reactor>
			<table name="core_security_roles_permissions_rel" loadFields="false">
				<![CDATA[
					<field alias="id" name="id"/>
					<hasOne name="core_security_permissions" alias="Permissions">
				        <relate from="permission_id" to="id"/>
				    </hasOne>
				    <hasOne name="core_security_roles" alias="Roles">
				        <relate from="role_id" to="id"/>
				    </hasOne>
				]]>
			</table>
			<table name="core_security_users_roles_rel" loadFields="false">
				<![CDATA[
					<hasOne name="core_security_roles">
				        <relate from="role_id" to="id"/>
				    </hasOne>
				    <hasOne name="user">
				        <relate from="user_id" to="id"/>
				    </hasOne>
				]]>
			</table>
			<table name="core_security_roles">
				<![CDATA[
					<hasMany name="core_security_permissions">
						<link name="core_security_roles_permissions_rel" from="Roles" to="Permissions" />
					</hasMany>
				]]>
			</table>
		</reactor>
	</special>
</module>
