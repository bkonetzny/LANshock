<cfoutput>
	<if condition="NOT len(trim(attributes.#caller.aFields[caller.i].alias#))">
		<true>
			<set name="attributes.#caller.aFields[caller.i].alias#" value="##attributes.#caller.aFields[caller.i].alias#__hidden##" />
		</true>
	</if>
</cfoutput>