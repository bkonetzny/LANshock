<?xml version="1.0" encoding="UTF-8"?>
<module name="Administration" version="2.0.0.0" date="2008-05-12" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="start" permissions="core_configmanager"/>
		<item action="core_config" permissions="core_configmanager"/>
		<item action="modules" permissions="core_modules"/>
		<!-- <item action="cron" permissions="core_configmanager"/> -->
		<!-- <item action="import" permissions="core_configmanager"/> -->
		<!-- <item action="core_configmanager_Listing" permissions="admin"/> -->
		<!-- <item action="core_modules_Listing" permissions="admin"/> -->
		<item action="core_navigation_Listing" permissions="core_navigation"/>
		<!-- <item action="core_security_permissions_Listing" permissions="admin"/> -->
		<item action="core_security_roles_Listing" permissions="core_security_roles"/>
		<!-- <item action="core_security_roles_permissions_rel_Listing" permissions="admin"/> -->
		<!-- <item action="core_security_users_roles_rel_Listing" permissions="admin"/> -->
		<item action="user_Listing" permissions="user"/>
		<item action="logviewer" permissions="logs"/>
		<item action="scaffolding" permissions="scaffolding"/>
	</navigation>
	
	<security>
		<permissions list="logs,user,core_configmanager,core_modules,core_navigation,core_security_permissions,core_security_roles,core_security_roles_permissions_rel,scaffolding"/>
		<role name="LANshock Admin" permissions="logs,user,core_configmanager,core_modules,core_navigation,core_security_permissions,core_security_roles,core_security_roles_permissions_rel,scaffolding"/>
	</security>
	
	<cron>
		<task action="cron_dbbackup" run="0 0 * * *"/>
	</cron>
	
	<database>
		<table name="core_configmanager">
			<field name="module" type="varchar" len="255" null="false" default=""/>
			<field name="version" type="varchar" len="255" null="false" default=""/>
			<field name="data" type="text" null="false" default=""/>
			<field name="dtlastchanged" type="datetime" null="true" default="NULL"/>
			<pk fields="module"/>
		</table>
		<table name="core_logs">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="logname" type="varchar" len="255" null="false" default=""/>
			<field name="level" type="varchar" len="255" null="false" default=""/>
			<field name="data" type="text" null="false" default=""/>
			<field name="timestamp" type="datetime" null="true" default="NULL"/>
			<pk fields="id"/>
			<index name="IDX_logname" fields="logname"/>
			<index name="IDX_level" fields="level"/>
			<index name="IDX_timestamp" fields="timestamp"/>
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
			<engine server="mysql" engine="InnoDB"/>
		</table>
	</database>
	
	<special>
		<reactor>
			<table name="core_security_roles_permissions_rel" loadFields="false">
				<![CDATA[
					<field alias="id" name="id"/>
					<hasOne name="core_security_permissions">
				        <relate from="permission_id" to="id"/>
				    </hasOne>
				    <hasOne name="core_security_roles">
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
						<link name="core_security_roles_permissions_rel" from="core_security_roles" to="core_security_permissions" />
					</hasMany>
					<hasMany name="user">
						<link name="core_security_users_roles_rel" from="core_security_roles" to="user" />
					</hasMany>
				]]>
			</table>
		</reactor>
	</special>
</module>