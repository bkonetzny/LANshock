<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/comments/circuit.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit access="public" xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:cs="coldspring/" xmlns:lanshock="lanshock/">
	
	<fuseaction name="comment_edit">
		<include template="act_comment_edit.cfm"/>
	</fuseaction>
	
	<fuseaction  name="comment_delete">
		<include template="act_comment_delete.cfm"/>
	</fuseaction>
	
	<fuseaction name="comments_enable_disable">
		<lanshock:security area="comments-manage"/>
		<include template="act_comments_enable_disable.cfm"/>
	</fuseaction>

</circuit>