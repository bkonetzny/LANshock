<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->
<module name="Blog" version="2.0.0.0" date="2008-07-14" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="archive"/>
		<item action="categories"/>
		<item action="news_entry_listing" permissions="news_entry"/>
		<!-- <item action="news_trackback_listing" reqstatus="admin"/> -->
		<item action="news_category_listing" permissions="news_category"/>
		<!-- <item action="news_entry_category_listing" reqstatus="admin"/> -->
		<!-- <item action="news_ping_url_listing" permissions="news_ping_url"/> -->
	</navigation>
	
	<security>
		<!-- news_trackback, news_entry_category -->
		<permissions list="news_entry,news_category,news_ping_url"/>
		<role name="Blog Admin" permissions="news_entry,news_category,news_ping_url"/>
	</security>
	
	<database>
		<table name="news_entry">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="author" type="integer" len="11" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" default=""/>
			<field name="date" type="datetime" null="true" default="NULL"/>
			<field name="mp3url" type="varchar" len="255" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="author" type="manyToOne" mapping="user.id"/>
			<fk field="id" type="manyToMany" mapping="news_entry_category.entry_id"/>
		</table>
		<table name="news_trackback">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="entry_id" type="integer" len="11" null="false" default="0"/>
			<field name="blog_name" type="varchar" len="255" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" default=""/>
			<field name="date" type="datetime" null="true" default="NULL"/>
			<field name="url" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
			<fk field="entry_id" mapping="news_entry.id"/>
		</table>
		<table name="news_category">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
			<fk field="id" type="manyToMany" mapping="news_entry_category.category_id"/>
		</table>
		<table name="news_entry_category">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="entry_id" type="integer" len="11" null="false" default="0"/>
			<field name="category_id" type="integer" len="11" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="entry_id" type="oneToMany" mapping="news_entry.id"/>
			<fk field="category_id" type="oneToMany" mapping="news_category.id"/>
		</table>
		<table name="news_ping_url">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="url" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
		</table>
	</database>
	
	<special>
		<reactor>
			<table name="news_entry_category" loadFields="false">
				<![CDATA[
					<field alias="id" name="id"/>
				]]>
			</table>
		</reactor>
		<scaffolding>
			<table name="news_entry">
				<list fields="id,title,author,date" sortDefault="date DESC"/>
				<form fields="id,author,date,title,text,mp3url">
					<field name="text" formType="FckEditor"/>
				</form>
			</table>
			<table name="news_category">
				<list sortDefault="name ASC"/>
			</table>
		</scaffolding>
	</special>
</module>
