<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('tournament_tournament','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.tournament_tournament.qData">
	
	<cfinvoke component="#application.lanshock.oFactory.load('tournament_team','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.tournament_team.qData">
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
