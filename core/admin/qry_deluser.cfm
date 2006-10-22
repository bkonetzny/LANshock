<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->
 
 <!--- Wenn der ganze User gel&ouml;scht werden soll alle Eintr&auml;ge loeschen --->
<CFif isDefined("attributes.deluser")>

	<!--- Sitzplatz ID uas DB hohlen --->
	<cfquery datasource=#application.lanshock.environment.datasource# name="seats2del">
		SELECT s.id
		FROM user u
		INNER JOIN guest g ON g.user = u.id
		INNER JOIN seats s ON s.guest = g.id
		WHERE u.id = <CFqueryParam cfsqltype="CF_SQL_INTEGER" value="#attributes.user_id#" maxlength="11">		
	</cfquery>

	<!--- <cfquery datasource=#application.lanshock.environment.datasource# name="seats2del">
		SELECT s.id
		FROM seats s
		INNER JOIN guest g ON g.id = s.guest
		INNER JOIN user u ON u.id = g.user 
		WHERE g.user = #attributes.user_id#		
	</cfquery> --->
	<!--- Wenn vorhanden, Sitzplatz loeschen --->
	<CFif seats2del.recordcount>
		<cfquery datasource=#application.lanshock.environment.datasource# name="deleteuser">
			DELETE FROM seats
			WHERE id = #seats2del.id#		
		</cfquery>
	</CFIF>
	<!--- User loeschen --->
	<cfquery datasource=#application.lanshock.environment.datasource# name="deleteuser">
		DELETE FROM user
		WHERE id = <CFqueryParam cfsqltype="CF_SQL_INTEGER" value="#attributes.user_id#" maxlength="11">		
	</cfquery>
	
	<!--- Gaststatus loeschen --->
	<cfquery datasource=#application.lanshock.environment.datasource# name="deleteguest">
		DELETE FROM guest
		WHERE user = <CFqueryParam cfsqltype="CF_SQL_INTEGER" value="#attributes.user_id#" maxlength="11">		
	</cfquery>	
<!--- Wenn nur der Gastestatus geloescht werden soll eintrag in tabelle user eintragen --->
<CFelse>

	<!--- Sitz ID aus DB hohlen --->
	<cfquery datasource=#application.lanshock.environment.datasource# name="seats2del">
		SELECT s.id
		FROM seats s
		INNER JOIN guest g ON g.id = s.guest
		INNER JOIN user u ON u.id = g.user 
		WHERE user = <CFqueryParam cfsqltype="CF_SQL_INTEGER" value="#attributes.user_id#" maxlength="11">		
	</cfquery>
	
	<!--- Wenn sitz da, sitz loeschen --->
	<CFif seats2del.recordcount>
		<cfquery datasource=#application.lanshock.environment.datasource# name="deleteuser">
			DELETE FROM seats
			WHERE id = #seats2del.id#		
		</cfquery>
	</CFIF>
	<!--- Gaststatus loeschen --->
	<cfquery datasource=#application.lanshock.environment.datasource# name="deleteguest">
		DELETE FROM guest
		WHERE user = <CFqueryParam cfsqltype="CF_SQL_INTEGER" value="#attributes.user_id#" maxlength="11">		
	</cfquery>
</CFIF>

<CFlocation url="#self#?fuseaction=#UDF_Module()#.userlist&#request.session.UrlToken#" addtoken="Yes">

<cfsetting enablecfoutputonly="No">
