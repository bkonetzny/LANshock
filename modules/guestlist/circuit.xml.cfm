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

<circuit access="public">

	<fuseaction name="main">
		<include template="act_guestlist.cfm"/>
		<include template="dsp_guestlist.cfm"/>
	</fuseaction>

	<fuseaction name="guestlist">
		<include template="act_guestlist.cfm"/>
		<include template="dsp_guestlist.cfm"/>
	</fuseaction>

</circuit>