<cfoutput>
	<if condition="NOT StructKeyExists(attributes,'#caller.aFields[caller.i].alias#')">
		<true>
			<set name="attributes.#caller.aFields[caller.i].alias#" value="0"/>
		</true>
	</if>
</cfoutput>