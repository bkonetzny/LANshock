<cfoutput>
	#chr(60)#cfif NOT isDate(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#)>
		#chr(60)#cfset o#caller.objectName#.set#attributes.stFieldData.alias#(now())>
	#chr(60)#/cfif>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#"><cfif attributes.stFieldData.required><em>*</em> </cfif>##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<div class="divInput" id="divDatePicker#attributes.stFieldData.uuid#"></div>
		<input type="hidden" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#" value="##LsDateFormat(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#,'YYYY-MM-DD')## ##LsTimeFormat(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#,'HH:MM:SS')##"/>
		<script type="text/javascript">
			<!--
			var myDatePicker#attributes.stFieldData.uuid# = new Ext.ux.form.DateTime({
				handler: function(value){
					$('####formrow_#attributes.stFieldData.uuid#').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker#attributes.stFieldData.uuid#.render('divDatePicker#attributes.stFieldData.uuid#');
				var dt#attributes.stFieldData.uuid# = new Date();
				dt#attributes.stFieldData.uuid# = Date.parseDate("##LsDateFormat(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#,'YYYY-MM-DD')## ##LsTimeFormat(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#,'HH:MM')##","Y-m-d G:i");
				myDatePicker#attributes.stFieldData.uuid#.setValue(dt#attributes.stFieldData.uuid#);
			});
			//-->
		</script>
	</div>
</cfoutput>