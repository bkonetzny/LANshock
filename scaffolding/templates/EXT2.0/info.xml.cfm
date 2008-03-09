<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2007-12-09 10:05:43 +0100 (So, 09 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 127 $
--->>

<<cfset sModule = oMetaData.getModule()>>

<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/info.xml.cfm")>>
	<<cffile action="read" file="../templates/EXT2.0/custom/$$sModule$$/info.xml.cfm" variable="sFileContent">>
<<cfelse>>
	<<cfset lTables = oMetaData.getLTableAliases()>>
	
	<<cfsavecontent variable="sFileContent">>
		<<cfoutput>>
<?xml version="1.0" encoding="UTF-8"?>
<module name="$$sModule$$ Module" version="0.0.0.1" date="$$LsDateFormat(now(),'YYYY-MM-DD')$$" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<navigation>
		<item action="main"/>
		<<cfloop list="$$lTables$$" index="idx">><item action="$$idx$$_Listing" reqstatus="admin"/>
		<</cfloop>>
	</navigation>
	
	<security>
		<<cfloop list="$$lTables$$" index="idx">><area name="$$idx$$"/>
		<</cfloop>>
	</security>

</module>
		<</cfoutput>>
	<</cfsavecontent>>
	
<</cfif>>

<<cfoutput>>$$trim(sFileContent)$$<</cfoutput>>