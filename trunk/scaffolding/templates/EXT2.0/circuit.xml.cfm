<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<!--- Set the name of the datasource, This is used to create the names of directories and circuits --->>
<<cfset datasourceName = oMetaData.getDatasource()>>
<<cfset sModule = oMetaData.getModule()>>

<<cfoutput>>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:lanshock="lanshock/">

	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/$$sModule$$/i18n/lang.properties" returnvariable="request.content"/>
			<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/controller/circuit_lanshock_fuseaction_i18n.xml.cfm")>>
				<<cfoutput>>
				<<cfinclude template="../templates/EXT2.0/custom/$$sModule$$/controller/circuit_lanshock_fuseaction_i18n.xml.cfm">>
				<</cfoutput>>
			<</cfif>>
			<include circuit="$$sModule$$" template="settings" />
		</lanshock:fuseaction>
	</prefuseaction>
	
	<postfuseaction>
		<lanshock:fuseaction>
			<if condition="isDefined('request.layout')">
				<true>
					<if condition="request.layout EQ 'json'">
						<true>
							<set name="_fba.debug" value="false"/>
							<include circuit="v_$$sModule$$" template="dsp_layout_json" />
						</true>
						<false>
							<if condition="request.layout EQ 'none'">
								<true>
									<set name="_fba.debug" value="false"/>
								</true>
								<false>
									<if condition="request.layout EQ 'admin'">
										<true>
											<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/view/styles.css")>>
											<lanshock:htmlhead type="style" content="@import url('#application.lanshock.oRuntime.getEnvironment().sWebPath#modules/$$sModule$$/view/styles.css');"/>
											<</cfif>>
										</true>
									</if>
								</false>
							</if>
						</false>
					</if>
				</true>
				<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/view/styles.css")>>
				<false>
					<lanshock:htmlhead type="style" content="@import url('#application.lanshock.oRuntime.getEnvironment().sWebPath#modules/$$sModule$$/view/styles.css');"/>
				</false>
				<</cfif>>
			</if>
		</lanshock:fuseaction>
	</postfuseaction>

	<fuseaction name="main" access="public">
		<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/controller/circuit_main.xml.cfm")>>
			<<cfoutput>>
			<<cfinclude template="../templates/EXT2.0/custom/$$sModule$$/controller/circuit_main.xml.cfm">>
			<</cfoutput>>
		<<cfelse>>
			<include circuit="$$sModule$$" template="main" />
		<</cfif>>
	</fuseaction>
	
	<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/controller/circuit.xml.cfm")>>
		<<cfoutput>>
		<<cfinclude template="../templates/EXT2.0/custom/$$sModule$$/controller/circuit.xml.cfm">>
		<</cfoutput>>
	<</cfif>>

</circuit>
<</cfoutput>>