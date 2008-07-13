<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->
<module name="Administration" version="2.0.0.0" date="2008-05-31" author="LANshock" url="http://www.lanshock.com">
	
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
		<item action="core_cron_listing" permissions="core_cron"/>
		<!-- <item action="core_modules_Listing" permissions="admin"/> -->
		<item action="core_navigation_listing" permissions="core_navigation"/>
		<!-- <item action="core_security_permissions_Listing" permissions="admin"/> -->
		<item action="core_security_roles_listing" permissions="core_security_roles"/>
		<!-- <item action="core_security_roles_permissions_rel_Listing" permissions="admin"/> -->
		<!-- <item action="core_security_users_roles_rel_Listing" permissions="admin"/> -->
		<item action="user_listing" permissions="user"/>
		<item action="logviewer" permissions="logs"/>
		<item action="scaffolding" permissions="scaffolding"/>
	</navigation>
	
	<security>
		<permissions list="logs,user,core_configmanager,core_cron,core_modules,core_navigation,core_security_permissions,core_security_roles,core_security_roles_permissions_rel,scaffolding"/>
		<role name="LANshock Admin" permissions="logs,user,core_configmanager,core_cron,core_modules,core_navigation,core_security_permissions,core_security_roles,core_security_roles_permissions_rel,scaffolding"/>
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
		<table name="core_cron">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="active" type="boolean" default="0"/>
			<field name="run" type="varchar" len="255" null="true" default="NULL"/>
			<field name="module" type="varchar" len="255" null="true" default="NULL"/>
			<field name="action" type="varchar" len="255" null="true" default="NULL"/>
			<field name="executions" type="integer" len="11" null="false" default="0"/>
			<field name="lastrun_dt" type="datetime" null="true" default="NULL"/>
			<field name="lastrun_time" type="integer" len="11" null="false" default="0"/>
			<field name="result" type="text" null="true" default="NULL"/>
			<pk fields="id"/>
		</table>
		<table name="core_logs">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="logname" type="varchar" len="255" null="false" default=""/>
			<field name="level" type="varchar" len="255" null="false" default=""/>
			<field name="data" type="text" null="false" default=""/>
			<field name="timestamp" type="datetime" null="true" default="NULL"/>
			<field name="userid" type="integer" len="11" null="false"/>
			<pk fields="id"/>
			<fk field="userid" mapping="user.id"/>
			<index name="IDX_logname" fields="logname"/>
			<index name="IDX_level" fields="level"/>
			<index name="IDX_timestamp" fields="timestamp"/>
			<index name="IDX_userid" fields="userid"/>
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
		<table name="user">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="email" type="varchar" len="255" null="false" default=""/>
			<field name="pwd" type="varchar" len="255" null="false" default=""/>
			<field name="firstname" type="varchar" len="255" null="false" default=""/>
			<field name="lastname" type="varchar" len="255" null="false" default=""/>
			<field name="gender" type="boolean" null="false" default="0"/>
			<field name="status" type="varchar" len="255" null="true" default="NULL"/>
			<field name="signature" type="text" null="true" default="NULL"/>
			<field name="homepage" type="varchar" len="255" null="true" default="NULL"/>
			<field name="internal_note" type="text" null="true" default="NULL"/>
			<field name="dt_birthdate" type="datetime" null="true" default="NULL"/>
			<field name="dt_lastlogin" type="datetime" null="true" default="NULL"/>
			<field name="dt_registered" type="datetime" null="true" default="NULL"/>
			<field name="logincount" type="integer" len="11" null="false" default="0"/>
			<field name="language" type="varchar" len="5" null="true" default="NULL"/>
			<field name="geo_latlong" type="varchar" len="255" null="true" default="NULL"/>
			<field name="country" type="varchar" len="255" null="true" default="NULL"/>
			<field name="city" type="varchar" len="255" null="true" default="NULL"/>
			<field name="street" type="varchar" len="255" null="true" default="NULL"/>
			<field name="zip" type="varchar" len="255" null="true" default="NULL"/>
			<field name="reset_password_key" type="varchar" len="255" null="true" default="NULL"/>
			<field name="openid_url" type="varchar" len="255" null="true" default="NULL"/>
			<field name="data_access" type="boolean" null="false" default="0"/>
			<pk fields="id"/>
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
			<table name="user">
				<![CDATA[
					<hasMany name="core_security_roles">
						<link name="core_security_users_roles_rel" from="user" to="core_security_roles" />
					</hasMany>
					<hasMany name="core_comments_posts">
						<relate from="id" to="user_id" />
					</hasMany>
				]]>
			</table>
		</reactor>
		<scaffolding>
			<table name="core_cron">
				<list fields="id,run,module,action,active,lastrun_dt,lastrun_time" sortDefault="module ASC"/>
				<form>
					<field name="lastrun_dt" formType="Display"/>
					<field name="lastrun_time" formType="Display"/>
					<field name="executions" formType="Display"/>
					<field name="result" formType="Display"/>
				</form>
			</table>
			<table name="user">
				<list fields="id,name,firstname,lastname,email" sortDefault="lastname ASC"/>
				<form>
					<field name="pwd" formType="Password"/>
					<field name="gender" formType="Radio"/>
					<field name="status" formType="Select"/>
					<field name="signature" formType="FckEditor"/>
					<field name="dt_lastlogin" formType="Display"/>
					<field name="dt_registered" formType="Display"/>
					<field name="logincount" formType="Display"/>
					<field name="language" formType="Select"/>
				</form>
			</table>
		</scaffolding>
	</special>
</module>