<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('tournament_group','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.tournament_group.qData">
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
