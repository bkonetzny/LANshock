<cfoutput>
	<fuseaction access="public" name="show">
		<include circuit="#sModule#" template="custom/act_content"/>
		<include circuit="v_#sModule#" template="custom/dsp_content"/>
	</fuseaction>
</cfoutput>