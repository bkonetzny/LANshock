<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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
			<index name="id" value=""/>
		</table>
		<table name="core_team_user">
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="team_id" type="integer" len="11" null="false" default="0"/>
			<field name="status" type="varchar" len="255" null="false" default=""/>
			<field name="rights" type="text" null="false" default=""/>
			<index name="user_id,team_id" value=""/>
		</table>
	</database>

</module>