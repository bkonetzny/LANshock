<cfapplication
	name="Generated_Application"
	sessionmanagement="Yes"
	sessiontimeout="#CreateTimeSpan(0,0,30,0)#"
	clientmanagement="No">

<cfset FUSEBOX_APPLICATION_PATH = "">
<cfinclude template="/fusebox5/fusebox5.cfm">