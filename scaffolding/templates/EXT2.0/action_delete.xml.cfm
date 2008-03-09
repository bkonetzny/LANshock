<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>

<<cfoutput>>
	<fuseaction name="$$objectName$$_delete" access="public">
		<lanshock:security area="$$objectName$$"/>
		
		<!-- Delete: I delete the selected $$objectName$$ records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none" />
		
		<invoke object="application.lanshock.oFactory.load('$$objectName$$','reactorGateway')" method="deleteByIDlist" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#" />
		</invoke>
	</fuseaction>	
<</cfoutput>>