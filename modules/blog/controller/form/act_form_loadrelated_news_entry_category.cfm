<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('news_entry','reactorGateway')#" method="getOptions" returnvariable="stRelated.stOneToMany.news_entry.qData">
	
	<cfinvoke component="#application.lanshock.oFactory.load('news_category','reactorGateway')#" method="getOptions" returnvariable="stRelated.stOneToMany.news_category.qData">
