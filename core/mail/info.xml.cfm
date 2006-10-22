<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="LANshock Messenger" version="1.0.6.0" date="2006-04-19" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="true"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="inbox"/>
		<item action="outbox"/>
		<item action="webmail"/>
	</navigation>
	
	<panels>
		<panel name="buddylist" action="buddylist" height="350"/>
	</panels>
	
	<database>
		<table name="core_mail_buddylist">
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="buddy_user_ids" type="text" null="false" default=""/>
			<field name="order_by" type="varchar" len="255" null="false" default="name"/>
			<index name="user_id" value=""/>
		</table>
		<table name="core_mail_message">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="user_id_from" type="integer" len="11" null="false" default="0"/>
			<field name="user_id_to" type="integer" len="11" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" null="false" default=""/>
			<field name="datetime" type="datetime" null="true" default="NULL"/>
			<field name="isnew" type="integer" len="1" null="false" default="1"/>
			<index name="id" value=""/>
		</table>
		<table name="core_mail_webmail">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="server" type="varchar" len="255" null="false" default=""/>
			<field name="port" type="integer" len="5" null="false" default="110"/>
			<field name="username" type="varchar" len="255" null="false" default=""/>
			<field name="password" type="varchar" len="255" null="false" default=""/>
			<field name="isactive" type="boolean" default="0"/>
			<index name="id" value=""/>
		</table>
	</database>

</module>