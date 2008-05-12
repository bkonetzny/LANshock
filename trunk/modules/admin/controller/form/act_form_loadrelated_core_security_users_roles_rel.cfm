<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('core_security_roles','reactorGateway')#" method="getOptions" returnvariable="stRelated.stOneToMany.core_security_roles.qData">
	
	<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getOptions" returnvariable="stRelated.stOneToMany.user.qData">
