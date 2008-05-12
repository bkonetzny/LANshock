<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	
	<!--- stManyToMany --->
	
		
		
			
				<cfinvoke component="#application.lanshock.oFactory.load('core_security_roles_permissions_rel','reactorGateway')#" method="getRelOptions" returnvariable="stRelated.stManyToMany.core_security_roles_permissions_rel.qData">
					<cfinvokeargument name="sRelTable" value="core_security_permissions">
				</cfinvoke>
			
		
			
		
	
		
		
			
		
			
				<cfinvoke component="#application.lanshock.oFactory.load('core_security_users_roles_rel','reactorGateway')#" method="getRelOptions" returnvariable="stRelated.stManyToMany.core_security_users_roles_rel.qData">
					<cfinvokeargument name="sRelTable" value="user">
				</cfinvoke>
			
		
	
	
	<!--- stOneToMany --->
