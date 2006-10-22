<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.module" default="">

<cfset qConfiglist = objectBreeze.list("core_configmanager","module ASC").getQuery()>

<cfif isDefined("attributes.reset_selected")>
	<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="clearConfig">
		<cfinvokeargument name="lmodules" value="#attributes.module#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif isDefined("attributes.reset_all")>
	<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="clearConfig">
		<cfinvokeargument name="lmodules" value="#valuelist(qConfiglist.module)#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif len(attributes.module)>
	<cfset qConfig = objectBreeze.getByWhere("core_configmanager","module = '#attributes.module#'").getQuery()>
	<cfwddx action="wddx2cfml" input="#qConfig.data#" output="stConfig">
</cfif>

<!--- <cffunction name="newConfigLevel">
	<cfargument name="data" type="any" required="true">
	<cfargument name="level" type="numeric" required="false" default="0">
	
	<cfset arguments.level = arguments.level + 1>
	
	<cfoutput><table class="vlist"></cfoutput>
	<cfif isStruct(arguments.data)>
		<cfloop list="#listSort(StructKeyList(arguments.data),'textnocase')#" index="idx">
			<cfif isSimpleValue(arguments.data[idx])>
				<cfoutput>
					<tr>
						<th>#idx#</th>
						<td><input type="text" value="#arguments.data[idx]#"></td>
					</tr>
				</cfoutput>
			</cfif>
		</cfloop>
		<cfloop list="#listSort(StructKeyList(arguments.data),'textnocase')#" index="idx">
			<cfif NOT isSimpleValue(arguments.data[idx])>
				<cfoutput>
					<tr>
						<td colspan="2"><span class="headline2">#idx#</span></td>
					</tr>
					<tr>
						<td>#newConfigLevel(arguments.data[idx],arguments.level)#</td>
					</tr>
				</cfoutput>
			</cfif>
		</cfloop>
	<cfelseif isArray(arguments.data)>
		<cfloop from="1" to="#arraylen(arguments.data)#" index="idx">
			<cfif isSimpleValue(arguments.data[idx])>
				<cfoutput>
					<tr>
						<th>#idx#</th>
						<td><input type="text" value="#arguments.data[idx]#"></td>
					</tr>
				</cfoutput>
			</cfif>
		</cfloop>
		<cfloop from="1" to="#arraylen(arguments.data)#" index="idx">
			<cfif NOT isSimpleValue(arguments.data[idx])>
				<cfoutput>
					<tr>
						<td colspan="2"><span class="headline2">#idx#</span></td>
					</tr>
					<tr>
						<td>#newConfigLevel(arguments.data[idx],arguments.level)#</td>
					</tr>
				</cfoutput>
			</cfif>
		</cfloop>
	</cfif>
	<cfoutput></table></cfoutput>
</cffunction>

<cffunction name="generateConfigLevel">
	<cfargument name="structure" type="struct" required="true">
	<cfargument name="level" type="numeric" required="false" default="0">
	
	<cfset arguments.level = arguments.level + 1>
	
	<cfoutput><table class="vlist"></cfoutput>
	<cfloop list="#listSort(StructKeyList(arguments.structure),'textnocase')#" index="idx">
		<cfif NOT isStruct(arguments.structure[idx])>
			<cfoutput>
				<tr>
					<th>#idx#</th>
					<td><input type="text" value="#arguments.structure[idx]#"></td>
				</tr>
			</cfoutput>
		</cfif>
	</cfloop>
	<cfloop list="#listSort(StructKeyList(arguments.structure),'textnocase')#" index="idx">
		<cfif isStruct(arguments.structure[idx])>
			<cfoutput>
				<tr>
					<td colspan="2"><span class="headline2">#idx#</span></td>
				</tr>
				<tr>
					<td>#newConfigLevel(arguments.structure[idx],arguments.level)#</td>
				</tr>
			</cfoutput>
		</cfif>
	</cfloop>
	<cfoutput></table></cfoutput>
</cffunction> --->

<cfsetting enablecfoutputonly="No">