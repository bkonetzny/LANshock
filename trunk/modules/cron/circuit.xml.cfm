<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/cron/circuit.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit access="public" xmlns:lanshock="lanshock/">
	
	<fuseaction name="main" lanshock:showlayout="none">
		<do action="run"/>
	</fuseaction>
	
	<fuseaction name="run" lanshock:showlayout="none">
		<include template="act_run.cfm"/>
	</fuseaction>

</circuit>