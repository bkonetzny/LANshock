<?xml version="1.0" encoding="UTF-8"?>
<module name="blog Module" version="2.0.0.0" date="2008-03-31" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="archive"/>
		<item action="categories"/>
		<item action="news_entry_Listing" permissions="news_entry"/>
		<!-- <item action="news_trackback_Listing" reqstatus="admin"/> -->
		<item action="news_category_Listing" permissions="news_category"/>
		<!-- <item action="news_entry_category_Listing" reqstatus="admin"/> -->
		<!-- <item action="news_ping_url_Listing" permissions="news_ping_url"/> -->
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
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="entry_id" type="integer" len="11" null="false" default="0"/>
			<field name="category_id" type="integer" len="11" null="false" default="0"/>
			<pk fields="id"/>
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
	
	<special>
		<reactor>
			<table name="news_entry_category" loadFields="false">
				<![CDATA[
					<field alias="id" name="id"/>
					<hasOne name="news_entry">
				        <relate from="entry_id" to="id"/>
				    </hasOne>
				    <hasOne name="news_category">
				        <relate from="category_id" to="id"/>
				    </hasOne>
				]]>
			</table>
			<table name="news_entry">
				<![CDATA[
					<hasMany name="news_category">
						<link name="news_entry_category" from="news_entry" to="news_category" />
					</hasMany>
				    <hasOne name="user">
				        <relate from="author" to="id"/>
				    </hasOne>
				]]>
			</table>
			<table name="news_category">
				<![CDATA[
					<hasMany name="news_entry">
						<link name="news_entry_category" from="news_category" to="news_entry" />
					</hasMany>
				]]>
			</table>
		</reactor>
	</special>
</module>
