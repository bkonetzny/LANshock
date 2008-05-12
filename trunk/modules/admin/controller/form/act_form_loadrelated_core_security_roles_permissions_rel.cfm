<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	
	<!--- stManyToMany --->
	
	
	<!--- stOneToMany --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('core_security_permissions','reactorGateway')#" method="getOptions" returnvariable="stRelated.stOneToMany.core_security_permissions.qData">
	
	<cfinvoke component="#application.lanshock.oFactory.load('core_security_roles','reactorGateway')#" method="getOptions" returnvariable="stRelated.stOneToMany.core_security_roles.qData">
