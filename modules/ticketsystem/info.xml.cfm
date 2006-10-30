<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="Ticketsystem" version="1.0.6.1" date="2006-01-03" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<panels>
		<panel name="tickets" action="panel_mytickets" height="100" bUser="false" bAdmin="true"/>
	</panels>
	
	<security>
		<area name="delete"/>
		<area name="answer"/>
	</security>
	
	<database>
		<table name="ticketsystem">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="problem" type="text" null="false" default=""/>
			<field name="answer" type="text" null="false" default=""/>
			<field name="user" type="integer" len="11" default="0"/>
			<field name="editor" type="integer" len="11" null="true" default="NULL"/>
			<field name="dtcreated" type="datetime" null="true" default="NULL"/>
			<field name="dtfinished" type="datetime" null="true" default="NULL"/>
			<field name="status" type="integer" len="1" null="false" default="0"/>
			<field name="badmin" type="boolean" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
	</database>

</module>