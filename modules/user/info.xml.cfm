<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/info.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<module name="LANshock User" version="2.0.0.0" date="2008-05-31" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="true"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="login"/>
		<item action="userdetails"/>
		<item action="logout"/>
	</navigation>
	
	<database>
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
	</special>

</module>