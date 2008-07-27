<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('tournament_type_se_match','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.tournament_type_se_match.qData">
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
