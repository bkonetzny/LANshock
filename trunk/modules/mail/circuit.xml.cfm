<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/circuit.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit access="public" xmlns:lanshock="lanshock/">
	
	<fuseaction name="main">
		<do action="inbox"/>
	</fuseaction>
	
	<!-- Show Inbox -->
	<fuseaction name="inbox">
		<include template="act_messagebox.cfm"/>
		<include template="dsp_messagebox.cfm"/>
	</fuseaction>
	
	<!-- Show Outbox -->
	<fuseaction name="outbox">
		<include template="act_messagebox.cfm"/>
		<include template="dsp_messagebox.cfm"/>
	</fuseaction>
	
	<!-- Show Webmail -->
	<fuseaction name="webmail">
		<include template="act_webmail.cfm"/>
		<include template="dsp_webmail.cfm"/>
	</fuseaction>
	
	<!-- Webmail Detail -->
	<fuseaction name="webmail_detail">
		<include template="act_webmail_detail.cfm"/>
		<include template="dsp_webmail_detail.cfm"/>
	</fuseaction>
	
	<!-- Delete Webmail -->
	<fuseaction name="webmail_delete">
		<include template="act_webmail_delete.cfm"/>
	</fuseaction>
	
	<!-- Webmail Account -->
	<fuseaction name="webmail_account_edit">
		<include template="act_webmail_account_edit.cfm"/>
		<include template="dsp_webmail_account_edit.cfm"/>
	</fuseaction>
	
	<!-- Delete Webmail Account -->
	<fuseaction name="webmail_account_delete">
		<include template="act_webmail_account_delete.cfm"/>
	</fuseaction>
	
	<!-- Add User To Buddylist -->
	<fuseaction name="buddy_add">
		<include template="act_buddy_add.cfm"/>
	</fuseaction>
	
	<!-- Remove User From Buddylist -->
	<fuseaction name="buddy_del">
		<include template="act_buddy_del.cfm"/>
	</fuseaction>
	
	<!-- Show Message -->
	<fuseaction name="message">
		<include template="act_message.cfm"/>
		<include template="dsp_message.cfm"/>
	</fuseaction>
	
	<!-- Delete Messages -->
	<fuseaction name="mail_del">
		<include template="act_message_delete.cfm"/>
	</fuseaction>
	
	<!-- Show Message Dialog -->
	<fuseaction name="message_new">
		<include template="act_messagebox_new.cfm"/>
		<include template="dsp_messagebox_new.cfm"/>
	</fuseaction>
	
	<!-- Show Message Dialog -->
	<fuseaction name="message_dialog" lanshock:showlayout="basic">
		<include template="act_message_dialog.cfm"/>
		<include template="dsp_message_dialog.cfm"/>
	</fuseaction>
	
	<!-- Show Message-Sent Confirmation -->
	<fuseaction name="message_dialog_confirm" lanshock:showlayout="basic">
		<include template="dsp_message_dialog_confirm.cfm"/>
	</fuseaction>

</circuit>