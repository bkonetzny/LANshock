<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#">##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<textarea name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#">###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "##request.lanshock.environment.webpath##templates/_shared/js/fckeditor/";
				var oFCKeditor_formrow_#attributes.stFieldData.uuid# = new FCKeditor('#attributes.stFieldData.alias#');
				oFCKeditor_formrow_#attributes.stFieldData.uuid#.BasePath = sBasePath;
				oFCKeditor_formrow_#attributes.stFieldData.uuid#.Config['CustomConfigurationsPath'] = sBasePath + 'editor/plugins/lanshock/config.js';
				oFCKeditor_formrow_#attributes.stFieldData.uuid#.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_#attributes.stFieldData.uuid#.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
</cfoutput>