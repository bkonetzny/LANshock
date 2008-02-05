<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].alias###</label>
		<textarea name="#aFields[i].alias#" id="formrow_##idFormRow##">###Format("o#objectName#.get#aFields[i].alias#()","#aFields[i].format#")###</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "##request.lanshock.environment.webpath##templates/_shared/js/fckeditor/";
				var oFCKeditor_formrow_##idFormRow## = new FCKeditor('#aFields[i].alias#');
				oFCKeditor_formrow_##idFormRow##.BasePath = sBasePath;
				oFCKeditor_formrow_##idFormRow##.Config['CustomConfigurationsPath'] = sBasePath + 'editor/plugins/lanshock/config.js';
				oFCKeditor_formrow_##idFormRow##.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_##idFormRow##.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
</cfoutput>