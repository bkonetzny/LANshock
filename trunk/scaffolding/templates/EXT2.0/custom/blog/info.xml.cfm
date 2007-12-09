<?xml version="1.0" encoding="UTF-8"?>
<module name="blog Module" version="1.1.1.0" date="2007-07-08" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="archive"/>
		<item action="categories"/>
		<item action="rss_feeds"/>
		<item action="news_entry_Listing" reqstatus="admin"/>
		<!-- <item action="news_trackback_Listing" reqstatus="admin"/> -->
		<item action="news_category_Listing" reqstatus="admin"/>
		<!-- <item action="news_entry_category_Listing" reqstatus="admin"/> -->
		<item action="news_ping_url_Listing" reqstatus="admin"/>
	</navigation>
	
	<panels>
		<panel name="news" action="panel_news" height="100"/>
	</panels>
	
	<security>
		<area name="news_entry"/>
		<!-- <area name="news_trackback"/> -->
		<area name="news_category"/>
		<!-- <area name="news_entry_category"/> -->
		<area name="news_ping_url"/>
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
			<pk fields="id"/>
			<fk field="author" mapping="user.id"/>
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
		</table>
		<table name="news_entry_category">
			<field name="entry_id" type="integer" len="11" null="false" default="0"/>
			<field name="category_id" type="integer" len="11" null="false" default="0"/>
			<pk fields="entry_id,category_id"/>
			<fk field="entry_id" mapping="news_entry.id"/>
			<fk field="category_id" mapping="news_category.id"/>
		</table>
		<table name="news_ping_url">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="url" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
		</table>
	</database>

</module>