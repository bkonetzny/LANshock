<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit access="public">
	
	<fuseaction name="main">
		<set name="ShowLayout" value="none"/>
		<do action="run"/>
	</fuseaction>
	
	<fuseaction name="run">
		<set name="ShowLayout" value="none"/>
		<include template="act_run.cfm"/>
	</fuseaction>

</circuit>