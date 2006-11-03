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
	
	<fuseaction name="main" customattributes:showlayout="none">
		<do action="run"/>
	</fuseaction>
	
	<fuseaction name="run" customattributes:showlayout="none">
		<include template="act_run.cfm"/>
	</fuseaction>

</circuit>