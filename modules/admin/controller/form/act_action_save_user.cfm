<cfset aErrors = ArrayNew(1)>
	<cfset aTranslatedErrors = ArrayNew(1)>
	
	
		

	
		

	
		

	
		

	
	<cfif NOT len(trim(attributes.pwd))>
		<cfset attributes.pwd = attributes.pwd__hidden>
	<cfelse>
		<cfset attributes.pwd = hash(attributes.pwd)>
	</cfif>
	
		

	
		

	
		

	
	<cfif NOT StructKeyExists(attributes,'gender')>
		<cfset attributes.gender = ''>
	</cfif>
	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
		

	
	
		<cfinclude template="act_action_save_postvalidation_user.cfm">
	
	<cfparam name="attributes.user_id" default="0">
	<cfset ouser = application.lanshock.oFactory.load('user','reactorRecord')>
	<cfif variables.mode EQ 'insert'>
		
		<cfset ouser.setname(attributes.name)>
		<cfset ouser.setemail(attributes.email)>
		<cfset ouser.setpwd(attributes.pwd)>
		<cfset ouser.setfirstname(attributes.firstname)>
		<cfset ouser.setlastname(attributes.lastname)>
		<cfset ouser.setgender(attributes.gender)>
		<cfset ouser.setstatus(attributes.status)>
		<cfset ouser.setsignature(attributes.signature)>
		<cfset ouser.sethomepage(attributes.homepage)>
		<cfset ouser.setinternal_note(attributes.internal_note)>
		<cfset ouser.setdt_birthdate(attributes.dt_birthdate)>
		<cfset ouser.setdt_lastlogin(attributes.dt_lastlogin)>
		<cfset ouser.setdt_registered(attributes.dt_registered)>
		<cfset ouser.setlanguage(attributes.language)>
		<cfset ouser.setcountry(attributes.country)>
		<cfset ouser.setcity(attributes.city)>
		<cfset ouser.setstreet(attributes.street)>
		<cfset ouser.setzip(attributes.zip)>
		<cfset ouser.setlogincount(attributes.logincount)>
		<cfset ouser.setreset_password_key(attributes.reset_password_key)>
		<cfset ouser.setopenid_url(attributes.openid_url)>
		<cfset ouser.setgeo_latlong(attributes.geo_latlong)>
	<cfelse>
		
		<cfset ouser.setid(attributes.id)>
		<cfset ouser.setname(attributes.name)>
		<cfset ouser.setemail(attributes.email)>
		<cfset ouser.setpwd(attributes.pwd)>
		<cfset ouser.setfirstname(attributes.firstname)>
		<cfset ouser.setlastname(attributes.lastname)>
		<cfset ouser.setgender(attributes.gender)>
		<cfset ouser.setstatus(attributes.status)>
		<cfset ouser.setsignature(attributes.signature)>
		<cfset ouser.sethomepage(attributes.homepage)>
		<cfset ouser.setinternal_note(attributes.internal_note)>
		<cfset ouser.setdt_birthdate(attributes.dt_birthdate)>
		<cfset ouser.setdt_lastlogin(attributes.dt_lastlogin)>
		<cfset ouser.setdt_registered(attributes.dt_registered)>
		<cfset ouser.setlanguage(attributes.language)>
		<cfset ouser.setcountry(attributes.country)>
		<cfset ouser.setcity(attributes.city)>
		<cfset ouser.setstreet(attributes.street)>
		<cfset ouser.setzip(attributes.zip)>
		<cfset ouser.setlogincount(attributes.logincount)>
		<cfset ouser.setreset_password_key(attributes.reset_password_key)>
		<cfset ouser.setopenid_url(attributes.openid_url)>
		<cfset ouser.setgeo_latlong(attributes.geo_latlong)>
	</cfif>
	
	<cfset ouser.validate()>
	<cfif ouser.hasErrors()>
		<cfset bHasErrors = true>
	</cfif>
	
	
	<cfif NOT bHasErrors>
		<cfset ocore_security_users_roles_reliterator = ouser.getcore_security_users_roles_reliterator()>
		<cfset ocore_security_users_roles_reliterator.deleteAll()>
		<cfif StructKeyExists(attributes,'core_security_users_roles_rel')>
			<cfloop list="#attributes.core_security_users_roles_rel#" index="idx">
				<cfset ocore_security_users_roles_reliterator.add(user_id = ouser.getid(), role_id = idx)>
			</cfloop>
		</cfif>
		<cfset ocore_security_users_roles_reliterator.validate()>
		<cfif ocore_security_users_roles_reliterator.hasErrors()>
			<cfset bHasErrors = true>
		</cfif>
	</cfif>
	
	<cfif NOT bHasErrors>
		<cfset ouser.save()>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._Startrow#&_maxrows=#attributes._Maxrows#')#" addtoken="false">
	<cfelse>
		<cfset request.layout = "admin">
		
		<cfinclude template="act_form_loadrelated_user.cfm">
		
			<cfinclude template="act_form_loadrelated_custom_user.cfm">
		
		<cfset aReactorErrors = ouser._getErrorCollection().getErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorErrors)#" index="idx">
			<cfset ArrayAppend(aErrors,aReactorErrors[idx])>
		</cfloop>
		<cfset aReactorTranslatedErrors = ouser._getErrorCollection().getTranslatedErrors()>
		<cfloop from="1" to="#ArrayLen(aReactorTranslatedErrors)#" index="idx">
			<cfset ArrayAppend(aTranslatedErrors,aReactorTranslatedErrors[idx])>
		</cfloop>
		
		<cfparam name="request.page.pageContent" default="">
		<cfsavecontent variable="request.page.pageContent">
			<cfoutput>#request.page.pageContent#</cfoutput>
			<cfinclude template="../../view/form/dsp_form_user.cfm">
		</cfsavecontent>
	</cfif>
