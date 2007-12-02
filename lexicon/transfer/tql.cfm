<cfscript>
	// author: Nick Tong - http://succor.co.uk | http://talkwebsolutions.co.uk
	// usage:
	//	<transfer:tql
	//		tql=" from post.Post as Post join system.Category join user.User order by Post.dateTime desc "
	//		queryName="myQueryName">
	//		<transfer:parameter name="id" value="#attributes.id#" />
	//	</transfer:tql>
	
	if (fb_.verbInfo.executionMode is "start") {
		// validate attributes
		// object - string
		if (not structKeyExists(fb_.verbInfo.attributes,"tql")) {
			fb_throw("fusebox.badGrammar.requiredAttributeMissing",
					"Required attribute is missing",
					"The attribute 'tql' is required, for a 'tql' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
		}
	
		// queryName - string
		if (not structKeyExists(fb_.verbInfo.attributes,"queryName")) {
			fb_throw("fusebox.badGrammar.requiredAttributeMissing",
					"Required attribute is missing",
					"The attribute 'queryName' is required, for a 'tql' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
		}
	    
	    // generate code:
	    fb_appendLine('<cfset #fb_.verbInfo.attributes.queryName# = ' &
					'myFusebox.getApplication().getApplicationData().transferFactory.getTransfer().createQuery("#fb_.verbInfo.attributes.tql#") />');
		
		// prepare for any parameters:
		fb_.verbInfo.parameters = structNew();
	}
	else {

		for (fb_.p in fb_.verbInfo.parameters) {
			fb_appendLine('<cfset #fb_.verbInfo.attributes.queryName#.setParam("#fb_.p#",#fb_.verbInfo.parameters[fb_.p]#) />');
		}

		fb_appendLine('<cfset #fb_.verbInfo.attributes.queryName# = ' &
					'myFusebox.getApplication().getApplicationData().transferFactory.getTransfer().listByQuery(#fb_.verbInfo.attributes.queryName#) />');

		fb_appendLine('<cfset myFusebox.trace("Transfer","Created TQL Query") />');
	}
</cfscript>