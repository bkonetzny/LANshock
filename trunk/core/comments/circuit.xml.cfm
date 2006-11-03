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
	
	<fuseaction name="comment_edit">
		<include template="act_comment_edit.cfm"/>
	</fuseaction>
	
	<fuseaction name="comment_delete">
		<include template="act_comment_delete.cfm"/>
	</fuseaction>
	
	<fuseaction name="comments_enable_disable">
		<set name="check" value="#UDF_SecurityCheck(area='disablecomments')#"/>
		<include template="act_comments_enable_disable.cfm"/>
	</fuseaction>

</circuit>