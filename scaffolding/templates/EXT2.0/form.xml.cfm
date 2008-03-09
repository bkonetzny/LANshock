<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2007-12-09 10:05:43 +0100 (So, 09 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 127 $
--->>

<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset sModule = oMetaData.getModule()>>

<<cfoutput>>
	<fuseaction name="$$objectName$$_add_form" access="public">
		<set name="mode" value="insert" />
		<xfa name="save" value="$$objectName$$_action_add" />
		<do action="$$objectName$$_form"/>
	</fuseaction>
	
	<fuseaction name="$$objectName$$_edit_form" access="public">
		<set name="mode" value="edit" />
		<xfa name="save" value="$$objectName$$_action_update" />
		<do action="$$objectName$$_form"/>
	</fuseaction>
	
	<fuseaction name="$$objectName$$_form" access="private" lanshock:includedCircuit="true">
		<lanshock:security area="$$objectName$$"/>
		<set name="request.layout" value="admin" />
		<xfa name="cancel" value="$$objectName$$_listing" />
		
		<include circuit="$$sModule$$" template="form/act_form_$$objectName$$" />
		
		<include circuit="$$sModule$$" template="form/act_form_loadrelated_$$objectName$$" />
		<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/controller/form/act_form_loadrelated_custom_$$objectName$$.cfm")>>
			<include circuit="$$sModule$$" template="form/act_form_loadrelated_custom_$$objectName$$" />
		<</cfif>>
		
		<include circuit="udfs" template="udf_appendParam" />
		<include circuit="v_$$sModule$$" template="form/dsp_form_$$objectName$$" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>
<</cfoutput>>