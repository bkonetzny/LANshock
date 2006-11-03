<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="News System" version="1.1.0.5" date="2006-09-05" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="archive"/>
		<item action="categories"/>
		<item action="rss_feeds"/>
		<item action="news_edit" reqstatus="admin"/>
		<item action="category_edit" reqstatus="admin"/>
		<item action="ping_url_edit" reqstatus="admin"/>
	</navigation>
	
	<panels>
		<panel name="news" action="panel_news" height="100"/>
	</panels>
	
	<security>
		<area name="news"/>
		<area name="category"/>
		<area name="pingurl"/>
	</security>
	
	<database>
		<table name="news_entry">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="author" type="integer" len="11" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" default=""/>
			<field name="date" type="datetime" null="true" default="NULL"/>
			<field name="mp3url" type="varchar" len="255" null="false" default=""/>
			<field name="ishtml" type="boolean" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="news_trackback">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="entry_id" type="integer" len="11" null="false" default="0"/>
			<field name="blog_name" type="varchar" len="255" null="false" default="0"/>
			<field name="title" type="varchar" len="255" null="false" default=""/>
			<field name="text" type="text" default=""/>
			<field name="date" type="datetime" null="true" default="NULL"/>
			<field name="url" type="varchar" len="255" null="false" default=""/>
			<index name="id" value=""/>
		</table>
		<table name="news_category">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<index name="id" value=""/>
		</table>
		<table name="news_entry_category">
			<field name="entry_id" type="integer" len="11" null="false" default="0"/>
			<field name="category_id" type="integer" len="11" null="false" default="0"/>
			<index name="entry_id,category_id" value=""/>
		</table>
		<table name="news_ping_url">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="url" type="varchar" len="255" null="false" default=""/>
			<index name="id" value=""/>
		</table>
	</database>

</module>