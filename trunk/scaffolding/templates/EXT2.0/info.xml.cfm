<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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