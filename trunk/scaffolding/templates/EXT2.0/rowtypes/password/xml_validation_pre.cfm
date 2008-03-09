<cfoutput>
	<if condition="NOT len(trim(attributes.#caller.aFields[caller.i].alias#))">
		<true>
			<set name="attributes.#caller.aFields[caller.i].alias#" value="##attributes.#caller.aFields[caller.i].alias#__hidden##" />
		</true>
		<false>
			<set name="attributes.#caller.aFields[caller.i].alias#" value="##hash(attributes.#caller.aFields[caller.i].alias#)##" />
		</false>
	</if>
</cfoutput>