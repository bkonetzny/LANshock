<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('tournament_tournament','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.tournament_tournament.qData">
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('tournament_type_se_result','reactorGateway')#" method="getOptions" returnvariable="stRelated.stOneToMany.tournament_type_se_result.qData">
