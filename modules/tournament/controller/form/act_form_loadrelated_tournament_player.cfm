<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('tournament_team','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.tournament_team.qData">
	
	<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.user.qData">
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
