<cfset stRelated = StructNew()>
	<cfset stRelated.stManyToOne = StructNew()>
	<cfset stRelated.stManyToMany = StructNew()>
	<cfset stRelated.stOneToMany = StructNew()>
	
	<!--- stManyToOne --->
	
	<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getOptions" returnvariable="stRelated.stManyToOne.user.qData">
	
	
	<!--- stManyToMany --->
	
		
		
			
		
			
				<cfinvoke component="#application.lanshock.oFactory.load('news_entry_category','reactorGateway')#" method="getRelOptions" returnvariable="stRelated.stManyToMany.news_entry_category.qData">
					<cfinvokeargument name="sRelTable" value="news_category">
				</cfinvoke>
			
		
	
	
	<!--- stOneToMany --->
