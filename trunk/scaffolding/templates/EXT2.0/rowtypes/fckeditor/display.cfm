<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#"><cfif attributes.stFieldData.required><em>*</em> </cfif>##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<textarea name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#">###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###</textarea>
		<script type="text/javascript">
			<!--
				$(document).ready(function(){
					var sBasePath = "##application.lanshock.oRuntime.getEnvironment().sWebPath##templates/_shared/js/";
					var oFCKeditor_formrow_#attributes.stFieldData.uuid# = new FCKeditor('#attributes.stFieldData.alias#');
					oFCKeditor_formrow_#attributes.stFieldData.uuid#.BasePath = sBasePath + "fckeditor/";
					oFCKeditor_formrow_#attributes.stFieldData.uuid#.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
					oFCKeditor_formrow_#attributes.stFieldData.uuid#.Value = '';
					oFCKeditor_formrow_#attributes.stFieldData.uuid#.ReplaceTextarea();
				});
			//-->
		</script>
	</div>
</cfoutput>