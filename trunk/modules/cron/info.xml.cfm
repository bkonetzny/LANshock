<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/cron/info.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<module name="LANshock Cron Service" version="0.0.0.1" date="2006-03-13" author="LANshock" url="http://www.lanshock.com">
	
	<general type="service" requiresLogin="false" loadLanguageFile="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<database>
		<table name="core_cron">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="active" type="boolean" default="0"/>
			<field name="run" type="varchar" len="255" null="false" default=""/>
			<field name="module" type="varchar" len="255" null="false" default=""/>
			<field name="action" type="varchar" len="255" null="false" default=""/>
			<field name="executions" type="integer" len="11" null="false" default="0"/>
			<field name="lastrun_dt" type="datetime" null="true" default="NULL"/>
			<field name="lastrun_time" type="integer" len="11" null="false" default="0"/>
			<field name="result" type="text" default=""/>
			<pk fields="id"/>
		</table>
	</database>

</module>