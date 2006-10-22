<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="LANshock Comment-System" version="0.3.0.5" date="2006-01-24" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="true"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<security>
		<area name="disablecomments"/>
	</security>

	<database>
		<table name="core_comments_topics">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="module" type="varchar" len="255" null="false" default=""/>
			<field name="identifier" type="varchar" len="255" null="false" default=""/>
			<field name="type" type="varchar" len="255" null="false" default=""/>
			<field name="linktosource" type="varchar" len="255" null="false" default=""/>
			<field name="dt_created" type="datetime" null="true" default="NULL"/>
			<field name="isclosed" type="boolean" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="core_comments_posts">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="topic_id" type="integer" len="11" null="false" default="0"/>
			<field name="parent_id" type="integer" len="11" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" null="false" default=""/>
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="dt_created" type="datetime" null="true" default="NULL"/>
			<index name="id" value=""/>
		</table>
	</database>

</module>