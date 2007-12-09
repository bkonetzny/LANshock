<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" >
	<fuseaction name="Initialise" access="internal">
		<!-- Initialise: I Initialise all of the required gateway objects. -->
		<!-- Create the reactorFactory. -->
		<reactor:initialize configuration="#expandPath('config/reactor/reactor.xml')#"/>
	</fuseaction>
	
	<fuseaction name="ReInitialise" access="internal">
		<!-- I check the URL parameters for the init variable, if present all the cached objects are recreated --->
		<if condition="isDefined('attributes.init')">
			<true>
				<do action="Initialise" />
			</true>
		</if>
	</fuseaction>
</circuit>