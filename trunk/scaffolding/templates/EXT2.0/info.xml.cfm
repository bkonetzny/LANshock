<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<cfset sModule = oMetaData.getModule()>>

<<cfif fileExists(expandPath('modules/$$sModule$$/info.xml.cfm'))>>
	<<cffile action="read" file="../../modules/$$sModule$$/info.xml.cfm" variable="sFileContent">>
<<cfelse>>
	<<cfset lTables = oMetaData.getLTableAliases()>>
	
	<<cfsavecontent variable="sFileContent">>
		<<cfoutput>>
<?xml version="1.0" encoding="UTF-8"?>
<module name="$$sModule$$ Module" version="0.0.0.1" date="$$LsDateFormat(now(),'YYYY-MM-DD')$$" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<navigation>
		<<cfloop list="$$lTables$$" index="idx">><item action="$$idx$$_listing" permissions="$$idx$$"/>
		<</cfloop>>
	</navigation>
	
	<security>
		<permissions list="$$lTables$$"/>
		<role name="$$sModule$$ Admin" permissions="$$lTables$$"/>
	</security>

</module>
		<</cfoutput>>
	<</cfsavecontent>>
	
<</cfif>>

<<cfoutput>>$$trim(sFileContent)$$<</cfoutput>>