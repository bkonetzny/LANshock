<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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
		<item action="grouplist" reqstatus="admin"/>
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
			<index name="id" value=""/>
		</table>
		<table name="core_configmanager">
			<field name="module" type="varchar" len="255" null="false" default=""/>
			<field name="version" type="varchar" len="255" null="false" default=""/>
			<field name="data" type="text" null="false" default=""/>
			<field name="dtlastchanged" type="datetime" null="true" default="NULL"/>
			<index name="module" value=""/>
		</table>
	</database>

</module>