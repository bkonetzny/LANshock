<!---
$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!---
FB40 plugin: NestedSettings.cfm
copyright: (c) 2003, by John Quarto-vonTivadar. You are free to use this FB40 plugin and to modify it as long as you leave my copyright notice intact.
use: the during Phase "preFuseaction"
overview: before each Fuseaction's execution attempt to load all files with a name specified by plugin.file in each circuit directory from the root parent circuit of the fuseaction's circuit to the fuseaction's circuit itself
	in short, this does the same thing as FB3's settings file loaded from top-to-bottom
	if isRequired is TRUE, and the file is not found, then an error message will be shown and processing aborted
	if isRequired is FALSE, then try to include the file specified by plugin.file if it exists but silently continue if it doesn't exist
--->

<cfset plugin = myFusebox.plugins[myFusebox.thisPlugin]>
<cfset plugin.file = "mySettings.cfm">
<cfset plugin.isRequired = "false">
<!--- load the any Settings.cfm files from the top circuit to thisCircuit  --->

<!--- preserve the value of myFusebox.thisCircuit --->
<cfset plugin.thisCircuit = myFusebox.thisCircuit>			

<!--- loop over each circuit from top to bottom in this circuit's circuitTrace, loading
       the plugin.file in each --->
<cfloop from="#arrayLen(application.fusebox.circuits[plugin.thisCircuit].circuitTrace)#" to="1" step="-1" index="plugin.i">
	<cfset plugin.aCircuit = application.fusebox.circuits[plugin.thisCircuit].circuitTrace[plugin.i]>
	<cfset myFusebox.thisCircuit = plugin.aCircuit>

	<cftry>
		<cfinclude template="#application.fusebox.plugins[myFusebox.thisPlugin][myFusebox.thisPhase].rootpath##application.fusebox.circuits[plugin.aCircuit].path##plugin.file#"> 
		<cfcatch type="missingInclude">
			<cfif right( cfcatch.missingFileName, Len(plugin.file) ) NEQ plugin.file>
				<cfrethrow>
			<cfelse>
				<cfif plugin.isRequired>
					<cfthrow type="missingPluginInclude" message="The required plugin file #plugin.file# in the circuit #myFusebox.thisCircuit# is missing.">
				<cfelse>
					<!--- if the file doesn't exist then do nothing --->		
				</cfif>
			</cfif>
		</cfcatch>
	</cftry>
	
</cfloop>

<!--- restore the value of myFusebox.thisCircuit --->
<cfset myFusebox.thisCircuit = plugin.thisCircuit>			