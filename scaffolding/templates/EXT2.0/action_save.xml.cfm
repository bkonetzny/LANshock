<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2007-12-09 10:05:43 +0100 (So, 09 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 127 $
--->>

<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<cfset stFields.aTable = oMetaData.getFieldsFromXML(objectName)>>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<cfset aManyToMany = oMetaData.getRelationshipsFromXML(objectName,"manyToMany")>>
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
		
		<<cfloop from="1" to="$$ArrayLen(stFields['aTable'])$$" index="i">>
			<<cfmodule template="../templates/EXT2.0/rowtypes/rowtype.cfm" rowtype="$$stFields['aTable'][i].formType$$" method="xml_validation_pre">>
		<</cfloop>>
		
		<include circuit="$$sModule$$" template="form/act_action_save_$$objectName$$" />
	</fuseaction>
	
<</cfoutput>>
