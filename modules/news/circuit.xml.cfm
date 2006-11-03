<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit access="public" xmlns:customattributes="customattributes/">

	<fuseaction name="main">
		<do action="news"/>
	</fuseaction>

	<!-- Show News -->
	<fuseaction name="news">
		<include template="act_news.cfm"/>
		<include template="dsp_news.cfm"/>
	</fuseaction>

	<!-- Show Archive -->
	<fuseaction name="archive">
		<include template="act_archive.cfm"/>
		<include template="dsp_archive.cfm"/>
	</fuseaction>

	<!-- Show Categories -->
	<fuseaction name="categories">
		<include template="dsp_categories.cfm"/>
	</fuseaction>

	<!-- Trackback -->
	<fuseaction name="trackback" customattributes:showlayout="none">
		<include template="act_trackback.cfm"/>
		<include template="dsp_trackback.cfm"/>
	</fuseaction>
	
	<fuseaction name="panel_news" customattributes:showlayout="basic">
		<include template="act_panel_news.cfm"/>
		<include template="dsp_panel_news.cfm"/>
	</fuseaction>

	<fuseaction name="news_edit">
		<set name="check" value="#UDF_SecurityCheck(area='news')#"/>
		<include template="act_news_edit.cfm"/>
		<include template="dsp_news_edit.cfm"/>
	</fuseaction>

	<fuseaction name="news_del">
		<set name="check" value="#UDF_SecurityCheck(area='news')#"/>
		<include template="act_news_del.cfm"/>
	</fuseaction>

	<fuseaction name="news_details">
		<include template="act_news_details.cfm"/>
		<include template="dsp_news_details.cfm"/>
	</fuseaction>

	<fuseaction name="news_comment_edit">
		<xfa name="next" value="news_comments"/>
		<include template="act_news_comment_edit.cfm"/>
	</fuseaction>

	<fuseaction name="news_comment_del">
		<set name="check" value="#UDF_SecurityCheck(area='news')#"/>
		<xfa name="next" value="news_comments"/>
		<include template="act_news_comment_del.cfm"/>
	</fuseaction>

	<fuseaction name="category_edit">
		<set name="check" value="#UDF_SecurityCheck(area='category')#"/>
		<include template="act_category_edit.cfm"/>
		<include template="dsp_category_edit.cfm"/>
	</fuseaction>

	<fuseaction name="ping_url_edit">
		<set name="check" value="#UDF_SecurityCheck(area='pingurl')#"/>
		<include template="act_ping_url_edit.cfm"/>
		<include template="dsp_ping_url_edit.cfm"/>
	</fuseaction>

	<!-- Show RSS -->
	<fuseaction name="rss_feeds">
		<include template="dsp_rss_feeds.cfm"/>
	</fuseaction>

	<!-- Show RSS -->
	<fuseaction name="rss" customattributes:showlayout="none">
		<include template="act_rss.cfm"/>
		<include template="dsp_rss.cfm"/>
	</fuseaction>

</circuit>