<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset sModule = oMetaData.getModule()>>

<<cfoutput>>
	<fuseaction name="$$objectName$$_action_add" access="public">
		<set name="mode" value="insert" />
		<xfa name="save" value="$$objectName$$_action_add" />
		<do action="$$objectName$$_action_save"/>
	</fuseaction>
	
	<fuseaction name="$$objectName$$_action_update" access="public">
		<set name="mode" value="edit" />
		<xfa name="save" value="$$objectName$$_action_update" />
		<do action="$$objectName$$_action_save"/>
	</fuseaction>
	
	<fuseaction name="$$objectName$$_action_save" access="private" lanshock:includedCircuit="true">
		<lanshock:security area="$$objectName$$"/>
		<set name="bHasErrors" value="false" />
		
		<xfa name="continue" value="$$objectName$$_listing" />
		<xfa name="cancel" value="$$objectName$$_listing" />
		
		<include circuit="$$sModule$$" template="form/act_action_save_$$objectName$$" />
	</fuseaction>
	
<</cfoutput>>