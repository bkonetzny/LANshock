<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#">##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<div id="divDatePicker#attributes.stFieldData.uuid#"></div>
		<input type="hidden" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#" value="##LsDateFormat(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#,'YYYY-MM-DD')##"/>
			<script type="text/javascript">
				var myDatePicker#attributes.stFieldData.uuid# = new Ext.DatePicker({
					handler : function(dp,date){
						var elmDate = Ext.get('formrow_#attributes.stFieldData.uuid#');
						elmDate.set({value:date.format("Y-m-d")});
					}
				});
				#chr(60)#cfif isDate(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#)>
					var dt#attributes.stFieldData.uuid# = new Date();
					dt#attributes.stFieldData.uuid# = Date.parseDate("##LsDateFormat(#caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#,'YYYY-MM-DD')##","Y-m-d");
					myDatePicker#attributes.stFieldData.uuid#.setValue(dt#attributes.stFieldData.uuid#);
				#chr(60)#/cfif>
				Ext.onReady(function(){
					myDatePicker#attributes.stFieldData.uuid#.render('divDatePicker#attributes.stFieldData.uuid#');
				});
			</script>
	</div>
</cfoutput>