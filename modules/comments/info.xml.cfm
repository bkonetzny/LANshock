<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/comments/info.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<module name="Comments Service" version="2.0.0.0" date="2008-05-12" author="LANshock" url="http://www.lanshock.com">

	<general type="service" requiresLogin="true"/>

	<license>
		<license type="gpl"/>
	</license>
	
	<security>
		<permissions list="comments-manage"/>
		<role name="Comments Admin" permissions="comments-manage"/>
	</security>

	<database>
		<table name="core_comments_topics">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="module" type="varchar" len="255" null="false" default=""/>
			<field name="identifier" type="varchar" len="255" null="false" default=""/>
			<field name="type" type="varchar" len="255" null="false" default=""/>
			<field name="linktosource" type="varchar" len="255" null="false" default=""/>
			<field name="dt_created" type="datetime" null="true" default="NULL"/>
			<field name="user_id_created" type="integer" len="11" null="false" default="0"/>
			<field name="dt_lastpost" type="datetime" null="true" default="NULL"/>
			<field name="user_id_lastpost" type="integer" len="11" null="true" default="NULL"/>
			<field name="postcount" type="integer" len="11" null="false" default="0"/>
			<field name="isclosed" type="boolean" null="false" default="0"/>
			<pk fields="id"/>
			<index name="IDX_module" fields="module"/>
			<index name="IDX_identifier" fields="identifier"/>
			<index name="IDX_type" fields="type"/>
			<index name="IDX_isclosed" fields="isclosed"/>
		</table>
		<table name="core_comments_posts">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="topic_id" type="integer" len="11" null="false" default="0"/>
			<field name="parent_id" type="integer" len="11" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" null="false" default=""/>
			<field name="user_id" type="integer" len="11" null="false" default="0"/>
			<field name="dt_created" type="datetime" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="topic_id" mapping="core_comments_topics.id"/>
			<fk field="parent_id" mapping="core_comments_posts.id"/>
			<fk field="user_id" mapping="user.id"/>
		</table>
	</database>

</module>