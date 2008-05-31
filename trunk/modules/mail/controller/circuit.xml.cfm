<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox:circuit PUBLIC "circuit.dtd" "circuit.dtd"> 
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/circuit.xml $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit xmlns:lanshock="lanshock/">

	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/mail/i18n/lang.properties" returnvariable="request.content"/>
		</lanshock:fuseaction>
	</prefuseaction>
	
	<fuseaction access="public" name="main">
		<xfa name="relocate" value="inbox"/>
		<lanshock:relocate xfa="relocate"/>
	</fuseaction>
	
	<fuseaction access="public" name="inbox">
		<include circuit="mail" template="custom/act_messagebox"/>
		<include circuit="v_mail" template="custom/dsp_messagebox"/>
	</fuseaction>
	
	<fuseaction access="public" name="outbox">
		<include circuit="mail" template="custom/act_messagebox"/>
		<include circuit="v_mail" template="custom/dsp_messagebox"/>
	</fuseaction>
	
	<fuseaction access="public" name="webmail">
		<include circuit="mail" template="custom/act_webmail"/>
		<include circuit="v_mail" template="custom/dsp_webmail"/>
	</fuseaction>
	
	<fuseaction access="public" name="webmail_detail">
		<include circuit="mail" template="custom/act_webmail_detail"/>
		<include circuit="v_mail" template="custom/dsp_webmail_detail"/>
	</fuseaction>
	
	<fuseaction access="public" name="webmail_delete">
		<include circuit="mail" template="custom/act_webmail_delete"/>
	</fuseaction>
	
	<fuseaction access="public" name="webmail_account_edit">
		<include circuit="mail" template="custom/act_webmail_account_edit"/>
		<include circuit="v_mail" template="custom/dsp_webmail_account_edit"/>
	</fuseaction>
	
	<fuseaction access="public" name="webmail_account_delete">
		<include circuit="mail" template="custom/act_webmail_account_delete"/>
	</fuseaction>
	
	<fuseaction access="public" name="buddy_add">
		<include circuit="mail" template="custom/act_buddy_add"/>
	</fuseaction>
	
	<fuseaction access="public" name="buddy_del">
		<include circuit="mail" template="custom/act_buddy_del"/>
	</fuseaction>
	
	<fuseaction access="public" name="message">
		<include circuit="mail" template="custom/act_message"/>
		<include circuit="v_mail" template="custom/dsp_message"/>
	</fuseaction>
	
	<fuseaction access="public" name="mail_del">
		<include circuit="mail" template="custom/act_message_delete"/>
	</fuseaction>
	
	<fuseaction access="public" name="message_new">
		<include circuit="mail" template="custom/act_messagebox_new"/>
		<include circuit="v_mail" template="custom/dsp_messagebox_new"/>
	</fuseaction>
	
	<fuseaction access="public" name="message_dialog" lanshock:showlayout="basic">
		<include circuit="mail" template="custom/act_message_dialog"/>
		<include circuit="v_mail" template="custom/dsp_message_dialog"/>
	</fuseaction>
	
	<fuseaction access="public" name="message_dialog_confirm" lanshock:showlayout="basic">
		<include circuit="v_mail" template="custom/dsp_message_dialog_confirm"/>
	</fuseaction>

</circuit>