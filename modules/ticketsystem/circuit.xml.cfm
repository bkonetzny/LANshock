<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit access="public">

	<!-- Show Ticketlist -->
	<fuseaction name="ticketlist">
		<include template="act_ticketlist.cfm"/>
		<include template="dsp_ticketlist.cfm"/>
	</fuseaction>
	
	<!-- Copy of ticketlist -->
	<fuseaction name="main">
		<include template="act_ticketlist.cfm"/>
		<include template="dsp_ticketlist.cfm"/>
	</fuseaction>

	<!-- Panel: Tickets -->
	<fuseaction name="panel_mytickets">
		<set name="ShowLayout" value="basic"/>
		<include template="act_panel_mytickets.cfm"/>
		<include template="dsp_panel_mytickets.cfm"/>
	</fuseaction>

	<!-- Show Ticketdetails -->
	<fuseaction name="details">
		<include template="act_details.cfm"/>
		<include template="dsp_details.cfm"/>
	</fuseaction>

	<!-- Create a Ticket -->
	<fuseaction name="create">
		<include template="act_create.cfm"/>
		<include template="dsp_create.cfm"/>
	</fuseaction>

	<!-- Accept a Ticket -->
	<fuseaction name="acceptticket">
		<set name="check" value="#UDF_SecurityCheck(area='answer')#"/>
		<include template="act_acceptticket.cfm"/>
	</fuseaction>

	<!-- Save Answer -->
	<fuseaction name="saveanswer">
		<include template="act_saveanswer.cfm"/>
	</fuseaction>

	<!-- Finish Ticket -->
	<fuseaction name="finishticket">
		<include template="act_finishticket.cfm"/>
	</fuseaction>

	<!-- Delete Ticket -->
	<fuseaction name="delete">
		<set name="check" value="#UDF_SecurityCheck(area='delete')#"/>
		<include template="act_delete.cfm"/>
	</fuseaction>

</circuit>