<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2007-12-09 10:05:43 +0100 (So, 09 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 127 $
--->>

<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<cfset aManyToMany = oMetaData.getRelationshipsFromXML(objectName,"manyToMany")>>
<<cfset aOneToMany = oMetaData.getRelationshipsFromXML(objectName,"oneToMany")>>

<<cfoutput>>
	<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	<<cfloop from="1" to="$$ArrayLen(aManyToOne)$$" index="i">>
	<cfinvoke component="#application.lanshock.oFactory.load('$$aManyToOne[i].name$$','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.$$aManyToOne[i].name$$.qData">
	<</cfloop>>
	
	<!--- stManyToMany --->
	<<cfloop from="1" to="$$ArrayLen(aManyToMany)$$" index="i">>
		<<cfset aRelOneToMany = oMetaData.getRelationshipsFromXML(aManyToMany[i].alias,"oneToMany")>>
		<<cfloop from="1" to="$$ArrayLen(aRelOneToMany)$$" index="i2">>
			<<cfif aRelOneToMany[i2].alias NEQ objectName>>
				<cfinvoke component="#application.lanshock.oFactory.load('$$aManyToMany[i].name$$','reactorGateway')#" method="getRelOptions" returnvariable="stRelated.stManyToMany.$$aManyToMany[i].name$$.qData">
					<cfinvokeargument name="sRelTable" value="$$aRelOneToMany[i2].alias$$">
				</cfinvoke>
			<</cfif>>
		<</cfloop>>
	<</cfloop>>
	
	<!--- stOneToMany --->
	<<cfloop from="1" to="$$ArrayLen(aOneToMany)$$" index="i">>
	<cfinvoke component="#application.lanshock.oFactory.load('$$aOneToMany[i].name$$','reactorGateway')#" method="getOptions" returnvariable="stRelated.stOneToMany.$$aOneToMany[i].name$$.qData">
	<</cfloop>>
<</cfoutput>>