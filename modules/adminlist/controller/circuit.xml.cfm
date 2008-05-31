<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/circuit.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit xmlns:lanshock="lanshock/">
		
	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/user/i18n/lang.properties" returnvariable="request.content"/>
			<include circuit="user" template="settings"/>
		</lanshock:fuseaction>
	</prefuseaction>
	
	<fuseaction access="public" name="main">
		<xfa name="relocate" value="list"/>
		<lanshock:relocate xfa="relocate"/>
	</fuseaction>
	
	<fuseaction access="public" name="list">
		<include circuit="adminlist" template="custom/act_list"/>
		<include circuit="v_adminlist" template="custom/dsp_list"/>
	</fuseaction>

</circuit>