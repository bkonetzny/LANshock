<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('event_events','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.event_events.qData">
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
