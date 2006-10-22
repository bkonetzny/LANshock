<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.type" default="csv">

<cfquery datasource="#application.lanshock.environment.datasource#" name="qUser">
	SELECT id, name, firstname, lastname, email
	FROM user
	ORDER BY id
</cfquery>

<cfswitch expression="#attributes.type#">

	<cfcase value="csv">

		<cfsavecontent variable="content">
		<cfoutput query="qUser">#id#;#name#;#firstname#;#lastname#;#email##chr(13)#</cfoutput>
		</cfsavecontent>
		
		<cfset content = 'id;name;firstname;lastname;email#chr(13)#' & trim(content)>

	</cfcase>

	<cfcase value="xml">

		<cfxml variable="content">
			<cfoutput><lanshock generated="#now()#">
			<cfloop query="qUser">
				<user id="#id#">
					<id>#id#</id>
					<name>#XMLFormat(name)#</name>
					<firstname>#XMLFormat(firstname)#</firstname>
					<lastname>#XMLFormat(lastname)#</lastname>
					<email>#XMLFormat(email)#</email>
				</user>
			</cfloop>
			</lanshock>
			</cfoutput>
		</cfxml>

	</cfcase>

</cfswitch>

<cfscript>
	content = trim(toString(content));
	getPageContext().getOut().clearBuffer();
	writeOutput(content);
</cfscript>

<cfabort>

<cfsetting enablecfoutputonly="No">