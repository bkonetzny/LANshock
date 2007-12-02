<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/info.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<module name="LANshock Team-Manager" version="0.9.0.0" date="2005-06-25" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="true"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="details"/>
		<item action="list"/>
	</navigation>
	
	<database>
		<table name="core_team">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="tag" type="varchar" len="255" null="false" default=""/>
			<field name="description" type="text" null="false" default=""/>
			<field name="homepage" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
		</table>
		<table name="core_team_user">
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="team_id" type="integer" len="11" null="false" default="0"/>
			<field name="status" type="varchar" len="255" null="false" default=""/>
			<field name="rights" type="text" null="false" default=""/>
			<pk fields="user_id,team_id"/>
			<fk field="user_id" mapping="user.id"/>
			<fk field="team_id" mapping="core_team.id"/>
		</table>
	</database>

</module>