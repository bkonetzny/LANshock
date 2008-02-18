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

<circuit access="public" xmlns:tr="transfer/" xmlns:reactor="reactor/">

	<fuseaction name="initFrameworks">
		<!-- <tr:init datasource="config/transfer/datasource.xml.cfm"
				configuration="config/transfer/transfer.xml.cfm"
				definitions="#application.lanshock.sStoragePath#secure/config/transfer/" /> -->
		
		<reactor:initialize configuration="#application.lanshock.sStoragePath#secure/config/reactor/reactor.xml"/>
	</fuseaction>

</circuit>