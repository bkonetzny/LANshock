<cfsetting enablecfoutputonly="Yes">
<!-------------------------------------------------------------------------+
 | Copyright (C) 2002 - 2005 LANshock.com                                  |
 |                                                                         |
 | lastmodified: 04-06-08                                                  |
 |           by: bkonetzny                                                 |
 |                               http://sourceforge.net/projects/lanshock/ |
 | Released Under the GNU General Public License (v2) (see license.txt)    |
 +------------------------------------------------------------------------->

<cfparam name="attributes.id" default="0">
<cfparam name="attributes.name" default="">

<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qContent">
	SELECT *
	FROM content_content
	WHERE
	<cfif len(attributes.name)>
		codename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.name#">
	<cfelse>
		id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.id#">
	</cfif>
	AND bactive = 1
</cfquery>

<cfsetting enablecfoutputonly="No">