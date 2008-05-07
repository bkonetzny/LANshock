<cfoutput>
	#chr(60)#cfif NOT StructKeyExists(attributes,'#caller.aFields[caller.i].alias#')>
		#chr(60)#cffile action="upload" filefield="form.#caller.aFields[caller.i].alias#" destination="##application.lanshock.oHelper.UDF_Module('storagePathTemp')##" mode="777" nameconflict="makeunique">
		#chr(60)#cfset attributes.#caller.aFields[caller.i].alias# = cffile>
	#chr(60)#/cfif>
</cfoutput>